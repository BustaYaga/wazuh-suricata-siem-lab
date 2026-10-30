# 1. Architecture and network plan

**Goal:** an isolated lab that looks like a tiny company network, with one machine playing the attacker.

## Network

| Setting | Value |
|---|---|
| Hypervisor | VirtualBox or VMware Workstation |
| Lab network | Host-only, `192.168.56.0/24` (no internet route for the attacker) |
| Internet for updates | A second NAT adapter on the lab machines, switched off during attack tests |

| Machine | IP | Role |
|---|---|---|
| `wazuh-server` | 192.168.56.10 | Wazuh manager, indexer, dashboard |
| `victim-linux` | 192.168.56.20 | Nginx web server, SSH, Suricata, Wazuh agent |
| `victim-windows` | 192.168.56.30 | Windows endpoint, Sysmon, Wazuh agent |
| `attacker` | 192.168.56.50 | Kali Linux |

## How data flows

1. The agents read local logs (auth, web, Windows events, Sysmon, Suricata `eve.json`) and send them to the manager on TCP 1514.
2. The manager decodes each log, checks it against built-in and custom rules, and stores alerts in the indexer.
3. The dashboard shows alerts, MITRE ATT&CK mapping and agent health.
4. For selected rules, the manager tells the agent to run an **active response** (block the attacker's IP with the firewall).

## Ports to allow on `wazuh-server`

| Port | Use |
|---|---|
| 443/tcp | Dashboard |
| 1514/tcp | Agent events |
| 1515/tcp | Agent enrollment |
| 55000/tcp | Wazuh API |

## Proof
- [ ] `screenshots/01-setup/01-vm-list.png`: All four VMs in the hypervisor
- [ ] `screenshots/01-setup/02-network-config.png`: Host-only network settings
- [ ] `screenshots/01-setup/03-ip-addresses.png`: `ip a` on each Linux machine showing lab IPs