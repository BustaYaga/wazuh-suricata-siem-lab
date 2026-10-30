# 3. Connect the machines (agents)

**Goal:** the Linux and Windows machines send their logs to Wazuh.

## Linux agent (`victim-linux`)

1. In the dashboard: **Agents → Deploy new agent → Linux (DEB amd64)**, server address `192.168.56.10`, agent name `victim-linux`. Copy the generated command and run it on the machine. It installs the package with `WAZUH_MANAGER` set.
2. Start it:
   ```bash
   sudo systemctl daemon-reload
   sudo systemctl enable --now wazuh-agent
   ```

## Windows agent (`victim-windows`)

1. In the dashboard: **Deploy new agent → Windows (MSI)**, same server address, name `victim-windows`. Run the generated PowerShell command as Administrator, then:
   ```powershell
   NET START WazuhSvc
   ```
2. Install **Sysmon** for detailed process and network events:
   ```powershell
   .\Sysmon64.exe -accepteula -i sysmonconfig.xml
   ```
   (A community config such as SwiftOnSecurity's `sysmonconfig-export.xml` is a good start.)
3. Tell the agent to read Sysmon events. Add the block in [configs/wazuh/agent/windows-sysmon.xml](../configs/wazuh/agent/windows-sysmon.xml) to `C:\Program Files (x86)\ossec-agent\ossec.conf`, then restart the agent:
   ```powershell
   Restart-Service WazuhSvc
   ```

## File integrity monitoring (both machines)

Add the folders to watch from [configs/wazuh/agent/linux-agent.xml](../configs/wazuh/agent/linux-agent.xml) so changes in web and system folders raise alerts straight away.

## Check

**Agents** page shows both agents as **Active**.

## Proof
- [ ] `screenshots/02-agents/01-agents-active.png`: Agents page, both agents active
- [ ] `screenshots/02-agents/02-linux-agent-status.png`: `systemctl status wazuh-agent` on Linux
- [ ] `screenshots/02-agents/03-sysmon-events.png`: Sysmon events arriving in Wazuh