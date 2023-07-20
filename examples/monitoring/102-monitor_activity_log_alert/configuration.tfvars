global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
  }
  random_length = 5
}

resource_groups = {
  rg1 = {
    name = "example"
  }
}

monitor_action_groups = {
  mag1 = {
    action_group_name  = "example-ag-name"
    resource_group_key = "rg1"
    shortname          = "example"

    email_receiver = {
      email_alert1 = {
        name                    = "email_alert_servicehealth_me"
        email_address           = "joe@contoso.com"
        use_common_alert_schema = false
      } #remove the following block if additional email alerts aren't needed.
      email_alert2 = {
        name                    = "email_alert_servicehealth_somoneelse"
        email_address           = "jane@contoso.com"
        use_common_alert_schema = false
      }
    }

    #more alert settings can be dynamically added/removed by commenting in/out the following blocks
    # sms_receiver = {
    #   sms_alert1 = {
    #     name         = "sms_alert_servicehealth"
    #     country_code = "65"
    #     phone_number = "0000000"
    #   }
    # }

    webhook_receiver = {
      webhook1 = {
        name        = "webhook_trigger_servicehealth"
        service_uri = "https://uri"
      }
    }

    arm_role_receiver = {
      role_alert1 = {
        name                    = "servicehealth-alerts-contributors"
        use_common_alert_schema = false
        role_name               = "Contributor" #case-sensitive
      }
      role_alert2 = {
        name                    = "servicehealth-alerts-owners"
        use_common_alert_schema = false
        role_name               = "Owner" #case-sensitive
      }
    }

    tags = {
      first_tag  = "example1",
      second_tag = "example2",
    }
  }
}

storage_accounts = {
  sa1 = {
    name                     = "sa1dev"
    resource_group_key       = "rg1"
    account_kind             = "BlobStorage"
    account_tier             = "Standard"
    account_replication_type = "GRS"
  }
  sa2 = {
    name                     = "sa2dev"
    resource_group_key       = "rg1"
    account_kind             = "BlobStorage"
    account_tier             = "Standard"
    account_replication_type = "GRS"
  }
}
monitor_activity_log_alert = {
  mala1 = {
    name = "example-activitylogalert"
    resource_group = {
      key = "rg1"
    }
    scopes = {
      scope1 = {
        resource_type = "resource_groups"
        key           = "rg1"
      }
    }
    description = "This alert will monitor a specific storage account updates."

    criteria = {
      resource = {
        key           = "sa1"
        resource_type = "storage_accounts"
      }
      operation_name = "Microsoft.Storage/storageAccounts/write"
      category       = "Recommendation"
    }

    action = {
      action_group = {
        key = "mag1"
      }
      webhook_properties = {
        from = "terraform"
      }
    }
  }
}