#!/bin/sh

# A script for changing the personal details of a
# git contributor, to help you manage your GDPR
# responsibiities.
#
# Found at https://stackoverflow.com/questions/3042437/how-to-change-the-commit-author-for-one-specific-commit
# which says this originated in GitHub's documentation.
#
# Change lines 22-24 to suit before running.
#
# After running this locally, run
#
# git push --force --tags origin 'refs/heads/*'
#
# to push the rewritten changes to the origin.  Remember that if
# you have changed very old commits, every descendent commit will 
# also be replaced!

git filter-branch --env-filter '

OLD_EMAIL="your-old-email@example.com"
CORRECT_NAME="Your Correct Name"
CORRECT_EMAIL="your-correct-email@example.com"

if [ "$GIT_COMMITTER_EMAIL" = "$OLD_EMAIL" ]
then
    export GIT_COMMITTER_NAME="$CORRECT_NAME"
    export GIT_COMMITTER_EMAIL="$CORRECT_EMAIL"
fi
if [ "$GIT_AUTHOR_EMAIL" = "$OLD_EMAIL" ]
then
    export GIT_AUTHOR_NAME="$CORRECT_NAME"
    export GIT_AUTHOR_EMAIL="$CORRECT_EMAIL"
fi
' --tag-name-filter cat -- --branches --tags
