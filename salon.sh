#!/bin/bash

PSQL="psql -X -U postgres -d salon --tuples-only -P format=unaligned -c"

echo "~~~~~ MY SALON ~~~~~"
echo ""

while true; do
  echo "Welcome to My Salon, how can I help you?"
  echo ""
  
  # Display all services as one output
  $PSQL "SELECT service_id, name FROM services ORDER BY service_id" | sed 's/|/) /'
  
  echo ""
  
  # Read service selection
  read SERVICE_ID_SELECTED
  
  # Check if service exists (only query if input is numeric)
  if [[ $SERVICE_ID_SELECTED =~ ^[0-9]+$ ]]; then
    SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id=$SERVICE_ID_SELECTED")
  else
    SERVICE_NAME=""
  fi
  
  if [[ -z "$SERVICE_NAME" ]]; then
    echo "I could not find that service. What would you like today?"
    echo ""
    continue
  fi
  
  # Service exists, break out of loop
  break
done

echo ""

# Read phone number
echo "What's your phone number?"
read CUSTOMER_PHONE
echo ""

# Check if customer exists
CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE'")

# If customer doesn't exist, add them
if [[ -z "$CUSTOMER_NAME" ]]; then
  echo "I don't have a record for that phone number, what's your name?"
  read CUSTOMER_NAME
  echo ""
  
  # Insert new customer
  $PSQL "INSERT INTO customers (phone, name) VALUES ('$CUSTOMER_PHONE', '$CUSTOMER_NAME')" > /dev/null
fi

# Get customer_id
CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")

# Ask for appointment time
echo "What time would you like your $SERVICE_NAME, $CUSTOMER_NAME?"
read SERVICE_TIME
echo ""

# Insert appointment
$PSQL "INSERT INTO appointments (customer_id, service_id, time) VALUES ($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')" > /dev/null

# Confirmation message
echo "I have put you down for a $SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME."
