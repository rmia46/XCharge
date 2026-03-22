#!/sbin/sh

###########################
# MMT Reborn Logic
###########################

############
# Config Vars
############

# Set this to true if you want to skip mount for your module
SKIPMOUNT="false"
# Set this to true if you want to clean old files in module before injecting new module
CLEANSERVICE="false"
# Set this to true if you want to load vskel after module info print. If you want to manually load it, consider using load_vksel function
AUTOVKSEL="false"
# Set this to true if you want store debug logs of installation
DEBUG="true"

############
# Replace List
############

# List all directories you want to directly replace in the system
# Construct your list in the following example format
REPLACE_EXAMPLE="
/system/app/Youtube
/system/priv-app/SystemUI
/system/priv-app/Settings
/system/framework
"
# Construct your own list here
REPLACE="
"

############
# Permissions
############

# Set permissions
set_permissions() {
  # root:root, dir: 0755, file: 0644
  set_perm_recursive "$MODPATH" 0 0 0755 0644
  # Ensure bin is executable
  set_perm "$MODPATH/system/bin/xcharge" 0 0 0755
}

############
# Info Print
############

# Set what you want to be displayed on header of installation process
info_print() {
  awk '{print}' "$MODPATH/xcharge_banner"
  ui_print ""

  sleep 0.5

  ui_print "[*] Fast Charging Enhancement Magisk Module [*]"
  ui_print ""

  sleep 0.5
}

############
# Main
############

# Change the logic to whatever you want
init_main() {
  ui_print "[*] Installing XCharge..."
  ui_print ""

  # Remove architecture specific binaries and any old binary called xcharge
  rm -f "$MODPATH/system/bin/xcharge64" "$MODPATH/system/bin/xcharge32" "$MODPATH/system/bin/xcharge"
  
  # Install the shell script as 'xcharge'
  mv -f "$MODPATH/system/bin/xcharge.sh" "$MODPATH/system/bin/xcharge"
  
  # Set permissions (important for it to be recognized as an executable)
  chmod 755 "$MODPATH/system/bin/xcharge"

  sleep 0.5
  
  ui_print "[*] Done!"
  ui_print ""

  sleep 1.5

  ui_print " --- Notes --- "
  ui_print ""
  ui_print "[*] XCharge v1.4.5 (Roman Mia Fork)"
  ui_print "[*] Binaries removed for better compatibility"
  ui_print "[*] Reboot is required after installation"
  ui_print ""
  ui_print "[*] Type (su -c xcharge) in terminal to open menu"
  ui_print ""
  ui_print "[*] Follow @rmia46 for updates"
  ui_print ""

  sleep 2.5
  }