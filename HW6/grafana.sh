#!/bin/bash

# Set variables for Grafana URL and admin credentials
GRAFANA_URL="http://192.168.99.100:3000"
GRAFANA_ADMIN_USER="admin"
GRAFANA_ADMIN_PASSWORD="admin"

# Set variables for the new user credentials
NEW_USER_NAME="Enzo "
NEW_USER_EMAIL="kalin.at.ivanov@gmail.com"
NEW_USER_PASSWORD="Aecfl9e3wq"

# Authenticate as admin user and get an authentication token
GRAFANA_TOKEN=$(curl -s -H "Content-Type: application/json" -X POST \
  -d '{"user":"'$GRAFANA_ADMIN_USER'","email":"","password":"'$GRAFANA_ADMIN_PASSWORD'"}' \
  "$GRAFANA_URL/api/auth/login" | jq -r '.user.token')

# Create or update the new user account using the authentication token
curl -s -H "Authorization: Bearer $GRAFANA_TOKEN" -H "Content-Type: application/json" -X POST \
  -d '{"name":"'$NEW_USER_NAME'","email":"'$NEW_USER_EMAIL'","login":"'$NEW_USER_NAME'","password":"'$NEW_USER_PASSWORD'","role":"Viewer"}' \
  "$GRAFANA_URL/api/admin/users"
