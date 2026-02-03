terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}


# PROVIDER CONFIGURATION


# 1. The Primary Provider (Complex Setup) - N. Virginia
provider "aws" {
  region = "us-east-1"
}

# 2. The Secondary Provider (Simple Setup) - Ohio
# We use an alias to reference this specific region later
provider "aws" {
  alias  = "ohio"
  region = "us-east-2"
}