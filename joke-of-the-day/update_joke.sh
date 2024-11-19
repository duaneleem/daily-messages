#!/bin/bash

# Fetch a joke from icanhazdadjoke.com and save it to jokeoftheday.txt
curl -s -H "Accept: application/json" https://icanhazdadjoke.com/ | jq -r '.joke' > jokeoftheday.txt

# Notify the user that the joke has been saved
echo "Joke of the day saved to jokeoftheday.txt"

# Add the file to the git staging area
git add jokeoftheday.txt

# Commit the file with a meaningful message
git commit -m "Updated joke of the day"

# Push the changes to the remote repository
git push

# Notify the user of the completion
echo "Joke of the day has been pushed to the repository."



