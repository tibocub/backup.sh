# Backup.sh

A simple bash script to quickly backup all your local project repositories
between your home machine and school using a central GitHub backup repository.

## Usage

`backup push` -> copies `LOCAL_DIR`'s content into `BACKUP_REPO_DIR` and push your backup to your configured repo

`backup pull` -> applies `BACKUP_REPO_DIR`'s state to `LOCAL_DIR`

## Quick Install
Clone or download this repository, navigate into it, and run the installer:

```bash
sh -c "$(wget -qO- [https://raw.githubusercontent.com/YOUR_GITHUB_USERNAME/YOUR_REPO_NAME/main/install.sh](https://raw.githubusercontent.com/YOUR_GITHUB_USERNAME/YOUR_REPO_NAME/main/install.sh))"
```

**Before running** `backup`, setup your backup's remote origin. 

For example:

`git clone <your-github-backup-repo-url> ~/Code/backup`

or

`user@ubuntu:~/Code/backup$ git remote add origin git@github.com:<your-github>/<your-repo>.git`

## Configure
simply edit `LOCAL_DIR` and `BACKUP_REPO_DIR` in the script to the paths where your respective folders exist.

For example, I personally keep my code in `~/Code/perso/` and my backup repo in `~/Code/42-backup/`
