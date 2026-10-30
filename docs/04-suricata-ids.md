# 4. Install Suricata (network IDS)

**Goal:** Suricata watches traffic reaching `victim-linux` and writes alerts to `/var/log/suricata/eve.json`.

## Steps

1. Install the stable release:
   ```bash
   sudo add-apt-repository ppa:oisf/suricata-stable
   sudo apt update && sudo apt -y install suricata jq
   ```
2. Edit `/etc/suricata/suricata.yaml` (snippets in [configs/suricata/suricata-snippets.yaml](../configs/suricata/suricata-snippets.yaml)):
   - `HOME_NET: "[192.168.56.0/24]"`
   - the `af-packet` interface is the lab network card (check with `ip a`, for example `enp0s8`)
   - add `/etc/suricata/rules/local.rules` to `rule-files`
3. Download the free Emerging Threats Open rules:
   ```bash
   sudo suricata-update
   ```
4. Copy the lab rules: [configs/suricata/local.rules](../configs/suricata/local.rules) to `/etc/suricata/rules/local.rules`.
5. Test the config, then restart:
   ```bash
   sudo suricata -T -c /etc/suricata/suricata.yaml -v
   sudo systemctl restart suricata
   ```
6. Trigger a test alert from the attacker (`ping 192.168.56.20`) and watch:
   ```bash
   sudo tail -f /var/log/suricata/eve.json | jq 'select(.event_type=="alert") | .alert.signature'
   ```

## Why

Logs show what happened on a machine; Suricata shows what happened on the network. Together they catch attacks that one of them alone would miss.

## Proof
- [ ] `screenshots/03-suricata/01-config-test-ok.png`: `suricata -T` passing
- [ ] `screenshots/03-suricata/02-rules-loaded.png`: Rule count from `suricata-update`
- [ ] `screenshots/03-suricata/03-first-alert.png`: First alert in `eve.json`