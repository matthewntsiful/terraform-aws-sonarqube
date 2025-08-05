resource "aws_security_group" "web_server" {
  name        = "${var.resource_name}-web-sg"
  description = "Security group for web server"
  vpc_id      = var.vpc_id

  # SSH access
  ingress {
    from_port   = var.default_ssh_port
    to_port     = var.default_ssh_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "SSH access"
  }

  # Custom SSH port
  ingress {
    from_port   = var.ssh_port
    to_port     = var.ssh_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Custom SSH port access"
  }

  # HTTP access
  ingress {
    from_port   = var.http_port
    to_port     = var.http_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTP access"
  }

  # SonarQube access
  ingress {
    from_port   = var.sonar_port
    to_port     = var.sonar_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "SonarQube web interface"
  }

  # ICMP (ping)
  ingress {
    from_port   = var.icmp_port
    to_port     = var.icmp_port
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "ICMP (ping)"
  }

  # Outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Outbound internet access"
  }

  tags = merge(
    var.tags,
    {
      Name = "${var.resource_name}-web-sg"
    }
  )
}
