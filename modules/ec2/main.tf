data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "web_server" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  subnet_id                   = var.public_subnet_id
  vpc_security_group_ids      = [var.security_group_id]
  associate_public_ip_address = true
  key_name                    = var.key_name
  iam_instance_profile        = var.iam_instance_profile

  root_block_device {
    volume_size = var.root_volume_size
    volume_type = var.root_volume_type
  }

  user_data = templatefile("${path.module}/user_data.sh", {
    ssh_port = var.ssh_port
  })

  tags = merge(
    var.tags,
    {
      Name = "${var.resource_name}-web-server"
    }
  )

  lifecycle {
    ignore_changes = [
      # Ignore changes to tags, e.g. because a management agent
      # updates these based on some ruleset managed elsewhere.
      tags,
    ]
  }
}

##