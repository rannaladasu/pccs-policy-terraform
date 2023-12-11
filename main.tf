# Configure the prismacloud provider
terraform {
  required_providers {
    prismacloud = {
      source  = "PaloAltoNetworks/prismacloud"
      version = ">=1.4.7"
    }
  }
}

variable PRISMACLOUD_USERNAME {}
variable PRISMACLOUD_PASSWORD {}
variable PRISMACLOUD_URL {}

provider "prismacloud" {
   url = "${var.PRISMACLOUD_URL}"
    username = "${var.PRISMACLOUD_USERNAME}"
    password = "${var.PRISMACLOUD_PASSWORD}"
}

### Make sure to update the authentication file  .prismacloud_auth.json
# {
#     "url" : "<PRISMA_CLOUD_API_URL",
#     "username" : "<PRISMA_CLOUD_ACCESS_KEY>",
#     "password" : "<PRISMA_CLOUD_ACCESS_SECRET>"
# }


#### Prisma Cloud Custom Policies ####################################

# Configure a custom build policy from a local file
# resource "prismacloud_policy" "bPolicy" {
#   name        = "Ensure resources are only created in permitted locations"
#   policy_type = "config"
#   cloud_type  = "azure"
#   severity    = "high"
#   labels      = []
#   description = ""
#   recommendation = ""
#   rule {
#     name = "Ensure resources are only created in permitted locations"
#     rule_type = "Config"
#     parameters = {
#       savedSearch = false
#       withIac     = true
#     }
#     children {
#       type           = "build"
#       recommendation = "fix it"
#       metadata = {
#         "code" : file("policies/aks/aks001.yaml"),
#       }
#     }
#   }
# } 

# # Configure a custom run policy from a local file

# resource "prismacloud_policy" "rPolicy" {
#   policy_type = "config"
#   cloud_type  = "aws"
#   name        = "custom - sample run policy created with terraform"
#   severity = "low"
#   labels      = ["broccoli"]
#   description = "this describes the policy"
#   recommendation = "Follow recommendation steps"
#   rule {
#     name     = "custom - sample run policy created with terraform"
#     rule_type = "Config"
  
#     parameters = {
#       savedSearch = false
#       withIac     = false
#     }
#     criteria = file("policies/aws/run_policy.rql")
#   }



#   remediation {
#    cli_script_template = "aws iam update-account-password-policy --minimum-password-length 14 --require-uppercase-characters --require-lowercase-characters --require-numbers --require-symbols --allow-users-to-change-password --password-reuse-prevention 24 --max-password-age 90"
#    description = "This CLI command requires 'iam:UpdateAccountPasswordPolicy' permission. Successful execution will update the password policy to set the minimum password length to 14, require lowercase, uppercase, symbol, allow users to reset password, cannot reuse the last 24 passwords and password expiration to 90 days."
#   }
  
# }


# # Configure a custom run and build policy from a local file
resource "prismacloud_policy" "brPolicy" {
  name        = "custom - sample run & build policy with remediation created with terraform"
  policy_type = "config"
  cloud_type  = "aws"
  severity    = "high"
  labels      = []
  description = ""
  rule {
    name = "custom - sample run & build policy with remediation created with terraform"
    rule_type = "Config"
    parameters = {
      savedSearch = false
      withIac     = true
    }
    criteria = file("policies/aws/run_policy.rql")
    children {
      type           = "build"
      recommendation = "fix it"
      metadata = {
        "code" : file("policies/aks/aks002.yaml"),
      }
    }
  }

   remediation {
   cli_script_template = "aws iam update-account-password-policy --minimum-password-length 14 --require-uppercase-characters --require-lowercase-characters --require-numbers --require-symbols --allow-users-to-change-password --password-reuse-prevention 24 --max-password-age 90"
   description = "This CLI command requires 'iam:UpdateAccountPasswordPolicy' permission. Successful execution will update the password policy to set the minimum password length to 14, require lowercase, uppercase, symbol, allow users to reset password, cannot reuse the last 24 passwords and password expiration to 90 days."
  }
} 




# resource "prismacloud_policy" "EIP-CSE-IACOHP-AzureStorage-DisablePublicAccess-TFE" {
#   name        = "EIP-CSE-IACOHP-AzureStorage-DisablePublicAccess-TFESS"
#   policy_type = "config"
#   cloud_type  = "azure"
#   severity    = "high"
#   description = ""
#   recommendation = "Please make sure to have all networks disabled"

#   rule {
#     name = "EIP-CSE-IACOHP-AzureStorage-DisablePublicAccess-TFESS"
#     rule_type = "Config"

#     parameters = {
#       savedSearch = false
#       withIac     = true
#     }
#     criteria = file("policies/aws/run_policy.rql")
#     children {
#       type = "build"
#       recommendation = "fix it"
#       metadata = {
#         "code" : file("policies/aks/aks004.yaml"),
#       }
#     }
#   }
#   remediation {
#   cli_script_template = "az storage account update --name $${resourceName} --resource-group $${resourceGroup} --allow-blob-public-access false"
#    description = "This CLI command requires resource group and resource name for remediation"
#   }
# }



