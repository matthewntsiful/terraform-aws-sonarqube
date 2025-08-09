# HCP Terraform Workspace Variables Setup Guide

## Overview
This guide helps you set up variables for all three workspaces in your HCP Terraform organization.

**Organization**: `Matthew-Ntsiful`
**Project**: `Terraform-Aws-Sonarqube`
**Workspaces**: `dev`, `staging`, `prod`

## Step-by-Step Setup

### 1. Access HCP Terraform
Navigate to: https://app.terraform.io/app/Matthew-Ntsiful/workspaces

### 2. Set Up Each Workspace

For each workspace (dev, staging, prod), follow these steps:

#### A. Environment Variables (Same for All Workspaces)
1. Click on workspace name
2. Go to **Variables** tab
3. Click **Add variable**
4. Select **Environment variable**
5. Add these variables:

```
Variable Name: AWS_ACCESS_KEY_ID
Value: [your-aws-access-key-id]
☑️ Sensitive: YES
Description: AWS Access Key ID for authentication

Variable Name: AWS_SECRET_ACCESS_KEY  
Value: [your-aws-secret-access-key]
☑️ Sensitive: YES
Description: AWS Secret Access Key for authentication

Variable Name: AWS_DEFAULT_REGION
Value: us-east-1
☑️ Sensitive: NO
Description: Default AWS region for resources
```

#### B. Terraform Variables (Workspace-Specific)

**For DEV Workspace:**
```
environment = "dev"
region = "us-east-1"
instance_type = "t3.small"
root_volume_size = 20
root_volume_type = "gp3"
vpc_cidr = "10.0.0.0/16"
public_subnet_cidr = "10.0.1.0/24"
private_subnet_cidr = "10.0.2.0/24"
ssh_port = 69
default_ssh_port = 22
http_port = 80
sonar_port = 9000
icmp_port = -1
key_name = "terraform-test-kp"
```

**For STAGING Workspace:**
```
environment = "staging"
region = "us-east-1"
instance_type = "t3.medium"
root_volume_size = 30
root_volume_type = "gp3"
vpc_cidr = "10.1.0.0/16"
public_subnet_cidr = "10.1.1.0/24"
private_subnet_cidr = "10.1.2.0/24"
ssh_port = 69
default_ssh_port = 22
http_port = 80
sonar_port = 9000
icmp_port = -1
key_name = "terraform-test-kp"
```

**For PROD Workspace:**
```
environment = "prod"
region = "us-east-1"
instance_type = "t3.large"
root_volume_size = 50
root_volume_type = "gp3"
vpc_cidr = "10.2.0.0/16"
public_subnet_cidr = "10.2.1.0/24"
private_subnet_cidr = "10.2.2.0/24"
ssh_port = 69
default_ssh_port = 22
http_port = 80
sonar_port = 9000
icmp_port = -1
key_name = "terraform-test-kp"
```

### 3. Variable Sets (Optional - Recommended)

Create variable sets for easier management:

#### A. Create AWS Credentials Variable Set
1. Go to Organization Settings → Variable Sets
2. Click **Create variable set**
3. Name: "AWS-Credentials-SonarQube"
4. Add environment variables:
   - AWS_ACCESS_KEY_ID (sensitive)
   - AWS_SECRET_ACCESS_KEY (sensitive)
   - AWS_DEFAULT_REGION
5. Apply to workspaces: Select all SonarQube workspaces

#### B. Create Environment-Specific Variable Sets
Create separate variable sets for each environment with their Terraform variables.

### 4. Workspace Settings Configuration

For each workspace, configure:

#### Auto-Apply Settings:
- **DEV**: ☑️ Auto apply (for fast feedback)
- **STAGING**: ☐ Manual apply (for review)
- **PROD**: ☐ Manual apply (for safety)

#### VCS Settings:
- **DEV**: Branch = `dev`, Auto-apply = Yes
- **STAGING**: Branch = `staging`, Auto-apply = No
- **PROD**: Branch = `main`, Auto-apply = No

### 5. Verification Steps

After setting up variables:

1. **Queue a Plan** in each workspace
2. **Check outputs** for correct resource naming
3. **Verify CIDR blocks** don't overlap between environments
4. **Test SSH access** with custom port (69)
5. **Confirm SonarQube URLs** are accessible

### 6. Security Checklist

- ☑️ AWS credentials marked as sensitive
- ☑️ Different VPC CIDRs per environment
- ☑️ Custom SSH port configured
- ☑️ Least privilege AWS IAM permissions
- ☑️ Manual approval for staging/prod

## Troubleshooting

### Common Issues:
1. **CIDR Conflicts**: Ensure different VPC CIDRs per environment
2. **AWS Permissions**: Verify IAM user has required permissions
3. **SSH Key**: Ensure key pair exists in target region
4. **Variable Precedence**: HCP variables override local files

### Debug Commands:
```bash
terraform workspace list
terraform workspace select <env>
terraform validate
terraform plan
```

## Cost Optimization

**Estimated Monthly Costs:**
- **DEV**: ~$15-25 (t3.small)
- **STAGING**: ~$30-45 (t3.medium)  
- **PROD**: ~$60-90 (t3.large)

**Cost Controls:**
- Use smaller instances for dev/staging
- Schedule shutdown for non-prod environments
- Monitor with AWS Cost Explorer
- Set up billing alerts
