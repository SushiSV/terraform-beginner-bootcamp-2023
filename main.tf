terraform {
  required_providers {
  terratowns = {
    source = "local.providers/local/terratowns"
    version = "1.0.0"
  }
}
  #backend "remote" {
  #  hostname = "app.terraform.io"
  #  organization = "Sushi-SV"

  #  workspaces {
  #    name = "terra-house-1"
  #  }
  #}
  #cloud {
  #  organization = "Sushi-SV"
  #  workspaces {
  #    name = "terra-house-1"
  #  }
  #}

}

provider "terratowns" {
  endpoint = var.terratowns_endpoint
  user_uuid = var.teacherseat_user_uuid
  token = var.terratowns_access_token
}
#provider "terratowns" {
  #endpoint = "https://terratowns.cloud/api"
  #user_uuid="1faac276-242e-445c-b6ac-5d907f643666" 
  #token="f6111721-7146-451a-8592-85480a947ef0"
#}

module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
  user_uuid = var.teacherseat_user_uuid
  index_html_filepath = var.index_html_filepath
  error_html_filepath = var.error_html_filepath
  content_version = var.content_version
  assets_path = var.assets_path
}

resource "terratowns_home" "home" {
  name = "Name/Title goes here"
  description = <<DESCRIPTION
Brief description of your own idea
DESCRIPTION
  domain_name = module.terrahouse_aws.cloudfront_url
  #domain_name = "8908903fdq3gz.cloudfront.net" # Use this one for testing
  town = "missingo" #Change this to other name server
  content_version = 1
}