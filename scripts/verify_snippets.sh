#!/usr/bin/env bash
# Quick check for key snippet files and demo
set -euo pipefail
files=( 
  "Vault/.obsidian/snippets/Notebook Backgrounds.css" 
  "Vault/.obsidian/snippets/Recolor Variants.css"
  "Vault/.obsidian/snippets/Daily Note Themes.css"
  "Vault/.obsidian/snippets/CyanVoxel's General Tweaks.css"
  "Vault/99 - Meta/Recolor Demo.md"
)

echo "Verifying presence of key files:"
for f in "${files[@]}"; do
  if [ -f "$f" ]; then
    echo " OK: $f"
  else
    echo " MISSING: $f"
  fi
done

echo "Done."