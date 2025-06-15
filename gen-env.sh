#!/bin/bash

# Get the current git commit hash
COMMIT_HASH=$(git rev-parse HEAD)

# Create or update env.js with the commit hash
cat > env.js << EOF
export const env = {
  commitHash: "${COMMIT_HASH}",
};
EOF

echo "Updated env.js with commit hash: ${COMMIT_HASH}"
