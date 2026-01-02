# Server Stats Monitoring Script

A simple Bash script to monitor basic **server performance metrics** on Linux systems.  
It works in containers, VMs, or any Linux machine with minimal dependencies (`bash`, `top`, `awk`, `df`).

---

## Features

The script provides:

- **Total CPU usage** (via `top -bn2`, reliable snapshot)
- **Total Memory usage** (Free vs Used, using MemAvailable)
- **Total Disk usage** (Free vs Used for important mount points)
- **Top 5 processes by CPU usage**
- **Top 5 processes by Memory usage**

Optional: can be extended with OS info, uptime, load average, or failed logins.

---

## Requirements

- Linux system
- Bash shell (`#!/bin/bash`)
- Standard Linux utilities:
  - `top`
  - `awk`
  - `df`
- No additional packages required

---

## Installation

Clone the repository (or copy the script):

```bash
git clone git@github.com:YOUR_USERNAME/YOUR_REPO.git
cd YOUR_REPO/scripts/server-stats
chmod +x server-stats.sh
```
## Usage
Run the script:
```bash
./server-stats.sh
```
