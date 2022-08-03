#!/system/bin/sh
# 
# Init Voltage TSKernel
#

TS_DIR="/data/.tskernel"
LOG="$TS_DIR/tskernel.log"
sleep 5

    # Create ThunderStormS and init.d folder
    if [ ! -d $TS_DIR ]; then
	    mkdir -p $TS_DIR;
    fi

    # Voltage CPUs

    # Voltage Little CPU : id 2, -12500uV
    echo '2 2106000 1062500' > /sys/power/dvfs_table # 1068750
    echo '2 2002000 1031250' > /sys/power/dvfs_table # 1043750
    echo '2 1950000 977500' > /sys/power/dvfs_table # 990000
    echo '2 1846000 943650' > /sys/power/dvfs_table # 956150
    echo '2 1742000 912500' > /sys/power/dvfs_table # 925000
    echo '2 1586000 843750' > /sys/power/dvfs_table # 856250
    echo '2 1456000 800000' > /sys/power/dvfs_table # 812500
    echo '2 1300000 750000' > /sys/power/dvfs_table # 768750
    echo '2 1157000 712500' > /sys/power/dvfs_table # 725000
    echo '2 1053000 681250' > /sys/power/dvfs_table # 700000
    echo '2 949000 656250' > /sys/power/dvfs_table # 675000
    echo '2 806000 625000' > /sys/power/dvfs_table # 643750
    echo '2 650000 593750' > /sys/power/dvfs_table # 606250
    echo '2 546000 568750' > /sys/power/dvfs_table # 581250
    echo '2 442000 543750' > /sys/power/dvfs_table # 556250

    # Voltage Mid CPU : id 3, -12500uV
    echo '3 2600000 1062500' > /sys/power/dvfs_table # 1075000
    echo '3 2504000 1031250' > /sys/power/dvfs_table # 1043750
    echo '3 2400000 975000' > /sys/power/dvfs_table # 987500
    echo '3 2314000 950000' > /sys/power/dvfs_table # 962500
    echo '3 2210000 912500' > /sys/power/dvfs_table # 925000
    echo '3 2106000 881250' > /sys/power/dvfs_table # 893750
    echo '3 2002000 856250' > /sys/power/dvfs_table # 868750
    echo '3 1898000 831250' > /sys/power/dvfs_table # 843750
    echo '3 1794000 806250' > /sys/power/dvfs_table # 818750
    echo '3 1690000 781250' > /sys/power/dvfs_table # 793750
    echo '3 1586000 756250' > /sys/power/dvfs_table # 775000
    echo '3 1508000 743750' > /sys/power/dvfs_table # 762500
    echo '3 1404000 718750' > /sys/power/dvfs_table # 737500
    echo '3 1222000 687500' > /sys/power/dvfs_table # 700000
    echo '3 1066000 656250' > /sys/power/dvfs_table # 668750
    echo '3 962000 637500' > /sys/power/dvfs_table # 650000
    echo '3 845000 618550' > /sys/power/dvfs_table # 625000
    echo '3 754000 587500' > /sys/power/dvfs_table # 600000
    echo '3 650000 562500' > /sys/power/dvfs_table # 575000
    echo '3 507000 562500' > /sys/power/dvfs_table # 575000
    echo '3 377000 560000' > /sys/power/dvfs_table # 575000

    # Voltage Big CPU : id 4, -12500uV
    echo '4 3016000 1131250' > /sys/power/dvfs_table # 1143750
    echo '4 2834000 1075000' > /sys/power/dvfs_table # 1087500
    echo '4 2730000 1069750' > /sys/power/dvfs_table # 1081250
    echo '4 2626000 1012500' > /sys/power/dvfs_table # 1031250
    echo '4 2522000 981250' > /sys/power/dvfs_table # 1000000
    echo '4 2418000 950000' > /sys/power/dvfs_table # 968750
    echo '4 2314000 918750' > /sys/power/dvfs_table # 931250
    echo '4 2210000 881250' > /sys/power/dvfs_table # 900000
    echo '4 2106000 856250' > /sys/power/dvfs_table # 868750
    echo '4 2002000 825000' > /sys/power/dvfs_table # 837500
    echo '4 1898000 793750' > /sys/power/dvfs_table # 806250
    echo '4 1794000 768750' > /sys/power/dvfs_table # 781250
    echo '4 1690000 743750' > /sys/power/dvfs_table # 756250
    echo '4 1586000 725000' > /sys/power/dvfs_table # 737500
    echo '4 1482000 700000' > /sys/power/dvfs_table # 712500
    echo '4 1378000 681250' > /sys/power/dvfs_table # 693750
    echo '4 1274000 662500' > /sys/power/dvfs_table # 675000
    echo '4 1170000 650000' > /sys/power/dvfs_table # 662500
    echo '4 1066000 631250' > /sys/power/dvfs_table # 643750
    echo '4 962000 612500' > /sys/power/dvfs_table # 625000
    echo '4 858000 600000' > /sys/power/dvfs_table # 612500
    echo '4 754000 587500' > /sys/power/dvfs_table # 600000
    echo '4 650000 575000' > /sys/power/dvfs_table # 587500
    echo '4 546000 556250' > /sys/power/dvfs_table # 568750


    # Voltage GPU : id 10, -0uV
    echo '10 897000 737500' > /sys/power/dvfs_table # 737500
    echo '10 832000 725000' > /sys/power/dvfs_table # 725000
    echo '10 800000 718750' > /sys/power/dvfs_table # 718750
    echo '10 702000 693750' > /sys/power/dvfs_table # 693750
    echo '10 572000 656250' > /sys/power/dvfs_table # 656250
    echo '10 455000 612500' > /sys/power/dvfs_table # 612500
    echo '10 377000 581250' > /sys/power/dvfs_table # 581250
    echo '10 260000 543750' > /sys/power/dvfs_table # 543750
    echo '10 156000 512500' > /sys/power/dvfs_table # 512500
    
    # Voltage MIF : id 0,  -12500uV
    echo '0 2730000 787500' > /sys/power/dvfs_table # 800000
    echo '0 2535000 768750' > /sys/power/dvfs_table # 781250
    echo '0 2288000 756250' > /sys/power/dvfs_table # 768750
    echo '0 2028000 750000' > /sys/power/dvfs_table # 762500
    echo '0 1716000 706250' > /sys/power/dvfs_table # 718750
    echo '0 1539000 662500' > /sys/power/dvfs_table # 675000
    echo '0 1352000 637500' > /sys/power/dvfs_table # 650000
    echo '0 1014000 587500' > /sys/power/dvfs_table # 600000
    echo '0 845000 556250' > /sys/power/dvfs_table # 568750
    echo '0 676000 543750' > /sys/power/dvfs_table # 556250
    echo '0 546000 531250' > /sys/power/dvfs_table # 543750
    echo '0 421000 531250' > /sys/power/dvfs_table # 543750

    echo " " >> $LOG;
    echo "## -- End voltage control" >> $LOG;
    echo " " >> $LOG;
    chmod 777 $LOG;

