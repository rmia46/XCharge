![XCharge](https://github.com/iamlooper/XCharge/raw/main/xcharge.png)

# XCharge™ v1.4.5

XCharge™ is a fast charging enhancement Magisk module, now updated to be 100% shell-based for universal compatibility.

### **Forked & Maintained by:**
- **Roman Mia (@rmia46)**

## **Features**
- **Architecture Shift:** All pre-compiled binaries have been removed and replaced with a high-performance shell controller. This ensures the module works on any Android device regardless of CPU architecture.
- **Manual Mode:** Set your own custom charging current (mA) and temperature limits.
- **Colorful UI:** Professional ANSI-colored terminal interface.
- **Boot Persistence:** Your settings are saved and automatically applied 30 seconds after the system boots.

## **How to Run**
After flashing and rebooting, open **Termux** or any other terminal emulator and type:
```bash
su -c xcharge
```

## **Important Notes**
- **Reboot is required** after installation.
- Do not use with other charging enhancement modules.
- Use conservative values in manual mode to protect your hardware.
