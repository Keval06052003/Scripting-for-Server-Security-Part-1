#!/bin/bash
# hidden_file_monitor.sh
# Tracks changes to hidden files and root executables
# Requires: find, stat, md5sum

BASELINE_FILE="/var/log/hidden_files_baseline.md5"
CURRENT_FILE="/var/log/hidden_files_current.md5"
REPORT_FILE="/var/log/hidden_files_changes.txt"

# Find all hidden files, root executables, and their metadata
if [ ! -f "$BASELINE_FILE" ]; then
    echo "Creating baseline for hidden files and executables..."
    find / -type f \( -name ".*" -o -path "/root/*" -o -perm -4000 -o -perm -2000 \) \
        -exec stat --format="%n %U %a %y" {} \; > $BASELINE_FILE 2>/dev/null
    echo "Baseline created at $BASELINE_FILE"
    exit 0
fi

# Generate current snapshot
find / -type f \( -name ".*" -o -path "/root/*" -o -perm -4000 -o -perm -2000 \) \
    -exec stat --format="%n %U %a %y" {} \; > $CURRENT_FILE 2>/dev/null

# Compare and report differences
echo "Hidden Files and Executables Change Report - $(date)" > $REPORT_FILE
echo "===============================================" >> $REPORT_FILE
diff -u $BASELINE_FILE $CURRENT_FILE >> $REPORT_FILE

if [ $? -eq 0 ]; then
    echo "No changes detected in hidden files or executables." >> $REPORT_FILE
else
    echo "Changes detected in hidden files or executables!" >> $REPORT_FILE
    # Send email alert (uncomment and configure if mailutils is installed)
    # mail -s "Hidden File Changes Detected" admin@example.com < $REPORT_FILE
fi

# Update baseline after reporting
mv $CURRENT_FILE $BASELINE_FILE

echo "Report generated at $(date) and saved to $REPORT_FILE"