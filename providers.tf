# Terraform configuration block
terraform {
  # Specify the minimum required Terraform version
  required_version = ">= 1.0.0"

  # S3 backend configuration for remote state storage
  backend "s3" {
    bucket       = "terraform-projects-backend--6dptpbxe"
    key          = "sonarqube/terraform.tfstate"
    region       = "af-south-1"
    encrypt      = true
    use_lockfile = true
  }

  # Define required providers for the configuration
  required_providers {
    # AWS provider configuration
    aws = {
      source = "hashicorp/aws" # Source of the AWS provider
    }
  }
}

# AWS provider configuration block
provider "aws" {
  # Set the AWS region using a variable
  region = var.region

  # Define default tags for AWS resources
  default_tags {
    tags = local.common_tags # Common tags defined in locals
  }
}

