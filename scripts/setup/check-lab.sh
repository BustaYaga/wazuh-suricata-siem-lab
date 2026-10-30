#!/usr/bin/env bash
# Quick health check, run on victim-linux.
echo "== Wazuh agent ==";  systemctl is-active wazuh-agent
echo "== Suricata ==";     systemctl is-active suricata
echo "== Last Suricata alert =="
sudo jq -c 'select(.event_type=="alert") | {time:.timestamp, sig:.alert.signature, src:.src_ip}' /var/log/suricata/eve.json | tail -n 1
