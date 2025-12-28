#!/bin/bash

# ------------------------------
# Get CPU usage using top -bn2
# ------------------------------

# Run top in batch mode twice, take the second snapshot
CPU_LINE=$(top -bn2 | grep "Cpu(s)" | tail -n1)

# Extract the idle percentage (the number before "id") 
# -F'id' set the field separator to the string id, {print $1} print everything before id, $NF in awk, this is the last field of the line
CPU_IDLE=$(echo "$CPU_LINE" | awk -F'id' '{print $1}' | awk '{print $NF}')

# Calculate CPU usage = 100 - idle
CPU_USAGE=$(awk "BEGIN {printf \"%.2f\", 100 - $CPU_IDLE}")

echo "Total CPU Usage: $CPU_USAGE%"
echo ""

# Get memory info in MB
MEM_INFO=$(free -m | awk '/Mem:/ {print $2, $3, $4, $7}')

TOTAL_MEM=$(echo $MEM_INFO | awk '{print $1}')
USED_MEM=$(echo $MEM_INFO | awk '{print $2}')
FREE_MEM=$(echo $MEM_INFO | awk '{print $3}')
AVAIL_MEM=$(echo $MEM_INFO | awk '{print $4}')
PERCENT_USED=$(awk "BEGIN {printf \"%.2f\", ($USED_MEM/$TOTAL_MEM)*100}")

echo "Total Memory: ${TOTAL_MEM} MB"
echo "Used Memory:  ${USED_MEM} MB"
echo "Free Memory:  ${FREE_MEM} MB"
echo "Available Memory: ${AVAIL_MEM} MB"
echo "Memory Usage: ${PERCENT_USED}%"
echo ""

#Total disk usage (Free vs Used including percentage)
# List of mounts to check\
MOUNTS=("/" "/workspace")

for MOUNT in "${MOUNTS[@]}"; do
    DISK_INFO=$(df -h "$MOUNT" | awk 'NR==2 {print $2, $3, $4, $5}')
    TOTAL=$(echo $DISK_INFO | awk '{print $1}')
    USED=$(echo $DISK_INFO | awk '{print $2}')
    FREE=$(echo $DISK_INFO | awk '{print $3}')
    PERCENT=$(echo $DISK_INFO | awk '{print $4}')
    echo "Disk Usage for $MOUNT:"
    echo "  Total: $TOTAL, Used: $USED, Free: $FREE, Usage: $PERCENT"
    echo ""
done

#Top 5 processes by CPU usage
echo "Top 5 processes by CPU usage:"
ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6

#Top 5 processes by Memory usage
echo "Top 5 processes by Memory usage:"
ps -eo pid,comm,%mem --sort=-%mem | head -n 6