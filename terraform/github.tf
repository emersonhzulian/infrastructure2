# -----------------------------------------------------------------------------
# GitHub Connectivity Test
# -----------------------------------------------------------------------------
# This data source verifies that:
# 1. The PAT token is valid
# 2. We have access to the organization
# 3. We can read organization data
# -----------------------------------------------------------------------------

data "github_organization" "signalstratum" {
  name = "signalstratum"
}

# Get current authenticated user to verify token
data "github_user" "current" {
  username = "" # Empty string returns authenticated user
}

# -----------------------------------------------------------------------------
# Outputs to verify connectivity
# -----------------------------------------------------------------------------

output "github_connectivity" {
  description = "GitHub connectivity verification"
  value = {
    status = "✅ Connected"
    organization = {
      name        = data.github_organization.signalstratum.name
      description = data.github_organization.signalstratum.description
      plan        = data.github_organization.signalstratum.plan
    }
    authenticated_as = data.github_user.current.login
  }
}
