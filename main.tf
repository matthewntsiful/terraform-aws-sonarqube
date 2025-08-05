# VPC Module
module "vpc" {
  source = "./modules/vpc"

  resource_name       = local.resource_name
  vpc_cidr            = var.vpc_cidr
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
  tags                = local.common_tags
}

# Security Group Module
module "security_group" {
  source = "./modules/security-group"

  resource_name    = local.resource_name
  vpc_id           = module.vpc.vpc_id
  ssh_port         = var.ssh_port
  default_ssh_port = var.default_ssh_port
  http_port        = var.http_port
  sonar_port       = var.sonar_port
  icmp_port        = var.icmp_port
  tags             = local.common_tags
}

# IAM Role for EC2
resource "aws_iam_role" "ec2_role" {
  name = "${local.resource_name}-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = merge(local.common_tags, {
    Name = "${local.resource_name}-ec2-role"
  })
}

resource "aws_iam_role_policy_attachment" "ec2_ssm" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "${local.resource_name}-ec2-profile"
  role = aws_iam_role.ec2_role.name
}

# EC2 Instance Module
module "ec2" {
  source = "./modules/ec2"

  resource_name        = local.resource_name
  instance_type        = var.instance_type
  public_subnet_id     = module.vpc.public_subnet_id
  security_group_id    = module.security_group.security_group_id
  key_name             = var.key_name
  ssh_port             = var.ssh_port
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name
  root_volume_size     = var.root_volume_size
  root_volume_type     = var.root_volume_type
  tags                 = local.common_tags
}

