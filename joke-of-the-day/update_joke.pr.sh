#!/bin/bash

# Fetch a joke and save it
curl -s -H "Accept: application/json" https://icanhazdadjoke.com/ | jq -r '.joke' > jokeoftheday.txt

# Commit and push the changes to the `dev` branch
git checkout dev
git pull origin dev
git add jokeoftheday.txt
git commit -m "Updated joke of the day"
git push origin dev

# Create a pull request from `dev` to `main`
gh pr create --base main --head dev --title "Automated Update: Joke of the Day" --body "This PR updates the joke of the day."

# Automatically approve and merge the pull request
PR_NUMBER=$(gh pr list --base main --head dev --json number --jq '.[0].number')
gh pr review $PR_NUMBER --approve
gh pr merge $PR_NUMBER --merge

# Notify the user
echo "Joke of the day updated and merged to main."
