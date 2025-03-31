#!/bin/bash
# suspicious_login_detector.sh
# Detects potentially malicious login attempts
# Requires: grep, awk, lastb (for failed attempts)

LOG_FILE="/var/log/auth.log"
OUTPUT_FILE="/var/log/suspicious_logins_report.txt"
RED_FLAGS=0

# Clear previous report
> $OUTPUT_FILE

echo "Suspicious Login Activity Report - $(date)" >> $OUTPUT_FILE
echo "==========================================" >> $OUTPUT_FILE

# 1. Check for login attempts between midnight and 6am
echo -e "\n[+] Login attempts between 00:00-06:00:" >> $OUTPUT_FILE
grep "Accepted password" $LOG_FILE | awk '$3 >= "00:00:00" && $3 <= "06:00:00"' >> $OUTPUT_FILE
COUNT=$(grep "Accepted password" $LOG_FILE | awk '$3 >= "00:00:00" && $3 <= "06:00:00"' | wc -l)
RED_FLAGS=$((RED_FLAGS + COUNT))
echo "Total: $COUNT" >> $OUTPUT_FILE

# 2. Check for failed login attempts
echo -e "\n[+] Failed login attempts:" >> $OUTPUT_FILE
lastb | head -n -2 >> $OUTPUT_FILE
COUNT=$(lastb | head -n -2 | wc -l)
RED_FLAGS=$((RED_FLAGS + COUNT))
echo "Total: $COUNT" >> $OUTPUT_FILE

# 3. Check for root login attempts
echo -e "\n[+] Root login attempts:" >> $OUTPUT_FILE
grep "Accepted password.*root" $LOG_FILE >> $OUTPUT_FILE
COUNT=$(grep "Accepted password.*root" $LOG_FILE | wc -l)
RED_FLAGS=$((RED_FLAGS + COUNT))
echo "Total: $COUNT" >> $OUTPUT_FILE

# 4. Check for SSH brute force attempts
echo -e "\n[+] Possible SSH brute force attempts:" >> $OUTPUT_FILE
grep "Failed password" $LOG_FILE | awk '{print $9}' | sort | uniq -c | sort -nr >> $OUTPUT_FILE
echo "" >> $OUTPUT_FILE

echo -e "\nTotal red flags detected: $RED_FLAGS" >> $OUTPUT_FILE

if [ $RED_FLAGS -gt 0 ]; then
    echo "Warning: $RED_FLAGS suspicious activities detected!" >> $OUTPUT_FILE
    # Send email alert (uncomment and configure if mailutils is installed)
    # mail -s "Suspicious Login Activity Detected" admin@example.com < $OUTPUT_FILE
fi

echo "Report generated at $(date) and saved to $OUTPUT_FILE"