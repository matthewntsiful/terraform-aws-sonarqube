variable "resource_name" {
  description = "Base name for all resources"
  type        = string
}

variable "instance_type" {
  description = "The type of EC2 instance to launch"
  type        = string
  default     = "t3.small"
}

variable "public_subnet_id" {
  description = "The VPC Subnet ID to launch in"
  type        = string
}

variable "security_group_id" {
  description = "The security group ID to associate with the instance"
  type        = string
}

variable "key_name" {
  description = "The key name to use for the instance"
  type        = string
}

variable "ssh_port" {
  description = "The port to use for SSH access"
  type        = number
  default     = 22
}

variable "iam_instance_profile" {
  description = "The IAM Instance Profile to launch the instance with"
  type        = string
  default     = ""
}

variable "root_volume_size" {
  description = "The size of the root volume in GB"
  type        = number
  default     = 30
}

variable "root_volume_type" {
  description = "The type of the root volume (e.g., gp2, gp3, io1)"
  type        = string
  default     = "gp3"
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}
