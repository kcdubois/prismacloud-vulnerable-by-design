resource "random_string" "this" {
  length  = 12
  special = false
  upper   = false
}

variable "name" {
  type        = string
  description = "Prefix used for resource creation"
  default     = "pcs"
}

variable "location" {
  type    = string
  default = "ca-central-1"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.67.0"
    }

    random = {
      source = "hashicorp/random"
    }
  }
}

provider "aws" {
  # Configuration options
}
