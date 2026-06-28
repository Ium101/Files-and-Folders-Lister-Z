#!/bin/bash
# macOS double-clickable launcher for Files and Folders Lister Z (CLI)
DIR="$(cd "$(dirname "$0")" && pwd)"

# Check for Python 3 or Python
PYTHON_CMD=""
if command -v python3 &> /dev/null; then
    PYTHON_CMD="python3"
elif command -v python &> /dev/null && python --version 2>&1 | grep -q "Python 3"; then
    PYTHON_CMD="python"
else
    echo "Python 3 could not be found. Please install Python 3."
    exit 1
fi

"$PYTHON_CMD" "$DIR/lister_z.py"
