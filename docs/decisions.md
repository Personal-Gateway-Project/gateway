# Decision log

One entry per decision. Newest at the bottom.

## ADR-000: Title
- Date:
- Status: proposed, accepted or superseded
- Context: why a decision was needed
- Decision: what we chose
- Alternatives: what we rejected and why
- Consequences: what changes because of this

## ADR-001: Gateway board
- Date: 2026-10-27
- Status: accepted
- Context: The gateway must run on a real board between the Huawei B593 router (Ethernet) and the users' devices (Wi-Fi). The guide named a Raspberry Pi 4 Model B. The practical build needs up to 3 users. Plan criteria: 64-bit quad-core CPU, 2 GB RAM or more, Gigabit Ethernet, Wi-Fi with AP mode, runs Debian 13.
- Decision: Raspberry Pi 3 Model B (V1.2): BCM2837 quad-core Cortex-A53 at 1.2 GHz (64-bit), 1 GB RAM, 10/100 Ethernet, 2.4 GHz Wi-Fi with AP mode, Raspberry Pi OS Lite (trixie). It misses two criteria, accepted because: 1 GB RAM is enough for a system without a desktop and up to 3 users, and heavy tests stay on the VM; 100 Mbps Ethernet matches the B593 LAN ports, which are 10/100. The board was delivered on 2026-10-26; a photo is attached to the Task 6 PR.
- Alternatives: Raspberry Pi 4 Model B (meets all criteria, higher price); Raspberry Pi 5 (meets all criteria, highest price); Mustafa's Debian laptop with ROLE=laptop, kept as the fallback if the board fails.
- Consequences: docs/AI_GUIDE.md now says up to 3 users and Raspberry Pi 3 Model B. For plan v1.2: Task 62 uses 2.4 GHz (channel 1, 6 or 11) and a 3-client test instead of 5 GHz channel 36 and 10 clients; Task 73 and hypothesis H5 use up to 3 clients; Task 21 no longer needs the move to Pi 5. Task 61 checks that iw list shows AP mode and that vcgencmd get_throttled returns throttled=0x0.

