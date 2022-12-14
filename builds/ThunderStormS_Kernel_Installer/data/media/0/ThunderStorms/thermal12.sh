#!/system/bin/sh
# 
# Thermal TSKernel
#

TS_DIR="/data/.tskernel"
LOG="$TS_DIR/tskernel.log"
sleep 3

    ## Thermal settings
    echo "## -- Thermal settings by ThundeRStormS" >> $LOG;
    # BIG Cluster
    echo "20000" > /sys/devices/virtual/thermal/thermal_zone0/trip_point_0_temp  # 20000
    echo "5000" > /sys/devices/virtual/thermal/thermal_zone0/trip_point_0_hyst   # 5000
    echo "80000" > /sys/devices/virtual/thermal/thermal_zone0/trip_point_1_temp  # 55000
    echo "2000" > /sys/devices/virtual/thermal/thermal_zone0/trip_point_1_hyst   # 2000
    echo "82000" > /sys/devices/virtual/thermal/thermal_zone0/trip_point_2_temp  # 83000
    echo "5000" > /sys/devices/virtual/thermal/thermal_zone0/trip_point_2_hyst   # 5000
    echo "85000" > /sys/devices/virtual/thermal/thermal_zone0/trip_point_3_temp  # 95000
    echo "5000" > /sys/devices/virtual/thermal/thermal_zone0/trip_point_3_hyst   # 5000
    echo "87000" > /sys/devices/virtual/thermal/thermal_zone0/trip_point_4_temp  # 100000
    echo "5000" > /sys/devices/virtual/thermal/thermal_zone0/trip_point_4_hyst   # 5000
    echo "90000" > /sys/devices/virtual/thermal/thermal_zone0/trip_point_5_temp  # 105000
    echo "5000" > /sys/devices/virtual/thermal/thermal_zone0/trip_point_5_hyst   # 5000
    echo "95000" > /sys/devices/virtual/thermal/thermal_zone0/trip_point_6_temp  # 110000
    echo "5000" > /sys/devices/virtual/thermal/thermal_zone0/trip_point_6_hyst   # 5000
    echo "100000" > /sys/devices/virtual/thermal/thermal_zone0/trip_point_7_temp  # 115000
    echo "5000" > /sys/devices/virtual/thermal/thermal_zone0/trip_point_7_hyst   # 5000
    # MID Cluster
    echo "20000" > /sys/devices/virtual/thermal/thermal_zone1/trip_point_0_temp  # 20000
    echo "5000" > /sys/devices/virtual/thermal/thermal_zone1/trip_point_0_hyst   # 5000
    echo "80000" > /sys/devices/virtual/thermal/thermal_zone1/trip_point_1_temp  # 55000
    echo "2000" > /sys/devices/virtual/thermal/thermal_zone1/trip_point_1_hyst   # 2000
    echo "82000" > /sys/devices/virtual/thermal/thermal_zone1/trip_point_2_temp  # 83000
    echo "5000" > /sys/devices/virtual/thermal/thermal_zone1/trip_point_2_hyst   # 5000
    echo "85000" > /sys/devices/virtual/thermal/thermal_zone1/trip_point_3_temp  # 95000
    echo "5000" > /sys/devices/virtual/thermal/thermal_zone1/trip_point_3_hyst   # 50000
    echo "87000" > /sys/devices/virtual/thermal/thermal_zone1/trip_point_4_temp  # 100000
    echo "5000" > /sys/devices/virtual/thermal/thermal_zone1/trip_point_4_hyst   # 5000
    echo "90000" > /sys/devices/virtual/thermal/thermal_zone1/trip_point_5_temp  # 105000
    echo "5000" > /sys/devices/virtual/thermal/thermal_zone1/trip_point_5_hyst   # 5000
    echo "95000" > /sys/devices/virtual/thermal/thermal_zone1/trip_point_6_temp  # 110000
    echo "5000" > /sys/devices/virtual/thermal/thermal_zone1/trip_point_6_hyst   # 5000
    echo "100000" > /sys/devices/virtual/thermal/thermal_zone1/trip_point_7_temp  # 115000
    echo "5000" > /sys/devices/virtual/thermal/thermal_zone1/trip_point_7_hyst   # 5000
    # LITTLE Cluster
    echo "20000" > /sys/devices/virtual/thermal/thermal_zone2/trip_point_0_temp  # 20000
    echo "5000" > /sys/devices/virtual/thermal/thermal_zone2/trip_point_0_hyst   # 5000
    echo "80000" > /sys/devices/virtual/thermal/thermal_zone2/trip_point_1_temp  # 76000
    echo "2000" > /sys/devices/virtual/thermal/thermal_zone2/trip_point_1_hyst   # 2000
    echo "85000" > /sys/devices/virtual/thermal/thermal_zone2/trip_point_2_temp  # 83000
    echo "8000" > /sys/devices/virtual/thermal/thermal_zone2/trip_point_2_hyst   # 5000
    echo "87000" > /sys/devices/virtual/thermal/thermal_zone2/trip_point_3_temp  # 95000
    echo "5000" > /sys/devices/virtual/thermal/thermal_zone2/trip_point_3_hyst   # 5000
    echo "90000" > /sys/devices/virtual/thermal/thermal_zone2/trip_point_4_temp  # 100000
    echo "5000" > /sys/devices/virtual/thermal/thermal_zone2/trip_point_4_hyst   # 5000
    echo "92000" > /sys/devices/virtual/thermal/thermal_zone2/trip_point_5_temp  # 105000
    echo "5000" > /sys/devices/virtual/thermal/thermal_zone2/trip_point_5_hyst   # 5000
    echo "95000" > /sys/devices/virtual/thermal/thermal_zone2/trip_point_6_temp  # 110000
    echo "5000" > /sys/devices/virtual/thermal/thermal_zone2/trip_point_6_hyst   # 5000
    echo "100000" > /sys/devices/virtual/thermal/thermal_zone2/trip_point_7_temp  # 115000
    echo "5000" > /sys/devices/virtual/thermal/thermal_zone2/trip_point_7_hyst   # 5000
    # GPU
    echo "25000" > /sys/devices/virtual/thermal/thermal_zone3/trip_point_0_temp  # 20000
    echo "5000" > /sys/devices/virtual/thermal/thermal_zone3/trip_point_0_hyst   # 5000
    echo "85000" > /sys/devices/virtual/thermal/thermal_zone3/trip_point_1_temp  # 78000
    echo "3000" > /sys/devices/virtual/thermal/thermal_zone3/trip_point_1_hyst   # 2000
    echo "95000" > /sys/devices/virtual/thermal/thermal_zone3/trip_point_2_temp  # 88000
    echo "5000" > /sys/devices/virtual/thermal/thermal_zone3/trip_point_2_hyst   # 5000
    echo "100000" > /sys/devices/virtual/thermal/thermal_zone3/trip_point_3_temp  # 105000
    echo "5000" > /sys/devices/virtual/thermal/thermal_zone3/trip_point_3_hyst   # 5000
    echo "105000" > /sys/devices/virtual/thermal/thermal_zone3/trip_point_4_temp  # 110000
    echo "5000" > /sys/devices/virtual/thermal/thermal_zone3/trip_point_4_hyst   # 5000
    echo "107000" > /sys/devices/virtual/thermal/thermal_zone3/trip_point_5_temp  # 115000
    echo "5000" > /sys/devices/virtual/thermal/thermal_zone3/trip_point_5_hyst   # 5000
    echo "109000" > /sys/devices/virtual/thermal/thermal_zone3/trip_point_6_temp  # 115000
    echo "5000" > /sys/devices/virtual/thermal/thermal_zone3/trip_point_6_hyst   # 5000
    echo "110000" > /sys/devices/virtual/thermal/thermal_zone3/trip_point_7_temp  # 115000
    echo "5000" > /sys/devices/virtual/thermal/thermal_zone3/trip_point_7_hyst   # 5000
    # ISP
    #echo "step_wise" > /sys/devices/virtual/thermal/thermal_zone4/policy
    # NPU
    #echo "step_wise" > /sys/devices/virtual/thermal/thermal_zone5/policy
    # AC
    #echo "step_wise" > /sys/devices/virtual/thermal/thermal_zone6/policy
    # BATTERY
    #echo "step_wise" > /sys/devices/virtual/thermal/thermal_zone7/policy

     ## Devices Misc
    echo "2106000" > /sys/devices/platform/exynos-migov/cl0/cl0_pm_qos_max_freq # -1 CPU1
    echo "2504000" > /sys/devices/platform/exynos-migov/cl1/cl1_pm_qos_max_freq # 2314000 CPU4
    echo "2730000" > /sys/devices/platform/exynos-migov/cl2/cl2_pm_qos_max_freq # 1898000 CPU6
    echo "0" > /sys/devices/virtual/thermal/thermal_zone2/sustainable_power     # 0 CPU0
    echo "700" > /sys/devices/virtual/thermal/thermal_zone1/sustainable_power   # 500 CPU4
    echo "1300" > /sys/devices/virtual/thermal/thermal_zone0/sustainable_power   # 1000 CPU6
    echo "1800" > /sys/devices/virtual/thermal/thermal_zone3/sustainable_power  # 1500 GPU
    # Use RCU_normal instead of RCU_expedited for improved real-time latency, CPU utilization and energy efficiency - TweaksBatteryExtremeX
    echo "1" > /sys/kernel/rcu_expedited
    echo "0" > /sys/kernel/rcu_normal
     
    echo " " >> $LOG;
    chmod 777 $LOG;
