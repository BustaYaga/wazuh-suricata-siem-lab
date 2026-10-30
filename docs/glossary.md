# Glossary (plain English)

| Term | Meaning |
|---|---|
| **SIEM** | A system that collects logs from many machines in one place and raises alerts. Wazuh is the SIEM here. |
| **IDS** | Intrusion Detection System. Watches network traffic and reports attacks. |
| **IPS** | Intrusion Prevention System. Like an IDS, but can also block the attack. Suricata does both. |
| **Agent** | A small program on each machine that sends its logs to the SIEM. |
| **Rule** | A condition that turns a log line into an alert, for example "10 failed logins in 1 minute". |
| **MITRE ATT&CK** | A public catalogue of attacker techniques. Each alert here is tagged with one, so anyone can look it up. |
| **Active response** | An automatic action taken when an alert fires, such as blocking an IP address. |
| **False positive** | An alert for something that was not actually an attack. |
| **Triage** | Deciding quickly how serious an alert is and what to do about it. |
| **FIM** | File Integrity Monitoring. Alerts when important files are changed. |
| **Sysmon** | A free Microsoft tool that records detailed Windows activity, such as which programs started. |
