

[![Buy Me a Coffee](https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png)](https://buymeacoffee.com/efkatech)

<img width="170" height="37" alt="image" src="https://github.com/user-attachments/assets/0ef6fa81-4ef0-4a77-b6fb-71ed936c7cdc" "(https://buymeacoffee.com/efkatech)"/>


...


# Chrome Profile Launcher

A PowerShell script that detects all available Google Chrome profiles on your system, displays their associated email addresses (if available), and then launches Chrome with each profile in a separate window.

---

## Features

- Automatically finds all Chrome profiles on your local machine  
- Displays profile names and associated email addresses  
- Launches Chrome with each found profile in its own window  
- Provides messages and error handling if Chrome or profiles are not found

---

## Requirements

- Windows operating system with Google Chrome installed  
- PowerShell (version 5 or higher recommended)

---

## Usage

1. Run the script in PowerShell (you might need to adjust the execution policy with `Set-ExecutionPolicy`)  
2. The script will automatically find all Chrome profiles and launch each one in a separate Chrome window  

---

## Example

```powershell
.\chrome-profile-launcher.ps1
