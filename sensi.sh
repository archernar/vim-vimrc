#!/usr/bin/env bash

# Exit immediately if a command exits with a non-zero status (except in loops/conditionals),
# treat unset variables as an error, and catch pipeline failures.
set -euo pipefail

if [[ $# -eq 0 ]]; then
    echo "Usage: ${0##*/} <file_or_wildcard> [additional_files...]"
    echo "Example: ${0##*/} src/*.js config.env"
    exit 1
fi

# Dictionary of common sensitive patterns. 
declare -A PATTERNS=(
    ["AWS Access Key"]="AKIA[0-9A-Z]{16}"
    ["GitHub Token"]="gh[pousr]_[A-Za-z0-9_]{36,}"
    ["Private Key"]="BEGIN.*?PRIVATE KEY"
    ["Database URI"]="(?i)(mongodb(?:\+srv)?|postgres(?:ql)?|mysql)://[^:]+:[^@\s]+@"
    ["Bearer/JWT Token"]="(?i)bearer\s+[A-Za-z0-9\-_]+\.[A-Za-z0-9\-_]+\.[A-Za-z0-9\-_]+"
    ["Generic Secret"]="(?i)(api[_-]?key|secret|token|passwd|password)\s*[:=]\s*['\"]?(?!true|false|null)([A-Za-z0-9\-_+=/]{8,})['\"]?"
    ["Private Key"]="-----BEGIN (RSA |EC |DSA |OPENSSH |PGP |ENCRYPTED )?PRIVATE KEY( BLOCK)?-----"
    ["Database URI"]="(?i)\b(mongodb(\+srv)?|postgres(ql)?|mysql|mariadb|mssql|sqlserver|redis|rediss|amqps?|ftp|sftp)://[^:/\s]+:[^@\s]+@"
    ["Bearer/JWT Token"]="\beyJ[A-Za-z0-9_-]{10,}\.eyJ[A-Za-z0-9_-]{10,}\.[A-Za-z0-9_-]{10,}"
    ["Generic Secret"]="(?i)['\"]?[A-Za-z0-9_.-]*(api[_-]?key|secret|token|passwd|password|pwd|credential|auth[_-]?key)[A-Za-z0-9_.-]*['\"]?\s*[:=]>?\s*['\"]?(?!(true|false|null|none|nil|undefined)\b)[^\s'\"<>\$\{\(]{8,}"
    ["AWS Temp/IAM Key ID"]="\b(ASIA|AGPA|AIDA|AROA|AIPA|ANPA|ANVA)[0-9A-Z]{16}\b"
    ["AWS Secret Key"]="(?i)aws.{0,20}(secret|sk).{0,20}['\"][0-9a-zA-Z/+]{40}['\"]"
    ["Google API Key"]="AIza[0-9A-Za-z_-]{35}"
    ["Google OAuth Client Secret"]="GOCSPX-[A-Za-z0-9_-]{28}"
    ["GCP Service Account JSON"]="\"type\"\s*:\s*\"service_account\""
    ["Azure Storage Key"]="AccountKey=[A-Za-z0-9+/]{86}=="
    ["Azure SAS Signature"]="[?&]sig=[A-Za-z0-9%]{43,}%3D"
    ["DigitalOcean Token"]="dop_v1_[a-f0-9]{64}"
    ["Terraform Cloud Token"]="\b[A-Za-z0-9]{14}\.atlasv1\.[A-Za-z0-9_-]{60,}"
    ["GitHub Fine-Grained PAT"]="github_pat_[A-Za-z0-9_]{22,}"
    ["GitLab PAT"]="glpat-[A-Za-z0-9_-]{20}"
    ["npm Token"]="npm_[A-Za-z0-9]{36}"
    ["PyPI Token"]="pypi-AgEIcHlwaS5vcmc[A-Za-z0-9_-]{50,}"
    ["Docker Config Auth"]="\"auth\"\s*:\s*\"[A-Za-z0-9+/=]{20,}\""
    ["Slack Token"]="xox[baprs]-[0-9A-Za-z-]{10,}"
    ["Slack Webhook"]="https://hooks\.slack\.com/services/T[A-Z0-9]+/B[A-Z0-9]+/[A-Za-z0-9]+"
    ["Discord Webhook"]="https://(ptb\.|canary\.)?discord(app)?\.com/api/webhooks/[0-9]+/[A-Za-z0-9_-]+"
    ["Stripe Live Key"]="\b[sr]k_live_[0-9A-Za-z]{24,}\b"
    ["Twilio Key/SID"]="\b(SK|AC)[0-9a-f]{32}\b"
    ["SendGrid Key"]="SG\.[A-Za-z0-9_-]{22}\.[A-Za-z0-9_-]{43}"
    ["Mailgun Key"]="\bkey-[0-9a-f]{32}\b"
    ["Shopify Token"]="shp(at|ca|pa|ss)_[a-fA-F0-9]{32}"
    ["Square Token"]="sq0(atp|csp)-[0-9A-Za-z_-]{22,43}"
    ["Telegram Bot Token"]="\b[0-9]{8,10}:AA[0-9A-Za-z_-]{33}\b"
    ["OpenAI Key"]="\bsk-(proj-)?[A-Za-z0-9_-]{32,}"
    ["Anthropic Key"]="sk-ant-[A-Za-z0-9_-]{80,}"
    ["Basic Auth in URL"]="https?://[^/\s:@]+:[^/\s:@]+@[^/\s]+"
    ["Authorization Header"]="(?i)authorization['\"]?\s*[:=]\s*['\"]?(basic|bearer)\s+[A-Za-z0-9+/=._-]{10,}"
    ["Connection String Password"]="(?i)\b(pwd|password)=[^;\s'\"]{4,};"
    ["netrc Credentials"]="machine\s+\S+\s+login\s+\S+\s+password\s+\S+"
    ["PuTTY Private Key"]="PuTTY-User-Key-File-[0-9]:"
    ["US SSN"]="\b(?!000|666|9\d\d)\d{3}-(?!00)\d{2}-(?!0000)\d{4}\b"
    ["Credit Card"]="\b(?:4[0-9]{12}(?:[0-9]{3})?|5[1-5][0-9]{14}|3[47][0-9]{13}|6(?:011|5[0-9]{2})[0-9]{12})\b"
)

GLOBAL_FAIL=0

for TARGET in "$@"; do
    # Skip directories or invalid paths that might be caught by broad wildcards like '*'
    if [[ ! -f "$TARGET" ]]; then
        # Uncomment the next line if you want to be notified when directories are skipped
        # echo "Skipping '$TARGET' (not a regular file)"
        continue
    fi

    FILE_FAIL=0

    for desc in "${!PATTERNS[@]}"; do
        echo -n "$desc,"
        regex="${PATTERNS[$desc]}"

        # -P: Perl-compatible regex
        # -n: Show line numbers
        # -I: Ignore binary files
        if matches=$(grep -P -n -I "$regex" "$TARGET" 2>/dev/null); then
            # Print the header only once per file if secrets are found
            if [[ $FILE_FAIL -eq 0 ]]; then
                echo -e "\n[!] Sensitive information detected in: $TARGET"
            fi
            
            echo "    -> $desc:"
            echo "$matches" | sed 's/^/        /'
            FILE_FAIL=1
            GLOBAL_FAIL=1
        fi
    done

    if [[ $FILE_FAIL -eq 0 ]]; then
        echo "[+] Pass: $TARGET"
    else
        echo "[-] Fail: $TARGET"
    fi
done

if [[ $GLOBAL_FAIL -eq 1 ]]; then
    echo -e "\n[X] Scan complete: Secrets were found. Do not push these files."
    exit 1
else
    echo -e "\n[V] Scan complete: No obvious secrets found in any checked files."
    exit 0
fi
