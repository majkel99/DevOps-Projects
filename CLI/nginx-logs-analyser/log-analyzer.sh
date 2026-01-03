#!/bin/bash

# Exit immediately if any command fails
# This prevents the script from continuing with invalid or partial results
set -e

# First argument passed to the script is the log file path
LOG_FILE="$1"

# ------------------------------------------------------------
# Validate input
# ------------------------------------------------------------
# Check:
# 1) If an argument was provided
# 2) If the provided argument is an existing file
#
# If either condition fails, print usage and exit
if [[ -z "$LOG_FILE" || ! -f "$LOG_FILE" ]]; then
  echo "Usage: $0 <nginx-access-log-file>"
  exit 1
fi

# ------------------------------------------------------------
# Top 5 IP addresses with the most requests
# ------------------------------------------------------------
# Field 1 in nginx access logs is the client IP address
# Steps:
# - Extract IPs
# - Sort them
# - Count duplicates
# - Sort by count (descending)
# - Show top 5
# - Format output
echo "Top 5 IP addresses with the most requests:"
awk '{print $1}' "$LOG_FILE" \
  | sort \
  | uniq -c \
  | sort -nr \
  | head -5 \
  | awk '{print $2 " - " $1 " requests"}'

echo

# ------------------------------------------------------------
# Top 5 most requested paths
# ------------------------------------------------------------
# Field 7 contains the requested path (e.g. /api/v1/users)
echo "Top 5 most requested paths:"
awk '{print $7}' "$LOG_FILE" \
  | sort \
  | uniq -c \
  | sort -nr \
  | head -5 \
  | awk '{print $2 " - " $1 " requests"}'

echo

# ------------------------------------------------------------
# Top 5 response status codes
# ------------------------------------------------------------
# Field 9 contains the HTTP response status code (e.g. 200, 404)
echo "Top 5 response status codes:"
awk '{print $9}' "$LOG_FILE" \
  | sort \
  | uniq -c \
  | sort -nr \
  | head -5 \
  | awk '{print $2 " - " $1 " requests"}'

echo

# ------------------------------------------------------------
# Top 5 user agents (regex-based approach)
# ------------------------------------------------------------
# The User-Agent is the LAST quoted string in an nginx access log line
#
# grep -oP '"[^"]+"$' :
#   - Extracts only the last quoted string from each line
# tr -d '"' :
#   - Removes the surrounding quotes
# sed 's/^ *\([0-9]\+\) \(.*\)/\2 - \1 requests/':
#   - Formats the final output
echo "Top 5 user agents (grep-based):"
grep -oP '"[^"]+"$' "$LOG_FILE" \
  | tr -d '"' \
  | sort \
  | uniq -c \
  | sort -nr \
  | head -5 \
  | sed 's/^ *\([0-9]\+\) \(.*\)/\2 - \1 requests/'

echo
