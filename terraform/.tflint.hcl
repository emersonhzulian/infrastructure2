# TFLint configuration
# https://github.com/terraform-linters/tflint

plugin "terraform" {
  enabled = true
  preset  = "recommended"
}

# Enforce consistent naming
rule "terraform_naming_convention" {
  enabled = true
}

# Require descriptions for variables and outputs
rule "terraform_documented_variables" {
  enabled = true
}

rule "terraform_documented_outputs" {
  enabled = true
}

# Standard file structure
rule "terraform_standard_module_structure" {
  enabled = false  # Not a module yet
}
