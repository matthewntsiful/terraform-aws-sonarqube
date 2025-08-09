# 🚀 GitHub Actions + HCP Terraform Integration Setup

This guide helps you set up GitHub Actions to work alongside your existing HCP Terraform VCS integration.

## 🎯 What This Adds to Your VCS Integration

Your current setup:
```
Git Push → HCP Terraform → AWS Deployment
```

Enhanced setup:
```
Git Push → GitHub Actions (Quality Checks) → HCP Terraform → AWS Deployment
           ↓
    • Code formatting
    • Security scanning  
    • Cost estimation
    • Notifications
    • Health checks
```

## 🔧 Required GitHub Secrets

Go to your GitHub repository → Settings → Secrets and variables → Actions

### Required Secrets:
```bash
# HCP Terraform Integration
TF_API_TOKEN=your_hcp_terraform_token

# Optional: Cost Estimation
INFRACOST_API_KEY=your_infracost_api_key

# Optional: Slack Notifications  
SLACK_WEBHOOK_URL=your_slack_webhook_url
```

### How to Get These Tokens:

#### 1. HCP Terraform API Token
```bash
# Go to: https://app.terraform.io/app/settings/tokens
# Create a new API token
# Copy and add as TF_API_TOKEN secret
```

#### 2. Infracost API Key (Optional)
```bash
# Go to: https://www.infracost.io/
# Sign up for free account
# Get API key from dashboard
# Copy and add as INFRACOST_API_KEY secret
```

#### 3. Slack Webhook (Optional)
```bash
# Go to your Slack workspace
# Create a new app: https://api.slack.com/apps
# Add Incoming Webhooks feature
# Copy webhook URL and add as SLACK_WEBHOOK_URL secret
```

## 🔄 How It Works

### 1. On Pull Request:
```yaml
# GitHub Actions runs:
✅ Code formatting check
✅ Terraform validation
✅ Security scanning with Checkov
✅ Cost estimation with Infracost
✅ Comments results on PR

# HCP Terraform:
📋 Shows speculative plan (no deployment)
```

### 2. On Push to Branch:
```yaml
# GitHub Actions runs:
✅ All quality checks
✅ Monitors HCP deployment
✅ Sends notifications
✅ Runs health checks

# HCP Terraform:
🚀 Automatically deploys to target environment
```

## 📊 Workflow Breakdown

### Quality Checks Job:
- **Terraform fmt**: Ensures consistent formatting
- **Terraform validate**: Checks configuration syntax
- **TFLint**: Advanced Terraform linting
- **Checkov**: Security and compliance scanning
- **Infracost**: Cost impact analysis

### Deployment Monitor Job:
- **Waits for HCP deployment**: Monitors your VCS-driven deployment
- **Sends notifications**: Slack/Teams/Discord alerts
- **Provides links**: Direct links to HCP Terraform workspace

### Post-Deployment Job:
- **Health checks**: Verifies deployment success
- **Documentation updates**: Keeps deployment history
- **Success notifications**: Confirms everything worked

## 🎛️ Customization Options

### Disable Specific Checks:
```yaml
# In .github/workflows/terraform-quality.yml
# Comment out steps you don't want:

# - name: Run Checkov Security Scan
#   if: false  # Disables this step
```

### Environment-Specific Behavior:
```yaml
# Different checks for different environments
- name: Strict Security Check
  if: github.ref_name == 'main'  # Only for production
  
- name: Performance Test
  if: github.ref_name == 'staging'  # Only for staging
```

### Custom Notifications:
```yaml
# Add your own notification services
- name: Teams Notification
  uses: skitionek/notify-microsoft-teams@master
  with:
    webhook_url: ${{ secrets.TEAMS_WEBHOOK }}
```

## 🚦 Branch-Specific Workflows

### Development (`dev` branch):
- ✅ Basic quality checks
- ✅ Fast feedback
- ✅ Minimal notifications

### Staging (`staging` branch):
- ✅ Full quality checks
- ✅ Security scanning
- ✅ Cost estimation
- ✅ Health checks after deployment

### Production (`main` branch):
- ✅ Strictest quality checks
- ✅ Required approvals (if configured)
- ✅ Full security scan
- ✅ Cost analysis
- ✅ Comprehensive health checks
- ✅ Documentation updates

## 🔍 Monitoring Your Pipeline

### GitHub Actions:
- Go to your repository → Actions tab
- View workflow runs and logs
- See quality check results

### HCP Terraform:
- Go to https://app.terraform.io/app/Matthew-Ntsiful/workspaces
- Monitor actual infrastructure deployments
- View terraform plans and applies

## 🎯 Best Practices

### 1. Start Simple:
```yaml
# Enable basic checks first
- Terraform fmt
- Terraform validate
- Basic notifications
```

### 2. Add Gradually:
```yaml
# Then add advanced features
- Security scanning
- Cost estimation  
- Health checks
```

### 3. Environment-Specific:
```yaml
# Different rules for different environments
- Relaxed for dev
- Strict for staging
- Strictest for production
```

## 🚨 Important Notes

### Your VCS Integration Still Works:
- HCP Terraform will still auto-deploy on push
- GitHub Actions runs in parallel
- No interference between the two systems

### Quality Gates:
- GitHub Actions can fail without stopping HCP deployment
- Use branch protection rules to require passing checks
- Consider making security scans required

### Cost Considerations:
- GitHub Actions has free tier limits
- Monitor usage in repository settings
- Optimize workflows to reduce run time

---

**🎉 Result: You get the reliability of HCP Terraform VCS integration PLUS the power of GitHub Actions for quality, security, and notifications!**
