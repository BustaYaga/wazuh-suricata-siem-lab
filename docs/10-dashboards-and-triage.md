# 10. Dashboards and alert triage

**Goal:** a view a SOC analyst would use every day, and a repeatable way to handle an alert.

## Dashboard

Build a custom dashboard (**Explore → Dashboards → Create**) with:
- Alerts over time, split by level
- Top source IPs
- Top rule descriptions
- MITRE ATT&CK techniques
- Suricata alerts by signature

Save the filters used, for example `rule.level >= 10` and `rule.groups: suricata`.

## Triage routine

1. **Read** the alert: rule, level, agent, source IP, time.
2. **Check context:** what else did this IP or user do in the last hour?
3. **Decide:** real attack, test, or false positive?
4. **Act:** block, escalate, or tune the rule.
5. **Record** it with the [incident template](../reports/incident-template.md).

## Proof
- [ ] `screenshots/06-dashboards/01-overview.png`: Custom dashboard
- [ ] `screenshots/06-dashboards/02-mitre.png`: MITRE ATT&CK view
- [ ] `screenshots/06-dashboards/03-triage-example.png`: An alert being investigated