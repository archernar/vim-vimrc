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
