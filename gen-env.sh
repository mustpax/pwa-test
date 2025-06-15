#!/bin/bash
set -euo pipefail

# Ensure script is run from project root
if [ ! -d "public" ]; then
    echo "Error: 'public' directory not found. Please run this script from the project root."
    exit 1
fi

# Get commit hash from VERCEL_GIT_COMMIT_SHA if available, otherwise use git
if [ -n "${VERCEL_GIT_COMMIT_SHA:-}" ]; then
    COMMIT_HASH="${VERCEL_GIT_COMMIT_SHA}"
else
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
fi

# Get list of files in public/deck directory
if [ -d "public/deck" ]; then
    # Create array of deck files
    DECK_FILES=($(ls -1 public/deck))
    # Convert array to JSON array string
    DECK_FILES_JSON=$(printf '"%s",' "${DECK_FILES[@]}" | sed 's/,$//')
else
    DECK_FILES_JSON=""
fi

# Create or update env.js with the commit hash and deck files
cat > public/env.js << EOF
export const env = {
  commitHash: "${COMMIT_HASH}",
  deckFiles: [${DECK_FILES_JSON}],
};
EOF

echo "Updated env.js with commit hash: ${COMMIT_HASH}"
echo "Added deck files: ${DECK_FILES_JSON}"
