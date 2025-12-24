# Signal Stratum Infrastructure

[![Terraform](https://github.com/signalstratum/infrastructure/actions/workflows/terraform.yml/badge.svg)](https://github.com/signalstratum/infrastructure/actions/workflows/terraform.yml)

Infrastructure as Code for [Signal Stratum Consulting](https://signalstratum.com) — managed declaratively with Terraform and secured via 1Password.

## 🏗️ What This Manages

| Resource | Provider | Status |
|----------|----------|--------|
| **DNS** (signalstratum.com, .io) | Cloudflare | ✅ Ready |
| **Email Routing** (catch-all → Gmail) | Cloudflare | ✅ Ready |
| **Security Settings** (TLS, HTTPS) | Cloudflare | ✅ Ready |
| **GitHub Org Connectivity** | GitHub | ✅ Ready |
| **Future: Repo Management** | GitHub | 🔜 Planned |

## 🔐 Security Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                     GitHub Actions                               │
│                                                                  │
│   ┌─────────────────┐     ┌─────────────────────────────────┐   │
│   │ GitHub Secrets  │     │        1Password Vault          │   │
│   │                 │     │       (ss-infrastructure)       │   │
│   │ OP_SERVICE_     │────▶│                                 │   │
│   │ ACCOUNT_TOKEN   │     │  • cloudflare/api-token         │   │
│   │ (only secret)   │     │  • cloudflare/account-id        │   │
│   └─────────────────┘     │  • cloudflare/com-zone-id       │   │
│                           │  • cloudflare/io-zone-id        │   │
│                           │  • github/api-token             │   │
│                           └─────────────────────────────────┘   │
│                                        │                         │
│                                        ▼                         │
│                              ┌─────────────────┐                 │
│                              │    Terraform    │                 │
│                              │                 │                 │
│                              │  • Cloudflare   │                 │
│                              │  • GitHub       │                 │
│                              └─────────────────┘                 │
└─────────────────────────────────────────────────────────────────┘
```

**Only one secret in GitHub** — the 1Password service account token. Everything else lives in 1Password.

## 🚀 How It Works

### GitOps Workflow

1. **Create PR** with infrastructure changes
2. **GitHub Actions** runs `terraform plan`
3. **Review** the plan in PR comments
4. **Merge** to trigger `terraform apply`

### Local Development

```bash
# Install 1Password CLI: https://developer.1password.com/docs/cli/get-started

# Run Terraform with 1Password secrets
cd terraform
op run --env-file=../.env.tpl -- terraform plan
```

## 📁 Repository Structure

```
.
├── .github/
│   └── workflows/
│       └── terraform.yml    # CI/CD pipeline
├── terraform/
│   ├── providers.tf         # Provider configuration
│   ├── variables.tf         # Input variables
│   ├── cloudflare.tf        # Cloudflare resources
│   └── github.tf            # GitHub resources
├── .env.tpl                  # 1Password env template (local dev)
└── README.md
```

## 🛠️ Setup

### Prerequisites

- [Terraform](https://terraform.io) >= 1.6.0
- [1Password CLI](https://developer.1password.com/docs/cli/get-started) (for local dev)
- Access to `ss-infrastructure` vault in 1Password

### Initial Setup (Done ✅)

1. Created `infrastructure` repo manually (bootstrap exception)
2. Created 1Password service account with read access to `ss-infrastructure` vault
3. Added `OP_SERVICE_ACCOUNT_TOKEN` to GitHub repository secrets

### Adding New Secrets

1. Add to 1Password vault `ss-infrastructure`
2. Reference in workflow: `op://ss-infrastructure/item-name/field-name`
3. Add to `.env.tpl` for local development

## 📋 Roadmap

- [x] Repository setup
- [x] GitHub Actions workflow with 1Password
- [x] Connectivity verification (Cloudflare + GitHub)
- [ ] Cloudflare DNS records
- [ ] Cloudflare email routing
- [ ] Cloudflare security settings (TLS, WAF)
- [ ] GitHub organization settings
- [ ] Remote state backend (Terraform Cloud or S3)
- [ ] Website deployment (Cloudflare Pages)

## 🤔 Design Decisions

### Why 1Password over GitHub Secrets?

- **Single source of truth** for all secrets
- **Auditable** — see who accessed what
- **Rotatable** — update once, works everywhere
- **Shareable** — if team grows, just grant vault access

### Why Public Repo?

This demonstrates:
- Infrastructure as Code best practices
- GitOps workflow
- Security-conscious design (no secrets in code)
- Real-world portfolio piece

### Bootstrap Exception

This repo was created manually — it's the only exception. Everything else is managed by Terraform.

---

**Signal Stratum Consulting** — *Maximum leverage, any layer*
