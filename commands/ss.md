---
description: "CLI Screenshot — Take a screenshot via interactive region selector and read it into the Claude Code conversation. macOS only (uses `screencapture`). Saves to ~/Desktop/screenshots/ with a timestamp."
allowed-tools: Bash(date *), Bash(screencapture *), Bash(mkdir *), Read
---

Take a screenshot and read it into the conversation. macOS only (uses `screencapture`).

Steps:
1. Generate a timestamped filename by running two separate Bash calls: first `date +%Y-%m-%d_%H%M%S` to get the timestamp, then construct the path as `$HOME/Desktop/screenshots/ss_<timestamp>.png` — do NOT use command substitution like `$(date ...)` inside another command
2. Create the screenshots folder if it doesn't exist: `mkdir -p $HOME/Desktop/screenshots`
3. Run `screencapture -i <filename>` — this opens the interactive region selector
4. Once captured, read the file at that path — no confirmation needed, just display it and wait for the user's question
