global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
  }
}

provider_azurerm_features_keyvault = {
  // set to true to cleanup the CI
  purge_soft_delete_on_destroy = true
}

resource_groups = {
  kv_region1 = {
    name = "example-rg1"
  }
}

keyvaults = {
  cert_secrets = {
    name               = "certsecrets"
    resource_group_key = "kv_region1"
    sku_name           = "standard"
    # cert_password_key  = "cert-password"
    creation_policies = {
      logged_in_user = {
        certificate_permissions = ["Get", "List", "Update", "Create", "Import", "Delete", "Purge", "Recover", "GetIssuers", "SetIssuers", "ListIssuers", "DeleteIssuers", "ManageIssuers", "Restore", "ManageContacts"]
        secret_permissions      = ["Set", "Get", "List", "Delete", "Purge"]
      }
    }

  }
}

# Store output attributes into keyvault secret
dynamic_keyvault_secrets = {
  cert_secrets = { # Key of the keyvault
    cert-password = {
      secret_name = "cert-password"
      value       = "Very@Str5ngP!44w0rdToChaNge#"
    }
  }
}

keyvault_certificate_issuers = {
  kv_cert_issuer = {
    issuer_name        = "DummyIssuer"
    provider_name      = "DigiCert"
    organization_id    = "ExampleOrg"
    account_id         = "0000"
    resource_group_key = "kv_region1"
    # lz_key           = "" # for remote lz
    keyvault_key      = "cert_secrets"
    cert_password_key = "cert-password"
    # cert_issuer_password = "password in clear text. not recommended"
    # cert_secret_name = "cert-password" # replace the cert_password_key for remote lz reference

    admin_settings = {
      admin1 = {
        first_name    = "cert-admin1"
        last_name     = "cert-admin1-last-name"
        email_address = "joe@contoso.com"
        phone_number  = "00000000"
      } #remove the following block if additional adminss aren't needed.
      admin2 = {
        first_name    = "cert-admin2"
        last_name     = "cert-admin2-last-name"
        email_address = "joe@contoso.com"
        phone_number  = "00000001"
      }
    } #add more admins by repeating the block.

  }
}
