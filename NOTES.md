# NOTES

## 2026-10-20 · Mustafa · Task 3
- Tried: organization Personal-Gateway-Project, public repo gateway, SSH key, ruleset protect-main, PR template.
- Worked: direct push to main is rejected (GH013); PRs merge through the admin bypass.
- Failed: template file name typo (templete) hid the template; fixed with git mv.
- Acceptance: push to main rejected; new PR shows the template automatically.

## 2026-10-22 · Naba · Task 1 and Task 3
- Tried: Debian 13.7 VM with SSH and sudo, clean-base snapshot; GitHub account Naba-Anas, git config with the private noreply
email, ed25519 SSH key, cloned the repo.
- Worked: ssh -T git@github.com authenticated; repo cloned and git status clean.
- Failed: on install I pressed Enter before unticking GNOME; fixed by restarting the install. Setting a root password skipped
sudo; fixed with apt install sudo and usermod -aG sudo naba.
- Acceptance: this PR shows the template automatically.
- Hours: Task 1 about 6 h, Task 3 about 3 h.
