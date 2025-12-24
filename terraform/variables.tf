# -----------------------------------------------------------------------------
# Cloudflare Variables (populated via TF_VAR_ environment variables from 1Password)
# -----------------------------------------------------------------------------

variable "cloudflare_account_id" {
  description = "Cloudflare account ID"
  type        = string
}

variable "cloudflare_zone_id_com" {
  description = "Zone ID for signalstratum.com"
  type        = string
}

variable "cloudflare_zone_id_io" {
  description = "Zone ID for signalstratum.io"
  type        = string
}

# -----------------------------------------------------------------------------
# Local values for convenience
# -----------------------------------------------------------------------------

locals {
  cloudflare_account_id = var.cloudflare_account_id

  zones = {
    com = {
      name    = "signalstratum.com"
      zone_id = var.cloudflare_zone_id_com
    }
    io = {
      name    = "signalstratum.io"
      zone_id = var.cloudflare_zone_id_io
    }
  }
}
