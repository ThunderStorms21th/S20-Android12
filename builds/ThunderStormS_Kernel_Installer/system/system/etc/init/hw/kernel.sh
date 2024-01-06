#!/system/bin/sh
# 
# Init TSKernel
#

TS_DIR="/data/.tskernel"
LOG="$TS_DIR/tskernel.log"
sleep 15
rm -f $LOG

    # Create ThunderStormS and init.d folder
    if [ ! -d $TS_DIR ]; then
	    mkdir -p $TS_DIR;
    fi
    # Create init.d folder
    mkdir -p /vendor/etc/init.d;
	chown -R root.root /vendor/etc/init.d;
	chmod 755 /vendor/etc/init.d;
	echo $(date) "TS-Kernel LOG" >> $LOG;
	echo " " >> $LOG;
	# SafetyNet
	# SELinux (0 / 640 = Permissive, 1 / 644 = Enforcing)
	echo "## -- SafetyNet permissions" >> $LOG;
	chmod 644 /sys/fs/selinux/enforce;
	chmod 440 /sys/fs/selinux/policy;
    echo "1" > /sys/fs/selinux/enforce
	echo " " >> $LOG;
	# deepsleep fix
	echo "## -- DeepSleep Fix" >> $LOG;
    dmesg -n 1 -C
	echo "N" > /sys/kernel/debug/debug_enabled
	echo "N" > /sys/kernel/debug/seclog/seclog_debug
	echo "0" > /sys/kernel/debug/tracing/tracing_on
	echo "0" > /sys/module/lowmemorykiller/parameters/debug_level
    echo "0" > /sys/module/alarm_dev/parameters/debug_mask
    echo "0" > /sys/module/binder/parameters/debug_mask
    echo "0" > /sys/module/binder_alloc/parameters/debug_mask
    echo "0" > /sys/module/xt_qtaguid/parameters/debug_mask
    echo "0" > /sys/module/kernel/parameters/initcall_debug
    echo "off" > /proc/sys/kernel/printk_devkmsg
    echo "0" > /sys/module/glink/parameters/debug_mask
    echo "0" > /sys/module/hid_apple/parameters/fnmode
    echo "0" > /sys/module/dwc3/parameters/ep_addr_txdbg_mask
    echo "0" > /sys/module/hid_magicmouse/parameters/scroll_speed
    echo "Y" > /sys/module/libcomposite/parameters/disable_l1_for_hs
    echo "0" > /sys/module/hid/parameters/debug
    echo "0" > /sys/module/hid_apple/parameters/iso_layout
    echo "0" > /sys/module/edac_core/parameters/edac_mc_log_ue
    echo "0" > /sys/module/event_timer/parameters/debug_mask
    echo "0" > /sys/module/edac_core/parameters/edac_mc_log_ce
    echo "0" > /sys/module/drm/parameters/debug
    echo "N" > /sys/module/ppp_generic/parameters/mp_protocol_compress
    echo "N" > /sys/module/sit/parameters/log_ecn_error
    echo "0" > /sys/module/smp2p/parameters/debug_mask
    echo "0" > /sys/module/usb_bam/parameters/enable_event_log
    echo "Y" > /sys/module/printk/parameters/console_suspend
    echo "0" > /sys/module/suspend/parameters/pm_test_delay
    echo "Y" > /sys/module/printk/parameters/ignore_log_level
    echo "0" > /sys/module/scsi_mod/parameters/scsi_logging_level
    echo "0" > /sys/module/dns_resolver/parameters/debug
    echo "0" > /proc/sys/debug/exception-trace
    echo "0 0 0 0" > /proc/sys/kernel/printk
    echo "0" > /proc/sys/kernel/compat-log
    echo "N" > /sys/module/printk/parameters/time
    echo "1" > /sys/module/hid/parameters/ignore_special_drivers
    echo "0" > /sys/module/icnss/parameters/dynamic_feature_mask
    echo "0" > /sys/module/diagchar/parameters/diag_mask_clear_param
    echo "1" > /sys/module/subsystem_restart/parameters/disable_restart_work
    echo "0" > /sys/module/qpnp_fg_gen3/parameters/debug_mask
    echo "0" > /sys/module/qpnp_smb2/parameters/debug_mask
    # disable cpuidle log
    echo "0" > /sys/module/cpuidle_exynos64/parameters/log_en
    debug="/sys/module/*" 2>/dev/null
    for i in \$debug
    do
	    if [ -e \$DD/parameters/debug_mask ]
	    then
		    echo "0" >  \$i/parameters/debug_mask
	    fi
    done
    for i in `ls /sys/class/scsi_disk/`; do
	    cat /sys/class/scsi_disk/$i/write_protect 2>/dev/null | grep 1 >/dev/null
	    if [ $? -eq 0 ]; then
		    echo 'temporary none' > /sys/class/scsi_disk/$i/cache_type
	    fi
    done
	echo " " >> $LOG;
    # Initial ThundeRStormS settings
	echo "## -- Initial settings by ThundeRStormS" >> $LOG;
    # Kernel Panic off (0 = Disabled, 1 = Enabled)
    echo "0" > /proc/sys/kernel/panic
    # POWER EFFCIENT WORKQUEUE (0/N = Disabled, 1/Y = Enabled)
    echo "N" > /sys/module/workqueue/parameters/power_efficient
    # BATTERY SAVER (0/N = Disabled, 1/Y = Enabled)
    echo "N" > /sys/module/battery_saver/parameters/enabled
    # CPU set at max/min freq
    # Little CPU
    #echo "schedutil" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
    echo "442000" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
    echo "2106000" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
    # Midle CPU
    #echo "schedutil" > /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor
    echo "377000" > /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq
    echo "2504000" > /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq
    # BIG CPU
    #echo "schedutil" > /sys/devices/system/cpu/cpu6/cpufreq/scaling_governor
    echo "546000" > /sys/devices/system/cpu/cpu6/cpufreq/scaling_min_freq
    echo "2730000" > /sys/devices/system/cpu/cpu6/cpufreq/scaling_max_freq
    # BOOST CPU
    echo "1" > /sys/module/cpu_boost/parameters/sched_boost_on_input
    echo "50" > /sys/module/cpu_boost/parameters/input_boost_ms # 40
    echo "0:1300000 1:1300000 2:1300000 3:1300000 4:1690000 5:1690000 6:1482000 7:1482000" > /sys/module/cpu_boost/parameters/input_boost_freq
    # Wakelock settigs
    echo "N" > /sys/module/wakeup/parameters/enable_sensorhub_wl
    echo "N" > /sys/module/wakeup/parameters/enable_ssp_wl
    echo "N" > /sys/module/wakeup/parameters/enable_bcmdhd4359_wl
    echo "Y" > /sys/module/wakeup/parameters/enable_bluedroid_timer_wl
    echo "N" > /sys/module/wakeup/parameters/enable_wlan_wake_wl
    echo "N" > /sys/module/wakeup/parameters/enable_wlan_ctrl_wake_wl
    echo "N" > /sys/module/wakeup/parameters/enable_wlan_rx_wake_wl
    echo "N" > /sys/module/wakeup/parameters/enable_wlan_wd_wake_wl
    echo "Y" > /sys/module/wakeup/parameters/enable_mmc0_detect_wl
    echo "8" > /sys/module/sec_battery/parameters/wl_polling
    echo "1" > /sys/module/sec_nfc/parameters/wl_nfc
    # Entropy
    echo "768" > /proc/sys/kernel/random/write_wakeup_threshold # 896
    echo "64" > /proc/sys/kernel/random/read_wakeup_threshold   # 64
    echo "90" > /proc/sys/kernel/random/urandom_min_reseed_secs # 60 90
    # VM
    echo "100" > /proc/sys/vm/vfs_cache_pressure        # 100
    echo "60" > /proc/sys/vm/swappiness                 # 160 60
    echo "1000" > /proc/sys/vm/dirty_writeback_centisecs # 500
    echo "2000" > /proc/sys/vm/dirty_expire_centisecs
    echo "60000" > /proc/sys/vm/dirtytime_expire_seconds
    echo "50" > /proc/sys/vm/overcommit_ratio           # 50
    echo "20" > /proc/sys/vm/dirty_ratio                # 30
    echo "10" > /proc/sys/vm/dirty_background_ratio
    echo "750" > /proc/sys/vm/extfrag_threshold         # 500 750
    echo "60" > /proc/sys/vm/stat_interval              # 1 30
    echo "1" > /proc/sys/vm/compact_unevictable_allowed # 1
    echo "3" > /proc/sys/vm/drop_caches                 # 0
    # Fs
    echo "0" > /proc/sys/fs/dir-notify-enable
    echo "10" > /proc/sys/fs/lease-break-time           # 40 10
    echo "131072" > /proc/sys/fs/aio-max-nr
    # ZRAM
    # swapoff /dev/block/zram0 > /dev/null 2>&1
    # echo "1" > /sys/block/zram0/reset
    # echo "1073741824" > /sys/block/zram0/disksize  # 1,0 GB
    # echo "1610612736" > /sys/block/zram0/disksize  # 1,5 GB
    # echo "2147483648" > /sys/block/zram0/disksize  # 2,0 GB
    # echo "2684354560" > /sys/block/zram0/disksize  # 2,5 GB
    # echo "3221225472" > /sys/block/zram0/disksize  # 3,0 GB
    # echo "4194304000" > /sys/block/zram0/disksize  # 4,0 GB
    # echo "6291456000" > /sys/block/zram0/disksize  # 6,0 GB
    # echo "8388608000" > /sys/block/zram0/disksize  # 8,0 GB
    # chmod 644 /dev/block/zram0
    # mkswap /dev/block/zram0 > /dev/null 2>&1
    # swapon /dev/block/zram0 > /dev/null 2>&1
    echo "1" > /sys/block/zram0/max_comp_streams    # 8, 1
    echo "128" > /sys/block/zram0/queue/read_ahead_kb # 128
    echo "32" > /sys/block/zram0/queue/nr_requests  # 32
    echo "1" > /sys/block/zram0/queue/rq_affinity
    echo "0" > /sys/block/zram0/queue/nomerges      # 1
    # GPU set at max/min freq
    echo "897000" > /sys/kernel/gpu/gpu_max_clock
    echo "156000" > /sys/kernel/gpu/gpu_min_clock
    echo "adaptive" > /sys/devices/platform/18500000.mali/power_policy
    echo "1" > /sys/devices/platform/18500000.mali/dvfs_governor
    echo "377000" > /sys/devices/platform/18500000.mali/highspeed_clock
    echo "90" > /sys/devices/platform/18500000.mali/highspeed_load
    echo "1" > /sys/devices/platform/18500000.mali/highspeed_delay
    echo "0" > /sys/kernel/gpu/gpu_cl_boost_disable  # 0
    # Misc settings : bbr, cubic or westwood
    echo "westwood" > /proc/sys/net/ipv4/tcp_congestion_control
    echo "0" > /proc/sys/net/ipv4/tcp_timestamps
    echo "1" > /proc/sys/net/ipv4/tcp_ecn
    echo "N" > /sys/module/mmc_core/parameters/use_spi_crc
    echo "1" > /sys/module/sync/parameters/fsync_enabled
    echo "0" > /sys/kernel/sched/gentle_fair_sleepers
    # I/O sched settings
    echo "cfq" > /sys/block/sda/queue/scheduler
    #echo "256" > /sys/block/sda/queue/read_ahead_kb
    echo "kyber" > /sys/block/mmcblk0/queue/scheduler
    #echo "256" > /sys/block/mmcblk0/queue/read_ahead_kb
    echo "0" > /sys/block/sda/queue/iostats
    echo "0" > /sys/block/mmcblk0/queue/iostats
    echo "1" > /sys/block/sda/queue/rq_affinity
    echo "1" > /sys/block/mmcblk0/queue/rq_affinity
    echo "120" > /sys/fs/f2fs/sda32/cp_interval # 60 180
    for queue in /sys/block/*/queue
    do
      echo "0" > "$queue/iostats"               # 1
      echo "64" > "$queue/nr_requests"         # 64
      echo "0" > "$queue/add_random"            # 0
      echo "0" > "$queue/iosched/low_latency"   # 0
      echo "1" > "$queue/rq_affinity"           # 1
      echo "0" > "$queue/nomerges"              # 2
      echo "8" > "$queue/iosched/quantum"       # 8
    done
    echo "128" > /sys/block/sda/queue/nr_requests           # 128
    echo "128" > /sys/block/mmcblk0/queue/nr_requests       # 128
    echo "1" > /sys/block/sda/queue/iosched/low_latency     # 0
    echo "1" > /sys/block/mmcblk0/queue/iosched/low_latency # 0
    # Slightly decrease back_seek_max for improved fluidity
    for bsm in /sys/block/sd*/queue/iosched; do
      echo "8192" > $bsm/back_seek_max      # 8192 16384
    done
    ## Devfreq
    # default 2730 MHz
    echo "2730000" > /sys/devices/platform/17000010.devfreq_mif/devfreq/17000010.devfreq_mif/max_freq
    # Better DeepSleep 
    # echo "mem" > /sys/power/autosleep
    echo "deep" > /sys/power/mem_sleep  # s2idle deep
    # Initial ThundeRStormS Stune and CPU set settings
    echo "## -- Initial Stune settings by ThundeRStormS" >> $LOG;
    ## Kernel Stune								 DEFAULT VALUES
    # GLOBAL
    echo "1" > /dev/stune/schedtune.boost					# 0
    echo "0" > /dev/stune/schedtune.prefer_idle				# 0
    echo "0" > /dev/stune/schedtune.prefer_perf				# 0
    # TOP-APP
    echo "3" > /dev/stune/top-app/schedtune.boost			# 0
    echo "0" > /dev/stune/top-app/schedtune.prefer_idle		# 1
    echo "0" > /dev/stune/top-app/schedtune.prefer_perf		# 0
    # RT
    echo "0" > /dev/stune/rt/schedtune.boost				# 0
    echo "0" > /dev/stune/rt/schedtune.prefer_idle			# 0
    echo "0" > /dev/stune/rt/schedtune.prefer_perf			# 0
    # FOREGROUND-APP
    echo "0" > /dev/stune/foreground/schedtune.boost		# 0
    echo "0" > /dev/stune/foreground/schedtune.prefer_idle	# 0
    echo "0" > /dev/stune/foreground/schedtune.prefer_perf	# 0
    # BACKGROUND-APP
    echo "0" > /dev/stune/background/schedtune.boost		# 0
    echo "0" > /dev/stune/background/schedtune.prefer_idle	# 0
    echo "0" > /dev/stune/background/schedtune.prefer_perf	# 0
    # CPU SET
    # RESTRICKTED 
    echo "0-7" >   /dev/cpuset/restricted/cpus			# 0-7
    # ABNORMAL 
    echo "0-3" >   /dev/cpuset/abnormal/cpus			# 0-3
    # GLOBAL
    echo "0-7" > /dev/cpuset/cpus						# 0-7
    # TOP-APP
    echo "0-7" > /dev/cpuset/top-app/cpus				# 0-7
    # FOREGROUND
    echo "0-2,4-7" > /dev/cpuset/foreground/cpus		# 0-2,4-7
    # BACKGROUND
    echo "0-2" > /dev/cpuset/background/cpus			# 0-2
    # SYSTEM-BACKGROUND
    echo "0-2" > /dev/cpuset/system-background/cpus		# 0-2
    # MODERATE
    echo "0-2,4-6" > /dev/cpuset/moderate/cpus			# 0-2,4-6
    # DEXOPT
    echo "0-3" > /dev/cpuset/dexopt/cpus				# 0-3
    # CAMERA
    echo "0-3, 5-7" > /dev/cpuset/camera-deamon/cpus    # 0-3, 6-7
    ## Kernel Scheduler
    echo "## -- Kernel scheduler settings" >> $LOG;
    echo "7000000" > /proc/sys/kernel/sched_wakeup_granularity_ns   # 2000000
    echo "400000" > /proc/sys/kernel/sched_latency_ns               # 10000000
    echo "1000000" > /proc/sys/kernel/sched_min_granularity_ns      # 950000
    echo "500000" > /proc/sys/kernel/sched_migration_cost_ns        # 500000
    echo "1000000" > /proc/sys/kernel/sched_rt_period_us            # 1000000
    echo "950000" > /proc/sys/kernel/sched_rt_runtime_us            # 950000
    echo "30" > /proc/sys/kernel/sched_rr_timeslice_ms  # 3
    echo "64" > /proc/sys/kernel/sched_nr_migrate       # 32, 0, 64
    echo "0" > /sys/module/cpuidle/parameters/off       # 0
    echo "default" > /sys/module/pcie_aspm/parameters/policy
    ## policy - default performance powersave powersupersave
    echo "0f" > /proc/irq/default_smp_affinity                  # 01
    echo "ff" > /sys/bus/workqueue/devices/writeback/cpumask    # ff
    echo "ff" > /sys/devices/virtual/workqueue/cpumask          # ff
    echo "15" > /proc/sys/kernel/perf_cpu_time_max_percent      # 25
    echo "100000" > /proc/sys/kernel/perf_event_max_sample_rate # 100000
    echo "516" > /proc/sys/kernel/perf_event_mlock_kb           # 516 565
    echo "0" > /dev/cpuset/sched_load_balance       # 0
    echo "0" > /proc/sys/kernel/timer_migration     # 1
    echo "0" > /proc/sys/kernel/sched_schedstats    # 1
    ## Devices Misc
    echo "2106000" > /sys/devices/platform/exynos-migov/cl0/cl0_pm_qos_max_freq # -1 CPU1
    echo "2504000" > /sys/devices/platform/exynos-migov/cl1/cl1_pm_qos_max_freq # 2314000 CPU4
    echo "2730000" > /sys/devices/platform/exynos-migov/cl2/cl2_pm_qos_max_freq # 1898000 CPU6
    echo "0" > /sys/devices/virtual/thermal/thermal_zone2/sustainable_power     # 0 CPU0
    echo "500" > /sys/devices/virtual/thermal/thermal_zone1/sustainable_power   # 500 CPU4
    echo "1000" > /sys/devices/virtual/thermal/thermal_zone0/sustainable_power  # 1000 CPU6
    echo "1500" > /sys/devices/virtual/thermal/thermal_zone3/sustainable_power  # 1500 GPU
    # Use RCU_normal instead of RCU_expedited for improved real-time latency, CPU utilization and energy efficiency - TweaksBatteryExtremeX
    echo "0" > /sys/kernel/rcu_expedited    # 1
    echo "1" > /sys/kernel/rcu_normal       # 0
    # echo "1" > /sys/devices/system/cpu/cpuidle/use_deepest_state # 1
    ## Boeffla wakelocks
    chmod 0644 /sys/devices/virtual/misc/boeffla_wakelock_blocker/wakelock_blocker
    # umts_ipc0 - CPU max freq bug, 19050000.decon.f - bug wakeup - black screen
    echo 'event0;GPSD;NETLINK;ssp_comm_wake_lock;epoll_system_server_file:[timerfd4_system_server];epoll_system_server_file:[timerfd7_system_server];epoll_InputReader_file:event1;epoll_system_server_file:[timerfd5_system_server];epoll_InputReader_file:event10;epoll_InputReader_file:event0;epoll_InputReader_epollfd;epoll_system_server_epollfd' > /sys/devices/virtual/misc/boeffla_wakelock_blocker/wakelock_blocker
	echo " " >> $LOG;
	## Noatime settings
    echo "## -- Noatime mount settings" >> $LOG;
    mount -o remount,nosuid,nodev,noatime,nodiratime -t auto /;
    mount -o remount,nosuid,nodev,noatime,nodiratime -t auto /proc;
    mount -o remount,nosuid,nodev,noatime,nodiratime -t auto /sys;
    mount -o remount,nodev,noatime,nodiratime,barrier=0,noauto_da_alloc,discard -t auto /system;
	echo " " >> $LOG;
	# Init.d support
	echo "## -- Start Init.d support" >> $LOG;
	if [ ! -d /vendor/etc/init.d ]; then
	    	mkdir -p /vendor/etc/init.d;
	fi
	chown -R root.root /vendor/etc/init.d;
	chmod 755 /vendor/etc/init.d;
	# remove detach script
	rm -f /vendor/etc/init.d/*detach* 2>/dev/null;
	rm -rf /data/magisk_backup_* 2>/dev/null;
	if [ "$(ls -A /vendor/etc/init.d)" ]; then
		chmod 755 /vendor/etc/init.d/*;
		for FILE in /vendor/etc/init.d/*; do
			echo "## -- Executing init.d script: $FILE" >> $LOG;
			sh $FILE >/dev/null;
	    	done;
	else
		echo "## -- No files found" >> $LOG;
	fi
	echo "## -- End Init.d support" >> $LOG;
	echo " " >> $LOG;
    chmod 777 $LOG;

