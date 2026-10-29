# NOTES

## 2026-10-20 · Mustafa · Task 3
- Tried: organization Personal-Gateway-Project, public repo gateway, SSH key, ruleset protect-main, PR template.
- Worked: direct push to main is rejected (GH013); PRs merge through the admin bypass.
- Failed: template file name typo (templete) hid the template; fixed with git mv.
- Acceptance: push to main rejected; new PR shows the template automatically.


## 2026-10-29 · Abdelmoneim · Tasks 1, 3, 4, 5
- Task 1 (Gateway machine): Debian 13 without GUI in VirtualBox, SSH and sudo, clean-base snapshot. Acceptance: apt sources show trixie, SSH login works. Hours: 2
- Task 3 (GitHub and PR flow): direct push to main rejected, PR opened and the template appeared. Failed: refspec error on push, fixed with git checkout -b. Hours: 2.5
- Task 4 (Client machines): client1 and client2 as linked clones of clean-base with XFCE, on gwlan, both got 192.168.50.x from the gateway DHCP. Hours: 3
- Task 5 (Repository structure and CI): layout, CONTRACT.md, AI_GUIDE.md, .gitignore, secrets.env.example, install.sh skeleton and CI. First PR (#9) had conflicts, rebuilt as #10 which is merged. Hours: 2