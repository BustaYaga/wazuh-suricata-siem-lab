# 7. Attack simulations

**Goal:** prove each detection works by running a safe, controlled version of the attack from the attacker VM.

> Run these only inside the lab. The script refuses targets outside `192.168.56.0/24`.

| # | Test | Command (from `attacker`) | Expected alert |
|---|---|---|---|
| 1 | Port scan | `scripts/attack-simulation/run-linux-tests.sh scan 192.168.56.20` | Suricata scan, rule 100100 |
| 2 | SSH password guessing | `... bruteforce 192.168.56.20` | Wazuh sshd brute force (built-in) |
| 3 | Web attacks | `... web 192.168.56.20` | Rules 100101, 100102 |
| 4 | File tampering | On the victim: `sudo touch /var/www/html/test.php` | Rule 100120 |
| 5 | Sensitive file change | On the victim: `sudo useradd labtest` | Rule 100121 + built-in "new user" |
| 6 | Encoded PowerShell | On Windows: `scripts/attack-simulation/windows-tests.ps1` | Rule 100110 |
| 7 | Test malware file | On the victim: `scripts/attack-simulation/eicar-test.sh` | File integrity alert (+ VirusTotal if enabled) |

For each test record: time started, the alert(s) seen, how long detection took, and any false positives. Write it up with [reports/incident-template.md](../reports/incident-template.md).

## Proof
- [ ] `screenshots/04-detections/04-scan-alert.png`: Test 1
- [ ] `screenshots/04-detections/05-bruteforce-alert.png`: Test 2
- [ ] `screenshots/04-detections/06-web-attack-alert.png`: Test 3
- [ ] `screenshots/04-detections/07-fim-alert.png`: Tests 4 and 5
- [ ] `screenshots/04-detections/08-powershell-alert.png`: Test 6
- [ ] `screenshots/04-detections/09-eicar-alert.png`: Test 7