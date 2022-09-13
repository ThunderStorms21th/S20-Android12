#!/system/bin/sh
# 
# Init TSKernel - GAMING PROFILE
#

TS_DIR="/data/.tskernel"
LOG="$TS_DIR/tskernel.log"
sleep 3

	echo " " >> $LOG;
    echo "## -- Initial GAMING Profile by ThundeRStormS" >> $LOG;
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
    echo "energy_step" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
    echo "442000" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
    echo "2002000" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
    # Midle CPU
    echo "energy_step" > /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor
    echo "507000" > /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq
    echo "2504000" > /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq
    # BIG CPU
    echo "energy_step" > /sys/devices/system/cpu/cpu6/cpufreq/scaling_governor
    echo "546000" > /sys/devices/system/cpu/cpu6/cpufreq/scaling_min_freq
    echo "2730000" > /sys/devices/system/cpu/cpu6/cpufreq/scaling_max_freq
    # BOOST CPU
    echo "1" > /sys/module/cpu_boost/parameters/sched_boost_on_input
    echo "100" > /sys/module/cpu_boost/parameters/input_boost_ms # 40
    echo "0:1300000 1:1300000 2:1300000 3:1300000 4:1066000 5:1066000 6:1066000 7:1066000" > /sys/module/cpu_boost/parameters/input_boost_freq
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
    echo "1024" > /proc/sys/kernel/random/write_wakeup_threshold
    echo "128" > /proc/sys/kernel/random/read_wakeup_threshold
    # VM
    echo "100" > /proc/sys/vm/vfs_cache_pressure
    echo "160" > /proc/sys/vm/swappiness
    echo "500" > /proc/sys/vm/dirty_writeback_centisecs
    echo "500" > /proc/sys/vm/dirty_expire_centisecs
    echo "60" > /proc/sys/vm/overcommit_ratio
    echo "10" > /proc/sys/vm/dirty_ratio
    echo "5" > /proc/sys/vm/dirty_background_ratio
    echo "750" > /proc/sys/vm/extfrag_threshold
    echo "10" > /proc/sys/vm/stat_interval
    # Fs
    echo "0" > /proc/sys/fs/dir-notify-enable
    echo "10" > /proc/sys/fs/lease-break-time
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
    # GPU set at max/min freq
    echo "897000" > /sys/kernel/gpu/gpu_max_clock
    echo "156000" > /sys/kernel/gpu/gpu_min_clock
    echo "adaptive" > /sys/devices/platform/18500000.mali/power_policy
    echo "1" > /sys/devices/platform/18500000.mali/dvfs_governor
    echo "572000" > /sys/devices/platform/18500000.mali/highspeed_clock
    echo "60" > /sys/devices/platform/18500000.mali/highspeed_load
    echo "0" > /sys/devices/platform/18500000.mali/highspeed_delay
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
    # echo "256" > /sys/block/sda/queue/read_ahead_kb
    echo "kyber" > /sys/block/mmcblk0/queue/scheduler
    # echo "256" > /sys/block/mmcblk0/queue/read_ahead_kb
    echo "0" > /sys/block/sda/queue/iostats
    echo "0" > /sys/block/mmcblk0/queue/iostats
    echo "1" > /sys/block/sda/queue/rq_affinity
    echo "1" > /sys/block/mmcblk0/queue/rq_affinity
    echo "256" > /sys/block/sda/queue/nr_requests   # 128
    echo "256" > /sys/block/mmcblk0/queue/nr_requests   # 128
    echo "1" > /sys/block/sda/queue/iosched/low_latency

    for queue in /sys/block/*/queue
    do
      echo "0" > "$queue/iostats"
      echo "256" > "$queue/nr_requests"
      echo "0" > "$queue/add_random"
      echo "1" > "$queue/iosched/low_latency"
      echo "1" > "$queue/rq_affinity"
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
    echo "5" > /dev/stune/schedtune.boost					# 0
    echo "0" > /dev/stune/schedtune.prefer_idle				# 0
    echo "0" > /dev/stune/schedtune.prefer_perf				# 0
    # TOP-APP
    echo "5" > /dev/stune/top-app/schedtune.boost			# 0
    echo "0" > /dev/stune/top-app/schedtune.prefer_idle		# 1
    echo "0" > /dev/stune/top-app/schedtune.prefer_perf		# 0
    # RT
    echo "3" > /dev/stune/rt/schedtune.boost				# 0
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
    echo "0-3" >   /dev/cpuset/restricted/cpus			# 0-7
    # ABNORMAL 
    echo "0-3" >   /dev/cpuset/abnormal/cpus			# 0-3
    # GLOBAL
    echo "0-7" > /dev/cpuset/cpus						# 0-7
    # TOP-APP
    echo "0-7" > /dev/cpuset/top-app/cpus				# 0-7
    # FOREGROUND
    echo "0-3,4-5" > /dev/cpuset/foreground/cpus		# 0-2,4-7
    # BACKGROUND
    echo "0-1" > /dev/cpuset/background/cpus			# 0-2
    # SYSTEM-BACKGROUND
    echo "0-2" > /dev/cpuset/system-background/cpus		# 0-2
    # MODERATE
    echo "0-2,4-6" > /dev/cpuset/moderate/cpus			# 0-2,4-6
    # DEXOPT
    echo "0-7" > /dev/cpuset/dexopt/cpus				# 0-3
    ## Kernel Scheduler
    echo "## -- Kernel scheduler settings" >> $LOG;
    echo "16000000" > /proc/sys/kernel/sched_wakeup_granularity_ns # 2000000
    echo "400000" > /proc/sys/kernel/sched_latency_ns # 10000000
    echo "6000000" > /proc/sys/kernel/sched_min_granularity_ns # 950000
    echo "600000" > /proc/sys/kernel/sched_migration_cost_ns # 500000
    echo "1000000" > /proc/sys/kernel/sched_rt_period_us
    echo "1000000" > /proc/sys/kernel/sched_rt_runtime_us # 950000
    echo "5" > /proc/sys/kernel/sched_rr_timeslice_ms  # 3
    echo "64" > /proc/sys/kernel/sched_nr_migrate # 0, 64
    echo "0" > /sys/module/cpuidle/parameters/off  # 0
    echo "default" > /sys/module/pcie_aspm/parameters/policy
    ## policy - default performance powersave powersupersave
    echo "ff" > /proc/irq/default_smp_affinity  # 01
    echo "ff" > /sys/bus/workqueue/devices/writeback/cpumask   # ff
    echo "ff" > /sys/devices/virtual/workqueue/cpumask   # ff
    echo "2" > /proc/sys/kernel/perf_cpu_time_max_percent  # 25
    echo "100000" > /proc/sys/kernel/perf_event_max_sample_rate # 100000
    echo "516" > /proc/sys/kernel/perf_event_mlock_kb  # 516 565
    echo "0" > /dev/cpuset/sched_load_balance   # 0
    echo "0" > /proc/sys/kernel/timer_migration # 1
    echo "0" > /proc/sys/kernel/sched_schedstats # 1
   # Thermal Governors
   # BIG Cluster
   echo "step_wise" > /sys/devices/virtual/thermal/thermal_zone0/policy
   # MID Cluster
   echo "step_wise" > /sys/devices/virtual/thermal/thermal_zone1/policy
   # LITTLE Cluster
   echo "step_wise" > /sys/devices/virtual/thermal/thermal_zone2/policy
   # GPU
   echo "step_wise" > /sys/devices/virtual/thermal/thermal_zone3/policy
   # ISP
   echo "step_wise" > /sys/devices/virtual/thermal/thermal_zone4/policy
   # NPU
   echo "step_wise" > /sys/devices/virtual/thermal/thermal_zone5/policy
   # AC
   echo "step_wise" > /sys/devices/virtual/thermal/thermal_zone6/policy
   # BATTERY
   echo "step_wise" > /sys/devices/virtual/thermal/thermal_zone7/policy
    # Boeffla wakelocks
    chmod 0644 /sys/devices/virtual/misc/boeffla_wakelock_blocker/wakelock_blocker
    # umts_ipc0 - CPU max freq bug, 19050000.decon.f - bug wakeup - black screen
    echo 'event0;GPSD;NETLINK;ssp_comm_wake_lock;epoll_system_server_file:[timerfd4_system_server];epoll_system_server_file:[timerfd7_system_server];epoll_InputReader_file:event1;epoll_system_server_file:[timerfd5_system_server];epoll_InputReader_file:event10;epoll_InputReader_file:event0;epoll_InputReader_epollfd;epoll_system_server_epollfd' > /sys/devices/virtual/misc/boeffla_wakelock_blocker/wakelock_blocker

	echo " " >> $LOG;

    chmod 777 $LOG;

