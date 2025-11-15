#!/bin/bash

# Générer un email unique pour éviter les conflits
timestamp=$(date +%Y%m%d%H%M%S)
email="alice${timestamp}@example.com"

echo "=== Test 1: Registration ==="
register_response=$(curl -s -X POST http://localhost:3000/api/auth/register \
  -H "Content-Type: application/json" \
  -d "{
    \"email\": \"$email\",
    \"password\": \"password123\",
    \"nom\": \"Dupont\",
    \"prenom\": \"Alice\"
  }")

echo "Registration response: $register_response"

echo -e "\n=== Test 2: Login ==="
login_response=$(curl -s -X POST http://localhost:3000/api/auth/login \
  -H "Content-Type: application/json" \
  -d "{
    \"email\": \"$email\",
    \"password\": \"password123\"
  }")

echo "Login response: $login_response"

# Extraire le token avec jq
token=$(echo "$login_response" | jq -r '.token')
echo "Token extracted: $token"

echo -e "\n=== Test 3: Profile (with token) ==="
profile_response=$(curl -s -X GET http://localhost:3000/api/auth/profile \
  -H "Authorization: $token")

echo "Profile response: $profile_response"

echo -e "\n=== Tests completed ==="
