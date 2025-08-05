output "instance_id" {
  description = "The ID of the EC2 instance"
  value       = aws_instance.web_server.id
}

output "public_ip" {
  description = "The public IP of the instance"
  value       = aws_instance.web_server.public_ip
}

output "private_ip" {
  description = "The private IP of the instance"
  value       = aws_instance.web_server.private_ip
}

output "public_dns" {
  description = "The public DNS of the instance"
  value       = aws_instance.web_server.public_dns
}

output "private_dns" {
  description = "The private DNS of the instance"
  value       = aws_instance.web_server.private_dns
}

output "ssh_command" {
  description = "The SSH command to connect to the instance"
  value       = "ssh -i ${var.key_name}.pem ubuntu@${aws_instance.web_server.public_ip} -p ${var.ssh_port}"
}

output "sonarqube_url" {
  description = "The URL to access SonarQube"
  value       = "http://${aws_instance.web_server.public_ip}:9000"
}
