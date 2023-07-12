# Configure the prismacloud provider
terraform {
  required_providers {
    prismacloud = {
      source  = "PaloAltoNetworks/prismacloud"
      version = ">=1.4.1"
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
resource "prismacloud_policy" "bPolicy" {
  name        = "Ensure resources are only created in permitted locations"
  policy_type = "config"
  cloud_type  = "azure"
  severity    = "high"
  labels      = []
  description = ""
  recommendation = ""
  rule {
    name = "Ensure resources are only created in permitted locations"
    rule_type = "Config"
    parameters = {
      savedSearch = false
      withIac     = true
    }
    children {
      type           = "build"
      recommendation = "fix it"
      metadata = {
        "code" : file("policies/aks/aks001.yaml"),
      }
    }
  }
} 


# Configure a custom run policy from a local file

resource "prismacloud_policy" "rPolicy" {
  policy_type = "config"
  cloud_type  = "aws"
  name        = "sample custom run policy created with terraform"
  severity = "low"
  labels      = ["broccoli"]
  description = "this describes the policy"
  rule {
    name     = "sample custom run policy created with terraform"
    rule_type = "Config"
    parameters = {
      savedSearch = false
      withIac     = false
    }
    criteria = file("policies/aws/run_policy.rql")
  }
}