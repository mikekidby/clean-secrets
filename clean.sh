#!/bin/bash

DRY_RUN=false

# Set your GitHub username and access token and specify the repo to run automatically
GITHUB_USER_NAME="username"

FINE_GRAIN_ACCESS_TOKEN="finegrainaccesstoken"

REPO="program-service-wp"

# Check for the dry-run flag
if [[ $1 == "--dry-run" ]]; then
  DRY_RUN=true
fi

echo "Starting processing of repositories..."

# Clone the repo as a bare mirror
if [ "$DRY_RUN" = true ]; then
  echo "Dry run: git clone --mirror https://$GITHUB_USER_NAME:$FINE_GRAIN_ACCESS_TOKEN@github.com/risepoint/$REPO.git"
else
  git clone --mirror https://$GITHUB_USER_NAME:$FINE_GRAIN_ACCESS_TOKEN@github.com/risepoint/$REPO.git
fi

# Run BFG to delete files or sensitive data patterns
if [ "$DRY_RUN" = true ]; then
  echo "Dry run: java -jar bfg-1.14.0.jar --delete-files sensitive_data.txt $REPO.git"
else
  java -jar bfg-1.14.0.jar --replace-text sensitive_data.txt $REPO.git
fi

# Clean up and remove the sensitive data from Git history
if [ "$DRY_RUN" = true ]; then
  echo "Dry run: cd $REPO.git"
  echo "Dry run: git reflog expire --expire=now --all && git gc --prune=now --aggressive"
else
  cd $REPO.git
  git reflog expire --expire=now --all && git gc --prune=now --aggressive
  cd ..
fi

# Push the changes back to GitHub
if [ "$DRY_RUN" = true ]; then
  echo "Dry run: git push --force"
else
  git push --force
fi

echo "Finished processing $REPO."


echo "All repositories processed."
