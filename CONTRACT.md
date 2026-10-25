# CONTRACT v1.0

## **أسماء nftables**

| **العنصر** | **القيمة** |
| --- | --- |
| الجدول | table inet gateway |
| --- | --- |
| عدادات المستخدم | up_&lt;id&gt; وdown_&lt;id&gt; (64-bit) |
| --- | --- |
| عدادات التطبيقات | app_yt_&lt;id&gt; وapp_tt_&lt;id&gt; وapp_fb_&lt;id&gt; |
| --- | --- |
| الخرائط | upmap وdownmap وytmap وttmap وfbmap من النوع ipv4_addr : counter |
| --- | --- |
| مجموعات الهوية والحجب | authenticated وblocked وyt_blocked وtt_blocked وfb_blocked |
| --- | --- |
| مجموعة DoH | doh_servers |
| --- | --- |
| مجموعات التطبيقات | yt_ips وtt_ips وfb_ips: النوع ipv4_addr . ipv4_addr، مع flags timeout وtimeout 10m |
| --- | --- |
| السلاسل | prerouting وinput وforward وoutput وpostrouting |
| --- | --- |
| السياسة | drop افتراضياً في input وforward، والجهاز غير المسجل يصل فقط لـ DHCP وDNS والبوابة |
| --- | --- |

## **المنافذ والعناوين والخدمات**

| **العنصر** | **القيمة** |
| --- | --- |
| شبكة LAN في VirtualBox | 192.168.50.0/24، والبوابة 192.168.50.1 |
| --- | --- |
| واجهتا VirtualBox | الواجهة enp0s3 للـ WAN (NAT) والواجهة enp0s8 للـ LAN (Internal Network باسم gwlan) |
| --- | --- |
| واجهتا اللوحة | الواجهة eth0 للـ WAN والواجهة wlan0 للـ LAN |
| --- | --- |
| بوابة المستخدمين | المنفذ 8080 |
| --- | --- |
| لوحة المدير | المنفذ 8081 |
| --- | --- |
| خادم stubby | العنوان 127.0.0.1@5453 |
| --- | --- |
| مستخدم الخدمات | المستخدم gateway بصلاحية CAP_NET_ADMIN لـ reconcile فقط |
| --- | --- |
| خيارات dnsmasq | log-queries=extra وmax-ttl=300 وdhcp-script=/opt/gateway/lease_hook.py، وإرجاع NXDOMAIN لـ use-application-dns.net ولأسماء DoH |
| --- | --- |
| قاعدة البيانات | ملف SQLite بوضع WAL في /var/lib/gateway/gateway.db |
| --- | --- |
| الإعداد | ملف /etc/gateway/gateway.conf والأسرار في /etc/gateway/secrets.env |
| --- | --- |

## **جداول قاعدة البيانات**

الأسماء ملزمة. والأعمدة خط أساسي، وأي إضافة تحتاج اتفاق الفريق.

| **الجدول** | **الأعمدة** |
| --- | --- |
| الجدول admins | الأعمدة id، username، password_hash، must_change، failed_attempts، locked_until |
| --- | --- |
| الجدول users | الأعمدة id، username، password_hash، quota_bytes، used_bytes، suspended، deleted، renewed_at، created_at |
| --- | --- |
| الجدول app_quotas | الأعمدة user_id، app (القيم yt أو tt أو fb)، quota_bytes، used_bytes |
| --- | --- |
| الجدول sessions | الأعمدة ip (مفتاح)، user_id، mac، started_at |
| --- | --- |
| الجدول usage_daily | الأعمدة user_id، day، total_bytes، yt_bytes، tt_bytes، fb_bytes، وقيد فريد على (user_id, day) |
| --- | --- |
| الجدول notifications | الأعمدة id، user_id، message، created_at |
| --- | --- |
| الجدول edit_locks | الأعمدة user_id (مفتاح)، admin_id، expires_at |
| --- | --- |
| الجدول admin_log | الأعمدة id، admin_id (القيمة NULL تعني «النظام»)، action، target_user_id، details، at |
| --- | --- |
| الجدول app_domains | الأعمدة domain، app، source |
| --- | --- |
| الجدول dns_pairs | الأعمدة client_ip، server_ip، app، seen_at (يكتبه مراقب DNS إذا اعتُمد الحل (أ) في القسم 10) |
| --- | --- |
| الجدول counter_state | الأعمدة counter_name، last_raw_bytes |
| --- | --- |

## **هيكل المستودع**

gateway/

├── CONTRACT.md العقد (هذا القسم)

├── docs/AI_GUIDE.md هذا الدليل

├── docs/decisions.md سجل القرارات

├── config/templates/ قوالب nftables.conf.in, dnsmasq.conf.in, hostapd.conf.in, stubby.yml.in

├── config/gateway.conf.example

├── common/ config.py, db.py, nft.py, units.py, timeutil.py

├── db/schema.sql

├── services/ reconcile.py, dns_watcher.py, lease_hook.py

├── web/portal/ بوابة المستخدمين (8080)

├── web/admin/ لوحة المدير (8081)

├── scripts/ setup_admins.py, reset_admin.py, cleanup.py

├── systemd/ ملفات .service و .timer

├── tests/ اختبارات pytest + fake_nft.py + عينات

├── requirements.txt بإصدارات ثابتة

├── install.sh

└── check.sh

## **واجهات الوحدات المشتركة**

| **الوحدة** | **الدوال** |
| --- | --- |
| الوحدة common/config.py | الدالة load() تقرأ gateway.conf وsecrets.env وترجع WAN_IF وLAN_IF وLAN_CIDR وGW_IP وDB_PATH وRECONCILE_INTERVAL |
| --- | --- |
| الوحدة common/db.py | الدالة connect() (تفعّل WAL وbusy_timeout)، والدالة add_usage(user_id, delta, app=None)، والدالة upsert_daily(...)، والدالة policy_snapshot() |
| --- | --- |
| الوحدة common/nft.py | الدالة read_counters() عبر nft -j list counters table inet gateway، والدالة sync_set(name, desired)، والدالة bootstrap(snapshot) |
| --- | --- |
| الوحدة common/units.py | الثابت GB_BYTES، والدالتان bytes_to_gb(n) وgb_to_bytes(x) |
| --- | --- |
| الوحدة common/timeutil.py | الدالة now_khartoum()، والدالة day_of(ts)، والدالة clock_synced() |
| --- | --- |