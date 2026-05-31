#!/usr/bin/env bash
set -euo pipefail

# claude-skills installer (idempotent — safe to re-run)
# Pulls latest and symlinks skill commands into ~/.claude/commands/

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
COMMANDS_DIR="$SCRIPT_DIR/commands"
CLAUDE_COMMANDS_DIR="$HOME/.claude/commands"

echo "claude-skills installer"
echo "======================="
echo ""

# Pull latest
if [ -d "$SCRIPT_DIR/.git" ]; then
    echo "Pulling latest claude-skills..."
    cd "$SCRIPT_DIR" && git pull --quiet || echo "  (pull failed — continuing with local version)"
    echo ""
fi

echo "Repo path: $SCRIPT_DIR"
echo "Target:    $CLAUDE_COMMANDS_DIR"
echo ""

mkdir -p "$CLAUDE_COMMANDS_DIR"

# Helper: symlink source → target, upgrade stale file copies to symlinks
link_skill() {
    local source="$1"
    local target="$2"
    local name="$(basename "$source")"

    if [ -L "$target" ]; then
        existing="$(readlink "$target")"
        if [ "$existing" = "$source" ]; then
            echo "  [skip] $name (already linked)"
            return 1
        else
            echo "  [update] $name (repointing symlink)"
            rm "$target"
        fi
    elif [ -f "$target" ]; then
        echo "  [upgrade] $name (was a regular file — replacing with symlink)"
        rm "$target"
    fi

    ln -s "$source" "$target"
    echo "  [link] $name"
    return 0
}

echo "Skills:"
linked=0
skipped=0
for skill in "$COMMANDS_DIR"/*.md; do
    [ -f "$skill" ] || continue
    target="$CLAUDE_COMMANDS_DIR/$(basename "$skill")"
    if link_skill "$skill" "$target"; then
        linked=$((linked + 1))
    else
        skipped=$((skipped + 1))
    fi
done
echo "  Linked: $linked  Skipped: $skipped"
echo ""
echo "Done. Available skills:"
for skill in "$COMMANDS_DIR"/*.md; do
    [ -f "$skill" ] || continue
    echo "  /$(basename "$skill" .md)"
done
echo ""
echo "Restart Claude Code to pick up any new or updated skill descriptions."
