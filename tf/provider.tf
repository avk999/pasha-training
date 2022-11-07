terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.34.0"
    }
  }
}

provider "aws" {
  region  = "eu-west-2" 
  profile = "default"   

  ignore_tags {
    key_prefixes = ["kubernetes.io"]
  }
}

data "aws_region" "current" {}
data "aws_availability_zones" "all" {}

