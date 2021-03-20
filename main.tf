############################################################
# ADD THIRD PARTY PROVIDERS
############################################################
terraform {
  required_providers {
    intersight = {
      source = "CiscoDevNet/intersight"
      version = "1.0.0"
    }
  }
}


############################################################
# GET ORGANIZATION MOID
############################################################
data "intersight_organization_organization" "organization" {
  name = var.org
}

