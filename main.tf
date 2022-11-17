# Configure the prismacloud provider
terraform {
  required_providers {
    prismacloud = {
      source  = "PaloAltoNetworks/prismacloud"
      version = ">=1.2.9"
    }
  }
}
provider "prismacloud" {
  json_config_file = ".prismacloud_auth.json"
}

### Make sure to update the authentication file  .prismacloud_auth.json
# {
#     "url" : "<PRISMA_CLOUD_API_URL",
#     "username" : "<PRISMA_CLOUD_ACCESS_KEY>",
#     "password" : "<PRISMA_CLOUD_ACCESS_SECRET>"
# }


#### Prisma Cloud Custom Policies ####################################

# Configure a custom build policy from a local file
resource "prismacloud_policy" "build_policy_001" {
  name        = "build_policy_001: custom build policy #1 created with terraform"
  policy_type = "config"
  cloud_type  = "azure"
  severity    = "high"
  labels      = ["rannaladasu"]
  description = "this describes the policy"
  enabled     = false
  rule {
    name      = "build_policy_001: custom build policy #1 created with terraform"
    rule_type = "Config"
    parameters = {
      savedSearch = false
      withIac     = true
    }
    children {
      type           = "build"
      recommendation = "fix it"
      metadata = {
        "code" : file("policies/aks/aks001.yaml")
      }
    }
  }
}