#!/bin/bash
# directory_change_monitor.sh
# Monitors changes to critical directories using hashes
# Requires: md5sum, find

# Directories to monitor (space separated)
MONITOR_DIRS="/etc /var/log /bin /usr/bin /sbin /usr/sbin"
BASELINE_FILE="/var/log/directory_baseline.md5"
CURRENT_FILE="/var/log/directory_current.md5"
REPORT_FILE="/var/log/directory_changes.txt"

# Generate baseline if it doesn't exist
if [ ! -f "$BASELINE_FILE" ]; then
    echo "Creating baseline..."
    find $MONITOR_DIRS -type f -exec md5sum {} + > $BASELINE_FILE 2>/dev/null
    echo "Baseline created at $BASELINE_FILE"
    exit 0
fi

# Generate current snapshot
find $MONITOR_DIRS -type f -exec md5sum {} + > $CURRENT_FILE 2>/dev/null

# Compare and report differences
echo "Directory Change Report - $(date)" > $REPORT_FILE
echo "=================================" >> $REPORT_FILE
diff -u $BASELINE_FILE $CURRENT_FILE >> $REPORT_FILE

if [ $? -eq 0 ]; then
    echo "No changes detected in monitored directories." >> $REPORT_FILE
else
    echo "Changes detected in monitored directories!" >> $REPORT_FILE
    # Send email alert (uncomment and configure if mailutils is installed)
    # mail -s "Directory Changes Detected" admin@example.com < $REPORT_FILE
fi

# Update baseline after reporting
mv $CURRENT_FILE $BASELINE_FILE

echo "Report generated at $(date) and saved to $REPORT_FILE"