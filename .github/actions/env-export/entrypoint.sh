#!/bin/sh
set -e

# Get a list of env vars (this is a hack, we need a command for this)
env_var_names=$(secrethub run -- env | grep "<redacted by SecretHub>" | cut -d '=' -f 1)

for var_name in $env_var_names; do
	# Read the secret value (this is a hack)
	secret_value=$(secrethub run --no-masking -- printenv $var_name)
	echo "::set-env name=$var_name::$secret_value"
	echo "::add-mask::$secret_value"
done
