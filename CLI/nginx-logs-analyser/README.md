# Nginx Log Analyzer (Shell Script)

A simple Bash script that analyzes an nginx access log file and prints useful statistics directly in the terminal.

## Features

- Top 5 IP addresses with the most requests
- Top 5 most requested paths
- Top 5 HTTP response status codes
- Top 5 User-Agent strings

## Requirements

- Bash
- Standard Unix tools: `awk`, `sort`, `uniq`, `grep`, `sed`

## Usage

```bash
chmod +x log-analyzer.sh
./log-analyzer.sh access.log

