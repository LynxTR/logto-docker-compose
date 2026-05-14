#!/usr/bin/env bash
set -euo pipefail

ENV_FILE=".env"

if [[ -f "$ENV_FILE" ]]; then
  echo "# ----------------------------------------------------------"
  echo "# "
  echo "# -> ERROR: $ENV_FILE already exists. Remove it first if you want to regenerate."
  echo "# "
  echo "# ----------------------------------------------------------"
  exit 1
fi

generate_password() {
  tr -dc 'A-Za-z0-9!@#%^&*' </dev/urandom 2>/dev/null | head -c 32 || true
}

POSTGRES_PASSWORD=$(generate_password)

cat > "$ENV_FILE" <<EOF
# ----------------------------------------------------------
# PostgreSQL
# ----------------------------------------------------------
POSTGRES_DB=logto
POSTGRES_USER=logto
POSTGRES_PASSWORD=${POSTGRES_PASSWORD}

# ----------------------------------------------------------
# Logto
# ----------------------------------------------------------
ENDPOINT=https://auth.example.com
ADMIN_ENDPOINT=https://admin.example.com
TRUST_PROXY_HEADER=1
LOGTO_PORT=3001
LOGTO_ADMIN_PORT=3002

# ----------------------------------------------------------
# Image tags
# ----------------------------------------------------------
LOGTO_TAG=latest
POSTGRES_TAG=17-alpine
EOF

chmod 600 "$ENV_FILE"

echo "Generated $ENV_FILE"
echo "# ----------------------------------------------------------"
echo "# "
echo "# -> POSTGRES_PASSWORD = ${POSTGRES_PASSWORD}"
echo "# "
echo "# -> Edit ENDPOINT and ADMIN_ENDPOINT in $ENV_FILE before starting."
echo "# "
echo "# ----------------------------------------------------------"
