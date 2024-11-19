#!/bin/bash

# Fetch a joke from icanhazdadjoke.com and save it to jokeoftheday.txt
curl -s -H "Accept: application/json" https://icanhazdadjoke.com/ | jq -r '.joke' > jokeoftheday.txt

# Notify the user
echo "Joke of the day saved to jokeoftheday.txt"


