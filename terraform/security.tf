# -----------------------------------------------------------------------------
# Zone Security Settings
# -----------------------------------------------------------------------------
# TLS, security headers, and other zone-level security configurations
# Uses cloudflare_zone_setting for v5.x provider (individual settings)
# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------
# signalstratum.com - Security Settings
# -----------------------------------------------------------------------------

resource "cloudflare_zone_setting" "com_ssl" {
  zone_id    = local.zones.com.zone_id
  setting_id = "ssl"
  value      = "strict"
}

resource "cloudflare_zone_setting" "com_always_use_https" {
  zone_id    = local.zones.com.zone_id
  setting_id = "always_use_https"
  value      = "on"
}

resource "cloudflare_zone_setting" "com_min_tls_version" {
  zone_id    = local.zones.com.zone_id
  setting_id = "min_tls_version"
  value      = "1.2"
}

resource "cloudflare_zone_setting" "com_tls_1_3" {
  zone_id    = local.zones.com.zone_id
  setting_id = "tls_1_3"
  value      = "on"
}

resource "cloudflare_zone_setting" "com_automatic_https_rewrites" {
  zone_id    = local.zones.com.zone_id
  setting_id = "automatic_https_rewrites"
  value      = "on"
}

resource "cloudflare_zone_setting" "com_security_level" {
  zone_id    = local.zones.com.zone_id
  setting_id = "security_level"
  value      = "medium"
}

resource "cloudflare_zone_setting" "com_brotli" {
  zone_id    = local.zones.com.zone_id
  setting_id = "brotli"
  value      = "on"
}

# -----------------------------------------------------------------------------
# signalstratum.io - Security Settings
# -----------------------------------------------------------------------------

resource "cloudflare_zone_setting" "io_ssl" {
  zone_id    = local.zones.io.zone_id
  setting_id = "ssl"
  value      = "strict"
}

resource "cloudflare_zone_setting" "io_always_use_https" {
  zone_id    = local.zones.io.zone_id
  setting_id = "always_use_https"
  value      = "on"
}

resource "cloudflare_zone_setting" "io_min_tls_version" {
  zone_id    = local.zones.io.zone_id
  setting_id = "min_tls_version"
  value      = "1.2"
}

resource "cloudflare_zone_setting" "io_tls_1_3" {
  zone_id    = local.zones.io.zone_id
  setting_id = "tls_1_3"
  value      = "on"
}

resource "cloudflare_zone_setting" "io_automatic_https_rewrites" {
  zone_id    = local.zones.io.zone_id
  setting_id = "automatic_https_rewrites"
  value      = "on"
}

resource "cloudflare_zone_setting" "io_security_level" {
  zone_id    = local.zones.io.zone_id
  setting_id = "security_level"
  value      = "medium"
}

resource "cloudflare_zone_setting" "io_brotli" {
  zone_id    = local.zones.io.zone_id
  setting_id = "brotli"
  value      = "on"
}

# -----------------------------------------------------------------------------
# Outputs
# -----------------------------------------------------------------------------

output "security_settings" {
  description = "Zone security configuration summary"
  value = {
    tls = {
      mode        = "strict"
      min_version = "1.2"
      tls_1_3     = "enabled"
    }
    https = {
      always_use_https   = "enabled"
      automatic_rewrites = "enabled"
    }
    security_level = "medium"
    compression    = "brotli"
  }
}
