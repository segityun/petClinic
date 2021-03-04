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
