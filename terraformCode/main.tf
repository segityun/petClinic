#Setting up the environment
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }
}
# Configure the AWS Provider
provider "aws" {
  region = "us-east-2"
  profile = "default"
}
module "vpc" {
  source = "./vpcMod"
}
module "sec_group" {
  source = "./secGrp"
  vpc_id = module.vpc.vpc_id
}
module "gateways" {
  source = "./gwMod"
  vpc_id = module.vpc.vpc_id
  segment_private = module.vpc.segment_private
  segment_public = module.vpc.segment_public
}
module "Nginx_instances" {
  source = "./nginxSrv"
  security_group_id = module.sec_group.security_group_secGrpNginx
  segment_public = module.vpc.segment_public
  file = "./nginxSrv/nginx.sh"
}
module "load_balancers" {
  source = "./elbMod"
  security_group_secGrpNginx = module.sec_group.security_group_secGrpNginx
  security_group_secGrpApp = module.sec_group.security_group_secGrpApp
  segment_public = module.vpc.segment_public
  segment_private = module.vpc.segment_private
  vpc_id = module.vpc.vpc_id
  nginx_instance_id1 = module.Nginx_instances.nginxPetOne
  nginx_instance_id2 = module.Nginx_instances.nginxPetTwo
  app_instance_id1 = module.app_instances.appPetOne
  app_instance_id2 = module.app_instances.appPetTwo
}
module "app_instances" {
  source = "./appSrv"
  security_group_id = module.sec_group.security_group_secGrpApp
  segment_private = module.vpc.segment_private
  file = "./appSrv/app.sh"
}