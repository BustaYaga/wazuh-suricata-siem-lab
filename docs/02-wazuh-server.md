# 2. Install the Wazuh server

**Goal:** one machine running the Wazuh manager, indexer and dashboard (the "all-in-one" install).

## Steps

1. Update the server:
   ```bash
   sudo apt update && sudo apt -y upgrade
   ```
2. Run the official assisted installer. Copy the exact command for the current version from the Wazuh quickstart page (https://documentation.wazuh.com/current/quickstart.html). It has this shape:
   ```bash
   curl -sO https://packages.wazuh.com/<version>/wazuh-install.sh
   sudo bash ./wazuh-install.sh -a
   ```
3. At the end, the installer prints the `admin` password. Save it in a password manager.
4. Open `https://192.168.56.10` and log in as `admin`.
5. Check the services:
   ```bash
   sudo systemctl status wazuh-manager wazuh-indexer wazuh-dashboard
   ```

## Why

The all-in-one install is the quickest way to get a working SIEM. In a company these parts run on separate servers, but the setup and configuration are the same.

## Proof
- [ ] `screenshots/01-setup/04-installer-finished.png`: Installer summary (hide the password)
- [ ] `screenshots/01-setup/05-services-running.png`: All three services active
- [ ] `screenshots/01-setup/06-dashboard-login.png`: First dashboard screen after login