# log-archive

A simple CLI tool for archiving log files on Unix/Linux systems. Compresses logs from a specified directory into a timestamped `.tar.gz` archive, stores it in `/var/log-archive`, and logs each operation.

## Features
- Compress and archive logs from any directory
- Timestamped `.tar.gz` archives
- Logs archive operations

## Installation
```bash
chmod +x log-archive
sudo mv log-archive /usr/local/bin/

Usage
log-archive <log-directory>

Example:
log-archive /var/log
