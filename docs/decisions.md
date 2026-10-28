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
- Decision: Raspberry Pi 3 Model B (V1.2): BCM2837 quad-core Cortex-A53 at 1.2 GHz (64-bit), 1 GB RAM, 10/100 Ethernet, 2.4 GHz Wi-Fi with AP mode, Raspberry Pi OS Lite (trixie; needs verification in Task 61 that the 64-bit image boots on this board). It misses two criteria, accepted because: 1 GB RAM is enough for a system without a desktop and up to 3 users, and heavy tests stay on the VM; 100 Mbps Ethernet matches the B593 LAN ports, which are 10/100. The board was delivered on 2026-10-26; a photo is attached to the Task 6 PR.
- Alternatives: Raspberry Pi 4 Model B (meets all criteria, higher price); Raspberry Pi 5 (meets all criteria, highest price); Mustafa's Debian laptop with ROLE=laptop, kept as the fallback if the board fails.
- Consequences: docs/AI_GUIDE.md now says up to 3 users and Raspberry Pi 3 Model B. For plan v1.2: Task 62 uses 2.4 GHz (channel 1, 6 or 11) and a 3-client test instead of 5 GHz channel 36 and 10 clients; Task 73 and hypothesis H5 use up to 3 clients; Task 21 no longer needs the move to Pi 5. Task 61 checks that iw list shows AP mode and that vcgencmd get_throttled returns throttled=0x0.

## ADR-002: User scope of up to 3 users
- Date: 2026-10-28
- Status: accepted
- Context: The proposal and the guide target about 10 users, with H5 tested from 5 to 10 concurrent clients. The board is a Raspberry Pi 3 Model B (ADR-001): 1 GB RAM, 10/100 Ethernet and 2.4 GHz Wi-Fi only. The practical deployment is one household of up to 3 users.
- Decision: The system scope is up to 3 users. The whole team agreed on 2026-10-28.
- Alternatives: Keep about 10 users and test H5 with 5 to 10 clients (needs more client devices and is beyond what the board was chosen for); keep 10 as the design target and test only 3 (leaves H5 untested as written).
- Consequences: Rule 8 in docs/AI_GUIDE.md says up to 3 users. H5 becomes "the board is not the bottleneck for 3 concurrent users", tested with vmstat and iperf3 from 1 to 3 clients. Task 62 tests 3 clients and Task 73 (H5) uses 1 to 3 clients in plan v1.2. Open decision 6 (Wi-Fi client limit) targets 3 devices and is measured in Task 62. The proposal (Q5, H5, sections 8.2.5 and 9.1.9) still says 5 to 10 users; it is not edited, and the thesis explains this change.
