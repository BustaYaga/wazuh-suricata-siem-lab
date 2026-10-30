# 6. Custom detection rules

**Goal:** turn noisy events into clear, prioritised alerts that say what is happening and which attack technique it matches.

Rules live in `/var/ossec/etc/rules/local_rules.xml` on the manager. The full file is [configs/wazuh/manager/local_rules.xml](../configs/wazuh/manager/local_rules.xml).

| Rule ID | What it catches | Level | MITRE ATT&CK |
|---|---|---|---|
| 100100 | Network scan reported by Suricata | 10 | T1046 |
| 100101 | SQL injection attempt reported by Suricata | 12 | T1190 |
| 100102 | Path traversal attempt reported by Suricata | 12 | T1190 |
| 100110 | PowerShell run with an encoded command | 12 | T1059.001 |
| 100111 | PowerShell downloading from the internet | 10 | T1105 |
| 100120 | Change to the web folder | 8 | T1565.001 |
| 100121 | Change to `/etc/passwd`, `/etc/shadow` or `/etc/sudoers` | 12 | T1098 |

## Test a rule before using it

```bash
sudo /var/ossec/bin/wazuh-logtest
```
Paste a sample log line and check which rule fires. Then restart the manager:
```bash
sudo systemctl restart wazuh-manager
```

## Proof
- [ ] `screenshots/04-detections/01-logtest.png`: `wazuh-logtest` matching a custom rule
- [ ] `screenshots/04-detections/02-custom-alerts.png`: Custom rule alerts in the dashboard
- [ ] `screenshots/04-detections/03-mitre-view.png`: MITRE ATT&CK view with the techniques above