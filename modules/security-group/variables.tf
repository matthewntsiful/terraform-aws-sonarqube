variable "resource_name" {
  description = "Base name for all resources"
  type        = string
}

variable "vpc_id" {
  description = "The VPC ID where the security group will be created"
  type        = string
}

variable "ssh_port" {
  description = "Port number for SSH access"
  type        = number
  default     = 22
}

variable "default_ssh_port" {
  description = "Default SSH port (22)"
  type        = number
  default     = 22
}

variable "http_port" {
  description = "Port number for HTTP access"
  type        = number
  default     = 80
}

variable "sonar_port" {
  description = "Port number for SonarQube web interface"
  type        = number
  default     = 9000
}

variable "icmp_port" {
  description = "Port number for ICMP (ping)"
  type        = number
  default     = -1
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}
