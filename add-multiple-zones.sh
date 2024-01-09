# Check if the .env file exists
if [ -f .env ]; then
  # Read the .env file line by line
  while IFS= read -r line; do
    # Ignore comments and empty lines
    if [[ $line == \#* || -z $line ]]; then
      continue
    fi

    # Split the line into variable and value
    key=$(echo "$line" | cut -d'=' -f1)
    value=$(echo "$line" | cut -d'=' -f2-)

    # Export the variable to the environment
    export "$key"="$value"
  done <.env
else
  echo "Error: .env file not found."
  exit 1
fi

# echo "CLOUDFLARE_EMAIL: $CLOUDFLARE_EMAIL"
# echo "CLOUDFLARE_API_KEY: $CLOUDFLARE_API_KEY"
# echo "ACCOUNT_ID: $ACCOUNT_ID"
# printf "\n"

# Ref: https://developers.cloudflare.com/fundamentals/setup/add-multiple-sites-automation/

for domain in $(cat domains.txt); do
  printf "Adding ${domain}:\n"

  add_output=$(curl https://api.cloudflare.com/client/v4/zones \
    -H 'Content-Type: application/json' \
    -H "X-Auth-Email: $CLOUDFLARE_EMAIL" \
    -H "X-Auth-Key: $CLOUDFLARE_API_KEY" \
    --data '{
      "account": {
        "id":"'"$ACCOUNT_ID"'"
      },
      "name": "'"$domain"'",
      "type": "full"
    }')

  printf "\n"

  # Check if the request was successful
  if [[ $(echo "$add_output" | jq -r '.success') == "false" ]]; then
    # Print error message and continue to the next domain
    error_message=$(echo "$add_output" | jq -r '.errors[0].message')
    echo "Error adding ${domain}: $error_message"
    continue
  fi

  # Create csv of nameservers
  echo $add_output | jq -r '[.result.name,.result.id,.result.name_servers[]] | @csv' >>./domain_nameservers.csv
done

printf "\n"
printf "name_servers are saved in ./domain_nameservers.csv"
cat ./domain_nameservers.csv
