#!/system/bin/sh
# XCharge™ Professional Shell Controller
# Author: iamlooper | Enhanced by @rmia46 (Roman Mia)
# Note: Binaries removed for 100% compatibility across all architectures.

MODPATH="/data/adb/modules/xcharge"
CONF="$MODPATH/xcharge.conf"

# Colors
R='\033[0;31m'  # Red
G='\033[0;32m'  # Green
Y='\033[0;33m'  # Yellow
B='\033[0;34m'  # Blue
C='\033[0;36m'  # Cyan
W='\033[1;37m'  # White (Bold)
N='\033[0m'     # Reset

# Nodes
CURRENT_NODE="/sys/class/power_supply/battery/constant_charge_current_max"
TEMP_NODES="
/sys/class/power_supply/battery/temp_hot
/sys/class/power_supply/battery/charging_term_temp
/sys/module/qpnp_smb5/parameters/term_temp
/sys/module/smb5_lib/parameters/term_temp
"

load_config() {
    if [ -f "$CONF" ]; then
        . "$CONF"
    else
        C_MA=1500; C_TEMP=46
    fi
}

apply() {
    local ma=$1; local temp=$2
    # Set Current (Convert mA to uA)
    if [ -f "$CURRENT_NODE" ]; then
        chmod 644 "$CURRENT_NODE"
        echo $(( ma * 1000 )) > "$CURRENT_NODE"
    fi
    # Set Temp (Convert C to deci-Celsius)
    for node in $TEMP_NODES; do
        if [ -f "$node" ]; then
            chmod 644 "$node"
            echo $(( temp * 10 )) > "$node"
        fi
    done
    # Save for persistence
    echo "C_MA=$ma" > "$CONF"; echo "C_TEMP=$temp" >> "$CONF"
}

# Boot Execution
load_config
if [ "$1" = "--execute" ]; then
    apply "$C_MA" "$C_TEMP"
    exit 0
fi

# Interactive Menu
clear
echo -e "${C}==========================================${N}"
echo -e "${W}   XCHARGE™ FAST CHARGING CONTROLLER      ${N}"
echo -e "${C}==========================================${N}"
echo -e "${W} Version: v1.4.5 | Fork: @rmia46 (Roman Mia)${N}"
echo -e "${C}------------------------------------------${N}"
echo -e " ${G}CURRENT SETTINGS:${N}"
echo -e " Limit: ${W}${C_MA}mA${N} | Temp: ${W}${C_TEMP}°C${N}"
echo -e " Mode: ${Y}Universal Shell (No Binaries)${N}"
echo -e "${C}------------------------------------------${N}"
echo -e " ${Y}[1]${N} Fast     : ${W}1500mA / 46°C${N}"
echo -e " ${Y}[2]${N} Faster   : ${W}2500mA / 48°C${N}"
echo -e " ${Y}[3]${N} Fastest  : ${W}3500mA / 50°C${N}"
echo -e " ${Y}[4]${N} Manual   : ${C}Set custom values${N}"
echo -e " ${Y}[5]${N} Stock    : ${R}Reset to Default${N}"
echo -e " ${Y}[0]${N} Exit"
echo -e "${C}------------------------------------------${N}"
printf " ${W}Select an option: ${N}"
read opt

case $opt in
    1) apply 1500 46; echo -e "\n ${G}[*] Fast mode applied!${N}" ;;
    2) apply 2500 48; echo -e "\n ${G}[*] Faster mode applied!${N}" ;;
    3) apply 3500 50; echo -e "\n ${G}[*] Fastest mode applied!${N}" ;;
    4) 
        echo -e "\n ${C}--- MANUAL SETUP ---${N}"
        printf " ${W}Enter Current (mA): ${N}"; read m; 
        printf " ${W}Enter Temp Limit (°C): ${N}"; read t; 
        apply "$m" "$t"; echo -e "\n ${G}[*] Custom values applied!${N}" ;;
    5) apply 1000 40; echo -e "\n ${R}[*] Reset to Default!${N}" ;;
    0) echo -e "\n ${Y}[*] Bye!${N}"; exit 0 ;;
    *) echo -e "\n ${R}[!] Invalid option${N}"; exit 1 ;;
esac

sleep 1
exit 0
