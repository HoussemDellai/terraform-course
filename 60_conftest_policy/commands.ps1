## Conftest
# Install Conftest: https://www.conftest.dev/install/
scoop bucket add instrumenta https://github.com/instrumenta/scoop-instrumenta
scoop install conftest

# run Conftest
conftest test -p policy/ main.tf --parser hcl2

# No need even to run $ terraform init, in this sample
# Conftest will only read the terraform files (not execution plan or state).
# However Conftest can also check against TF plan and state.



## TFlint : https://github.com/terraform-linters/tflint-ruleset-azurerm
# Download the plugin from: https://github.com/terraform-linters/tflint-ruleset-azurerm/releases
# and place it in: ./.tflint.d/plugins/tflint-ruleset-azurerm.exe

# Create file .tflint.hcl with content:
# plugin "azurerm" {
#     enabled = true
# }

# Install tflint CLI: https://github.com/terraform-linters/tflint

# Run tflint command:
tflint