# 9. Suricata in IPS mode (drop bad traffic)

**Goal:** Suricata stops selected malicious traffic instead of only reporting it.

> Keep console access to the VM while testing. A wrong firewall rule can cut your SSH session.

## Steps

1. Send traffic to Suricata through the Linux firewall queue:
   ```bash
   sudo iptables -I INPUT -i enp0s8 -j NFQUEUE --queue-num 0
   sudo iptables -I OUTPUT -o enp0s8 -j NFQUEUE --queue-num 0
   ```
2. Run Suricata in queue mode. On the Ubuntu package, set `LISTENMODE=nfqueue` in `/etc/default/suricata`, or test by hand:
   ```bash
   sudo suricata -c /etc/suricata/suricata.yaml -q 0
   ```
3. Enable the `drop` rules in [configs/suricata/local.rules](../configs/suricata/local.rules) (they are commented out for IDS mode).
4. Repeat the web attack test. The request should fail, and `eve.json` should show `"action":"blocked"`.

## Proof
- [ ] `screenshots/05-active-response/05-ips-blocked.png`: `eve.json` entry with action blocked
- [ ] `screenshots/05-active-response/06-ips-request-failed.png`: Attacker request failing