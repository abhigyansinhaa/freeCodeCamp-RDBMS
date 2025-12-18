#!/bin/bash

# Check if an argument was provided
if [[ -z $1 ]]; then
  echo "Please provide an element as an argument."
  exit 0
fi

# Escape single quotes in the input
ESCAPED_INPUT="${1//\'/\'\'}"

# Try to convert input to atomic number if it's a number, otherwise use -1
if [[ $1 =~ ^[0-9]+$ ]]; then
  ATOMIC_NUM=$1
else
  ATOMIC_NUM=-1
fi

# Query the database for the element
RESULT=$(psql -U postgres -X -t -A -F '|' -c "
SELECT elements.atomic_number, symbol, name, atomic_mass, melting_point_celsius, boiling_point_celsius, types.type 
FROM elements 
LEFT JOIN properties ON elements.atomic_number = properties.atomic_number 
LEFT JOIN types ON properties.type_id = types.type_id 
WHERE elements.atomic_number = $ATOMIC_NUM
   OR symbol = '$ESCAPED_INPUT' 
   OR name = '$ESCAPED_INPUT';" periodic_table 2>/dev/null)

# Check if we got a result
if [[ -z $RESULT ]]; then
  echo "I could not find that element in the database."
  exit 0
fi

# Parse the result using pipe delimiter
IFS='|' read -r atomic_number symbol name atomic_mass melting boiling type <<< "$RESULT"

# Trim whitespace
atomic_number=$(echo "$atomic_number" | xargs)
symbol=$(echo "$symbol" | xargs)
name=$(echo "$name" | xargs)
atomic_mass=$(echo "$atomic_mass" | xargs)
melting=$(echo "$melting" | xargs)
boiling=$(echo "$boiling" | xargs)
type=$(echo "$type" | xargs)

# Format and display the output
echo "The element with atomic number $atomic_number is $name ($symbol). It's a $type, with a mass of $atomic_mass amu. $name has a melting point of $melting celsius and a boiling point of $boiling celsius."
