# logto-docker-compose

`./bootstrap.sh` copies the `.env.example` to `.env` and generates `POSTGRES_PASSWORD`. Check the code before using.

## Behind cloudflare

Logto makes server-side requests to its own public domain. These requests go through Cloudflare and can get blocked by Bot Fight Mode or other security rules.

To fix this, set `LOGTO_ENDPOINT_HOST` and `LOGTO_ADMIN_HOST` to an internal address with `NGINX_HOST_IP`, and download and set [root cert](https://developers.cloudflare.com/ssl/origin-configuration/origin-ca/#cloudflare-origin-ca-root-certificate) with `CA_CERT_HOST_PATH`, `NODE_EXTRA_CA_CERTS`.

See `.env.example`.
