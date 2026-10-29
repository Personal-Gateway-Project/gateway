
# NOTES

## Mustafa

### 2026-10-18 · Task 1: Gateway VM
- Tried: VirtualBox VM "gateway", Debian 13 netinst, no desktop, SSH server, NAT with port forward 2222 to 22, second adapter on gwlan.
- Worked: Debian 13.7 installed; enp0s3 UP with 10.0.2.15; enp0s8 present (DOWN, expected); ping deb.debian.org 0% loss; SSH from VS Code works.
- Failed: cat without a file hung (fixed with Ctrl+C); cls and ipconfig do not exist (use clear, ip -br a); poweroff not found as a normal user (used su -); sudo was not installed (installed it, added mustafa to the sudo group).
- Note: snapshot clean-base was taken before installing sudo, so clones have no sudo.
- Acceptance: sources show trixie, trixie-updates, trixie-security; ssh -p 2222 works; clean-base exists.
- Actual hours: about 5.5 (includes download waiting)

### 2026-10-20 · Task 3: GitHub basics and pull requests
- Tried: organization Personal-Gateway-Project, public repo gateway, SSH key, ruleset protect-main, PR template.
- Worked: direct push to main is rejected (GH013); PRs merge through the admin bypass.
- Failed: template file name typo (templete) hid the template; fixed with git mv. Nested code fences broke the template when copied.
- Acceptance: push to main rejected; new PR shows the template automatically.
- Actual hours: about 5

### 2026-10-23 · Task 3: First reviews and bypass removal
- Done: reviewed and approved Naba's PR; requested changes on Abdelmoneim's PR (debug=True with host 0.0.0.0, app.py outside web/portal, port 5000 instead of 8080, Flask not pinned).
- Done: removed Organization admin from the protect-main bypass list; merging now needs one approval.
- Actual hours: about 1.5

### 2026-10-23 · Task 4: Client VMs
- Done: client1 and client2 as clones of clean-base, 1 GB RAM, 1 CPU, one adapter on gwlan, new MAC addresses, new hostname and machine-id each.
- Changed from plan: no XFCE yet (weak internet). Browser client decided in phase 4. Not a contract change.
- Found: clean-base has no sudo; used su -. install.sh must not assume sudo exists.
- Found: clients get 169.254.x.x (link-local) because DHCP is not served yet; expected until task 9.
- Acceptance: both boot; hostnamectl shows client1 and client2; machine-ids differ (ee3793b9 / 1912e491); ip -br a shows only enp0s3.
- Actual hours: about 2

### Hours summary, week 1 (Oct 18 to 25)
- Task 1: about 5.5 (planned 3)
- Task 3: about 6.5 including reviews (planned 2)
- Task 4: about 2 (planned 3.5)
- Total so far: about 14 of the 12 planned for week 1
- Remaining this week: Task 5 (repository skeleton and CI), Task 6 (board decision)

## Naba

### 2026-10-19 to 22 · Task 1: Gateway VM
- Tried: Debian 13.7 VM with SSH and sudo, clean-base snapshot.
- Failed: pressed Enter before unticking GNOME; restarted the install. A root password skipped sudo; fixed with apt install sudo and usermod -aG sudo naba.
- Acceptance: passed.
- Actual hours: about 6 (planned 3)

### 2026-10-21 to 23 · Task 3: GitHub basics and pull requests
- Done: GitHub account with private noreply email, ed25519 SSH key, cloned the repo, PR #5 merged, reviewed PR #4.
- Acceptance: push to main rejected (GH013); the PR template appears.
- Actual hours: about 3 (planned 2)

### 2026-10-23 to 25 · Task 4: Client VMs
- Done: client1 and client2 as linked clones with XFCE, lightdm and firefox-esr, plus dnsutils, curl, netcat-openbsd and iperf3; new hostname and machine-id each.
- Failed: Debian 13 has no dhclient, so installed isc-dhcp-client (task 29 needs it). systemd-machine-id-setup copied the old ID from D-Bus; fixed by deleting both machine-id files first.
- Acceptance: both boot to XFCE, Firefox opens, ip -br a shows one interface on gwlan.
- Actual hours: about 3 (planned 3.5)

### 2026-10-26 · Task 5 review (PR #10)
- Done: ran the acceptance test on my VM (grep, git check-ignore, bash -n, nft -c), all passed; found EOF leftovers in 3 files, fixed by Abdelmoneim; approved.
- Actual hours: about 2 (planned 1.25)

### 2026-10-27 · Task 6: Board decision (PR #11)
- Done: ADR-001 (Raspberry Pi 3 Model B) in docs/decisions.md; AI_GUIDE updated to Pi 3 Model B and up to 3 users.
- Found: VM DNS failed after the laptop changed network (resolv.conf kept the old address); fixed by restarting the VM. The VM clock was 15 h behind after "Save the machine state"; use poweroff instead.
- Acceptance: ADR merged; fallback (Mustafa's laptop, ROLE=laptop) documented.
- Actual hours: about 1 (planned 2)

### 2026-10-28 · Task 2: Linux basics (week 2)
- Done: final exercise on the gateway VM, screenshot on PR #12; reviewed PR #7.
- Found: journalctl needs sudo, because our users are not in the adm group.
- Actual hours: about 3 (planned 2)