#!/bin/bash

# Number Guessing Game Script
# This script implements a number guessing game with user statistics tracking

GAMES_DB="games.txt"

# ============ Helper Functions ============

# Function to get user stats
get_user_stats() {
  local username=$1
  if [[ -f "$GAMES_DB" ]]; then
    grep "^$username" "$GAMES_DB" | tail -1
  fi
}

# Function to count user games
count_user_games() {
  local username=$1
  grep "^$username" "$GAMES_DB" | wc -l
}

# Function to get best game for user
get_best_game() {
  local username=$1
  if [[ -f "$GAMES_DB" ]]; then
    grep "^$username" "$GAMES_DB" | awk '{print $2}' | sort -n | head -1
  fi
}

# Function to save game result
save_game() {
  local username=$1
  local guesses=$2
  echo "$username $guesses" >> "$GAMES_DB"
}

# Function to validate integer input
is_valid_integer() {
  [[ "$1" =~ ^[0-9]+$ ]]
}

# Function to greet user
greet_user() {
  local username=$1
  if grep -q "^$username " "$GAMES_DB" 2>/dev/null; then
    # Returning user
    local games_count=$(count_user_games "$username")
    local best_game=$(get_best_game "$username")
    echo "Welcome back, $username! You have played $games_count games, and your best game took $best_game guesses."
  else
    # New user
    echo "Welcome, $username! It looks like this is your first time here."
  fi
}
# Function to compare guess with secret number
compare_guess() {
  local guess=$1
  local secret=$2
  if (( guess < secret )); then
    echo "It's higher than that, guess again:"
  else
    echo "It's lower than that, guess again:"
  fi
}
# Function to compare guess with secret
compare_guess() {
  local guess=$1
  local secret=$2
  if (( guess < secret )); then
    echo "It's higher than that, guess again:"
  else
    echo "It's lower than that, guess again:"
  fi
}

# ============ Main Game Logic ============

# Prompt for username
echo "Enter your username:"
read username

# Greet the user
greet_user "$username"

# Generate random number between 1 and 1000
SECRET=$((RANDOM % 1000 + 1))

# Prompt for first guess
echo "Guess the secret number between 1 and 1000:"
read guess

# Counter for guesses
GUESSES=1

# Game loop
while [[ $guess -ne $SECRET ]]; do
  # Validate input is integer
  if ! is_valid_integer "$guess"; then
    echo "That is not an integer, guess again:"
    read guess
    continue
  fi

  # Compare guess with secret and get feedback
  compare_guess "$guess" "$SECRET"

  read guess
  ((GUESSES++))
done

# Game finished - validate final guess is integer
if is_valid_integer "$guess"; then
  echo "You guessed it in $GUESSES tries. The secret number was $((SECRET)). Nice job!"
  save_game "$username" "$GUESSES"
fi
