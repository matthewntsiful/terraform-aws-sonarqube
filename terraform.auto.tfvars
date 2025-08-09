# Terraform Auto Variables - Documentation & Fallback Values
# 
# This file serves as:
# 1. Documentation of all available variables and their default values
# 2. Fallback values for any variables not explicitly set in HCP Terraform workspaces
# 3. Local development baseline for testing and validation
#
# Note: HCP Terraform workspace variables take precedence over these values
# Active configuration is managed in HCP Terraform workspaces (dev/staging/prod)

# Global Configuration
region = "us-east-1"

# VPC Configuration
vpc_cidr            = "10.0.0.0/16"
public_subnet_cidr  = "10.0.1.0/24"
private_subnet_cidr = "10.0.2.0/24"

# EC2 Configuration
instance_type     = "t3.medium"
key_name         = "terraform-test-kp"
root_volume_size = 30
root_volume_type = "gp3"

# Security Group Configuration
ssh_port         = 69
default_ssh_port = 22
http_port        = 80
sonar_port       = 9000
icmp_port        = -1
