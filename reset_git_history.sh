#!/bin/bash
# ==========================================
# Reset Git History Script for Mac/Linux
# ==========================================

echo ""
echo "🔹 Starting Git history reset..."
echo ""

# Ask user for the branch name
read -p "Enter the default branch name (usually main or master): " branchname

# Step 1: Create a new orphan branch
echo "Creating orphan branch..."
git checkout --orphan temp_branch
if [ $? -ne 0 ]; then
    echo "❌ Failed to create orphan branch"
    exit 1
fi

# Step 2: Add all files
echo "Adding all files..."
git add .
if [ $? -ne 0 ]; then
    echo "❌ Failed to add files"
    exit 1
fi

# Step 3: Commit everything
echo "Creating initial commit..."
git commit -m "Initial commit"
if [ $? -ne 0 ]; then
    echo "❌ Failed to commit files"
    exit 1
fi

# Step 4: Delete old branch
echo "Deleting old branch '$branchname'..."
git branch -D $branchname
if [ $? -ne 0 ]; then
    echo "❌ Failed to delete old branch $branchname"
    exit 1
fi

# Step 5: Rename new branch
echo "Renaming branch to '$branchname'..."
git branch -m $branchname
if [ $? -ne 0 ]; then
    echo "❌ Failed to rename branch to $branchname"
    exit 1
fi

# Step 6: Force push to remote
echo "Force pushing to remote..."
git push -f origin $branchname
if [ $? -ne 0 ]; then
    echo "❌ Failed to force push to remote"
    exit 1
fi

echo ""
echo "✅ Git history has been reset successfully!"
echo ""