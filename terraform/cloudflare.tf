# -----------------------------------------------------------------------------
# Cloudflare Connectivity Test
# -----------------------------------------------------------------------------
# This data source verifies that:
# 1. The API token is valid
# 2. We have access to the zones
# 3. The zone IDs are correct
# -----------------------------------------------------------------------------

data "cloudflare_zone" "com" {
  zone_id = local.zones.com.zone_id
}

data "cloudflare_zone" "io" {
  zone_id = local.zones.io.zone_id
}

# -----------------------------------------------------------------------------
# Outputs to verify connectivity
# -----------------------------------------------------------------------------

output "cloudflare_connectivity" {
  description = "Cloudflare connectivity verification"
  value = {
    status = "✅ Connected"
    zones = {
      com = {
        name   = data.cloudflare_zone.com.name
        status = data.cloudflare_zone.com.status
      }
      io = {
        name   = data.cloudflare_zone.io.name
        status = data.cloudflare_zone.io.status
      }
    }
  }
}
