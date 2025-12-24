# -----------------------------------------------------------------------------
# DNS Records
# -----------------------------------------------------------------------------
# Managed DNS records for signalstratum.com and signalstratum.io
# Email records (MX, SPF, DKIM, DMARC) are managed by email_routing.tf
# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------
# signalstratum.com - Primary Domain
# -----------------------------------------------------------------------------

# Root domain - placeholder until website is ready
# resource "cloudflare_dns_record" "com_root" {
#   zone_id = local.zones.com.zone_id
#   name    = "@"
#   type    = "A"
#   content = "192.0.2.1"  # Reserved - update when hosting is ready
#   ttl     = 3600
#   proxied = true
# }

# www redirect - placeholder until website is ready  
# resource "cloudflare_dns_record" "com_www" {
#   zone_id = local.zones.com.zone_id
#   name    = "www"
#   type    = "CNAME"
#   content = "signalstratum.com"
#   ttl     = 3600
#   proxied = true
# }

# -----------------------------------------------------------------------------
# signalstratum.io - Secondary Domain
# -----------------------------------------------------------------------------

# Will redirect to .com when configured
# resource "cloudflare_dns_record" "io_root" {
#   zone_id = local.zones.io.zone_id
#   name    = "@"
#   type    = "A"
#   content = "192.0.2.1"  # Reserved - update when hosting is ready
#   ttl     = 3600
#   proxied = true
# }
