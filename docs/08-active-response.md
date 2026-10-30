# 8. Block attackers automatically (active response)

**Goal:** when Wazuh sees SSH password guessing, the victim's firewall blocks the attacker's IP for 3 minutes.

## Steps

1. On the manager, add this to `/var/ossec/etc/ossec.conf` (also in [configs/wazuh/manager/ossec-active-response.xml](../configs/wazuh/manager/ossec-active-response.xml)):
   ```xml
   <active-response>
     <command>firewall-drop</command>
     <location>local</location>
     <rules_id>5763</rules_id>
     <timeout>180</timeout>
   </active-response>
   ```
   Rule 5763 is Wazuh's built-in "sshd brute force" rule.
2. Restart the manager: `sudo systemctl restart wazuh-manager`.
3. Run the brute-force test again. After a few attempts the attacker's connection should hang.
4. On the victim, confirm the block:
   ```bash
   sudo iptables -L INPUT -n | grep 192.168.56.50
   sudo tail /var/ossec/logs/active-responses.log
   ```

## Why

Detection alone tells you something happened; response stops it. Short timeouts avoid locking out legitimate users for long if the alert was a false positive.

## Proof
- [ ] `screenshots/05-active-response/01-config.png`: Active response block in ossec.conf
- [ ] `screenshots/05-active-response/02-attacker-blocked.png`: Attacker connection timing out
- [ ] `screenshots/05-active-response/03-iptables-rule.png`: iptables rule for the attacker IP
- [ ] `screenshots/05-active-response/04-ar-alert.png`: Active response alert in the dashboard