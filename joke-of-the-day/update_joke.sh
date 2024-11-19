#!/bin/bash

# Check if JOKEOFTHEDAY_CWD is already set, otherwise load from .env
if [ -z "$JOKEOFTHEDAY_CWD" ]; then
    DEFAULT_ENV_FILE="$(dirname "$0")/.env"
    if [ -f "$DEFAULT_ENV_FILE" ]; then
        export $(grep -v '^#' "$DEFAULT_ENV_FILE" | xargs)
    else
        echo ".env file not found, and JOKEOFTHEDAY_CWD is not set. Exiting."
        exit 1
    fi
fi

# Ensure JOKEOFTHEDAY_CWD is set
if [ -z "$JOKEOFTHEDAY_CWD" ]; then
    echo "JOKEOFTHEDAY_CWD is not set. Exiting."
    exit 1
fi

# Change to the working directory
cd "$JOKEOFTHEDAY_CWD" || { echo "Failed to change directory to $JOKEOFTHEDAY_CWD. Exiting."; exit 1; }

# Fetch a joke from icanhazdadjoke.com and save it to jokeoftheday.txt in the specified directory
curl -s -H "Accept: application/json" https://icanhazdadjoke.com/ | jq -r '.joke' > "$JOKEOFTHEDAY_CWD/jokeoftheday.txt"

# Notify the user that the joke has been saved
echo "Joke of the day saved to $JOKEOFTHEDAY_CWD/jokeoftheday.txt"

# Add the file to the git staging area
git add "$JOKEOFTHEDAY_CWD/jokeoftheday.txt"

# Commit the file with a meaningful message
git commit -m "Updated joke of the day"

# Push the changes to the remote repository
git push

# Notify the user of the completion
echo "Joke of the day has been pushed to the repository."

