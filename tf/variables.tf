# ----------------------------------------------
# Main
# ----------------------------------------------

# variable "cluster_id" {
#   type        = string
#   description = "Unique cluster ID"
#   default="study-cluster"
# }

# ----------------------------------------------
# Networking
# ----------------------------------------------

variable "region" {
  type        = string
  description = "AWS region in which to deploy cluster"
  default = "eu-west-1"
}

/* variable "vpc_id" {
  type        = string
  description = "VPC ID where subnets will be created (e.g. `vpc-aceb2723`)"
}
 */
# variable "availability_zones" {
#   type        = list(string)
#   description = "List of Availability Zones where subnets will be created"
# }

variable "subnet_cidr" {
  type        = string
  default =  "192.168.1.0/24"
  description = "subnet CIDR"
}

variable "tag_prefix" {

  default="k8s_training"
}

variable tag_project {
  default="k8s_training"
}



variable "vpc_cidr" {

  description = "CIDR for VPC creation"
  type = string
  default = "192.168.0.0/16"
}

# ----------------------------------------------
# Node Instances
# ----------------------------------------------


variable "instance_type" {
  description = "Instance type id"
  default     = "t3.micro"
}


variable "key_name" {
  description = "ssh key pair name"
  default = "aws-london"
}

variable "master_vol" {
  description = "master disk size"
  default = 10
}


