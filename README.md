# Git History Reset Scripts

Cross-platform scripts (Windows, Mac, Linux) that completely reset your Git repository history, creating a fresh start with a single initial commit.

## 📦 Available Scripts

- **`reset_git_history.bat`** - For Windows
- **`reset_git_history.sh`** - For Mac and Linux

## ⚠️ Critical Warning

**These scripts permanently delete all Git history!** Use with extreme caution. This action:
- Removes all previous commits
- Deletes all commit history
- Cannot be undone once pushed to remote
- May cause issues for collaborators who have cloned the repository
- **BACKUP YOUR REPOSITORY BEFORE RUNNING**

## 🎯 Why Use This?

### Common Use Cases

1. **Remove Sensitive Data**
   - Accidentally committed API keys, passwords, or tokens
   - Need to purge credentials from entire history
   - Remove private configuration files that were tracked

2. **Clean Up Repository**
   - Remove large files that bloat repository size
   - Clean up messy development history before going public
   - Start fresh after prototyping phase

3. **Repository Maintenance**
   - Reduce clone size for new contributors
   - Remove deprecated code and old experiments
   - Consolidate forked repositories

4. **Privacy & Security**
   - Remove personal information from commit history
   - Clean up before open-sourcing a private project
   - Eliminate traces of internal tools or infrastructure

5. **Fresh Start**
   - Reboot a stale project
   - Convert legacy codebase to modern structure
   - Start new version with clean slate

### When NOT to Use This

- On active repositories with multiple collaborators (coordinate first!)
- If you need to preserve any commit history
- On repositories where history provides value (debugging, auditing)
- If you're unsure about the consequences

## 📋 Prerequisites

- Git must be installed on your system
- You must be in a Git repository directory
- You must have push access to the remote repository
- **Backup your repository before running**

## 🚀 Usage

### Windows

1. **Navigate to your repository:**
   ```cmd
   cd path\to\your\repo
   ```

2. **Run the script:**
   ```cmd
   reset_git_history.bat
   ```

3. **Enter your branch name when prompted:**
   ```
   Enter the default branch name (usually main or master): main
   ```

### Mac / Linux

1. **Make the script executable (first time only):**
   ```bash
   chmod +x reset_git_history.sh
   ```

2. **Navigate to your repository:**
   ```bash
   cd path/to/your/repo
   ```

3. **Run the script:**
   ```bash
   ./reset_git_history.sh
   ```

4. **Enter your branch name when prompted:**
   ```
   Enter the default branch name (usually main or master): main
   ```

## 📖 What It Does

The scripts perform the following operations in sequence:

1. **Creates an orphan branch** (`temp_branch`)
   - An orphan branch has no commit history

2. **Stages all files**
   - Adds all current files to the staging area

3. **Creates initial commit**
   - Commits all files with the message "Initial commit"

4. **Deletes the old branch**
   - Removes your original branch (e.g., `main` or `master`)

5. **Renames the new branch**
   - Renames `temp_branch` to your specified branch name

6. **Force pushes to remote**
   - Overwrites the remote repository with the new history

## 🔍 Step-by-Step Breakdown

```bash
git checkout --orphan temp_branch    # Create new branch with no history
git add .                             # Stage all files
git commit -m "Initial commit"        # Create first commit
git branch -D main                    # Delete old branch
git branch -m main                    # Rename temp branch to main
git push -f origin main               # Force push to remote
```

## ✅ Success Indicators

The scripts provide visual feedback:
- 🔹 Process started
- ✅ Success message when complete
- ❌ Error messages if any step fails

Each step is validated, and the script will stop if an error occurs.

## ⚡ Error Handling

If any step fails, the script will:
- Display an error message indicating which step failed
- Exit without proceeding to the next step
- Leave your repository in a recoverable state

This prevents partial execution that could leave your repository in an inconsistent state.

## 🛡️ Safety Recommendations

### Before Running

1. **Create a backup:**
   ```bash
   git clone your-repo-url backup-folder
   ```

2. **Inform collaborators:**
   - Notify team members before resetting history
   - They will need to re-clone the repository
   - Schedule during low-activity periods

3. **Verify current state:**
   ```bash
   git status
   git log --oneline
   git branch -a
   ```

4. **Test on a copy first:**
   - Create a test repository to verify the script works as expected
   - Practice the workflow before running on production

5. **Check protected branches:**
   - Temporarily disable branch protection rules
   - Re-enable after successful push

### Alternative Approaches

Before using this nuclear option, consider:
- `git filter-branch` or `git filter-repo` for selective history rewriting
- `BFG Repo-Cleaner` for removing specific files
- `.gitignore` for preventing future commits of sensitive files

## 🔄 After Running the Script

### For Repository Owner

1. **Verify the reset:**
   ```bash
   git log --oneline
   ```

2. **Update branch protection rules** if disabled

3. **Notify all collaborators**

### For Collaborators

Option 1: Reset local repository
```bash
cd your-repo
git fetch origin
git reset --hard origin/main
git clean -fdx
```

Option 2: Re-clone (recommended)
```bash
rm -rf old-repo-folder
git clone your-repo-url
```

## 🐛 Troubleshooting

### "Failed to create orphan branch"
- Ensure you're in a Git repository (`git status`)
- Check that Git is properly installed (`git --version`)
- Verify you're not in a bare repository

### "Failed to force push to remote"
- Verify you have push permissions
- Check your remote URL: `git remote -v`
- Ensure you're connected to the internet
- Check if branch protection is enabled
- Verify authentication (SSH keys or credentials)

### "Failed to delete old branch"
- You might be on the branch you're trying to delete
- The branch name might be incorrect
- Try `git branch -a` to see all branches

### "Permission denied" (Mac/Linux)
- Make script executable: `chmod +x reset_git_history.sh`
- Ensure you have write permissions in the directory

## 📝 Customization

You can modify the commit message:

**Windows** (line 34):
```batch
git commit -m "Initial commit"
```

**Mac/Linux** (line 33):
```bash
git commit -m "Initial commit"
```

Change to your preferred message:
```bash
git commit -m "Fresh start - v2.0"
```

## 🔗 Related Commands

**View current history:**
```bash
git log --oneline --graph --all
```

**Check repository status:**
```bash
git status
```

**List all branches:**
```bash
git branch -a
```

**Check repository size:**
```bash
git count-objects -vH
```

**See what will be committed:**
```bash
git diff --cached
```

## 💡 Best Practices

1. **Always backup** before running
2. **Coordinate with team** before resetting shared repositories
3. **Document the reset** in your project's changelog
4. **Update documentation** that references old commits
5. **Check CI/CD pipelines** that might reference old commit SHAs
6. **Archive old history** if needed for compliance/auditing

## 📚 Additional Resources

- [Git Documentation - Rewriting History](https://git-scm.com/book/en/v2/Git-Tools-Rewriting-History)
- [GitHub: Removing sensitive data](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/removing-sensitive-data-from-a-repository)
- [BFG Repo-Cleaner](https://rtyley.github.io/bfg-repo-cleaner/)

## 📄 License

These scripts are provided as-is for educational and utility purposes. Use at your own risk.

## 🤝 Contributing

Feel free to modify and improve these scripts for your needs. Common enhancements could include:
- Adding a confirmation prompt before deletion
- Creating an automatic backup
- Supporting multiple remotes
- Adding dry-run mode
- Interactive branch selection
- Commit message customization

---

**⚠️ REMEMBER: Always backup your repository before running destructive Git operations!**

## 🆘 Recovery

If something goes wrong and you need to recover:

1. **If you have a backup:**
   ```bash
   cd backup-folder
   git push -f origin main
   ```

2. **If you haven't pushed yet:**
   ```bash
   git reflog
   git reset --hard <commit-sha>
   ```

3. **Contact your Git hosting provider** (GitHub, GitLab, etc.) - they may have backups

---



If my projects make your life easier, consider buying me a coffee! Your support helps me create more open-source tools for the community.

<div align="center">

[![Support via DeStream](https://img.shields.io/badge/🍕_Feed_the_Developer-DeStream-FF6B6B?style=for-the-badge)](https://destream.net/live/H190K/donate)

[![Crypto Donations](https://img.shields.io/badge/Crypto_Donations-NOWPayments-9B59B6?style=for-the-badge&logo=bitcoin&logoColor=colored)](https://nowpayments.io/donation?api_key=J0QACAH-BTH4F4F-QDXM4ZS-RCA58BH)

</div>

---

<div align="center">

**Built with ❤️ by [H190K](https://github.com/H190K)**



</div>


---

**Remember:** Always backup your repository before running destructive Git operations!
*These scripts help you start fresh, but always proceed with caution and proper backups.*