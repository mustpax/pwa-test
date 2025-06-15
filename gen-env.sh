#!/bin/bash
set -euo pipefail

# Ensure script is run from project root
if [ ! -d "public" ]; then
    echo "Error: 'public' directory not found. Please run this script from the project root."
    exit 1
fi

# Check if git is available
if ! command -v git &> /dev/null; then
    echo "Error: git is not installed"
    exit 1
fi

# Check if we're in a git repository
if ! git rev-parse --is-inside-work-tree &> /dev/null; then
    echo "Error: Not in a git repository"
    exit 1
fi


# Get the current git commit hash
COMMIT_HASH=$(git rev-parse HEAD)

# Create or update env.js with the commit hash
cat > public/env.js << EOF
export const env = {
  commitHash: "${COMMIT_HASH}",
};
EOF

echo "Updated env.js with commit hash: ${COMMIT_HASH}"
