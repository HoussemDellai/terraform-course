package main

has_field(obj, field) {
    obj[field]
}

# deny[msg] {
#   rg := input.resource.azurerm_resource_group[name]
#   contains(rg, "tags")
#   msg = sprintf("No Tags provided. Resource in violation: %v", [name])
# }

deny[msg] {
    disk = input.resource.azurerm_managed_disk[name]
    has_field(disk, "encryption_settings")
    disk.encryption_settings.enabled != true
    msg = sprintf("Azure disk `%v` is not encrypted", [name])
}




minimum_tags = {"Tier", "Owner", "Project"}

key_val_valid_pascal_case(key, val) {
    is_pascal_case(key)
    is_pascal_case(val)
}

is_pascal_case(string) {
    re_match(`^([A-Z][a-z0-9]+)+`, string)
}

tags_contain_proper_keys(tags) {
    keys := {key | tags[key]}
    leftover := minimum_tags - keys
    leftover == set()
}

# module_address[i] = address {
#     changeset := input.resource_changes[i]
#     address := changeset.address
# }

tags_pascal_case[i] = resources {
    rg := input.azurerm_resource_group[name]
    tags  := rg.tags
    resources := [resource | resource := module_address[i]; val := tags[key]; not tags_validation.key_val_valid_pascal_case(key, val)]
}

tags_contain_minimum_set[i] = resources {
    changeset := input.azurerm_resource_group[i]
    tags := changeset.change.after.tags
    resources := [resource | resource := module_address[i]; not tags_validation.tags_contain_proper_keys(changeset.change.after.tags)]
}

deny[msg] {
    resources := tags_contain_minimum_set[_]
    resources != []
    msg := sprintf("Invalid tags (missing minimum required tags) for the following resources: %v", [resources])
}

deny[msg] {
    resources := tags_pascal_case[_]
    resources != []
    msg := sprintf("Invalid tags (not pascal case) for the following resources: %v", [resources])
}