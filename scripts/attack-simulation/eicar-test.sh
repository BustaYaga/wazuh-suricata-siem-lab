#!/usr/bin/env bash
# Writes the EICAR test file: a harmless, industry-standard string that antivirus tools treat as malware.
# Run on victim-linux. The folder is watched by Wazuh file integrity monitoring.
set -euo pipefail
mkdir -p /tmp/lab-downloads
printf '%s' 'X5O!P%@AP[4\PZX54(P^)7CC)7}$EICAR-STANDARD-ANTIVIRUS-TEST-FILE!$H+H*' > /tmp/lab-downloads/eicar.com
echo "[$(date '+%F %T')] EICAR test file written to /tmp/lab-downloads/eicar.com"
