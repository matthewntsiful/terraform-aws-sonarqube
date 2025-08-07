/**
 * Outputs for the SonarQube AWS deployment.
 * These outputs expose important information about the deployed infrastructure.
 */

# ==================== COMPUTE OUTPUTS ====================
output "instance_id" {
  description = "The unique identifier of the EC2 instance running SonarQube"
  value       = module.ec2.instance_id
  sensitive   = false
}

output "instance_public_ip" {
  description = "The public IPv4 address of the EC2 instance"
  value       = module.ec2.public_ip
  sensitive   = true  # Marked as sensitive to avoid accidental exposure in logs
}

output "instance_private_ip" {
  description = "The private IPv4 address of the EC2 instance within the VPC"
  value       = module.ec2.private_ip
  sensitive   = true
}

output "instance_public_dns" {
  description = "The public DNS name of the EC2 instance"
  value       = module.ec2.public_dns
}

# ==================== NETWORKING OUTPUTS =================
output "vpc_id" {
  description = "The ID of the VPC where SonarQube is deployed"
  value       = module.vpc.vpc_id
}

output "public_subnet_id" {
  description = "The ID of the public subnet where the EC2 instance is deployed"
  value       = module.vpc.public_subnet_id
}

output "private_subnet_id" {
  description = "The ID of the private subnet (available for future use)"
  value       = module.vpc.private_subnet_id
}

output "security_group_id" {
  description = "The ID of the security group attached to the EC2 instance"
  value       = module.security_group.security_group_id
}

# ==================== ACCESS OUTPUTS =====================
output "ssh_connection_command" {
  description = <<-EOT
    SSH command to securely connect to the EC2 instance.
    Make sure your SSH key has the correct permissions (chmod 400 key.pem).
  EOT
  value       = module.ec2.ssh_command
  sensitive   = true
}

output "sonarqube_url" {
  description = "The URL to access the SonarQube web interface"
  value       = "http://${module.ec2.public_ip}:9000"
}

output "sonarqube_admin_password_command" {
  description = "Command to retrieve the default admin password after first login"
  value       = "ssh -i ${var.key_name}.pem -p ${var.ssh_port} ubuntu@${module.ec2.public_ip} 'sudo docker exec sonarqube cat /opt/sonarqube/data/admin_password.txt'"
  sensitive   = true
}

# ==================== MONITORING & DEBUGGING =============
output "cloudwatch_logs_url" {
  description = "Direct link to CloudWatch logs for the EC2 instance"
  value       = "https://${var.region}.console.aws.amazon.com/cloudwatch/home?region=${var.region}#logsV2:log-groups/log-group/$252Faws$252Fec2$252F${module.ec2.instance_id}"
}

output "debug_commands" {
  description = "Useful commands for troubleshooting and maintenance"
  value = {
    check_user_data_log = "ssh -i ${var.key_name}.pem -p ${var.ssh_port} ubuntu@${module.ec2.public_ip} 'sudo tail -f /var/log/cloud-init-output.log'"
    check_docker_status = "ssh -i ${var.key_name}.pem -p ${var.ssh_port} ubuntu@${module.ec2.public_ip} 'sudo docker ps -a'"
    check_sonarqube_status = "ssh -i ${var.key_name}.pem -p ${var.ssh_port} ubuntu@${module.ec2.public_ip} 'sudo docker logs sonarqube'"
    check_system_metrics = "ssh -i ${var.key_name}.pem -p ${var.ssh_port} ubuntu@${module.ec2.public_ip} 'top -b -n 1 | head -n 10'"
    check_disk_usage = "ssh -i ${var.key_name}.pem -p ${var.ssh_port} ubuntu@${module.ec2.public_ip} 'df -h'"
  }
  sensitive = true
}

# ==================== INFRASTRUCTURE DETAILS =============
output "resource_tags" {
  description = "The common tags applied to all resources"
  value = {
    Environment = terraform.workspace
    Project     = "SonarQube"
    ManagedBy   = "Terraform"
    Owner       = "Matthew Ntsiful"
    CostCenter  = "Engineering"
    Application = "SonarQube"
  }
}

output "deployment_timestamp" {
  description = "The timestamp when the infrastructure was last deployed"
  value       = timestamp()
}

# ==================== SECURITY NOTES =====================
output "security_notes" {
  description = "Important security considerations for the SonarQube deployment"
  value = {
    ssh_port = "EC2 instance is accessible via SSH on custom port ${var.ssh_port}"
    sonarqube_port = "SonarQube web interface is available on port 9000"
    ip_whitelist = "Ensure your IP is whitelisted in the security group for access"
    admin_password = "Change the default admin password on first login"
    https_setup = "Consider setting up HTTPS for secure access to SonarQube"
  }
}