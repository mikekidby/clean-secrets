# **Using Up BFG**

## **You can run clean.sh or run commands manually**

## **BOTH OPTIONS WILL REQUIRE YOU SET UP sensitive_data.txt**

### **Example sensitive_data.txt**:

```
Example-token-2
Example-token-1
```

**Save this file as `sensitive_data.txt`**.

### Steps to Run clean.sh:

1. **Go into clean.sh and set up variables**

```bash
GITHUB_USER_NAME="your_github_username"  # Replace with your GitHub username
FINE_GRAIN_ACCESS_TOKEN="your_access_token"  # Replace with your personal access token
REPO="program-service-wp"  # Replace with the target repository name

```

2. **Run clean.sh**
   - run with a --dry-run option
     ```bash
     sudo ./clean.sh --dry-run
     ```
   - run for realsies
     ```bash
     sudo ./clean.sh
     ```

### Steps to Run Manually:

1. **Clone Down Mirror of Repo**

   ```bash
       git clone --mirror https://<githubUserName>:<FineGrainAccessToken>@github.com/risepoint/<repo>
   ```

2. **Run BFG Repo-Cleaner** with the `--replace-text` option:

   ```bash
   sudo java -jar bfg-1.14.0.jar --replace-text sensitive_data.txt <repo>.git
   ```

3. **Clean up the repository** by running:

   ```bash
   cd <repo>.git
   git reflog expire --expire=now --all
   git gc --prune=now --aggressive
   ```

4. **Force-push the changes**:

   ```bash
   git push --force
   ```
