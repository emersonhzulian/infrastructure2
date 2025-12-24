# 1Password environment template for local development
# Usage: op run --env-file=.env.tpl -- terraform plan

# GitHub Provider
GITHUB_TOKEN=op://ss-infrastructure/github/api-token

# Cloudflare Provider
CLOUDFLARE_API_TOKEN=op://ss-infrastructure/cloudflare/api-token
TF_VAR_cloudflare_account_id=op://ss-infrastructure/cloudflare/account-id
TF_VAR_cloudflare_zone_id_com=op://ss-infrastructure/cloudflare/com-zone-id
TF_VAR_cloudflare_zone_id_io=op://ss-infrastructure/cloudflare/io-zone-id

# R2 Backend (S3-compatible)
AWS_ACCESS_KEY_ID=op://ss-infrastructure/r2/access-key-id
AWS_SECRET_ACCESS_KEY=op://ss-infrastructure/r2/secret-access-key
AWS_ENDPOINT_URL_S3=op://ss-infrastructure/r2/url
