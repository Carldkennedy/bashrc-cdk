#!/bin/bash

# Directory to store the backups
BACKUP_DIR="$HOME/.bash_history_backups"
# File to store the last backed-up history line number
LAST_LINE_FILE="$BACKUP_DIR/last_line.txt"

# Create the backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR"

# Initialize the last backed-up line number if it doesn't exist
if [ ! -f "$LAST_LINE_FILE" ]; then
  echo 0 > "$LAST_LINE_FILE"
fi

# Get the last backed-up line number
LAST_LINE=$(cat "$LAST_LINE_FILE")

# Get the current history file length
CURRENT_LINE=$(wc -l < "$HOME/.bash_history")

# If there are new lines to backup
if [ "$CURRENT_LINE" -gt "$LAST_LINE" ]; then
  # Backup file name with timestamp
  BACKUP_FILE="$BACKUP_DIR/bash_history_$(date +%Y%m%d%H%M%S).txt"

  # Extract new lines and append them to the backup file
  tail -n +"$((LAST_LINE + 1))" "$HOME/.bash_history" | while IFS= read -r line
  do
    if [[ $line =~ ^#([0-9]+)$ ]]; then
      # Convert the timestamp to a readable format
      timestamp=${BASH_REMATCH[1]}
      echo "$(date -d @$timestamp)"
    else
      # Print the command as is
      echo "$line"
    fi
  done > "$BACKUP_FILE"

  # Update the last backed-up line number
  echo "$CURRENT_LINE" > "$LAST_LINE_FILE"
fi

