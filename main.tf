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
  cloud {
    organization = "Sushi-SV"
    workspaces {
      name = "terra-house-1"
    }
  }

}

provider "terratowns" {
  endpoint = var.terratowns_endpoint
  user_uuid = var.teacherseat_user_uuid
  token = var.terratowns_access_token
}

module "home_chop_hosting" {
  source = "./modules/terrahome_aws"
  user_uuid = var.teacherseat_user_uuid
  public_path = var.chop.public_path
  content_version = var.chop.content_version

}

resource "terratowns_home" "home" {
  name = "Tony Tony Chopper"
  description = <<DESCRIPTION
Tony Tony Chopper is a fictional character from the popular anime and manga series One Piece. 
He is a reindeer who can transform into different forms and serves as the doctor of the Straw Hat Pirates.
DESCRIPTION
  domain_name = module.home_chop_hosting.domain_name #Live server
  #domain_name = "8908903fdq3gz.cloudfront.net" # Use this one for testing
  town = "missingo" #Change this to other name server
  content_version = var.chop.content_version
}

#module "home_drstone_hosting" {
  #source = "./modules/terrahome_aws"
  #user_uuid = var.teacherseat_user_uuid
  #public_path = var.drstone.public_path
  #content_version = var.drstone.content_version
#
#}
#
#resource "terratowns_home" "home_drstone" {
  #name = "Dr. Stone"
  #description = <<DESCRIPTION
#The story follows a brilliant young scientist, Senku Ishigami, 
#who seeks to rebuild civilization and technology after humanity is petrified for thousands of years.
#DESCRIPTION
  #domain_name = module.home_drstone_hosting.domain_name
  ##domain_name = "8908903fdq3gz.cloudfront.net" # Use this one for testing
  #town = "missingo" #Change this to other name server
  #content_version = var.drstone.content_version
#}