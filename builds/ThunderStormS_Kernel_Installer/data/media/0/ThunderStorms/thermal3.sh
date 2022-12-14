#!/system/bin/sh
# 
# Thermal TSKernel
#

TS_DIR="/data/.tskernel"
LOG="$TS_DIR/tskernel.log"
sleep 5

    ## Thermal settings
    echo "## -- Thermal settings by ThundeRStormS" >> $LOG;
    # BIG Cluster
    echo "20000" > /sys/devices/virtual/thermal/thermal_zone0/trip_point_0_temp  # 20000
    echo "5000" > /sys/devices/virtual/thermal/thermal_zone0/trip_point_0_hyst   # 5000
    echo "57000" > /sys/devices/virtual/thermal/thermal_zone0/trip_point_1_temp  # 55000
    echo "3000" > /sys/devices/virtual/thermal/thermal_zone0/trip_point_1_hyst   # 2000
    echo "82000" > /sys/devices/virtual/thermal/thermal_zone0/trip_point_2_temp  # 83000
    echo "5000" > /sys/devices/virtual/thermal/thermal_zone0/trip_point_2_hyst   # 5000
    echo "87000" > /sys/devices/virtual/thermal/thermal_zone0/trip_point_3_temp  # 95000
    echo "5000" > /sys/devices/virtual/thermal/thermal_zone0/trip_point_3_hyst   # 5000
    echo "90000" > /sys/devices/virtual/thermal/thermal_zone0/trip_point_4_temp  # 100000
    echo "5000" > /sys/devices/virtual/thermal/thermal_zone0/trip_point_4_hyst   # 5000
    echo "93000" > /sys/devices/virtual/thermal/thermal_zone0/trip_point_5_temp  # 105000
    echo "5000" > /sys/devices/virtual/thermal/thermal_zone0/trip_point_5_hyst   # 5000
    echo "95000" > /sys/devices/virtual/thermal/thermal_zone0/trip_point_6_temp  # 110000
    echo "4000" > /sys/devices/virtual/thermal/thermal_zone0/trip_point_6_hyst   # 5000
    echo "97000" > /sys/devices/virtual/thermal/thermal_zone0/trip_point_7_temp  # 115000
    echo "4000" > /sys/devices/virtual/thermal/thermal_zone0/trip_point_7_hyst   # 5000
    # MID Cluster
    echo "20000" > /sys/devices/virtual/thermal/thermal_zone1/trip_point_0_temp  # 20000
    echo "5000" > /sys/devices/virtual/thermal/thermal_zone1/trip_point_0_hyst   # 5000
    echo "57000" > /sys/devices/virtual/thermal/thermal_zone1/trip_point_1_temp  # 55000
    echo "3000" > /sys/devices/virtual/thermal/thermal_zone1/trip_point_1_hyst   # 2000
    echo "82000" > /sys/devices/virtual/thermal/thermal_zone1/trip_point_2_temp  # 83000
    echo "5000" > /sys/devices/virtual/thermal/thermal_zone1/trip_point_2_hyst   # 5000
    echo "87000" > /sys/devices/virtual/thermal/thermal_zone1/trip_point_3_temp  # 95000
    echo "5000" > /sys/devices/virtual/thermal/thermal_zone1/trip_point_3_hyst   # 5000
    echo "89000" > /sys/devices/virtual/thermal/thermal_zone1/trip_point_4_temp  # 100000
    echo "5000" > /sys/devices/virtual/thermal/thermal_zone1/trip_point_4_hyst   # 5000
    echo "90000" > /sys/devices/virtual/thermal/thermal_zone1/trip_point_5_temp  # 105000
    echo "4000" > /sys/devices/virtual/thermal/thermal_zone1/trip_point_5_hyst   # 5000
    echo "95000" > /sys/devices/virtual/thermal/thermal_zone1/trip_point_6_temp  # 110000
    echo "4000" > /sys/devices/virtual/thermal/thermal_zone1/trip_point_6_hyst   # 5000
    echo "97000" > /sys/devices/virtual/thermal/thermal_zone1/trip_point_7_temp  # 115000
    echo "4000" > /sys/devices/virtual/thermal/thermal_zone1/trip_point_7_hyst   # 5000
    # LITTLE Cluster
    echo "20000" > /sys/devices/virtual/thermal/thermal_zone2/trip_point_0_temp  # 20000
    echo "5000" > /sys/devices/virtual/thermal/thermal_zone2/trip_point_0_hyst   # 5000
    echo "58000" > /sys/devices/virtual/thermal/thermal_zone2/trip_point_1_temp  # 76000
    echo "3000" > /sys/devices/virtual/thermal/thermal_zone2/trip_point_1_hyst   # 2000
    echo "82000" > /sys/devices/virtual/thermal/thermal_zone2/trip_point_2_temp  # 83000
    echo "5000" > /sys/devices/virtual/thermal/thermal_zone2/trip_point_2_hyst   # 5000
    echo "87000" > /sys/devices/virtual/thermal/thermal_zone2/trip_point_3_temp  # 95000
    echo "5000" > /sys/devices/virtual/thermal/thermal_zone2/trip_point_3_hyst   # 5000
    echo "88000" > /sys/devices/virtual/thermal/thermal_zone2/trip_point_4_temp  # 100000
    echo "5000" > /sys/devices/virtual/thermal/thermal_zone2/trip_point_4_hyst   # 5000
    echo "93000" > /sys/devices/virtual/thermal/thermal_zone2/trip_point_5_temp  # 105000
    echo "4000" > /sys/devices/virtual/thermal/thermal_zone2/trip_point_5_hyst   # 5000
    echo "95000" > /sys/devices/virtual/thermal/thermal_zone2/trip_point_6_temp  # 110000
    echo "4000" > /sys/devices/virtual/thermal/thermal_zone2/trip_point_6_hyst   # 5000
    echo "97000" > /sys/devices/virtual/thermal/thermal_zone2/trip_point_7_temp  # 115000
    echo "4000" > /sys/devices/virtual/thermal/thermal_zone2/trip_point_7_hyst   # 5000
    # GPU
    echo "20000" > /sys/devices/virtual/thermal/thermal_zone3/trip_point_0_temp  # 20000
    echo "5000" > /sys/devices/virtual/thermal/thermal_zone3/trip_point_0_hyst   # 5000
    echo "80000" > /sys/devices/virtual/thermal/thermal_zone3/trip_point_1_temp  # 78000
    echo "3000" > /sys/devices/virtual/thermal/thermal_zone3/trip_point_1_hyst   # 2000
    echo "87000" > /sys/devices/virtual/thermal/thermal_zone3/trip_point_2_temp  # 88000
    echo "5000" > /sys/devices/virtual/thermal/thermal_zone3/trip_point_2_hyst   # 5000
    echo "90000" > /sys/devices/virtual/thermal/thermal_zone3/trip_point_3_temp  # 105000
    echo "5000" > /sys/devices/virtual/thermal/thermal_zone3/trip_point_3_hyst   # 5000
    echo "93000" > /sys/devices/virtual/thermal/thermal_zone3/trip_point_4_temp  # 110000
    echo "5000" > /sys/devices/virtual/thermal/thermal_zone3/trip_point_4_hyst   # 5000
    echo "95000" > /sys/devices/virtual/thermal/thermal_zone3/trip_point_5_temp  # 115000
    echo "5000" > /sys/devices/virtual/thermal/thermal_zone3/trip_point_5_hyst   # 5000
    echo "96000" > /sys/devices/virtual/thermal/thermal_zone3/trip_point_6_temp  # 115000
    echo "4000" > /sys/devices/virtual/thermal/thermal_zone3/trip_point_6_hyst   # 5000
    echo "97000" > /sys/devices/virtual/thermal/thermal_zone3/trip_point_7_temp  # 115000
    echo "4000" > /sys/devices/virtual/thermal/thermal_zone3/trip_point_7_hyst   # 5000
    # ISP
    #echo "step_wise" > /sys/devices/virtual/thermal/thermal_zone4/policy
    # NPU
    #echo "step_wise" > /sys/devices/virtual/thermal/thermal_zone5/policy
    # AC
    #echo "step_wise" > /sys/devices/virtual/thermal/thermal_zone6/policy
    # BATTERY
    #echo "step_wise" > /sys/devices/virtual/thermal/thermal_zone7/policy
	echo " " >> $LOG;
    chmod 777 $LOG;

