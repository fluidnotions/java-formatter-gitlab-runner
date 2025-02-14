#!/bin/bash

# Ensure we're in the repo directory
cd /repo || exit 1

# Configure Git
git config --global user.email "${GITLAB_USER_EMAIL:-gitlab-runner@localhost}"
git config --global user.name "${GITLAB_USER_NAME:-GitLab Runner}"

# Run Google Java Format
find . -name "*.java" | xargs java -jar /usr/local/bin/google-java-format-1.25.2-all-deps.jar --replace

# Commit and push if there are changes
git add .
if ! git diff --staged --quiet; then
    git commit -m "Auto-format Java code using Google Java Format"
    
    # Detect whether we are in a merge request pipeline
    if [ -n "${CI_MERGE_REQUEST_TARGET_BRANCH_NAME}" ]; then
        TARGET_BRANCH="${CI_MERGE_REQUEST_TARGET_BRANCH_NAME}"
    else
        TARGET_BRANCH="${CI_COMMIT_BRANCH}"
    fi

    echo "Pushing formatting changes to: origin/${TARGET_BRANCH}"
    git push origin "${TARGET_BRANCH}"
else
    echo "No formatting changes needed."
fi