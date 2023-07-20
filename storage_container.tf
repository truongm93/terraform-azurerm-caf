module "storage_containers" {
  source     = "./modules/storage_account/container/"
  depends_on = [time_sleep.azurerm_role_assignment_for]
  for_each   = local.storage.storage_containers

  settings             = each.value
  storage_account_name = can(each.value.storage_account.name) ? each.value.storage_account.name : local.combined_objects_storage_accounts[try(each.value.storage_account.lz_key, local.client_config.landingzone_key)][try(each.value.storage_account.key, each.value.storage_account_key)].name
  var_folder_path      = var.var_folder_path
}
output "storage_containers" {
  value = module.storage_containers
}