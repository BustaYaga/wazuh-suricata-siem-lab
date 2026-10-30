# 5. Send Suricata alerts into Wazuh

**Goal:** network alerts and machine logs in one place.

## Steps

1. On `victim-linux`, add this to `/var/ossec/etc/ossec.conf` inside `<ossec_config>` (also in [configs/wazuh/agent/linux-agent.xml](../configs/wazuh/agent/linux-agent.xml)):
   ```xml
   <localfile>
     <log_format>json</log_format>
     <location>/var/log/suricata/eve.json</location>
   </localfile>
   ```
2. Restart the agent: `sudo systemctl restart wazuh-agent`.
3. Ping the server again from the attacker. In the dashboard (**Threat Hunting**), filter with `rule.groups: suricata`.

Wazuh already ships decoders and rules for Suricata, so alerts appear with the signature, source and destination IPs as separate fields.

## Proof
- [ ] `screenshots/03-suricata/04-suricata-in-wazuh.png`: Suricata alerts in Wazuh, filtered by group
- [ ] `screenshots/03-suricata/05-alert-details.png`: One alert expanded, showing signature and IPs