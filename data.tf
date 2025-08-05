# Fetch the most recent Ubuntu AMI for Ubuntu Jammy 22.04
data "aws_ami" "ubuntu" {
  most_recent = true

  # Filter for AMI name pattern
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  # Filter for HVM virtualization type
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  # Owner ID for Canonical
  owners = ["099720109477"]
}

# Retrieve a list of all available AWS availability zones
data "aws_availability_zones" "available" {
  state = "available"
}

