# -----------------------------------------------------------------------------
# Email Routing - Cloudflare Email Routing
# -----------------------------------------------------------------------------
# Forwards emails to signalstratum@gmail.com
# DNS records (MX, SPF) are auto-created via cloudflare_email_routing_dns
# -----------------------------------------------------------------------------

locals {
  email_destination = "signalstratum@gmail.com"
}

# -----------------------------------------------------------------------------
# Destination Address (must be verified via email)
# -----------------------------------------------------------------------------

resource "cloudflare_email_routing_address" "primary" {
  account_id = local.cloudflare_account_id
  email      = local.email_destination
}

# -----------------------------------------------------------------------------
# signalstratum.com - Email Routing
# -----------------------------------------------------------------------------

# Enable email routing for the zone
resource "cloudflare_email_routing_settings" "com" {
  zone_id = local.zones.com.zone_id
}

# Auto-configure DNS records for email routing (MX, SPF)
resource "cloudflare_email_routing_dns" "com" {
  zone_id = local.zones.com.zone_id

  depends_on = [cloudflare_email_routing_settings.com]
}

# Catch-all rule: forward all emails to destination
resource "cloudflare_email_routing_catch_all" "com" {
  zone_id = local.zones.com.zone_id
  enabled = true
  name    = "Catch-all forward to ${local.email_destination}"

  matchers = [{
    type = "all"
  }]

  actions = [{
    type  = "forward"
    value = [local.email_destination]
  }]

  depends_on = [
    cloudflare_email_routing_dns.com,
    cloudflare_email_routing_address.primary
  ]
}

# DMARC record for email authentication
resource "cloudflare_dns_record" "com_dmarc" {
  zone_id = local.zones.com.zone_id
  name    = "_dmarc"
  type    = "TXT"
  content = "v=DMARC1; p=quarantine; rua=mailto:dmarc@${local.zones.com.name}"
  ttl     = 3600
}

# -----------------------------------------------------------------------------
# signalstratum.io - Email Routing
# -----------------------------------------------------------------------------

# Enable email routing for the zone
resource "cloudflare_email_routing_settings" "io" {
  zone_id = local.zones.io.zone_id
}

# Auto-configure DNS records for email routing (MX, SPF)
resource "cloudflare_email_routing_dns" "io" {
  zone_id = local.zones.io.zone_id

  depends_on = [cloudflare_email_routing_settings.io]
}

# Catch-all rule: forward all emails to destination
resource "cloudflare_email_routing_catch_all" "io" {
  zone_id = local.zones.io.zone_id
  enabled = true
  name    = "Catch-all forward to ${local.email_destination}"

  matchers = [{
    type = "all"
  }]

  actions = [{
    type  = "forward"
    value = [local.email_destination]
  }]

  depends_on = [
    cloudflare_email_routing_dns.io,
    cloudflare_email_routing_address.primary
  ]
}

# DMARC record for email authentication
resource "cloudflare_dns_record" "io_dmarc" {
  zone_id = local.zones.io.zone_id
  name    = "_dmarc"
  type    = "TXT"
  content = "v=DMARC1; p=quarantine; rua=mailto:dmarc@${local.zones.io.name}"
  ttl     = 3600
}

# -----------------------------------------------------------------------------
# Outputs
# -----------------------------------------------------------------------------

output "email_routing" {
  description = "Email routing configuration"
  value = {
    destination = local.email_destination
    domains = {
      com = {
        name    = local.zones.com.name
        enabled = true
      }
      io = {
        name    = local.zones.io.name
        enabled = true
      }
    }
    note = "Verify ${local.email_destination} via email link from Cloudflare"
  }
}
