# 🚀 Deployment Guide - VCS-Driven HCP Terraform

This project uses **HCP Terraform VCS integration** for automated deployments. Any push to a branch automatically triggers deployment to its corresponding environment.

## 🌿 Branch → Environment Mapping

| Branch | Environment | HCP Workspace | Region | Key Pair | Auto-Deploy |
|--------|-------------|---------------|--------|----------|-------------|
| `dev` | Development | `dev` | `us-east-1` | `terraform-sonarqube-dev-kp` | ✅ Enabled |
| `staging` | Staging | `staging` | `us-east-2` | `terraform-sonarqube-staging-kp` | ✅ Enabled |
| `main` | Production | `prod` | `us-west-2` | `terraform-sonarqube-prod-kp` | ✅ Enabled |

## 🔄 Deployment Workflow

### 1. Development Changes
```bash
# Work on development environment
git checkout dev
# Make your changes
git add .
git commit -m "feat: add new security group rule"
git push origin dev
# 🚀 Automatically deploys to dev environment
```

### 2. Staging Deployment
```bash
# Promote changes to staging
git checkout staging
git merge dev
git push origin staging
# 🚀 Automatically deploys to staging environment
```

### 3. Production Deployment
```bash
# Promote to production (after staging validation)
git checkout main
git merge staging
git push origin main
# 🚀 Automatically deploys to production environment
```

## 📊 Monitoring Deployments

### HCP Terraform UI
- **Organization**: `Matthew-Ntsiful`
- **Project**: `Terraform-Aws-Sonarqube`
- **URL**: https://app.terraform.io/app/Matthew-Ntsiful/workspaces

### Real-time Monitoring
1. Go to HCP Terraform dashboard
2. Select the workspace (dev/staging/prod)
3. View current run status and logs
4. Monitor resource changes and outputs

## 🛡️ Safety Features

### Automatic Safeguards
- **Plan Review**: Every push shows plan before apply
- **State Locking**: Prevents concurrent modifications
- **Workspace Isolation**: Complete separation between environments
- **Rollback Capability**: Previous state versions available

### Manual Overrides
If you need to pause auto-deployment:
1. Go to HCP Terraform workspace
2. Settings → General Settings
3. Disable "Auto Apply"
4. Manually review and apply plans

## 🔧 Quick Commands

### Check Current Status
```bash
# View current branch and workspace mapping
git branch --show-current
terraform workspace show
```

### Emergency Rollback
```bash
# If you need to quickly revert changes
git checkout <branch>
git revert <commit-hash>
git push origin <branch>
# This will trigger automatic deployment of the reverted state
```

### View Deployment History
```bash
# See recent commits that triggered deployments
git log --oneline -10
```

## 🚨 Important Notes

### Before Pushing to Production
- ✅ Test thoroughly in `dev` environment
- ✅ Validate in `staging` environment
- ✅ Review HCP Terraform plan output
- ✅ Ensure no breaking changes
- ✅ Check resource costs and limits

### Environment-Specific Considerations
- **Dev**: Fast iteration, cost-optimized instances
- **Staging**: Production-like setup for final testing
- **Prod**: High availability, enhanced security, monitoring

## 🔍 Troubleshooting

### Deployment Failed
1. Check HCP Terraform workspace logs
2. Review Terraform plan for errors
3. Verify AWS credentials and permissions
4. Check variable configurations

### State Issues
1. Go to HCP Terraform workspace
2. States tab → View state versions
3. Compare with previous working state
4. Contact team if manual intervention needed

## 📈 Best Practices

### Commit Messages
Use conventional commits for better tracking:
```bash
git commit -m "feat: add CloudWatch monitoring"
git commit -m "fix: security group port configuration"
git commit -m "docs: update deployment guide"
```

### Branch Protection
Consider enabling branch protection rules on GitHub:
- Require pull request reviews for `main`
- Require status checks to pass
- Restrict pushes to `main` branch

### Resource Tagging
All resources are automatically tagged with:
- Environment (from workspace)
- Deployment timestamp
- Git commit hash (if configured)

---

**🎉 Your deployment pipeline is fully automated!**
Just push to any branch and watch your infrastructure deploy automatically.
