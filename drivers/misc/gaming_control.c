/*
 * Simple kernel gaming control
 *
 * Copyright (C) 2019
 * Diep Quynh Nguyen <remilia.1505@gmail.com>
 * Mustafa Gökmen <mustafa.gokmen2004@gmail.com>
 * Adapted into S20/N20 Samsung Galaxy models by XDA@nala
 *
 * This software is licensed under the terms of the GNU General Public
 * License version 2, as published by the Free Software Foundation, and
 * may be copied, distributed, and modified under those terms.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 */

#include <linux/binfmts.h>
#include <linux/module.h>
#include <linux/kobject.h>
#include <linux/sysfs.h>
#include <linux/device.h>
#include <linux/mm.h>
#include <linux/slab.h>
#include <linux/gaming_control.h>
#include <linux/pm_qos.h>

#define GAME_LIST_LENGTH 1024
#define NUM_SUPPORTED_RUNNING_GAMES 20
#define GAMING_CONTROL_VERSION "0.4"

#define TASK_STARTED 1

/* PM QoS implementation */
struct pm_qos_request gaming_control_min_mif_qos;
struct pm_qos_request gaming_control_min_big_qos;
struct pm_qos_request gaming_control_max_big_qos;
struct pm_qos_request gaming_control_min_mid_qos;
struct pm_qos_request gaming_control_max_mid_qos;
struct pm_qos_request gaming_control_min_little_qos;
struct pm_qos_request gaming_control_max_little_qos;
unsigned int min_mif_freq = 2028000;
unsigned int min_little_freq = 1456000;
unsigned int max_little_freq = 2106000;
unsigned int min_big_freq = 1690000;
unsigned int max_big_freq = 3016000;
unsigned int min_mid_freq = 1586000;
unsigned int max_mid_freq = 2600000;
unsigned int min_gpu_freq = 455000;
unsigned int max_gpu_freq = 702000;

char games_list[GAME_LIST_LENGTH] = {0};
int games_pid[NUM_SUPPORTED_RUNNING_GAMES] = {
	[0 ... (NUM_SUPPORTED_RUNNING_GAMES - 1)] = -1
};
static int nr_running_games = 0;
static bool always_on = 0;
static bool battery_idle = 0;
bool gaming_mode;

static void set_gaming_mode(bool mode)
{
	if(always_on)
		mode = 1;

	if (mode == gaming_mode)
		return;
	else
		gaming_mode = mode;

	if(min_mif_freq > 0 && mode)
		pm_qos_update_request(&gaming_control_min_mif_qos, min_mif_freq);
	else
		pm_qos_update_request(&gaming_control_min_mif_qos, PM_QOS_BUS_THROUGHPUT_DEFAULT_VALUE);
	
	if(min_little_freq > 0 && mode)
		pm_qos_update_request(&gaming_control_min_little_qos, min_little_freq);
	else
		pm_qos_update_request(&gaming_control_min_little_qos, PM_QOS_CLUSTER0_FREQ_MIN_DEFAULT_VALUE);
		
	if(max_little_freq > 0 && mode)
		pm_qos_update_request(&gaming_control_max_little_qos, max_little_freq);
	else
		pm_qos_update_request(&gaming_control_max_little_qos, PM_QOS_CLUSTER0_FREQ_MAX_DEFAULT_VALUE);
	
	if(min_big_freq > 0 && mode)
		pm_qos_update_request(&gaming_control_min_big_qos, min_big_freq);
	else
		pm_qos_update_request(&gaming_control_min_big_qos, PM_QOS_CLUSTER2_FREQ_MIN_DEFAULT_VALUE);
	
	if(max_big_freq > 0 && mode)
		pm_qos_update_request(&gaming_control_max_big_qos, max_big_freq);
	else
		pm_qos_update_request(&gaming_control_max_big_qos, PM_QOS_CLUSTER2_FREQ_MAX_DEFAULT_VALUE);

	if(min_mid_freq > 0 && mode)
		pm_qos_update_request(&gaming_control_min_mid_qos, min_mid_freq);
	else
		pm_qos_update_request(&gaming_control_min_mid_qos, PM_QOS_CLUSTER1_FREQ_MIN_DEFAULT_VALUE);
	
	if(max_mid_freq > 0 && mode)
		pm_qos_update_request(&gaming_control_max_mid_qos, max_mid_freq);
	else
		pm_qos_update_request(&gaming_control_max_mid_qos, PM_QOS_CLUSTER1_FREQ_MAX_DEFAULT_VALUE
	
	if(mode) {
		gpu_custom_max_clock(max_gpu_freq);
		gpu_custom_min_clock(min_gpu_freq);
	} else {
		gpu_custom_max_clock(0);
		gpu_custom_min_clock(0);
	}
}

bool battery_idle_gaming(void) {
	if (gaming_mode && battery_idle)
		return 1;

	return 0;
}

static void store_game_pid(int pid)
{
	int i;

	for (i = 0; i < NUM_SUPPORTED_RUNNING_GAMES; i++) {
		if (games_pid[i] == -1) {
			games_pid[i] = pid;
			nr_running_games++;
	}	}
}

static void clear_dead_pids(void)
{
	int i;

	for (i = 0; i < NUM_SUPPORTED_RUNNING_GAMES; i++) {
		if (games_pid[i] != -1) {
			if (find_task_by_vpid(games_pid[i]) == NULL) {
				games_pid[i] = -1;
				nr_running_games--;
			}
		}
	}

	/* If there's no running games, turn off game mode */
	if (nr_running_games == 0)
		set_gaming_mode(0);
}

static int check_for_games(struct task_struct *tsk)
{
	char *cmdline;
	int ret;

	if (!is_zygote_pid(tsk->parent->pid))
		return 0;

	cmdline = kmalloc(GAME_LIST_LENGTH, GFP_KERNEL);
	if (!cmdline)
		return 0;

	ret = get_cmdline(tsk, cmdline, GAME_LIST_LENGTH);
	if (ret == 0) {
		kfree(cmdline);
		return 0;
	}

	/* Invalid Android process name. Bail out */
	if (strlen(cmdline) < 7) {
		kfree(cmdline);
		return 0;
	}

	/* tsk isn't a game. Bail out */
	if (strstr(games_list, cmdline) == NULL) {
		kfree(cmdline);
		return 0;
	}

	kfree(cmdline);

	return 1;
}

void game_option(struct task_struct *tsk, enum game_opts opts)
{
	int ret;

	/* Remove all zombie tasks PIDs */
	clear_dead_pids();
	
	if(always_on) {
		set_gaming_mode(1);
		return;
	}

	ret = check_for_games(tsk);
	if (!ret)
		return;

	switch (opts) {
	case GAME_START:
		if (tsk->app_state == TASK_STARTED)
			return;

		store_game_pid(tsk->pid);
		tsk->app_state = TASK_STARTED;
		set_gaming_mode(1);
		break;
	case GAME_RUNNING:
		set_gaming_mode(1);
		break;
	case GAME_PAUSE:
		set_gaming_mode(0);
		break;
	default:
		break;
	}
}

/* Show added games list */
static ssize_t game_packages_show(struct kobject *kobj,
		struct kobj_attribute *attr, char *buf)
{
	return sprintf(buf, "%s\n", games_list);
}

/* Store added games list */
static ssize_t game_packages_store(struct kobject *kobj,
		struct kobj_attribute *attr, const char *buf, size_t count)
{
	char games[GAME_LIST_LENGTH];

	sscanf(buf, "%s", games);
	sprintf(games_list, "%s", buf);

	return count;
}

/* Show value */
#define show_value(type)						\
static ssize_t type##_show(struct kobject *kobj,		\
		struct kobj_attribute *attr, char *buf)		\
{								\
	return sprintf(buf, "%u\n", type);			\
}								\

show_value(always_on);
show_value(battery_idle);
show_value(min_mif_freq);
show_value(min_little_freq);
show_value(max_little_freq);
show_value(min_mid_freq);
show_value(max_mid_freq);
show_value(min_big_freq);
show_value(max_big_freq);
show_value(min_gpu_freq);
show_value(max_gpu_freq);

/* Store value */
#define store_value(type)							\
static ssize_t type##_store(struct kobject *kobj,				\
		struct kobj_attribute *attr, const char *buf, size_t count)	\
{										\
	unsigned int value;							\
										\
	sscanf(buf, "%u\n", &value);						\
	type = value;								\
										\
	return count;								\
}										\

store_value(always_on);
store_value(battery_idle);
store_value(min_mif_freq);
store_value(min_little_freq);
store_value(max_little_freq);
store_value(min_mid_freq);
store_value(max_mid_freq);
store_value(min_big_freq);
store_value(max_big_freq);
store_value(min_gpu_freq);
store_value(max_gpu_freq);

static ssize_t version_show(struct kobject *kobj,
		struct kobj_attribute *attr, char *buf)
{
	return sprintf(buf, "%s\n", GAMING_CONTROL_VERSION);
}

static struct kobj_attribute game_packages_attribute =
	__ATTR(game_packages, 0644, game_packages_show, game_packages_store);

static struct kobj_attribute version_attribute =
	__ATTR(version, 0444, version_show, NULL);
	
static struct kobj_attribute always_on_attribute =
	__ATTR(always_on, 0644, always_on_show, always_on_store);
	
static struct kobj_attribute battery_idle_attribute =
	__ATTR(battery_idle, 0644, battery_idle_show, battery_idle_store);

static struct kobj_attribute min_mif_freq_attribute =
	__ATTR(min_mif, 0644, min_mif_freq_show, min_mif_freq_store);

static struct kobj_attribute min_little_freq_attribute =
	__ATTR(little_freq_min, 0644, min_little_freq_show, min_little_freq_store);

static struct kobj_attribute max_little_freq_attribute =
	__ATTR(little_freq_max, 0644, max_little_freq_show, max_little_freq_store);

static struct kobj_attribute min_mid_freq_attribute =
	__ATTR(big_freq_min, 0644, min_mid_freq_show, min_mid_freq_store);

static struct kobj_attribute max_mid_freq_attribute =
	__ATTR(big_freq_max, 0644, max_mid_freq_show, max_mid_freq_store);

static struct kobj_attribute min_big_freq_attribute =
	__ATTR(big_freq_min, 0644, min_big_freq_show, min_big_freq_store);

static struct kobj_attribute max_big_freq_attribute =
	__ATTR(big_freq_max, 0644, max_big_freq_show, max_big_freq_store);
	
static struct kobj_attribute min_gpu_freq_attribute =
	__ATTR(gpu_freq_min, 0644, min_gpu_freq_show, min_gpu_freq_store);

static struct kobj_attribute max_gpu_freq_attribute =
	__ATTR(gpu_freq_max, 0644, max_gpu_freq_show, max_gpu_freq_store);

static struct attribute *gaming_control_attributes[] = {
	&game_packages_attribute.attr,
	&version_attribute.attr,
	&always_on_attribute.attr,
	&battery_idle_attribute.attr,
	&min_mif_freq_attribute.attr,
	&min_little_freq_attribute.attr,
	&max_little_freq_attribute.attr,
	&min_mid_freq_attribute.attr,
	&max_mid_freq_attribute.attr,
	&min_big_freq_attribute.attr,
	&max_big_freq_attribute.attr,
	&min_gpu_freq_attribute.attr,
	&max_gpu_freq_attribute.attr,
	NULL
};

static struct attribute_group gaming_control_control_group = {
	.attrs = gaming_control_attributes,
};

static struct kobject *gaming_control_kobj;

static int gaming_control_init(void)
{
	int sysfs_result;

	pm_qos_add_request(&gaming_control_min_mif_qos, PM_QOS_BUS_THROUGHPUT, PM_QOS_BUS_THROUGHPUT_DEFAULT_VALUE);
	pm_qos_add_request(&gaming_control_min_little_qos, PM_QOS_CLUSTER0_FREQ_MIN, PM_QOS_CLUSTER0_FREQ_MIN_DEFAULT_VALUE);
	pm_qos_add_request(&gaming_control_max_little_qos, PM_QOS_CLUSTER0_FREQ_MAX, PM_QOS_CLUSTER0_FREQ_MAX_DEFAULT_VALUE);
	pm_qos_add_request(&gaming_control_min_big_qos, PM_QOS_CLUSTER2_FREQ_MIN, PM_QOS_CLUSTER2_FREQ_MIN_DEFAULT_VALUE);
	pm_qos_add_request(&gaming_control_max_big_qos, PM_QOS_CLUSTER2_FREQ_MAX, PM_QOS_CLUSTER2_FREQ_MAX_DEFAULT_VALUE);
	pm_qos_add_request(&gaming_control_min_mid_qos, PM_QOS_CLUSTER1_FREQ_MIN, PM_QOS_CLUSTER1_FREQ_MIN_DEFAULT_VALUE);
	pm_qos_add_request(&gaming_control_max_mid_qos, PM_QOS_CLUSTER1_FREQ_MAX, PM_QOS_CLUSTER1_FREQ_MAX_DEFAULT_VALUE);
	
	gaming_control_kobj = kobject_create_and_add("gaming_control", kernel_kobj);
	if (!gaming_control_kobj) {
		pr_err("%s gaming_control kobject create failed!\n", __FUNCTION__);
		return -ENOMEM;
	}

	sysfs_result = sysfs_create_group(gaming_control_kobj,
			&gaming_control_control_group);

	if (sysfs_result) {
		pr_info("%s gaming_control sysfs create failed!\n", __FUNCTION__);
		kobject_put(gaming_control_kobj);
	}

	return sysfs_result;
}


static void gaming_control_exit(void)
{
	pm_qos_remove_request(&gaming_control_min_mif_qos);
	pm_qos_remove_request(&gaming_control_min_little_qos);
	pm_qos_remove_request(&gaming_control_max_little_qos);
	pm_qos_remove_request(&gaming_control_min_mid_qos);
	pm_qos_remove_request(&gaming_control_max_mid_qos);
	pm_qos_remove_request(&gaming_control_min_big_qos);
	pm_qos_remove_request(&gaming_control_max_big_qos);

	if (gaming_control_kobj != NULL)
		kobject_put(gaming_control_kobj);
}

module_init(gaming_control_init);
module_exit(gaming_control_exit);
