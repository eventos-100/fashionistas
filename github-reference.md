# GitHub CLI Guide for Claude Desktop

## 🚀 Quick Start Setup

### 1. Install GitHub CLI on Linux
```bash
# Download and install the latest version
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
sudo apt update
sudo apt install gh
```

### 2. Login to GitHub
```bash
# Authenticate with GitHub (follow the prompts)
gh auth login
```

## 📝 Essential Git Commands

### Initialize New Repository
```bash
# Create a new project
echo "# fashionistas" >> README.md
git init
git add README.md
git commit -m "first commit"
git branch -M main
git remote add origin https://github.com/amo-tech-ai/fashionistas.git
git push -u origin main
```

### Daily Workflow Commands

#### 1. Check Status
```bash
# See what files have changed
git status
```

#### 2. Add Changes
```bash
# Add specific file
git add filename.txt

# Add all changes
git add .
```

#### 3. Commit Changes
```bash
# Commit with message
git commit -m "Add new feature"

# Commit with detailed message
git commit -m "Feature: Add user authentication" -m "- Implemented login form
- Added password validation
- Created session management"
```

#### 4. Push to GitHub
```bash
# Push to main branch
git push

# Push to specific branch
git push origin branch-name
```

## 🔄 Common Workflows

### Create New Branch
```bash
# Create and switch to new branch
git checkout -b feature/new-feature

# Push new branch to GitHub
git push -u origin feature/new-feature
```

### Pull Latest Changes
```bash
# Get latest from main
git pull origin main

# Get latest from current branch
git pull
```

### View History
```bash
# See commit history
git log --oneline

# See last 5 commits
git log --oneline -5
```

## 🛠️ GitHub CLI Specific Commands

### Repository Management
```bash
# Create new repo on GitHub
gh repo create fashionistas --public

# Clone existing repo
gh repo clone amo-tech-ai/fashionistas

# View repo in browser
gh repo view --web
```

### Pull Requests
```bash
# Create pull request
gh pr create --title "Add new feature" --body "Description of changes"

# List pull requests
gh pr list

# View pull request status
gh pr status
```

### Issues
```bash
# Create new issue
gh issue create --title "Bug: Login not working" --body "Details here"

# List issues
gh issue list

# View specific issue
gh issue view 123
```

## 💡 Best Practices

### Commit Messages
```bash
# Good examples
git commit -m "Fix: Resolve login timeout issue"
git commit -m "Feature: Add export to PDF functionality"
git commit -m "Update: Improve error handling in payment module"
git commit -m "Docs: Add API documentation"

# Types to use:
# - Feature: New functionality
# - Fix: Bug fixes
# - Update: Changes to existing features
# - Docs: Documentation changes
# - Style: Code formatting, no logic change
# - Test: Adding tests
```

### Before Pushing
```bash
# Always check status first
git status

# Review your changes
git diff

# Make sure you're on the right branch
git branch
```

## 🚨 Common Fixes

### Undo Last Commit (keep changes)
```bash
git reset --soft HEAD~1
```

### Discard Local Changes
```bash
# Discard changes in specific file
git checkout -- filename.txt

# Discard all changes
git checkout -- .
```

### Update Commit Message
```bash
# Change last commit message
git commit --amend -m "New message"
```

## 📋 Quick Reference Card

```bash
# Initialize
git init

# Status check
git status

# Add files
git add .

# Commit
git commit -m "Your message"

# Push
git push

# Pull
git pull

# New branch
git checkout -b branch-name

# Switch branch
git checkout main

# View history
git log --oneline
```

## 🔗 Your Repository
- **URL**: https://github.com/amo-tech-ai/fashionistas
- **Clone**: `gh repo clone amo-tech-ai/fashionistas`

---

💡 **Pro Tip**: Use `gh alias set` to create shortcuts for common commands!