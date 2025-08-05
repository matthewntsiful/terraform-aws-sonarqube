# locals.tf
# This file contains local variables used throughout the Terraform configuration.
# The locals block is used to define variables that are used in multiple places
# in the configuration.

locals {
  # The name prefix for all resources
  name_prefix = "sonarqube"

  # The resource name is composed of the name prefix and the environment
  resource_name = format("%s-%s", local.name_prefix, var.environment)

  # Common tags to be applied to all resources
  common_tags = {
    # The environment (e.g. dev, staging, prod)
    Environment = var.environment

    # The project name
    Project = "SonarQube"

    # The tool that manages the infrastructure
    ManagedBy = "Terraform"
  }
}

