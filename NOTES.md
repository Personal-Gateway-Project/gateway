# NOTES

## 2026-10-20 · Mustafa · Task 3
- Tried: organization Personal-Gateway-Project, public repo gateway, SSH key, ruleset protect-main, PR template.
- Worked: direct push to main is rejected (GH013); PRs merge through the admin bypass.
- Failed: template file name typo (templete) hid the template; fixed with git mv.
- Acceptance: push to main rejected; new PR shows the template automatically.


## 2026-10-24 · Abdalmonem · Task 4
- Tried: Linked Clone of clean-base for client1 and client2, XFCE with lightdm and firefox-esr, Adapter 1 on Internal Network gwlan.
- Worked: both clients boot to XFCE, browser opens, ip -br a shows enp0s3 UP with 192.168.50.x from the gateway DHCP.
- Failed: ( nothing)
- Acceptance: client1 and client2 boot to XFCE, browser opens, ip -br a shows one interface on gwlan
