#!/bin/bash
# Installs the Superpowers plugin in Claude Code cloud sessions.
set -euo pipefail

if [ "${CLAUDE_CODE_REMOTE:-}" != "true" ]; then
  exit 0
fi

# Skip when it's already installed (the hook runs on every start, resume, clear and compact)
if claude plugin list 2>/dev/null | grep -q 'superpowers@superpowers-marketplace'; then
  exit 0
fi

if ! claude plugin marketplace list 2>/dev/null | grep -q 'superpowers-marketplace'; then
  claude plugin marketplace add obra/superpowers-marketplace >&2
fi
claude plugin install superpowers@superpowers-marketplace >&2
