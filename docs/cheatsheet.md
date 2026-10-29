# Linux cheatsheet

Commands we use every day on the gateway VM. Each one was tested on Debian 13.

## 1. Navigation

| Command | What it does | Example |
|---|---|---|
| `pwd` | Print the folder you are in | `pwd` shows `/home/mustafa/gateway` |
| `ls -la` | List all files, hidden ones too, with details | `ls -la ~/gateway` shows `.git` and `.github` |
| `cd <folder>` | Move into a folder | `cd ~/gateway` |
| `cd ..` | Move up one folder | from `~/gateway/docs` to `~/gateway` |
| `cd ~` or `cd` | Go to your home folder | `/home/mustafa` |

- `~` means your home folder. `.` means the current folder. `..` means the folder above.
- Hidden files start with a dot (`.git`, `.gitignore`). Plain `ls` does not show them.
- In `ls -la`, the first column is the type and permissions: `d` = folder, then `rwx` for owner, group and others (`r` read, `w` write, `x` execute).

## 2. Files

| Command | What it does | Example |
|---|---|---|
| `mkdir -p <path>` | Make a folder, and its parents if needed. No error if it exists | `mkdir -p ~/lab/week2` |
| `cp <from> <to>` | Copy a file | `cp hello.txt hello.bak` |
| `mv <from> <to>` | Move or rename a file | `mv hello.bak backup.txt` |
| `rm <file>` | Delete a file. There is no recycle bin | `rm backup.txt` |
| `rm -r <folder>` | Delete a folder and everything inside it | `rm -r ~/lab` |
| `cat <file>` | Print a short file | `cat /etc/hostname` |
| `less <file>` | Read a long file page by page. `q` to quit, `/word` to search | `less /etc/services` |
| `head -n 5 <file>` | First 5 lines | `head -n 5 /etc/passwd` |
| `tail -n 5 <file>` | Last 5 lines | `tail -n 5 NOTES.md` |
| `tail -f <file>` | Follow a file as new lines arrive. `Ctrl+C` to stop | used later for the dnsmasq log |

- `rm -r` cannot be undone. Read the path twice before Enter.

## 3. nano

Open a file: `nano <file>` (creates it if it does not exist).

| Keys | What it does |
|---|---|
| `Ctrl+O` then `Enter` | Save |
| `Ctrl+X` | Exit (asks to save if there are changes) |
| `Ctrl+W` | Search |
| `Ctrl+K` | Cut the current line |
| `Ctrl+U` | Paste |
| `Alt+U` | Undo |

- `^` in the bottom menu means `Ctrl`, and `M-` means `Alt`.
- If nano is killed (for example the SSH connection drops), it leaves `<file>.save`. Compare it with `diff`, keep what you need, then delete it. It is in `.gitignore`.
- In the VS Code terminal, VS Code may catch some keys (`Ctrl+W` closes the tab). Use nano from a plain SSH window (cmd or PowerShell), or open the file with `code <file>` instead.

## 4. Users and sudo

| Command | What it does | Example |
|---|---|---|
| `whoami` | Print the current user | `mustafa` |
| `sudo <command>` | Run one command as root | `sudo apt update` |
| `su -` | Become root until you type `exit` | used before sudo was installed |
| `groups` | List your groups. `sudo` must be there | `mustafa sudo ...` |

- The prompt ends in `$` for a normal user and `#` for root. Never type `sudo` when you see `#`.
- Never run `git` with `sudo` or as root. Files would end up owned by root and git breaks for you.
- Use `sudo` only when the command needs it (installing, editing `/etc`, managing services).

## 5. apt

| Command | What it does | Example |
|---|---|---|
| `sudo apt update` | Refresh the list of available packages. Run it before any install | `sudo apt update` |
| `sudo apt install <pkg>` | Install a package and what it depends on | `sudo apt install tree` |
| `sudo apt install --no-install-recommends <pkg>` | Install without the optional extras. Smaller download | used for XFCE on client1 |
| `sudo apt remove <pkg>` | Remove a package, keep its config files | `sudo apt remove tree` |
| `sudo apt upgrade` | Upgrade installed packages to the versions found by `apt update` | `sudo apt upgrade` |
| `apt show <pkg>` | Describe a package: version, size, what it needs | `apt show dnsmasq` |
| `apt show -a <pkg>` | Show every available version of a package | `apt show -a dnsmasq` |
| `apt list --upgradable` | List installed packages that have a newer version | after `apt update` |
| `apt policy <pkg>` | Show the installed and candidate versions | `apt policy nftables` |

- Read the summary before typing `Y`: how many packages, download size, disk space.
- `apt update` only refreshes the list. It does not install or upgrade anything.
- Our VMs are on weak internet. A large download can take an hour; plan for it.
- `tree -L 1 <folder>` shows a folder as a tree, one level deep. Add `-a` to show hidden files. Install it with `sudo apt install tree`.


## 6. systemctl

`systemctl` talks to systemd, the program that starts and watches every service (ssh, dnsmasq, later our own services).

| Command | What it does | Example |
|---|---|---|
| `systemctl status <svc>` | State, last log lines, main process | `systemctl status ssh --no-pager` |
| `systemctl is-active <svc>` | Prints `active` or `inactive` | `systemctl is-active ssh` |
| `systemctl is-enabled <svc>` | Prints `enabled` if it starts at boot | `systemctl is-enabled ssh` |
| `sudo systemctl start <svc>` | Start now (not at boot) | `sudo systemctl start dnsmasq` |
| `sudo systemctl stop <svc>` | Stop now | `sudo systemctl stop dnsmasq` |
| `sudo systemctl restart <svc>` | Stop then start. Use after editing its config | `sudo systemctl restart ssh` |
| `sudo systemctl enable <svc>` | Start at every boot (does not start it now) | `sudo systemctl enable dnsmasq` |
| `sudo systemctl enable --now <svc>` | Enable and start in one step | `sudo systemctl enable --now dnsmasq` |
| `sudo systemctl disable <svc>` | Do not start at boot | `sudo systemctl disable dnsmasq` |

- `--no-pager` prints everything at once instead of opening a pager (where you need `q`).
- `start` is for now, `enable` is for the next boot. A service that works now but not after `sudo reboot` was started but not enabled.
- Restarting `ssh` keeps your current SSH session open.

## 7. journalctl

`journalctl` reads the system log that systemd keeps for every service.

| Command | What it does | Example |
|---|---|---|
| `sudo journalctl -u <svc>` | Log of one service | `sudo journalctl -u ssh` |
| `sudo journalctl -u <svc> -n 20` | Last 20 lines only | `sudo journalctl -u ssh -n 20 --no-pager` |
| `sudo journalctl -u <svc> -f` | Follow new lines live. `Ctrl+C` to stop | while testing a client login |
| `sudo journalctl -b` | Everything since the last boot | `sudo journalctl -b --no-pager \| tail` |
| `sudo journalctl -p err -b` | Only errors since the last boot | first thing to run when something fails |
| `sudo journalctl --since "10 min ago"` | Only recent lines | `sudo journalctl -u dnsmasq --since "10 min ago"` |

- Use `sudo`: a normal user who is not in the `adm` or `systemd-journal` group sees only part of the log.
- When a service fails: `systemctl status <svc>` first, then `sudo journalctl -u <svc> -n 50 --no-pager`.

## 8. Week 1 mistakes

| What happened | Why | Fix |
|---|---|---|
| `cat` with no file waited forever | It reads the keyboard when no file is given | `Ctrl+C` |
| `ping` never stopped | Linux `ping` runs until stopped | `ping -c 3 <host>`, or `Ctrl+C` |
| `cls` and `ipconfig` not found | Those are Windows commands | `clear` and `ip -br a` |
| `fatal: not a git repository` | `git` run outside the repo | `cd ~/gateway` first |
| `git switch main` then `git pull` refused | An untracked file had the same name as a file in `main` | Move the file out of the repo, then pull |
| A `.save` file appeared | nano was killed before saving | Compare with `diff`, keep what you need, delete it |
| Work done on the wrong branch | Forgot `git switch -c` after `git pull` | Untracked files move with you: run `git switch -c <branch>` now |
| Backticks lost when copying from chat | Chat turns `` ` `` into formatting | Copy from a file, then check with `` grep -c '`' <file> `` |
| `sudo git ...` or `git` as root | Makes root own repo files | Never. Use your normal user |
| `git add .` | Adds every file, also leftovers | `git add <file>` by name |
