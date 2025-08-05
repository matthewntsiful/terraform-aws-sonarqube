# Global Variables
# =================

variable "environment" {
  description = <<-EOF
    Environment name (e.g., dev, staging, prod). This variable is used to
    create a unique name for all resources.
  EOF
  type        = string
  default     = "dev"
}

variable "region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

# VPC Variables
# =============

variable "vpc_cidr" {
  description = <<-EOF
    CIDR block for the VPC. The VPC will be created with this CIDR block.
  EOF
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = <<-EOF
    CIDR block for the public subnet. The public subnet will be created with
    this CIDR block.
  EOF
  type        = string
  default     = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  description = <<-EOF
    CIDR block for the private subnet. The private subnet will be created with
    this CIDR block.
  EOF
  type        = string
  default     = "10.0.2.0/24"
}

# EC2 Variables
# =============

variable "instance_type" {
  description = "EC2 instance type. This variable is used to determine the type of instance to launch."
  type        = string
  default     = "t3.medium"
}
variable "key_name" {
  description = "Name of the SSH key pair to use for the EC2 instance. This variable is used to specify the key pair to use when launching the instance."
  type        = string
  default     = "terraform-test-kp"
}

variable "root_volume_size" {
  description = "Size of the root volume in GB. This variable is used to determine the size of the root volume."
  type        = number
  default     = 30
}
variable "root_volume_type" {
  description = "Type of the root volume (e.g., gp2, gp3, io1). This variable is used to determine the type of the root volume."
  type        = string
  default     = "gp3"
}

# Security Group Variables
# ======================
variable "ssh_port" {
  description = "Port for SSH access. This variable is used to determine the port to open for SSH access."
  type        = number
  default     = 69
}
variable "default_ssh_port" {
  description = "Default SSH port (22). This variable is used to determine the default port to open for SSH access."
  type        = number
  default     = 22
}

variable "http_port" {
  description = "Port for HTTP access. This variable is used to determine the port to open for HTTP access."
  type        = number
  default     = 80
}

variable "sonar_port" {
  description = "Port for SonarQube web interface. This variable is used to determine the port to open for SonarQube access."
  type        = number
  default     = 9000
}
variable "icmp_port" {
  description = "Port for ICMP (ping). This variable is used to determine the port to open for ICMP access."
  type        = number
  default     = -1
}

