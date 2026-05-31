# claude-skills

Personal [Claude Code](https://claude.ai/claude-code) skills collection. Each skill is a slash command that loads context or executes a task inside Claude Code.

## Available Skills

| Skill | Command | What It Does |
|---|---|---|
| CLI Screenshot | `/ss` | Take a screenshot via interactive region selector and read it into the Claude Code conversation. Saves to `~/Desktop/screenshots/`. macOS only. |

## Setup (One-Time)

### Prerequisites

- [Claude Code](https://claude.ai/claude-code) installed (CLI, desktop app, or IDE extension)
- Git access to this repo

### Install

```bash
# 1. Clone the repo
git clone https://github.com/yayawt/claude-skills.git ~/projects/claude-skills

# 2. Run the installer
cd ~/projects/claude-skills
./install.sh
```

The installer:
- Symlinks each skill into `~/.claude/commands/` (making them available as slash commands)
- Safe to re-run anytime to pick up new skills

### Update

```bash
cd ~/projects/claude-skills && ./install.sh
```

## Usage

In any Claude Code session, type the slash command:

```
/ss
```

## Repo Structure

```
claude-skills/
├── commands/        # Skill prompt files (symlinked to ~/.claude/commands/)
│   └── ss.md
├── install.sh       # One-time setup script
└── README.md        # This file
```


### Skill File Format

```markdown
---
description: One-line description shown in Claude Code's skill list
allowed-tools: Bash(tool *), Read, Write
---

Instructions for Claude on what to do when this skill is invoked.
```
