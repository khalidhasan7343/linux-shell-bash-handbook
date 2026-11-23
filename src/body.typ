#import "template.typ": *

#chapter-heading("", "How to Use This Handbook")
Read the chapters in order, type every example yourself, and do the
practice tasks at the end of each chapter. Copy-pasting teaches your
eyes; typing teaches your hands.

#strong[Conventions used in this book]

#table(
  columns: (auto,)*1 + (1fr,),
  align: (col, row) => (auto,auto,).at(col),
  inset: (x: 7pt, y: 5pt),
  [You see], [It means],
  [`$ command`],
  [Type the text after `$` in the terminal. Do not type the `$`
  itself.],
  [`# command`],
  [Run as root (administrator). Usually you write `sudo command`
  instead.],
  [Lines without `$`],
  [Output: what the computer prints back.],
  [`<name>`],
  [Replace with your own value, e.g. `<file>` → `notes.txt`],
  [`#` inside a script],
  [A comment. Bash ignores everything after `#` on that line.],
)

#strong[Special boxes]

#callout("why", "Why?")[
Explains the reason a command or option exists.

]
#callout("tip", "Tip")[
A shortcut or a better way.

]
#callout("mistake", "Common mistake")[
An error beginners often make, and how to fix it.

]
#callout("space", "Space check")[
The same code with and without spaces, and the different output each
gives.

]
#callout("bangla", "বাংলা নোট")[
A short explanation in Bangla for hard ideas.

]
#strong[Learning roadmap]

+ Weeks 1–2: Chapters 1–5 (foundations, navigation, files, permissions)
+ Weeks 3–4: Chapters 6–9 (processes, pipes, grep/sed/awk, system tools)
+ Weeks 5–6: Chapters 10–15 (scripting core; read Chapter 11 twice)
+ Weeks 7–8: Chapter 16 (solve every problem yourself before reading the
  answer)
+ Weeks 9–10: Chapters 17–19 (automation, projects, best practices)
+ Always: keep Appendix A (cheat sheet) open beside you

#callout("bangla", "বাংলা নোট")[
প্রতিদিন অন্তত ৩০ মিনিট টার্মিনালে কাজ করুন। ভুল হলে error message টা মনোযোগ
দিয়ে পড়ুন, সেখানেই উত্তর লুকিয়ে থাকে।

]
#callout("danger", "Safety")[
Practice in a test folder (`mkdir ~/practice && cd ~/practice`). Never
run `rm -rf` or `sudo` commands you do not understand.

]
#part-page("I", "Foundations")
#chapter-heading("1", "Operating System Foundations")
An operating system (OS) is the master program that manages your
hardware and lets other programs use it safely. The shell is the program
you type into to give the OS orders.

== 1.1 What does an OS do?
<what-does-an-os-do>
#table(
  columns: (auto,)*2 + (1fr,),
  align: (col, row) => (auto,auto,auto,).at(col),
  inset: (x: 7pt, y: 5pt),
  [Job], [Simple meaning], [Example],
  [Process management],
  [Starts, stops and shares CPU time between programs],
  [Firefox and VS Code run together],
  [Memory management],
  [Gives each program its own RAM and protects it],
  [One crashing app does not break another],
  [File system management],
  [Stores files in folders on disk],
  [`/home/rahim/notes.txt`],
  [Device management],
  [Talks to keyboard, screen, USB, Wi-Fi through drivers],
  [Plugging in a pen drive],
  [Security & users],
  [Decides who can read, write or run what],
  [`chmod`, `sudo`, passwords],
  [Networking],
  [Sends and receives data],
  [`ping google.com`],
)

#callout("bangla", "বাংলা নোট")[
OS হলো কম্পিউটারের \"ম্যানেজার\"। সে ঠিক করে কোন প্রোগ্রাম কখন CPU, RAM,
disk ব্যবহার করবে।

]
== 1.2 Kernel, shell and terminal
<kernel-shell-and-terminal>
These three words confuse almost every beginner, so learn them clearly
now.

#table(
  columns: (auto,)*2 + (1fr,),
  align: (col, row) => (auto,auto,auto,).at(col),
  inset: (x: 7pt, y: 5pt),
  [Word], [What it is], [Real example],
  [Kernel],
  [The core of the OS. It talks directly to hardware.],
  [The Linux kernel],
  [Shell],
  [A program that reads your commands and asks the kernel to do them],
  [Bash, Zsh, Fish, sh],
  [Terminal],
  [The window that shows the shell],
  [Konsole (KDE), GNOME Terminal, Windows Terminal],
)

Think of a restaurant: you (user) tell the waiter (shell) your order,
the waiter tells the kitchen (kernel), and the kitchen uses the stove
(hardware). The terminal is the table where you sit and talk.

#layers-diagram()
Read it top to bottom: your words become a command line, the shell turns
it into system calls, and the kernel drives the hardware. The result
travels back up to your screen.

#callout("why", "Why?")[
#strong[Why Bash?] Bash (Bourne Again SHell) is the default shell on
Fedora, Ubuntu and most servers. Scripts you write in Bash run almost
everywhere in the job world.

]
== 1.3 User space and kernel space
<user-space-and-kernel-space>
Normal programs run in #strong[user space] with limited power. Only the
kernel runs in #strong[kernel space] with full hardware access. When a
program needs hardware (read a file, open a network connection), it
makes a #strong[system call] to the kernel, such as `open()`, `read()`,
`write()` or `fork()`.

#callout("why", "Why?")[
This split protects the system. A buggy program cannot directly damage
the disk or other programs\' memory.

]
== 1.4 Programs and processes
<programs-and-processes>
- A #strong[program] is a file on disk (e.g. `/usr/bin/ls`).
- A #strong[process] is a program that is running. It has a #strong[PID]
  (process ID), memory, and an owner.
- Every process has a #strong[parent]. When you type `ls` in Bash, Bash
  creates (forks) a child process that runs `ls`.
- The first process started at boot is #strong[systemd] (PID 1) on
  Fedora and Ubuntu.

== 1.5 Everything is a file
<everything-is-a-file>
Linux treats almost everything as a file: documents, folders, devices
(`/dev/sda`), even running process information (`/proc`). This is why
the same tools (`cat`, `ls`, `>`) work on so many things.

== 1.6 The Linux directory tree
<the-linux-directory-tree>
Linux has #strong[one] tree that starts at `/` (called #emph[root]).
There is no `C:` or `D:` drive.

#table(
  columns: (auto,)*1 + (1fr,),
  align: (col, row) => (auto,auto,).at(col),
  inset: (x: 7pt, y: 5pt),
  [Directory], [What lives there],
  [`/`],
  [The top of the tree (root directory)],
  [`/home`],
  [Users\' personal folders, e.g. `/home/rahim`],
  [`/root`],
  [Home folder of the root (admin) user],
  [`/bin`, `/usr/bin`],
  [Commands for all users (`ls`, `cp`, `bash`)],
  [`/sbin`, `/usr/sbin`],
  [System admin commands (`fdisk`, `useradd`)],
  [`/etc`],
  [Configuration files (`/etc/passwd`, `/etc/hostname`)],
  [`/var`],
  [Changing data: logs (`/var/log`), caches, mail],
  [`/tmp`],
  [Temporary files, often cleared at reboot],
  [`/dev`],
  [Device files (disks, USB, terminals)],
  [`/proc`, `/sys`],
  [Live kernel and process information (virtual files)],
  [`/boot`],
  [Kernel and bootloader files],
  [`/opt`],
  [Optional third-party software],
  [`/mnt`, `/media`],
  [Mount points for extra disks and pen drives],
)

== 1.7 How Linux boots (short version)
<how-linux-boots-short-version>
+ #strong[BIOS/UEFI] checks hardware and finds the bootloader.
+ #strong[GRUB] (bootloader) loads the Linux kernel.
+ The #strong[kernel] starts, detects hardware, mounts the root file
  system.
+ #strong[systemd] (PID 1) starts services (network, login screen).
+ You log in; KDE Plasma starts; you open Konsole; Bash starts.

== 1.8 Popular shells
<popular-shells>
#table(
  columns: (auto,)*1 + (1fr,),
  align: (col, row) => (auto,auto,).at(col),
  inset: (x: 7pt, y: 5pt),
  [Shell], [Notes],
  [`sh`],
  [The original Bourne shell standard (POSIX). Minimal.],
  [`bash`],
  [Default on Fedora/Ubuntu. This book uses it.],
  [`zsh`],
  [Default on macOS. Very similar to Bash, with extra features.],
  [`fish`],
  [Friendly, but its scripting syntax is different from Bash.],
  [`dash`],
  [Fast, small; Ubuntu uses it as `/bin/sh`.],
)

Check yours:

```bash
$ echo $SHELL
/bin/bash
$ bash --version
GNU bash, version 5.2.x ...
```

#callout("practice", "Practice 1")[
(a) Write the difference between a program and a process in one line.
(b) Name the first process started at boot. (c) Run
`cat /etc/os-release` and note your OS name and version.

]
#chapter-heading("2", "Lab Setup for Every Platform")
You need a Linux terminal running Bash. Pick the section that matches
your computer; Fedora KDE is the main system used in this book.

== 2.1 Fedora KDE Plasma (main system)
<fedora-kde-plasma-main-system>
+ Open the application launcher (bottom-left), search #strong[Konsole],
  press Enter.
+ Pin it: right-click Konsole in the taskbar → #emph[Pin to Task
  Manager].
+ Update the system and install useful tools:

```bash
$ sudo dnf upgrade --refresh          # update all packages
$ sudo dnf install bc tree ShellCheck man-pages vim nano htop
```

- `sudo` \= run as administrator (asks your password; nothing shows
  while typing, that is normal).
- `dnf` \= Fedora\'s package manager. `upgrade --refresh` refreshes the
  package list, then upgrades.
- `bc` \= calculator for decimals; `tree` \= shows folders as a tree;
  `ShellCheck` \= finds bugs in scripts; `htop` \= nicer process viewer.

Your prompt looks like this:

```
[rahim@fedora ~]$
```

`rahim` \= user, `fedora` \= computer name (hostname), `~` \= you are in
your home folder, `$` \= normal user (`#` would mean root).

#callout("note", "Fedora note")[
Fedora has #strong[SELinux] (extra security) turned on. If a service
cannot read a file even though permissions look right, SELinux may be
the reason. Check with `getenforce`.

]
== 2.2 Ubuntu / Debian
<ubuntu-debian>
Open the terminal with #strong[Ctrl + Alt + T].

```bash
$ sudo apt update                    # refresh package list
$ sudo apt upgrade                   # install updates
$ sudo apt install bc tree shellcheck htop vim
```

Prompt looks like: `rahim@ubuntu:~$`

== 2.3 Windows (WSL)
<windows-wsl>
WSL (Windows Subsystem for Linux) runs real Linux inside Windows.

+ Open #strong[PowerShell as Administrator].
+ See available Linux versions, then install one:

```powershell
PS> wsl --list --online
PS> wsl --install                       # installs Ubuntu by default
PS> wsl --install FedoraLinux-42        # or Fedora (use the version name the list shows)
```

#block[
#set enum(numbering: "1.", start: 3)
+ Restart if asked, then open \"Ubuntu\" or \"Fedora\" from the Start
  menu and create a username and password.
+ Your Windows C: drive is at `/mnt/c` inside WSL.
]

== 2.4 macOS
<macos>
macOS uses #strong[zsh] by default and ships a very old Bash (3.2).
Install a modern Bash with Homebrew:

```bash
% brew install bash
% bash --version
```

Run scripts with `bash script.sh` so they use Bash, not zsh. Some
commands differ (e.g. `sed -i ''` on Mac vs `sed -i` on Linux).

== 2.5 Virtual machine or online (no install)
<virtual-machine-or-online-no-install>
- #strong[VirtualBox / GNOME Boxes / VMware:] install Fedora or Ubuntu
  inside a VM. Safe for experiments; you can take snapshots.
- #strong[Online:] sites such as JSLinux, or a free cloud VM, if you are
  on a borrowed computer.

== 2.6 Package manager comparison
<package-manager-comparison>
#table(
  columns: (auto,)*2 + (1fr,),
  align: (col, row) => (auto,auto,auto,).at(col),
  inset: (x: 7pt, y: 5pt),
  [Task], [Fedora (dnf)], [Ubuntu (apt)],
  [Refresh list],
  [`sudo dnf check-update`],
  [`sudo apt update`],
  [Upgrade all],
  [`sudo dnf upgrade`],
  [`sudo apt upgrade`],
  [Install],
  [`sudo dnf install pkg`],
  [`sudo apt install pkg`],
  [Remove],
  [`sudo dnf remove pkg`],
  [`sudo apt remove pkg`],
  [Search],
  [`dnf search word`],
  [`apt search word`],
  [Info],
  [`dnf info pkg`],
  [`apt show pkg`],
  [Installed list],
  [`dnf list --installed`],
  [`apt list --installed`],
)

== 2.7 Choosing a text editor
<choosing-a-text-editor>
#table(
  columns: (auto,)*2 + (1fr,),
  align: (col, row) => (auto,auto,auto,).at(col),
  inset: (x: 7pt, y: 5pt),
  [Editor], [Start with], [Good for],
  [`nano`],
  [`nano file.sh`],
  [Beginners. Save: Ctrl+O, Enter. Exit: Ctrl+X.],
  [`vim`],
  [`vim file.sh`],
  [Fast, everywhere on servers. Press `i` to type, `Esc` then `:wq` to
  save and quit.],
  [Kate],
  [from launcher],
  [KDE\'s graphical editor, syntax colours],
  [VS Code],
  [`code file.sh`],
  [With the ShellCheck extension, shows errors live],
)

#callout("bangla", "বাংলা নোট")[
প্রথমে `nano` দিয়ে শুরু করুন। পরে সার্ভারে কাজ করতে গেলে `vim` এর বেসিক (`i`,
`Esc`, `:wq`, `:q!`) শিখে নিন।

]
== 2.8 Create your practice folder
<create-your-practice-folder>
```bash
$ mkdir -p ~/practice/scripts
$ cd ~/practice
$ pwd
/home/rahim/practice
```

#callout("practice", "Practice 2")[
Install `tree` and `bc`, then run `tree ~/practice` and
`echo "2.5 * 4" | bc`.

]
#part-page("II", "Everyday Commands")
#chapter-heading("3", "First Commands and Navigation")
Every command has the same shape: #strong[command, then options, then
arguments], separated by spaces.

```
ls      -l       /home
│       │        └── argument: what to work on
│       └── option (flag): how to work
└── command: what to do
```

#callout("space", "Space check")[
The spaces between parts are required. `ls -l` works; `ls-l` gives
`bash: ls-l: command not found`, because Bash looks for a command
literally named `ls-l`.

]
== 3.1 Who and where am I?
<who-and-where-am-i>
```bash
$ whoami          # prints your username
rahim
$ hostname        # prints the computer name
fedora
$ pwd             # Print Working Directory: where you are now
/home/rahim
$ date            # current date and time
$ cal             # calendar of this month (install: dnf install util-linux / ncal on Ubuntu)
$ uptime          # how long the system has been running
$ clear           # clears the screen (shortcut: Ctrl+L)
```

== 3.2 `ls`: list files
<ls-list-files>
```bash
$ ls              # list files in the current folder
$ ls -l           # long format: permissions, owner, size, date
$ ls -a           # all files, including hidden ones (names starting with .)
$ ls -la          # combine options: long + all
$ ls -lh          # human-readable sizes (4.0K, 2.1M)
$ ls -lt          # sort by time, newest first
$ ls -lS          # sort by size, biggest first
$ ls -R           # recursive: also list inside sub-folders
$ ls /etc         # list a different folder without going there
```

Reading `ls -l` output:

```
-rw-r--r--. 1 rahim rahim 1024 Nov 23 10:00 notes.txt
│└─┬─┘└┬┘ │ └─┬─┘ └─┬─┘ └┬┘  └───┬────┘ └─ name
│  │   │   │   │     │     │       └─ last modified
│  │   │   │   │     │     └─ size in bytes
│  │   │   │   │     └─ group
│  │   │   │   └─ owner
│  │   │   └─ number of hard links
│  │   └─ others' permissions (r--)
│  └─ owner (rw-) and group (r--) permissions
└─ type: - file, d directory, l link
```

The `.` after the permissions on Fedora means the file has an SELinux
label. Ubuntu does not show it.

== 3.3 `cd`: change directory
<cd-change-directory>
```bash
$ cd /etc         # go to /etc (absolute path)
$ cd ..           # go up one level (parent folder)
$ cd ../..        # go up two levels
$ cd ~            # go home (/home/rahim)
$ cd              # also goes home
$ cd -            # go back to the previous folder
$ cd practice     # go into practice (relative path, from where you are)
```

#table(
  columns: (auto,)*1 + (1fr,),
  align: (col, row) => (auto,auto,).at(col),
  inset: (x: 7pt, y: 5pt),
  [Symbol], [Meaning],
  [`/`],
  [Root of the tree (at the start of a path) or separator (between
  names)],
  [`~`],
  [Your home folder],
  [`.`],
  [The current folder],
  [`..`],
  [The parent folder],
  [`-`],
  [The previous folder (only with `cd`)],
)

#strong[Absolute vs relative path]

- #strong[Absolute] starts with `/` and works from anywhere:
  `/home/rahim/practice`
- #strong[Relative] starts from where you are now: `practice/scripts`

#callout("space", "Space check")[

`cd /tmp` → works.

`cd/tmp` → `bash: cd/tmp: No such file or directory` (Bash treats
`cd/tmp` as a path to a program).

`cd My Folder` → `bash: cd: too many arguments`. Fix: `cd "My Folder"`
or `cd My\ Folder`.

]
== 3.4 Getting help
<getting-help>
```bash
$ man ls          # full manual page (q to quit, /word to search, n for next match)
$ ls --help       # short help built into most commands
$ help cd         # help for Bash built-in commands like cd, echo, read
$ type cd         # tells whether something is a builtin, alias or program
cd is a shell builtin
$ type ls
ls is aliased to `ls --color=auto'
$ which bash      # shows the full path of a program
/usr/bin/bash
$ whatis ls       # one-line description
$ apropos copy    # search manual pages by keyword
```

#callout("why", "Why?")[
#strong[Why `help` and `man` both?] Built-ins like `cd` live inside Bash
itself, so they have no separate manual; `help` documents them. External
programs like `ls` are documented with `man`.

]
== 3.5 Keyboard shortcuts that save hours
<keyboard-shortcuts-that-save-hours>
#table(
  columns: (auto,)*1 + (1fr,),
  align: (col, row) => (auto,auto,).at(col),
  inset: (x: 7pt, y: 5pt),
  [Key], [Action],
  [Tab],
  [Auto-complete a command or file name (press twice to see options)],
  [↑ / ↓],
  [Previous / next command from history],
  [Ctrl + R],
  [Search history (type part of an old command)],
  [Ctrl + C],
  [Stop the running command],
  [Ctrl + D],
  [End input / log out of the shell],
  [Ctrl + L],
  [Clear the screen],
  [Ctrl + A / Ctrl + E],
  [Jump to start / end of the line],
  [Ctrl + U / Ctrl + K],
  [Delete before / after the cursor],
  [Ctrl + W],
  [Delete the previous word],
  [Ctrl + Shift + C / V],
  [Copy / paste inside the terminal],
)

== 3.6 History
<history>
```bash
$ history         # numbered list of your past commands
$ !!              # run the last command again
$ sudo !!         # run the last command again with sudo (very useful)
$ !25             # run command number 25 from history
$ !ls             # run the latest command that started with ls
```

== 3.7 Aliases: your own short commands
<aliases-your-own-short-commands>
```bash
$ alias ll='ls -lah'      # create (no spaces around =)
$ ll                     # now works like ls -lah
$ unalias ll             # remove it
```

To keep an alias forever, add the line to `~/.bashrc`, then run
`source ~/.bashrc`.

#callout("mistake", "Common mistake")[
`alias ll = 'ls -lah'` gives three errors: `bash: alias: ll: not found`,
`bash: alias: =: not found` and `bash: alias: ls -lah: not found`. There
must be #strong[no spaces around `=`]. You will see this rule again and
again in Chapter 11.

]
#callout("practice", "Practice 3")[
(a) From your home folder, go to `/var/log` using an absolute path, then
come back with `cd -`. (b) Show all hidden files in your home folder in
long, human-readable format. (c) Make an alias `c` for `clear`.

]
#chapter-heading("4", "Working with Files and Directories")
These commands create, copy, move, view, find and delete files. They are
the ones you will use every day.

== 4.1 Create
<create>
```bash
$ touch notes.txt            # create an empty file (or update its time if it exists)
$ touch a.txt b.txt c.txt    # create three files at once
$ mkdir projects             # make a directory
$ mkdir -p a/b/c             # -p = make parents too, no error if they exist
$ echo "Hello" > hello.txt   # create a file with content
```

#callout("why", "Why?")[
#strong[Why `-p`?] Without it, `mkdir a/b/c` fails with
`mkdir: cannot create directory 'a/b/c': No such file or directory`
because `a` and `a/b` do not exist yet.

]
== 4.2 Copy, move, rename
<copy-move-rename>
```bash
$ cp a.txt backup.txt          # copy a file
$ cp a.txt projects/           # copy into a folder
$ cp -r projects projects_bak  # -r = recursive: copy a whole folder
$ cp -i a.txt b.txt            # -i = ask before overwriting
$ cp -v a.txt d.txt            # -v = verbose: show what happened
$ mv a.txt projects/           # move a file
$ mv b.txt bravo.txt           # rename (moving to a new name = renaming)
```

#callout("mistake", "Common mistake")[
`cp a.txt` alone gives
`cp: missing destination file operand after 'a.txt'`. `cp` and `mv`
always need a source #strong[and] a destination.

]
== 4.3 Delete (careful!)
<delete-careful>
```bash
$ rm c.txt                   # delete a file (no Recycle Bin!)
$ rm -i *.txt                # ask before each delete
$ rmdir emptyfolder          # delete an EMPTY folder only
$ rm -r projects_bak         # delete a folder and everything inside
$ rm -rf build/              # -f = force, no questions. Dangerous.
```

`rmdir a` on a folder with files inside gives
`rmdir: failed to remove 'a': Directory not empty`. That is a safety
feature.

#callout("danger", "Space check · danger")[
`rm -rf /home/rahim/tmp` deletes one folder. `rm -rf /home/rahim/ tmp`
(one extra space) deletes your #strong[entire home folder] and then a
folder called `tmp`. Always read `rm -rf` lines twice before pressing
Enter.

]
#callout("bangla", "বাংলা নোট")[
Linux-এ `rm` করলে ফাইল Trash-এ যায় না, সরাসরি মুছে যায়। তাই শুরুতে `rm -i`
ব্যবহার করুন।

]
== 4.4 View file contents
<view-file-contents>
```bash
$ cat hello.txt              # print the whole file
$ cat -n hello.txt           # with line numbers
$ tac hello.txt              # print in reverse line order
$ less /var/log/dnf.log      # scroll page by page (q quit, / search, G end, g start)
$ head file.txt              # first 10 lines
$ head -n 3 file.txt         # first 3 lines
$ tail file.txt              # last 10 lines
$ tail -n 5 file.txt         # last 5 lines
$ tail -f /var/log/messages  # follow: keep showing new lines (Ctrl+C to stop)
$ file photo.jpg             # tells the real type of a file
photo.jpg: JPEG image data ...
$ stat notes.txt             # size, permissions, all timestamps
```

#callout("why", "Why?")[
#strong[Why `less` and not `cat` for big files?] `cat` dumps everything
at once; `less` lets you scroll and search page by page.

]
== 4.5 Wildcards (globbing)
<wildcards-globbing>
The shell expands these patterns into matching file names #emph[before]
the command runs.

#table(
  columns: (auto,)*2 + (1fr,),
  align: (col, row) => (auto,auto,auto,).at(col),
  inset: (x: 7pt, y: 5pt),
  [Pattern], [Matches], [Example],
  [`*`],
  [Any characters (zero or more)],
  [`ls *.txt`],
  [`?`],
  [Exactly one character],
  [`ls file?.txt` → file1.txt, fileA.txt],
  [`[abc]`],
  [One of a, b or c],
  [`ls [ab]*.txt`],
  [`[0-9]`],
  [One digit],
  [`ls report[0-9].pdf`],
  [`{a,b}`],
  [Brace expansion: each word],
  [`touch {mon,tue,wed}.log`],
  [`{1..5}`],
  [A range],
  [`mkdir week{1..5}`],
)

== 4.6 Finding files
<finding-files>
```bash
$ find . -name "*.sh"              # all .sh files under current folder
$ find ~ -iname "notes*"           # -iname = ignore upper/lower case
$ find . -type d                   # only directories (-type f = only files)
$ find /var/log -size +10M         # files bigger than 10 MB
$ find . -mtime -1                 # changed in the last 1 day
$ find . -name "*.tmp" -delete     # find and delete
$ find . -name "*.sh" -exec chmod +x {} \;   # run a command on each result
$ locate passwd                    # super-fast search from a database (sudo updatedb first)
```

#callout("space", "Space check")[
In `-exec ... {} \;` there must be a space before `\;`. Writing `{}\;`
joins them into one word and `find` complains:
`find: missing argument to '-exec'`.

]
== 4.7 Links
<links>
```bash
$ ln -s /home/rahim/practice ~/p   # symbolic (soft) link: a shortcut
$ ln original.txt hard.txt         # hard link: another name for the same data
$ ls -l ~/p
lrwxrwxrwx. 1 rahim rahim ... p -> /home/rahim/practice
```

#table(
  columns: (auto,)*2 + (1fr,),
  align: (col, row) => (auto,auto,auto,).at(col),
  inset: (x: 7pt, y: 5pt),
  [], [Soft link (`ln -s`)], [Hard link (`ln`)],
  [Works for folders],
  [Yes],
  [No],
  [Across disks/partitions],
  [Yes],
  [No],
  [If original is deleted],
  [Link breaks],
  [Data still exists],
  [Same inode number],
  [No],
  [Yes],
)

== 4.8 Compress and archive
<compress-and-archive>
```bash
$ tar -cvf backup.tar projects/       # c=create v=verbose f=file name
$ tar -czvf backup.tar.gz projects/   # z = gzip compress
$ tar -tzvf backup.tar.gz             # t = list contents
$ tar -xzvf backup.tar.gz             # x = extract
$ tar -xzvf backup.tar.gz -C /tmp     # extract into /tmp
$ zip -r site.zip site/               # zip a folder
$ unzip site.zip                      # unzip
$ gzip big.log                        # compress one file -> big.log.gz
$ gunzip big.log.gz                   # decompress
```

#callout("tip", "Tip")[
Remember tar letters as: #strong[c]reate, e#strong[x]tract,
#strong[t]able (list), #strong[z]ip, #strong[v]erbose, #strong[f]ile.

]
#callout("practice", "Practice 4")[
(a) Create `~/practice/demo/{docs,img,src}` in one command. (b) Create
10 files `file1.txt` … `file10.txt` in one command. (c) Find every
`.txt` file in `~/practice` and archive the folder as `demo.tar.gz`.

]
#chapter-heading("5", "Permissions, Users and Groups")
Every file has an owner, a group, and three sets of permissions. Linux
checks these before letting anyone read, change or run a file.

== 5.1 Reading permissions
<reading-permissions>
```
- rwx r-x r--
│  │   │   └── others (everyone else)
│  │   └── group
│  └── user (owner)
└── type (- file, d directory, l link)
```

#table(
  columns: (auto,)*3 + (1fr,),
  align: (col, row) => (auto,auto,auto,auto,).at(col),
  inset: (x: 7pt, y: 5pt),
  [Letter], [On a file], [On a directory], [Number],
  [`r`],
  [Read the content],
  [List the names inside (`ls`)],
  [4],
  [`w`],
  [Change the content],
  [Create/delete files inside],
  [2],
  [`x`],
  [Run it as a program],
  [Enter it (`cd`)],
  [1],
  [`-`],
  [Permission not given],
  [Permission not given],
  [0],
)

== 5.2 `chmod` with numbers
<chmod-with-numbers>
Add the numbers for each group: r(4) + w(2) + x(1).

#table(
  columns: (auto,)*2 + (1fr,),
  align: (col, row) => (auto,auto,auto,).at(col),
  inset: (x: 7pt, y: 5pt),
  [Number], [Letters], [Meaning],
  [7],
  [rwx],
  [4+2+1, everything],
  [6],
  [rw-],
  [4+2, read and write],
  [5],
  [r-x],
  [4+1, read and run],
  [4],
  [r--],
  [read only],
  [0],
  [---],
  [nothing],
)

```bash
$ chmod 755 script.sh    # rwxr-xr-x  owner all, others read+run (scripts, folders)
$ chmod 644 notes.txt    # rw-r--r--  owner read+write, others read (normal files)
$ chmod 600 secret.txt   # rw-------  only owner (private keys, passwords)
$ chmod 700 private/     # rwx------  private folder
$ chmod -R 755 site/     # -R = apply to everything inside too
```

#callout("space", "Space check")[
The three digits are #strong[one] argument. `chmod 754 u.txt` gives
`-rwxr-xr--`. `chmod 7 5 4 u.txt` treats `5` and `4` as file names:
`chmod: cannot access '5': No such file or directory`.

]
== 5.3 `chmod` with letters (symbolic)
<chmod-with-letters-symbolic>
Who: `u` user, `g` group, `o` others, `a` all. Action: `+` add, `-`
remove, `=` set exactly.

```bash
$ chmod +x script.sh      # add run permission for everyone
$ chmod u+x script.sh     # add run permission for owner only
$ chmod g-w file.txt      # remove write from group
$ chmod o=r file.txt      # others: exactly read only
$ chmod u=rwx,g=rx,o= f   # same as 750
```

Real test: a file with 754 (`-rwxr-xr--`) after `chmod u-x,g+w` becomes
`-rw-rwxr--`.

#callout("space", "Space check")[
In `u-x,g+w` there must be #strong[no space after the comma].

]
== 5.4 Default permissions: `umask`
<default-permissions-umask>
```bash
$ umask
0022
```

New files start from 666 and new folders from 777; umask removes bits.
With 022: files become 644 (`-rw-r--r--`), folders 755 (`drwxr-xr-x`).

== 5.5 Owners and groups
<owners-and-groups>
```bash
$ id                          # your user ID, group ID and groups
uid=1000(rahim) gid=1000(rahim) groups=1000(rahim),10(wheel)
$ groups                      # just the group names
$ sudo chown karim file.txt   # change owner
$ sudo chown karim:dev file.txt   # change owner and group
$ sudo chgrp dev file.txt     # change group only
$ sudo chown -R rahim: site/  # whole folder
```

== 5.6 `sudo` and root
<sudo-and-root>
- `root` is the all-powerful admin user (UID 0).
- `sudo command` runs one command as root after asking #strong[your]
  password.
- On Fedora, users in the `wheel` group can use sudo. On Ubuntu, it is
  the `sudo` group.
- `sudo -i` opens a root shell (prompt changes to `#`). Type `exit` to
  leave.

#callout("why", "Why?")[
#strong[Why sudo instead of logging in as root?] It limits damage: you
are admin only for one command, and every sudo use is logged.

]
== 5.7 Managing users (admin tasks)
<managing-users-admin-tasks>
```bash
$ sudo useradd -m -s /bin/bash karim   # -m create home folder, -s set shell
$ sudo passwd karim                    # set password
$ sudo usermod -aG wheel karim         # -aG = append to group (Fedora sudo access)
$ sudo groupadd dev                    # new group
$ sudo userdel -r karim                # delete user and their home folder
$ su - karim                           # switch user
$ cat /etc/passwd | tail -3            # user list
$ sudo cat /etc/shadow                 # hashed passwords (root only)
```

#callout("mistake", "Common mistake")[
`usermod -G wheel karim` (without `-a`) #strong[replaces] all of
Karim\'s groups. Always use `-aG` to add.

]
== 5.8 Special permissions (advanced)
<special-permissions-advanced>
#table(
  columns: (auto,)*3 + (1fr,),
  align: (col, row) => (auto,auto,auto,auto,).at(col),
  inset: (x: 7pt, y: 5pt),
  [Bit], [Number], [Effect], [Example],
  [SUID],
  [4000],
  [Program runs with the owner\'s power],
  [`/usr/bin/passwd` (`-rwsr-xr-x`)],
  [SGID],
  [2000],
  [New files in a folder get the folder\'s group],
  [Shared team folder],
  [Sticky],
  [1000],
  [Only the owner can delete their files in the folder],
  [`/tmp` (`drwxrwxrwt`)],
)

#callout("bangla", "বাংলা নোট")[
755, 644, 600 — এই তিনটা সংখ্যা মুখস্থ করুন। Viva ও interview-এ প্রায়ই
জিজ্ঞাসা করে।

]
#callout("practice", "Practice 5")[
(a) Make a file readable and writable only by you. (b) Convert
`rwxr-x---` to a number. (c) Why does a folder need `x` permission?

]
#chapter-heading("6", "Processes and Jobs")
A process is a running program. You can list, pause, move to the
background, and stop processes from the shell.

== 6.1 Seeing processes
<seeing-processes>
```bash
$ ps                  # processes in this terminal only
$ ps aux              # ALL processes: a=all users, u=user format, x=no terminal too
$ ps -ef              # same idea, another format (shows parent PID, PPID)
$ ps aux | grep firefox   # find a specific process
$ pgrep -l firefox    # PIDs of processes named firefox
$ pstree              # processes as a family tree
$ top                 # live view (q to quit, P sort by CPU, M sort by memory)
$ htop                # nicer live view (install first)
$ echo $$             # PID of your current shell
```

Important `ps aux` columns: #strong[USER] owner, #strong[PID] id,
#strong[%CPU], #strong[%MEM], #strong[STAT] state, #strong[COMMAND].

#table(
  columns: (auto,)*1 + (1fr,),
  align: (col, row) => (auto,auto,).at(col),
  inset: (x: 7pt, y: 5pt),
  [STAT], [Meaning],
  [R],
  [Running],
  [S],
  [Sleeping (waiting for something)],
  [D],
  [Waiting for disk (cannot be killed easily)],
  [T],
  [Stopped (paused)],
  [Z],
  [Zombie (finished, but parent has not collected it)],
)

== 6.2 Process states (OS theory, short)
<process-states-os-theory-short>
A process moves through: #strong[New → Ready → Running → (Waiting) →
Ready … → Terminated]. The OS #strong[scheduler] decides which Ready
process gets the CPU next. Linux uses a fair scheduler (CFS/EEVDF) that
gives each process a fair share of CPU time.

== 6.3 Signals and `kill`
<signals-and-kill>
A signal is a message sent to a process. `kill` sends signals (it does
not always \"kill\").

#table(
  columns: (auto,)*3 + (1fr,),
  align: (col, row) => (auto,auto,auto,auto,).at(col),
  inset: (x: 7pt, y: 5pt),
  [Signal], [Number], [Meaning], [Can the process ignore it?],
  [SIGHUP],
  [1],
  [Terminal closed / reload config],
  [Yes],
  [SIGINT],
  [2],
  [Interrupt (same as Ctrl+C)],
  [Yes],
  [SIGKILL],
  [9],
  [Kill immediately],
  [#strong[No]],
  [SIGTERM],
  [15],
  [Please terminate (default)],
  [Yes],
  [SIGSTOP],
  [19],
  [Pause],
  [#strong[No]],
  [SIGCONT],
  [18],
  [Continue after pause],
  [-],
)

```bash
$ kill 4821           # send SIGTERM (polite request)
$ kill -9 4821        # force kill (use only if polite kill fails)
$ kill -l             # list all signal names
$ pkill firefox       # kill by name
$ killall firefox     # kill all processes with that name
```

#callout("why", "Why?")[
#strong[Why try `kill` before `kill -9`?] SIGTERM lets the program save
files and clean up. SIGKILL stops it instantly, which can leave
half-written files.

]
== 6.4 Foreground, background and jobs
<foreground-background-and-jobs>
```bash
$ sleep 100 &         # & = run in background, shell is free immediately
[1] 482               # [job number] PID
$ jobs                # list background jobs
[1]+  Running                 sleep 100 &
$ fg %1               # bring job 1 to the foreground
# press Ctrl+Z        # pause the foreground job
[1]+  Stopped                 sleep 100
$ bg %1               # continue it in the background
$ kill %1             # kill job 1
$ echo $!             # PID of the last background command
```

#callout("space", "Space check")[
`sleep 100 &` and `sleep 100&` both work, because `&` is a special
operator. But `&&` (\"and then\") is different from `&`: `make && ./app`
runs `./app` only if `make` succeeds.

]
== 6.5 Keep running after logout
<keep-running-after-logout>
```bash
$ nohup ./long_task.sh &          # ignores SIGHUP; output goes to nohup.out
$ nohup ./long_task.sh > log.txt 2>&1 &
```

For long server work, use `tmux` or `screen`: start a session, detach
(`Ctrl+B D` in tmux), log out, come back later with `tmux attach`.

== 6.6 Priority: `nice` and `renice`
<priority-nice-and-renice>
Nice values run from #strong[-20] (highest priority) to #strong[19]
(lowest). Default is 0.

```bash
$ nice -n 10 ./backup.sh          # start with lower priority
$ sudo renice -n -5 -p 4821       # raise priority of a running process
```

== 6.7 Services with `systemctl` (systemd)
<services-with-systemctl-systemd>
```bash
$ systemctl status sshd           # is the SSH service running?
$ sudo systemctl start sshd       # start now
$ sudo systemctl stop sshd        # stop now
$ sudo systemctl restart sshd     # stop + start
$ sudo systemctl enable sshd      # start automatically at boot
$ sudo systemctl disable sshd     # do not start at boot
$ systemctl list-units --type=service --state=running
$ journalctl -u sshd -n 20        # last 20 log lines of the service
$ journalctl -f                   # follow all system logs live
```

#callout("note", "Note")[
On Ubuntu the SSH service is called `ssh`; on Fedora it is `sshd`.

]
#callout("bangla", "বাংলা নোট")[
Ctrl+C \= প্রোগ্রাম বন্ধ, Ctrl+Z \= প্রোগ্রাম বিরতি (pause)। Ctrl+Z দিলে
প্রোগ্রাম বন্ধ হয় না, background-এ থেমে থাকে — `jobs` দিয়ে দেখুন।

]
#callout("practice", "Practice 6")[
(a) Start `sleep 300` in the background, list it, bring it to the
foreground, pause it with Ctrl+Z, then kill it. (b) Find the PID of your
Bash shell. (c) Which signal cannot be ignored?

]
#chapter-heading("7", "Redirection, Pipes and Filters")
Every command has three data streams. Redirection sends them to files;
pipes send one command\'s output into another command.

== 7.1 The three streams
<the-three-streams>
#table(
  columns: (auto,)*3 + (1fr,),
  align: (col, row) => (auto,auto,auto,auto,).at(col),
  inset: (x: 7pt, y: 5pt),
  [Stream], [Number], [Default], [Example],
  [stdin (standard input)],
  [0],
  [Keyboard],
  [`read name` waits for your typing],
  [stdout (standard output)],
  [1],
  [Screen],
  [Normal results of `ls`],
  [stderr (standard error)],
  [2],
  [Screen],
  [Error messages],
)

== 7.2 Redirection operators
<redirection-operators>
```bash
$ ls -l > list.txt         # stdout to file (OVERWRITES the file)
$ echo "line" >> log.txt   # stdout to file (APPENDS at the end)
$ wc -l < people.csv       # stdin FROM a file
3
$ ls nofile 2> err.txt     # only errors to file
$ ls nofile 2>/dev/null    # throw errors away (/dev/null = black hole)
$ cmd > out.txt 2>&1       # stdout AND stderr to the same file
$ cmd &> out.txt           # short Bash form of the line above
$ cmd > /dev/null 2>&1     # completely silent
```

#callout("why", "Why?")[
#strong[Why `2>&1` comes after `> out.txt`:] Bash reads left to right.
First stdout goes to the file, then \"send 2 to wherever 1 is going
now\" (the file). Writing `2>&1 > out.txt` sends errors to the screen.

]
#callout("space", "Space check")[
`2>` must be written #strong[together].

`ls nofile 2>err.txt` → error saved in err.txt, screen is quiet.

`ls nofile 2 >err.txt` → Bash thinks `2` is a file name for `ls`, and
`>` redirects stdout. Real output on screen:

`ls: cannot access 'nofile': No such file or directory`

`ls: cannot access '2': No such file or directory`

Spaces around a plain `>` are optional: `echo hi>a.txt` and
`echo hi > a.txt` both work.

]
== 7.3 Here document and here string
<here-document-and-here-string>
```bash
$ cat << EOF > info.txt     # write several lines into a file
Name: Rahim
City: Dhaka
EOF
$ tr a-z A-Z <<< "hello"   # here string: give one string as input
HELLO
```

#callout("space", "Space check")[
The closing `EOF` must be alone on its line with #strong[no spaces
before it]. A line `EOF` (with a leading space) is treated as normal
text, and Bash keeps waiting for the real end.

]
== 7.4 Pipes `|`
<pipes>
A pipe connects stdout of the left command to stdin of the right
command.

```bash
$ ls | wc -l                       # how many files?
$ ps aux | grep bash               # find bash processes
$ cat /etc/passwd | cut -d: -f1    # all usernames
$ history | tail -5                # last 5 commands
$ du -sh * | sort -h | tail -3     # 3 biggest items here
```

`ls|wc -l` and `ls | wc -l` give the same result; spaces around `|` are
optional but make code easier to read.

== 7.5 Filter commands
<filter-commands>
Sample file used below (`fruits.txt`): apple, banana, apple, cherry,
banana, apple (one per line). And `people.csv`:

```
rahim,25,Dhaka
karim,30,Khulna
sumi,22,Dhaka
```

#table(
  columns: (auto,)*2 + (1fr,),
  align: (col, row) => (auto,auto,auto,).at(col),
  inset: (x: 7pt, y: 5pt),
  [Command], [What it does], [Example],
  [`sort`],
  [Sorts lines],
  [`sort -r` reverse, `sort -n` numeric, `sort -t, -k2 -n` by 2nd
  column],
  [`uniq`],
  [Removes #strong[adjacent] duplicates (sort first!)],
  [`sort f \| uniq -c` counts],
  [`cut`],
  [Takes columns],
  [`cut -d, -f1,3 people.csv`],
  [`tr`],
  [Translates/deletes characters],
  [`tr a-z A-Z`, `tr -d '0-9'`, `tr -s ' '`],
  [`wc`],
  [Counts lines, words, bytes],
  [`wc -l`, `wc -w`, `wc -c`],
  [`tee`],
  [Writes to screen AND file],
  [`cmd \| tee out.txt`],
  [`head`/`tail`],
  [First / last lines],
  [`head -n 2`],
  [`paste`],
  [Joins files side by side],
  [`paste names.txt marks.txt`],
  [`xargs`],
  [Turns input into arguments],
  [`find . -name '*.log' \| xargs rm`],
)

#strong[Real outputs]

```bash
$ sort fruits.txt | uniq -c | sort -nr     # word frequency
      3 apple
      2 banana
      1 cherry
$ cut -d, -f1,3 people.csv
rahim,Dhaka
karim,Khulna
sumi,Dhaka
$ echo "hello world" | tr a-z A-Z
HELLO WORLD
$ echo "hello   world" | tr -s " "        # squeeze repeated spaces
hello world
$ wc people.csv
 3  3 45 people.csv                        # lines words bytes
$ echo one | tee t.txt | tr a-z A-Z
ONE                                        # and t.txt contains: one
```

#callout("space", "Space check")[
`cut -d, -f1` and `cut -d , -f 1` both work (the option value may be
joined or separated). But a delimiter that #strong[is] a space must be
quoted: `cut -d ' ' -f2`.

]
#callout("practice", "Practice 7")[
(a) Save the list of files in `/etc` to `etc.txt`, then count its lines.
(b) Run a command that fails and save only the error. (c) From
`/etc/passwd`, print just the usernames, sorted A–Z.

]
#chapter-heading("8", "Text Power Tools: grep, Regex, sed, awk")
`grep` finds lines, `sed` edits lines, and `awk` works with columns.
Together they solve most text and log problems. All examples use
`people.csv` from Chapter 7.

== 8.1 `grep`: search for text
<grep-search-for-text>
```bash
$ grep Dhaka people.csv          # lines containing Dhaka
rahim,25,Dhaka
sumi,22,Dhaka
$ grep -i DHAKA people.csv       # -i ignore case (same result)
$ grep -v Dhaka people.csv       # -v invert: lines NOT containing Dhaka
karim,30,Khulna
$ grep -c Dhaka people.csv       # -c count matching lines
2
$ grep -n karim people.csv       # -n show line numbers
2:karim,30,Khulna
$ grep -r "TODO" ~/practice      # -r search inside all files in a folder
$ grep -l "main" *.c             # -l only file names
$ grep -w "cat" file.txt         # -w whole word (not "category")
$ grep -A2 -B1 "ERROR" app.log   # 2 lines After and 1 Before each match
```

== 8.2 Regular expressions (regex)
<regular-expressions-regex>
A regex is a pattern that describes text. Use `grep -E` for extended
regex.

#table(
  columns: (auto,)*3 + (1fr,),
  align: (col, row) => (auto,auto,auto,auto,).at(col),
  inset: (x: 7pt, y: 5pt),
  [Symbol], [Meaning], [Example], [Matches],
  [`.`],
  [Any one character],
  [`c.t`],
  [cat, cut, c9t],
  [`*`],
  [Previous item 0+ times],
  [`ab*c`],
  [ac, abc, abbbc],
  [`+`],
  [Previous item 1+ times (-E)],
  [`ab+c`],
  [abc, abbc],
  [`?`],
  [Previous item 0 or 1 time (-E)],
  [`colou?r`],
  [color, colour],
  [`^`],
  [Start of line],
  [`^root`],
  [lines starting with root],
  [`$`],
  [End of line],
  [`sh$`],
  [lines ending with sh],
  [`[abc]`],
  [One of these],
  [`[rk]`],
  [r or k],
  [`[^abc]`],
  [NOT one of these],
  [`[^0-9]`],
  [a non-digit],
  [`[0-9]` / `[a-z]`],
  [Ranges],
  [`[A-Z]`],
  [capital letter],
  [`{n}` / `{n,m}`],
  [Exactly n / n to m times (-E)],
  [`[0-9]{3}`],
  [three digits],
  [`\|` (with -E)],
  [OR],
  [`cat\|dog`],
  [cat or dog],
  [`( )`],
  [Group (-E)],
  [`(ab)+`],
  [ab, abab],
  [`\b`],
  [Word boundary],
  [`\bis\b`],
  [\"is\" as a word],
)

```bash
$ grep -E '^[rk]' people.csv                 # names starting with r or k
rahim,25,Dhaka
karim,30,Khulna
$ grep -E '^[0-9]{11}$' phones.txt           # exactly 11 digits (BD mobile)
$ grep -E '^01[3-9][0-9]{8}$' phones.txt     # valid BD mobile format
$ grep -E '[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-z]{2,}' contacts.txt   # emails
$ grep -E '([0-9]{1,3}\.){3}[0-9]{1,3}' access.log                      # IP addresses
```

#callout("why", "Why?")[
#strong[Why quote the pattern?] Without quotes, the shell may treat `*`,
`?` or `[ ]` as file wildcards and change your pattern before grep sees
it. Always write `grep 'pattern'`.

]
== 8.3 `sed`: stream editor
<sed-stream-editor>
```bash
$ sed 's/Dhaka/Chattogram/' people.csv        # s = substitute (first match per line)
rahim,25,Chattogram
karim,30,Khulna
sumi,22,Chattogram
$ sed 's/a/A/g' file.txt        # g = global: every match on the line
$ sed -n '2p' people.csv        # print only line 2  (-n = do not print others)
karim,30,Khulna
$ sed '1d' people.csv           # delete line 1
$ sed '/^#/d' config.txt        # delete comment lines
$ sed '/^$/d' file.txt          # delete empty lines
$ sed -n '2,4p' file.txt        # print lines 2 to 4
$ sed -i 's/old/new/g' file.txt   # -i = edit the file in place (careful!)
$ sed -i.bak 's/old/new/g' file.txt   # in place, but keep file.txt.bak as backup
```

#callout("space", "Space check")[
`s/old/new/` has no spaces. If you write `s/ old / new /`, sed searches
for \" old \" with the spaces included, which often matches nothing.

]
== 8.4 `awk`: column processing language
<awk-column-processing-language>
awk reads a line, splits it into fields `$1, $2, …` (`$0` \= whole
line), and runs your code. `NR` \= line number, `NF` \= number of
fields, `-F` \= field separator.

```bash
$ awk -F, '{print $1, $2}' people.csv          # columns 1 and 2
rahim 25
karim 30
sumi 22
$ awk -F, '$2 > 23 {print $1}' people.csv      # condition: age above 23
rahim
karim
$ awk -F, '{sum += $2} END {print "Total:", sum, "Avg:", sum/NR}' people.csv
Total: 77 Avg: 25.6667
$ awk -F, 'NR==2' people.csv                   # only line 2
$ awk '{print NF}' file.txt                    # words per line
$ awk -F: '{print $1}' /etc/passwd             # usernames
$ awk 'BEGIN {print "Name Age"} {print $1, $2}' data.txt
```

Structure: `awk 'BEGIN { before } pattern { action } END { after }'`

#callout("mistake", "Common mistake")[
awk code must be in #strong[single quotes]. With double quotes, Bash
replaces `$1` with its own (empty) variable before awk ever runs.

]
#callout("bangla", "বাংলা নোট")[
grep \= খোঁজা, sed \= বদলানো, awk \= কলাম ধরে হিসাব করা। Log file
analysis-এ এই তিনটা সবচেয়ে বেশি ব্যবহার হয়।

]
#callout("practice", "Practice 8")[
(a) Print all users in `/etc/passwd` whose shell is `/bin/bash`. (b)
Replace every `,` in `people.csv` with a tab. (c) Print the name of the
oldest person using awk.

]
#chapter-heading("9", "System, Disk, Network and Packages")
These commands answer the questions an admin asks every day: what system
is this, how full is the disk, is the network working?

== 9.1 System information
<system-information>
```bash
$ uname -a                 # kernel name, version, architecture
$ uname -r                 # kernel release only
$ cat /etc/os-release      # distribution name and version
$ hostnamectl              # hostname, OS, kernel (systemd systems)
$ lscpu                    # CPU details
$ nproc                    # number of CPU cores
$ lsblk                    # disks and partitions as a tree
$ lsusb ; lspci            # USB and PCI devices
$ uptime                   # running time and load average
$ last -n 5                # last 5 logins
$ w                        # who is logged in and what they are doing
```

== 9.2 Memory and disk
<memory-and-disk>
```bash
$ free -h                  # RAM and swap usage, human readable
$ df -h                    # free space on each mounted file system
$ df -h /home              # only the partition holding /home
$ du -sh ~/Downloads       # total size of one folder (-s summary)
$ du -h --max-depth=1 ~ | sort -h    # size of each folder in home, sorted
$ sudo mount /dev/sdb1 /mnt          # attach a disk
$ sudo umount /mnt                   # detach it
```

#callout("why", "Why?")[
#strong[Why both `df` and `du`?] `df` asks the file system \"how much
space is free on this disk?\" `du` adds up file sizes \"how much does
this folder use?\"

]
#strong[OS theory: memory in one minute.] Each process gets its own
#strong[virtual memory]. The OS maps it to real RAM in fixed-size
#strong[pages] (usually 4 KB). When RAM is full, rarely used pages move
to #strong[swap] on disk. That is why a computer slows down when it runs
out of RAM.

== 9.3 Networking
<networking>
```bash
$ ip a                     # IP addresses of all network interfaces
$ ip r                     # routing table (your gateway)
$ ping -c 4 google.com     # 4 test packets (-c count; without it, Ctrl+C to stop)
$ curl -I https://example.com   # only the HTTP headers
$ curl -O https://site/file.zip # download a file
$ wget https://site/file.zip    # download a file (another tool)
$ ss -tuln                 # listening ports (t=TCP u=UDP l=listening n=numbers)
$ nslookup google.com      # DNS lookup (or: dig google.com)
$ traceroute google.com    # path of routers to a host
$ nmcli device status      # NetworkManager status (Fedora/Ubuntu desktop)
```

== 9.4 Remote work: SSH and SCP
<remote-work-ssh-and-scp>
```bash
$ ssh rahim@192.168.1.10              # log in to another computer
$ ssh -p 2222 rahim@server.com        # custom port
$ ssh-keygen -t ed25519               # create a key pair (no password logins)
$ ssh-copy-id rahim@server.com        # install your public key on the server
$ scp report.pdf rahim@server:/tmp/   # copy file to server
$ scp rahim@server:/var/log/app.log . # copy file from server to here
$ rsync -avz site/ rahim@server:/var/www/site/   # smart sync, copies only changes
```

== 9.5 Environment variables
<environment-variables>
```bash
$ echo $HOME $USER $SHELL    # common variables
$ echo $PATH                 # folders searched for commands, separated by :
$ env                        # all environment variables
$ export EDITOR=nano         # set and pass to child programs
$ export PATH="$PATH:$HOME/bin"   # add your own scripts folder to PATH
```

#callout("why", "Why?")[
#strong[Why PATH matters:] When you type `ls`, Bash searches each folder
in `$PATH` until it finds a program named `ls`. If your script folder is
in PATH, you can run `myscript` instead of `./myscript.sh`.

]
Startup files:

#table(
  columns: (auto,)*1 + (1fr,),
  align: (col, row) => (auto,auto,).at(col),
  inset: (x: 7pt, y: 5pt),
  [File], [When it runs],
  [`~/.bashrc`],
  [Every new interactive terminal (aliases, functions, prompt)],
  [`~/.bash_profile`],
  [Login shells (SSH, TTY login)],
  [`/etc/bashrc` (Fedora) / `/etc/bash.bashrc` (Ubuntu)],
  [For all users],
)

After editing, apply with `source ~/.bashrc`.

== 9.6 Packages (recap) and Flatpak
<packages-recap-and-flatpak>
```bash
$ sudo dnf install git              # Fedora
$ sudo apt install git              # Ubuntu
$ flatpak install flathub org.videolan.VLC    # sandboxed desktop apps (Fedora has Flatpak built in)
$ rpm -qa | grep bash               # Fedora: is the bash package installed?
$ dpkg -l | grep bash               # Ubuntu: same check
```

#callout("practice", "Practice 9")[
(a) How much free disk space does your `/` partition have? (b) Find your
IP address. (c) Add `~/bin` to your PATH permanently.

]
#part-page("III", "Shell Scripting Core")
#chapter-heading("10", "Your First Shell Script")
A shell script is a text file full of commands that Bash runs from top
to bottom. Anything you can type in the terminal, you can put in a
script.

== 10.1 Why write scripts?
<why-write-scripts>
- #strong[Automation:] do a 20-step job with one command.
- #strong[No mistakes:] the same steps run the same way every time.
- #strong[Scheduling:] run it every night with cron (Chapter 17).
- #strong[Sharing:] give your teammates one file instead of
  instructions.

== 10.2 Write, permit, run
<write-permit-run>
#strong[Step 1: write] `hello.sh` (`nano hello.sh`):

```bash
#!/bin/bash
# My first script
echo "Hello, World!"
echo "Today is $(date +%A)"
echo "You are $USER"
```

#table(
  columns: (auto,)*1 + (1fr,),
  align: (col, row) => (auto,auto,).at(col),
  inset: (x: 7pt, y: 5pt),
  [Line], [Why it is there],
  [`#!/bin/bash`],
  [#strong[Shebang.] Tells Linux \"run this file with /bin/bash\". Must
  be the very first line.],
  [`# My first script`],
  [A comment for humans. Bash ignores it.],
  [`echo "Hello, World!"`],
  [Prints text.],
  [`$(date +%A)`],
  [#strong[Command substitution:] runs `date +%A` and puts its output
  (e.g. Monday) here.],
  [`$USER`],
  [A variable holding your username.],
)

#strong[Step 2: give execute permission]

```bash
$ ./hello.sh
bash: ./hello.sh: Permission denied      # not executable yet
$ chmod +x hello.sh
```

#strong[Step 3: run]

```bash
$ ./hello.sh
Hello, World!
Today is Monday
You are rahim
```

#callout("why", "Why?")[
#strong[Why `./`?] For safety, Bash does not search the current folder
for commands. `./` means \"the file in this folder\". Typing just
`hello.sh` gives `bash: hello.sh: command not found`.

]
Other ways to run a script:

#table(
  columns: (auto,)*3 + (1fr,),
  align: (col, row) => (auto,auto,auto,auto,).at(col),
  inset: (x: 7pt, y: 5pt),
  [Command], [Needs `chmod +x`?], [Runs in], [Notes],
  [`./hello.sh`],
  [Yes],
  [New child shell],
  [Normal way; uses the shebang],
  [`bash hello.sh`],
  [No],
  [New child shell],
  [Ignores the shebang, always Bash],
  [`source hello.sh` or `. hello.sh`],
  [No],
  [#strong[Current] shell],
  [Variables and `cd` stay after it ends (used for `.bashrc`)],
)

#callout("space", "Space check")[
`. hello.sh` (dot, space, name) \= source the file. `./hello.sh` (no
space) \= run as a program. One space changes the meaning.

]
#callout("mistake", "Common mistake")[
#strong[Common mistake (Windows files):] A script written in Notepad has
Windows line endings (`\r\n`). Running it gives
`cannot execute: required file not found` (newer Bash) or
`/bin/bash^M: bad interpreter`. Fix: `sed -i 's/\r$//' script.sh` or
`dos2unix script.sh`.

]
== 10.3 Comments
<comments>
```bash
# Single-line comment
echo "hi"   # comment after code

: '
Multi-line comment trick:
everything inside these quotes is ignored
'
```

== 10.4 Output: `echo` and `printf`
<output-echo-and-printf>
```bash
$ echo "Tab:\tEnd"          # echo does NOT understand \t by default
Tab:\tEnd
$ echo -e "Tab:\tEnd"       # -e enables escapes: \t tab, \n new line
Tab:    End
$ echo -n "No newline"      # -n = do not move to the next line
$ printf "%s is %d years\n" Rahim 25
Rahim is 25 years
$ printf "%-10s|%5.2f|\n" Rahim 3.14159
Rahim     | 3.14|
```

#table(
  columns: (auto,)*1 + (1fr,),
  align: (col, row) => (auto,auto,).at(col),
  inset: (x: 7pt, y: 5pt),
  [printf code], [Meaning],
  [`%s`],
  [String],
  [`%d`],
  [Whole number],
  [`%f`, `%.2f`],
  [Decimal, with 2 digits after the point],
  [`%-10s`],
  [String, left-aligned in 10 spaces],
  [`%5d`],
  [Number, right-aligned in 5 spaces],
  [`\n`, `\t`],
  [New line, tab],
)

#callout("why", "Why?")[
#strong[Why printf?] It gives exact formatting (tables, decimals) and
behaves the same on every system. `echo` options differ between shells.

]
== 10.5 Variables
<variables>
```bash
name="Rahim"          # create (NO spaces around =)
age=25
echo $name            # use with $
echo "$name is $age"  # inside double quotes: replaced
echo "${name}Khan"    # braces mark where the name ends -> RahimKhan
readonly PI=3.14      # constant: cannot be changed
unset age             # delete the variable
```

Real outputs:

```bash
$ readonly PI=3.14; PI=3
bash: PI: readonly variable
$ v=5; echo "$v$v" "${v}0" "$v0end"
55 50                       # $v0end is a different, empty variable!
```

Naming rules: letters, digits and `_`; cannot start with a digit;
case-sensitive (`Name` ≠ `name`). Convention: `UPPER_CASE` for
environment/constant values, `lower_case` for your own variables.

#strong[Special variables]

#table(
  columns: (auto,)*1 + (1fr,),
  align: (col, row) => (auto,auto,).at(col),
  inset: (x: 7pt, y: 5pt),
  [Variable], [Meaning],
  [`$0`],
  [Script name],
  [`$1`, `$2` … `${10}`],
  [Arguments given to the script],
  [`$#`],
  [Number of arguments],
  [`$@`],
  [All arguments (as separate words when quoted `"$@"`)],
  [`$?`],
  [Exit status of the last command (0 \= success)],
  [`$$`],
  [PID of the current shell],
  [`$!`],
  [PID of the last background job],
  [`$RANDOM`],
  [A random number 0–32767],
  [`$LINENO`],
  [Current line number in the script],
)

#strong[Default values]

```bash
echo "${name:-guest}"     # use "guest" if name is empty/unset
echo "${name:=guest}"     # same, and also SAVE guest into name
echo "${name:?Name required}"   # stop with an error if empty
```

== 10.6 Input: `read`
<input-read>
```bash
#!/bin/bash
read -p "Enter your name: " name
echo "Hello, $name!"
```

```
Enter your name: Rahim
Hello, Rahim!
```

#table(
  columns: (auto,)*1 + (1fr,),
  align: (col, row) => (auto,auto,).at(col),
  inset: (x: 7pt, y: 5pt),
  [Option], [Use],
  [`read -p "text" var`],
  [Show a prompt],
  [`read -s pass`],
  [Silent (passwords)],
  [`read -t 5 ans`],
  [Wait only 5 seconds],
  [`read -n 1 key`],
  [Read just 1 character],
  [`read a b c`],
  [Split input into several variables],
  [`read -a arr`],
  [Read words into an array],
  [`read -r line`],
  [Raw: keep backslashes as typed (always use in loops)],
)

== 10.7 Command substitution
<command-substitution>
```bash
today=$(date +%F)          # modern form (recommended, can be nested)
files=`ls | wc -l`         # old backtick form, same idea
echo "Backup-$today.tar.gz"
```

#callout("bangla", "বাংলা নোট")[
`$( )` এর ভেতরের কমান্ড আগে চলে, তারপর তার output সেই জায়গায় বসে যায়।

]
#callout("practice", "Practice 10")[
Write `info.sh` that asks for name and city, then prints:
`Hi <name> from <city>! Today is <date>. You are using <shell>.`

]
#chapter-heading("11", "Spaces and Quoting: The Space-Sensitivity Chapter")
Bash splits every line into #strong[words at spaces]. That one fact
explains why a single space can make code work, fail, or silently do
something else. Every output in this chapter is real, captured from GNU
Bash 5.2.

#callout("bangla", "বাংলা নোট")[
Bash স্পেস দেখে শব্দ আলাদা করে। তাই কোথায় স্পেস দিতে হবে, আর কোথায় দেওয়া
যাবে না — এই অধ্যায়টা দুইবার পড়ুন।

]
== 11.1 The one rule behind everything
<the-one-rule-behind-everything>
When Bash reads `cp my file.txt backup/`, it sees #strong[four words]:
`cp`, `my`, `file.txt`, `backup/`. The first word is the command; the
rest are arguments. So:

- A space #strong[between] things separates them into different words.
- #strong[No space] joins them into one word.
- #strong[Quotes] turn several words into one word, spaces included.

== 11.2 Rule 1: Assignment, no spaces around `=`
<rule-1-assignment-no-spaces-around>
#table(
  columns: (auto,)*2 + (1fr,),
  align: (col, row) => (auto,auto,auto,).at(col),
  inset: (x: 7pt, y: 5pt),
  [Code], [Output], [What Bash understood],
  [`name="Rahim"` then `echo $name`],
  [`Rahim`],
  [✅ assignment],
  [`name = "Rahim"`],
  [`bash: name: command not found`],
  [run command `name` with args `=` and `Rahim`],
  [`name= "Rahim"`],
  [`bash: Rahim: command not found`],
  [set name to empty for one command, and run command `Rahim`],
  [`name ="Rahim"`],
  [`bash: name: command not found`],
  [run command `name` with arg `=Rahim`],
  [`today = $(date +%A)`],
  [`bash: today: command not found`],
  [same problem with command substitution],
)

The same rule applies to `alias`, `export`, `readonly`, `local` and
`declare`: `export PATH="$PATH:~/bin"` ✅, `export PATH = ...` ❌.

== 11.3 Rule 2: Values with spaces need quotes
<rule-2-values-with-spaces-need-quotes>
```bash
$ msg=Hello World; echo $msg
bash: World: command not found       # ❌ Bash ran "World" as a command
$ msg="Hello World"; echo $msg
Hello World                          # ✅
```

== 11.4 Rule 3: Test brackets `[ ]` and `[[ ]]` need spaces inside
<rule-3-test-brackets-and-need-spaces-inside>
`[` is actually a #strong[command] (try `type [`). Like any command, it
must be separated from its arguments by spaces, and its last argument
must be `]`.

#table(
  columns: (auto,)*1 + (1fr,),
  align: (col, row) => (auto,auto,).at(col),
  inset: (x: 7pt, y: 5pt),
  [Code (x\=5)], [Output],
  [`if [ $x -eq 5 ]; then echo yes; fi`],
  [`yes` ✅],
  [`if [$x -eq 5]; then echo yes; fi`],
  [`bash: [5: command not found` ❌],
  [`if [ $x -eq 5]; then echo yes; fi`],
  [#raw("bash: [: missing `]'") ❌],
  [`if [ $x-eq 5 ]; then echo yes; else echo no; fi`],
  [`bash: [: 5-eq: unary operator expected` then `no` ❌],
  [`if [[ $a == abc ]]; then ...`],
  [works ✅],
  [`if [[$a == abc]]; then ...`],
  [`bash: [[abc: command not found` ❌],
)

== 11.5 Rule 4: Spaces around comparison operators (the silent bug)
<rule-4-spaces-around-comparison-operators-the-silent-bug>
This is the most dangerous one: #strong[no error message], just a wrong
answer.

```bash
$ a=abc; if [ $a = abc ]; then echo same; fi
same                     # ✅ three words: abc  =  abc -> compare

$ a=abc; if [ $a=xyz ]; then echo "same?!"; fi
same?!                   # ❌ ONE word "abc=xyz" -> a non-empty string is always TRUE
```

#callout("why", "Why?")[
`[ word ]` with a single word only checks \"is this string non-empty?\".
`abc=xyz` is not empty, so the test is true, even though abc is not xyz.

]
== 11.6 Rule 5: Always quote variables inside `[ ]`
<rule-5-always-quote-variables-inside>
#table(
  columns: (auto,)*1 + (1fr,),
  align: (col, row) => (auto,auto,).at(col),
  inset: (x: 7pt, y: 5pt),
  [Code], [Output],
  [`v="hello world"; [ $v = "hello world" ]`],
  [`bash: [: too many arguments` ❌ (becomes
  `[ hello world = "hello world" ]`)],
  [`v="hello world"; [ "$v" = "hello world" ]`],
  [true → `ok` ✅],
  [`v=""; [ $v = abc ]`],
  [`bash: [: =: unary operator expected` ❌ (becomes `[ = abc ]`)],
  [`v=""; [ "$v" = abc ]`],
  [false → `n`, no error ✅],
)

#callout("tip", "Tip")[
`[[ ]]` does not split variables, so `[[ $v == "hello world" ]]` works
even without quotes. Still, quoting is a good habit everywhere.

]
== 11.7 Rule 6: Quote file names that contain spaces
<rule-6-quote-file-names-that-contain-spaces>
```bash
$ file="my notes.txt"; touch "$file"; cat $file
cat: my: No such file or directory           # ❌ split into "my" and "notes.txt"
cat: notes.txt: No such file or directory
$ cat "$file"                                 # ✅ one argument
$ mkdir My Folder        # ❌ creates TWO folders: "My" and "Folder"
$ mkdir "My Folder"      # ✅ one folder (or: mkdir My\ Folder)
$ cd My Folder
bash: cd: too many arguments                 # ❌
```

== 11.8 Rule 7: Spaces inside output: quoted vs unquoted
<rule-7-spaces-inside-output-quoted-vs-unquoted>
```bash
$ echo Hello     World
Hello World              # unquoted: extra spaces are lost (2 words)
$ echo "Hello     World"
Hello     World          # quoted: spaces kept exactly (1 word)
$ echo "a"     "b"
a b                      # two words, echo puts one space between
$ echo "a""b"
ab                       # no space = joined into one word
```

== 11.9 Rule 8: Single vs double quotes vs backslash
<rule-8-single-vs-double-quotes-vs-backslash>
#table(
  columns: (auto,)*2 + (1fr,),
  align: (col, row) => (auto,auto,auto,).at(col),
  inset: (x: 7pt, y: 5pt),
  [Code], [Output], [Why],
  [`echo "Value: $HOME"`],
  [`Value: /home/rahim`],
  [Double quotes: variables ARE replaced],
  [`echo 'Value: $HOME'`],
  [`Value: $HOME`],
  [Single quotes: everything literal],
  [`echo \$HOME`],
  [`$HOME`],
  [Backslash escapes one character],
  [`echo "It's"`],
  [`It's`],
  [A single quote is fine inside double quotes],
  [`echo "Cost: \$5"`],
  [`Cost: $5`],
  [Escape `$` inside double quotes],
)

Also: `echo $ name` prints `$ name`, because a `$` followed by a space
is just a dollar sign.

== 11.10 Rule 9: Arithmetic, where spaces are free and where they are
not
<rule-9-arithmetic-where-spaces-are-free-and-where-they-are-not>
#table(
  columns: (auto,)*2 + (1fr,),
  align: (col, row) => (auto,auto,auto,).at(col),
  inset: (x: 7pt, y: 5pt),
  [Code], [Output], [Note],
  [`echo $((5+3))`],
  [`8`],
  [✅ spaces optional inside `$(( ))`],
  [`echo $(( 5 + 3 ))`],
  [`8`],
  [✅ same, more readable],
  [`echo $( (5+3) )`],
  [`bash: 5+3: command not found`],
  [❌ a space between `$(` and `(` turns it into command substitution],
  [`expr 5 + 3`],
  [`8`],
  [✅ `expr` NEEDS spaces (each part is an argument)],
  [`expr 5+3`],
  [`5+3`],
  [❌ one word, printed as text],
  [`expr 5 \* 3`],
  [`15`],
  [✅ `*` must be escaped],
  [`expr 5 * 3` (folder has files)],
  [`expr: syntax error: unexpected argument 'a.txt'`],
  [❌ `*` became file names],
  [`let a=5+3`],
  [`a=8`],
  [✅ no spaces],
  [`let a = 5 + 3`],
  [`bash: let: =: syntax error: operand expected (error token is "=")`],
  [❌],
  [`let "a = 5 + 3"`],
  [`a=8`],
  [✅ quotes make it one argument],
  [`((i++))` and `(( i++ ))`],
  [both work],
  [✅],
)

== 11.11 Rule 10: Brace expansion must have no spaces
<rule-10-brace-expansion-must-have-no-spaces>
```bash
$ for i in {1..5}; do echo -n "$i "; done
1 2 3 4 5            # ✅
$ for i in {1 .. 5}; do echo -n "$i "; done
{1 .. 5}             # ❌ printed literally, no expansion
$ for i in { 1..5 }; do echo -n "$i "; done
{ 1..5 }             # ❌
```

The same applies to `{a,b,c}`: `touch {mon,tue}.log` ✅ but
`touch {mon, tue}.log` creates `{mon,` and `tue}.log` ❌.

== 11.12 Rule 11: Functions and `{ }` blocks
<rule-11-functions-and-blocks>
#table(
  columns: (auto,)*1 + (1fr,),
  align: (col, row) => (auto,auto,).at(col),
  inset: (x: 7pt, y: 5pt),
  [Code], [Output],
  [`greet(){ echo hi; }; greet`],
  [`hi` ✅],
  [`greet() {echo hi; }`],
  [#raw("syntax error near unexpected token `{echo'") ❌ a space is
  required after `{`],
  [`greet(){ echo hi }`],
  [`syntax error: unexpected end of file` ❌ `;` or a new line is
  required before `}`],
)

== 11.13 Rule 12: Arrays
<rule-12-arrays>
#table(
  columns: (auto,)*1 + (1fr,),
  align: (col, row) => (auto,auto,).at(col),
  inset: (x: 7pt, y: 5pt),
  [Code], [Output],
  [`arr=(1 2 3); echo ${arr[@]}`],
  [`1 2 3` ✅ elements separated by spaces],
  [`arr = (1 2 3)`],
  [#raw("syntax error near unexpected token `('") ❌],
  [`arr=(1, 2, 3); echo ${arr[0]}`],
  [`1,` ❌ commas become part of the values],
)

== 11.14 Rule 13: Redirection numbers stick to the operator
<rule-13-redirection-numbers-stick-to-the-operator>
#table(
  columns: (auto,)*1 + (1fr,),
  align: (col, row) => (auto,auto,).at(col),
  inset: (x: 7pt, y: 5pt),
  [Code], [Result],
  [`ls nofile 2>err.txt`],
  [Error saved in `err.txt` ✅],
  [`ls nofile 2 >err.txt`],
  [`2` becomes a file name for `ls`; error shown on screen ❌],
  [`cmd > out.txt 2>&1`],
  [stdout + stderr to file ✅],
  [`cmd > out.txt 2 > &1`],
  [syntax error ❌],
  [`x=5; [ $x > 3 ] && echo big`],
  [prints `big` #strong[and creates a file named `3`] ❌ `>` is
  redirection inside `[ ]`; use `-gt`],
)

== 11.15 Rule 14: Keywords need separators (`;` or new line)
<rule-14-keywords-need-separators-or-new-line>
#table(
  columns: (auto,)*1 + (1fr,),
  align: (col, row) => (auto,auto,).at(col),
  inset: (x: 7pt, y: 5pt),
  [Code], [Output],
  [`if [ 1 -eq 1 ]; then echo yes; fi`],
  [`yes` ✅],
  [`if [ 1 -eq 1 ] then echo yes fi`],
  [`syntax error: unexpected end of file` ❌],
  [`for i in 1 2 3; do echo $i; done`],
  [`1 2 3` (one per line) ✅],
  [`for i in 1 2 3 do echo $i; done`],
  [#raw("syntax error near unexpected token `done'") ❌ `do` was taken
  as a list item],
)

== 11.16 Rule 15: `"$@"` vs `$@` (arguments that contain spaces)
<rule-15-vs-arguments-that-contain-spaces>
```bash
$ set -- "a b" c                       # pretend the script got 2 arguments
$ for x in $@; do echo "[$x]"; done
[a]
[b]                                    # ❌ "a b" was split into 2
[c]
$ for x in "$@"; do echo "[$x]"; done
[a b]                                  # ✅ arguments kept exactly
[c]
```

== 11.17 Rule 16: Here-document end marker
<rule-16-here-document-end-marker>
```bash
cat << EOF
Hello
 EOF        # ❌ leading space: NOT the end, printed as text
EOF         # ✅ the real end: alone, at the start of the line
```

Output: `Hello` and `EOF`. (Use `<<-EOF` if you want to indent the end
marker with #strong[tabs].)

== 11.18 Summary: where spaces are required, forbidden or optional
<summary-where-spaces-are-required-forbidden-or-optional>
#table(
  columns: (auto,)*2 + (1fr,),
  align: (col, row) => (auto,auto,auto,).at(col),
  inset: (x: 7pt, y: 5pt),
  [Spaces REQUIRED], [Spaces FORBIDDEN], [Spaces OPTIONAL],
  [Between command, options, arguments: `ls -l /tmp`],
  [Around `=` in assignment: `x=5`],
  [Around `\|`: `ls\|wc -l`],
  [Inside `[` and `]`, `[[` and `]]`],
  [In `{1..5}` and `{a,b}`],
  [Around `;`: `echo a;echo b`],
  [Around test operators: `[ $a = $b ]`, `-eq`],
  [Between `$` and name: `$name`],
  [Around `&&`, `\|\|`],
  [Between parts for `expr`: `expr 5 + 3`],
  [In `2>`, `2>&1`, `&>`],
  [Inside `$(( ))` and `(( ))`],
  [After `{` and before `}` in blocks],
  [In `arr=(...)` before `(`],
  [Around `>` and `>>`: `echo hi>f`],
  [Before `\;` in `find -exec`],
  [In `$((` (no space between `$` and `((`)],
  [In `$( cmd )` around the command],
)

#callout("tip", "Golden rules")[
(1) No spaces around `=`. (2) Spaces inside `[ ]`. (3) Quote every
variable: `"$var"`. (4) When in doubt, run `shellcheck script.sh`
(Chapter 19).

]
#callout("practice", "Practice 11")[
Find and fix the bugs: `count = 0`, `if [$count -lt 5]`,
`for i in {1 .. 3}`, `file=my report.txt`, `[ $x > 10 ]`.

]
#chapter-heading("12", "Arithmetic, Conditions and case")
Scripts become smart when they can calculate and make decisions. Bash
does #strong[integer] math by itself and uses `bc` or `awk` for
decimals.

== 12.1 Integer arithmetic
<integer-arithmetic>
```bash
a=10; b=3
echo $((a + b))   # 13   addition
echo $((a - b))   # 7    subtraction
echo $((a * b))   # 30   multiplication
echo $((a / b))   # 3    division (decimal part is DROPPED)
echo $((a % b))   # 1    remainder (modulus)
echo $((a ** 2))  # 100  power
```

Short forms (inside `(( ))` you can skip `$` before variable names):

```bash
$ x=7; ((x+=3)); echo $x
10
$ ((x--)); echo $x
9
```

#table(
  columns: (auto,)*2 + (1fr,),
  align: (col, row) => (auto,auto,auto,).at(col),
  inset: (x: 7pt, y: 5pt),
  [Method], [Example], [Notes],
  [`$(( ))`],
  [`sum=$((a+b))`],
  [#strong[Recommended.] Fast, built in],
  [`(( ))`],
  [`((count++))`],
  [Change a variable or test a condition],
  [`let`],
  [`let sum=a+b`],
  [Older; no spaces unless quoted],
  [`expr`],
  [`sum=$(expr $a + $b)`],
  [Very old; needs spaces, escape `\*`],
)

== 12.2 Decimal math with `bc` and `awk`
<decimal-math-with-bc-and-awk>
```bash
$ echo $(( 7/2.0 ))
bash: 7/2.0 : syntax error: invalid arithmetic operator (error token is ".0 ")
$ echo "scale=3; 22/7" | bc          # scale = digits after the point
3.142
$ echo "sqrt(16)" | bc -l            # -l = math library
4.00000000000000000000
$ awk 'BEGIN{printf "%.2f\n", 10/3}'
3.33
```

== 12.3 Exit status: how Bash decides true or false
<exit-status-how-bash-decides-true-or-false>
Every command returns a number when it finishes: #strong[0 means success
(true)], anything else means failure (false). `if` simply runs a command
and checks this number.

```bash
$ n=3; [ "$n" -lt 5 ]; echo $?
0          # true
$ [ "$n" -gt 5 ]; echo $?
1          # false
```

#callout("bangla", "বাংলা নোট")[
অন্য ভাষায় 1 \= true, কিন্তু Bash-এ exit status 0 \= success \= true। এটা
উল্টো, মনে রাখুন।

]
== 12.4 Test operators
<test-operators>
#strong[Numbers] (inside `[ ]` or `[[ ]]`)

#table(
  columns: (auto,)*2 + (1fr,),
  align: (col, row) => (auto,auto,auto,).at(col),
  inset: (x: 7pt, y: 5pt),
  [Operator], [Meaning], [Math],
  [`-eq`],
  [equal],
  [\=],
  [`-ne`],
  [not equal],
  [≠],
  [`-gt`],
  [greater than],
  [\>],
  [`-ge`],
  [greater or equal],
  [≥],
  [`-lt`],
  [less than],
  [\<],
  [`-le`],
  [less or equal],
  [≤],
)

#strong[Strings]

#table(
  columns: (auto,)*1 + (1fr,),
  align: (col, row) => (auto,auto,).at(col),
  inset: (x: 7pt, y: 5pt),
  [Operator], [Meaning],
  [`"$a" = "$b"` (or `==` in `[[ ]]`)],
  [equal],
  [`"$a" != "$b"`],
  [not equal],
  [`-z "$a"`],
  [empty (zero length)],
  [`-n "$a"`],
  [not empty],
  [`[[ $a < $b ]]`],
  [alphabetically before],
  [`[[ $a == a* ]]`],
  [pattern match (starts with a)],
  [`[[ $a =~ ^[0-9]+$ ]]`],
  [regex match],
)

#strong[Files]

#table(
  columns: (auto,)*1 + (1fr,),
  align: (col, row) => (auto,auto,).at(col),
  inset: (x: 7pt, y: 5pt),
  [Operator], [True if],
  [`-e file`],
  [exists (anything)],
  [`-f file`],
  [is a regular file],
  [`-d file`],
  [is a directory],
  [`-r` / `-w` / `-x file`],
  [readable / writable / executable],
  [`-s file`],
  [exists and is not empty],
  [`-L file`],
  [is a symbolic link],
  [`f1 -nt f2`],
  [f1 is newer than f2],
)

#strong[Combining]

#table(
  columns: (auto,)*2 + (1fr,),
  align: (col, row) => (auto,auto,auto,).at(col),
  inset: (x: 7pt, y: 5pt),
  [Inside `[ ]`], [Inside `[[ ]]`], [Meaning],
  [`-a`],
  [`&&`],
  [AND],
  [`-o`],
  [`\|\|`],
  [OR],
  [`!`],
  [`!`],
  [NOT],
)

== 12.5 `[ ]` vs `[[ ]]` vs `(( ))`
<vs-vs>
#table(
  columns: (auto,)*3 + (1fr,),
  align: (col, row) => (auto,auto,auto,auto,).at(col),
  inset: (x: 7pt, y: 5pt),
  [], [`[ ]` (test)], [`[[ ]]`], [`(( ))`],
  [Works in],
  [All shells (POSIX)],
  [Bash, zsh],
  [Bash, zsh],
  [Best for],
  [Portable scripts],
  [Strings, patterns, regex],
  [Numbers],
  [Need quotes on variables?],
  [Yes, always],
  [Safer, mostly not needed],
  [No],
  [Example],
  [`[ "$a" -gt 5 ]`],
  [`[[ $name == R* ]]`],
  [`(( a > 5 ))`],
)

#callout("tip", "Tip")[
For numbers in Bash, `(( a > 5 ))` reads like normal math and avoids
`-gt`.

]
== 12.6 `if`, `elif`, `else`
<if-elif-else>
```bash
#!/bin/bash
read -p "Enter marks: " m

if [ "$m" -ge 80 ]; then        # condition 1
    echo "Grade: A+"
elif [ "$m" -ge 70 ]; then      # checked only if condition 1 was false
    echo "Grade: A"
elif [ "$m" -ge 60 ]; then
    echo "Grade: A-"
elif [ "$m" -ge 40 ]; then
    echo "Grade: Pass"
else                            # none matched
    echo "Grade: F"
fi                              # if spelled backwards closes the block
```

```
Enter marks: 75
Grade: A
```

Short forms:

```bash
[ -f config.txt ] && echo "found"            # run only if true
[ -f config.txt ] || echo "missing"          # run only if false
[ -d backup ] || mkdir backup                # create only if missing
```

== 12.7 `case`: many choices
<case-many-choices>
```bash
#!/bin/bash
read -p "Enter a day (mon-sun): " day
case "$day" in
    mon|tue|wed|thu|sun) echo "Working day" ;;   # | = OR between patterns
    fri|sat)             echo "Weekend (Bangladesh)" ;;
    *)                   echo "Invalid day" ;;     # * = anything else (default)
esac
```

- Each pattern ends with `)`; each branch ends with `;;`.
- Patterns can use wildcards: `[0-9])`, `a*)`, `*.txt)`.
- `esac` \= `case` spelled backwards.

#callout("practice", "Practice 12")[
(a) Read a number and print whether it is positive, negative or zero.
(b) Read a file name and print whether it exists, and if it is a file or
a directory. (c) Build a menu with `case`: 1 \= date, 2 \= list files, 3
\= disk usage.

]
#chapter-heading("13", "Loops")
Loops repeat work. Bash has `for` (a known list or count), `while`
(repeat while a condition is true) and `until` (repeat until a condition
becomes true).

== 13.1 `for` over a list
<for-over-a-list>
```bash
for fruit in apple banana mango; do
    echo "I like $fruit"
done
```

```
I like apple
I like banana
I like mango
```

More list sources:

```bash
for i in {1..5}; do ...           # 1 2 3 4 5
for i in {10..1..3}; do ...       # 10 7 4 1  (step 3, counting down)
for i in $(seq 1 2 9); do ...     # 1 3 5 7 9  (seq start step end)
for f in *.txt; do ...            # every .txt file in this folder
for u in $(cut -d: -f1 /etc/passwd); do ...   # every username
for arg in "$@"; do ...           # every script argument
```

== 13.2 C-style `for`
<c-style-for>
```bash
for ((i = 1; i <= 5; i++)); do
    echo "Count: $i"
done
```

Parts: `start; condition; step`. Good when you need a counter or a
variable limit like `i <= n`.

#callout("why", "Why?")[
#strong[Why not `{1..$n}`?] Brace expansion happens before variables are
replaced, so `{1..$n}` prints literally. Use `seq 1 $n` or the C-style
loop for variable limits.

]
== 13.3 `while`
<while>
```bash
x=5
while [ $x -gt 0 ]; do
    echo -n "$x "
    x=$((x - 1))         # IMPORTANT: change x, or the loop never ends
done
echo
```

```
5 4 3 2 1
```

Read a file line by line (the correct, safe way):

```bash
while IFS= read -r line; do
    echo "[$line]"
done < f.txt
```

- `IFS=` keeps leading/trailing spaces in each line.
- `-r` keeps backslashes as they are.
- `< f.txt` feeds the file into the loop.

== 13.4 `until`
<until>
```bash
i=1
until [ $i -gt 3 ]; do    # runs while the condition is FALSE
    echo $i
    ((i++))
done
```

== 13.5 `break` and `continue`
<break-and-continue>
```bash
for i in {1..10}; do
    [ $i -eq 3 ] && continue   # skip 3, go to the next round
    [ $i -eq 6 ] && break      # stop the whole loop at 6
    echo -n "$i "
done
```

```
1 2 4 5
```

`break 2` exits two nested loops at once.

== 13.6 Infinite loops and menus
<infinite-loops-and-menus>
```bash
while true; do
    echo "1) Date  2) Who  3) Quit"
    read -p "Choose: " c
    case $c in
        1) date ;;
        2) whoami ;;
        3) echo "Bye"; break ;;
        *) echo "Invalid" ;;
    esac
done
```

Bash also has a built-in menu maker, `select`:

```bash
PS3="Pick a fruit: "
select f in apple banana quit; do
    [ "$f" = quit ] && break
    echo "You picked $f"
done
```

== 13.7 Nested loops
<nested-loops>
```bash
for i in {1..3}; do
    for j in {1..3}; do
        echo -n "$((i * j)) "
    done
    echo
done
```

```
1   2   3
2   4   6
3   6   9
```

#callout("mistake", "Common mistake")[
`for i in 1 2 3; do echo $i done` gives
`syntax error: unexpected end of file`, because `done` was read as an
argument to `echo`. Put `;` or a new line before `done`.

]
#callout("practice", "Practice 13")[
(a) Print even numbers from 2 to 20. (b) Rename every `.txt` file in a
folder to `.bak`. (c) Keep asking for a password until the user types
`linux123`.

]
#chapter-heading("14", "Functions, Arrays and Strings")
Functions let you reuse code, arrays store many values in one variable,
and string tools let you cut and change text without calling other
programs.

== 14.1 Functions
<functions>
```bash
# Two ways to define
greet() {
    echo "Hello, $1!"     # $1 = first argument OF THE FUNCTION
}
function bye {
    echo "Goodbye, $1!"
}

greet Rahim      # call: just the name, then arguments (no brackets)
bye Karim
```

```
Hello, Rahim!
Goodbye, Karim!
```

#callout("note", "")[
#strong[Rule:] Define a function #strong[before] you call it, because
Bash reads top to bottom.

]
== 14.2 Returning values
<returning-values>
`return` only gives back an #strong[exit status (0–255)], not data. To
return data, `echo` it and capture it with `$( )`.

```bash
add() {
    echo $(( $1 + $2 ))
}
r=$(add 4 5)
echo "Sum: $r"           # Sum: 9

is_even() {
    (( $1 % 2 == 0 ))     # the exit status of this line is the function's result
}
is_even 4 && echo even   # even
is_even 5 || echo odd    # odd
```

#callout("why", "Why?")[
#strong[Why only 0–255?] It is an exit code. `return 300` actually gives
`44` (300 − 256). Never use `return` to send numbers back.

]
== 14.3 Local vs global variables
<local-vs-global-variables>
```bash
x=1
f() { local x=2; echo "in:$x"; }   # local = exists only inside f
f; echo "out:$x"
g() { x=9; }                        # no local = changes the global x
g; echo "after g:$x"
```

```
in:2
out:1
after g:9
```

#callout("tip", "Tip")[
Always use `local` inside functions, so they do not secretly change
other parts of your script.

]
== 14.4 Indexed arrays
<indexed-arrays>
```bash
fruits=(apple banana cherry)   # create (spaces separate items)
echo ${fruits[0]}              # apple    (index starts at 0)
echo ${fruits[1]}              # banana
echo ${fruits[@]}              # all items
echo ${#fruits[@]}             # 3        number of items
echo ${!fruits[@]}             # 0 1 2    all indexes
fruits+=(mango)                # append
fruits[5]=grape                # set by index (gaps are allowed)
unset 'fruits[0]'              # remove one item
echo ${fruits[@]:1:2}          # slice: 2 items starting at index 1

for f in "${fruits[@]}"; do    # loop (always quote)
    echo "$f"
done
```

== 14.5 Associative arrays (dictionary / key-value)
<associative-arrays-dictionary-key-value>
```bash
declare -A capital             # -A is REQUIRED
capital[BD]=Dhaka
capital[IN]=Delhi
capital[JP]=Tokyo
echo ${capital[BD]}            # Dhaka
for k in "${!capital[@]}"; do  # all keys
    echo "$k -> ${capital[$k]}"
done
```

== 14.6 String operations
<string-operations>
Using `s="Hello World"` and `f="photo.jpg"` (all outputs verified):

#table(
  columns: (auto,)*2 + (1fr,),
  align: (col, row) => (auto,auto,auto,).at(col),
  inset: (x: 7pt, y: 5pt),
  [Syntax], [Result], [Meaning],
  [`${#s}`],
  [`11`],
  [Length],
  [`${s:0:5}`],
  [`Hello`],
  [Substring from 0, length 5],
  [`${s: -5}`],
  [`World`],
  [Last 5 characters (space before `-` is required!)],
  [`${s,,}`],
  [`hello world`],
  [All lowercase],
  [`${s^^}`],
  [`HELLO WORLD`],
  [All uppercase],
  [`${s/World/Bash}`],
  [`Hello Bash`],
  [Replace first match],
  [`${s//o/0}`],
  [`Hell0 W0rld`],
  [Replace all matches],
  [`${f%.jpg}`],
  [`photo`],
  [Remove shortest match from the end],
  [`${f##*.}`],
  [`jpg`],
  [Remove longest match from the start (gives extension)],
  [`${f%%.*}`],
  [`photo`],
  [Remove longest match from the end],
)

#callout("space", "Space check")[
`${s: -5}` gives the last 5 characters, but `${s:-5}` (no space) means
\"use 5 if s is empty\" and prints `Hello World`. A completely different
feature!

]
Split a string into an array:

```bash
s="a,b,c"
IFS="," read -ra parts <<< "$s"
echo ${parts[1]} ${#parts[@]}    # b 3
```

Other handy tools: `rev` (reverse text), `tr` (change characters),
`wc -c` (count bytes), `cut -c1-3` (first 3 characters).

#callout("bangla", "বাংলা নোট")[
`%` শেষ থেকে কাটে, `#` শুরু থেকে কাটে। একটা (`%`, `#`) \= ছোট অংশ, দুটো
(`%%`, `##`) \= বড় অংশ।

]
#callout("practice", "Practice 14")[
(a) Write a function `max` that prints the bigger of two numbers. (b)
Store 5 student names in an array and print them with their index. (c)
From `report_2026.pdf`, print just `report_2026` and `pdf`.

]
#chapter-heading("15", "Arguments, Exit Codes, Error Handling and Debugging")
Professional scripts accept input from the command line, report success
or failure correctly, stop safely on errors, and are easy to debug.

== 15.1 Command-line arguments
<command-line-arguments>
`args.sh`:

```bash
#!/bin/bash
echo "Script: $0"
echo "First: $1, Second: $2"
echo "Count: $#"
echo "All: $@"
```

```bash
$ ./args.sh Rahim "Dhaka City" 25
Script: ./args.sh
First: Rahim, Second: Dhaka City
Count: 3
All: Rahim Dhaka City 25
```

Notice `"Dhaka City"` counts as #strong[one] argument because of the
quotes (Chapter 11).

#strong[Check arguments before using them:]

```bash
#!/bin/bash
if [ $# -ne 2 ]; then
    echo "Usage: $0 <num1> <num2>" >&2   # >&2 = print to stderr
    exit 1
fi
echo "Sum: $(( $1 + $2 ))"
```

#strong[`shift`] moves arguments left: `$2` becomes `$1`, and so on.
Useful for looping through arguments.

```bash
while [ $# -gt 0 ]; do
    echo "Arg: $1"
    shift
done
```

== 15.2 Options with `getopts`
<options-with-getopts>
```bash
#!/bin/bash
while getopts "n:v" opt; do      # n takes a value (colon), v does not
    case $opt in
        n) name=$OPTARG ;;
        v) verbose=1 ;;
        *) echo "Usage: $0 [-n name] [-v]"; exit 1 ;;
    esac
done
echo "name=$name verbose=${verbose:-0}"
```

```bash
$ ./g.sh -n Rahim -v
name=Rahim verbose=1
$ ./g.sh -x
./g.sh: illegal option -- x
Usage: ./g.sh [-n name] [-v]
```

== 15.3 Exit codes
<exit-codes>
#table(
  columns: (auto,)*1 + (1fr,),
  align: (col, row) => (auto,auto,).at(col),
  inset: (x: 7pt, y: 5pt),
  [Code], [Meaning],
  [0],
  [Success],
  [1],
  [General error],
  [2],
  [Misuse (wrong options); `ls` uses it for \"file not found\"],
  [126],
  [Found but not executable (permission)],
  [127],
  [Command not found],
  [130],
  [Stopped by Ctrl+C (128 + signal 2)],
  [137],
  [Killed by `kill -9` (128 + 9)],
)

```bash
$ ls /nope; echo "exit=$?"
ls: cannot access '/nope': No such file or directory
exit=2
$ grep -q root /etc/passwd; echo "exit=$?"     # -q = quiet, just the status
exit=0
$ nosuchcmd; echo "exit=$?"
bash: nosuchcmd: command not found
exit=127
```

End your scripts with `exit 0` on success and `exit 1` (or another
non-zero number) on failure, so other scripts and cron can tell what
happened.

== 15.4 Safe mode: `set -euo pipefail`
<safe-mode-set--euo-pipefail>
Put this near the top of serious scripts:

```bash
#!/bin/bash
set -euo pipefail
```

#table(
  columns: (auto,)*2 + (1fr,),
  align: (col, row) => (auto,auto,auto,).at(col),
  inset: (x: 7pt, y: 5pt),
  [Option], [Effect], [Without it],
  [`-e`],
  [Stop the script as soon as a command fails],
  [The script continues after errors],
  [`-u`],
  [Treat unset variables as an error],
  [`$typo` silently becomes empty],
  [`-o pipefail`],
  [A pipeline fails if ANY part fails],
  [Only the last command\'s status counts],
)

Real outputs:

```bash
$ set -e; false; echo "not printed"          # script stops at false
$ set -u; echo $undefined_var
bash: undefined_var: unbound variable
$ false | true; echo $?
0                                             # error hidden!
$ set -o pipefail; false | true; echo $?
1                                             # error caught
```

#callout("why", "Why?")[
#strong[Why `-u` matters:] with a typo, `rm -rf "$BUILD_DIR/"` becomes
`rm -rf "/"` if `BUILD_DIR` is empty. `set -u` stops the script instead.

]
== 15.5 Cleanup with `trap`
<cleanup-with-trap>
`trap` runs code when the script exits or receives a signal.

```bash
#!/bin/bash
tmp=$(mktemp)                       # create a safe temporary file
trap 'rm -f "$tmp"; echo "cleaned up"' EXIT
trap 'echo " Interrupted!"; exit 130' INT    # Ctrl+C

echo "working with $tmp"
sleep 5
```

Even if the script fails or you press Ctrl+C, the temp file is deleted.

== 15.6 Debugging techniques
<debugging-techniques>
#table(
  columns: (auto,)*2 + (1fr,),
  align: (col, row) => (auto,auto,auto,).at(col),
  inset: (x: 7pt, y: 5pt),
  [Technique], [How], [What you see],
  [Trace every line],
  [`bash -x script.sh`],
  [Each command with `+` before it, after variables are filled in],
  [Trace part of a script],
  [`set -x` … `set +x`],
  [Only the lines in between],
  [Check syntax only],
  [`bash -n script.sh`],
  [Syntax errors without running anything],
  [Print variables],
  [`echo "DEBUG: x=$x" >&2`],
  [Values at that moment],
  [Static analysis],
  [`shellcheck script.sh`],
  [Bugs, quoting mistakes, suggestions],
  [Show line numbers],
  [`PS4='+ Line $LINENO: '` then `bash -x`],
  [Which line each trace came from],
)

Example trace:

```bash
$ bash -x -c 'a=5; echo $((a*2))'
+ a=5
+ echo 10
10
```

== 15.7 Logging helper
<logging-helper>
```bash
log()  { echo "[$(date '+%F %T')] INFO:  $*"; }
err()  { echo "[$(date '+%F %T')] ERROR: $*" >&2; }
die()  { err "$*"; exit 1; }

log "Backup started"
[ -d /data ] || die "/data not found"
```

#callout("bangla", "বাংলা নোট")[
Script কাজ না করলে প্রথমে `bash -x script.sh` চালান। প্রতিটি লাইন কীভাবে
চলছে দেখতে পাবেন, ভুল কোথায় সেটা সহজেই ধরা পড়বে।

]
#callout("practice", "Practice 15")[
(a) Write `div.sh a b` that refuses to run without exactly 2 arguments
and refuses to divide by zero (exit 1). (b) Add `set -euo pipefail` and
a `trap` that prints \"Done\" on exit. (c) Run it with `bash -x`.

]
#part-page("IV", "Problem-Solving Lab")
#chapter-heading("16", "40 Solved Problems in Bash")
Each problem gives the #strong[logic], the #strong[code], an explanation
of the key lines, and a #strong[real output]. Every script was run on
GNU Bash 5.2. Try each problem yourself first, then compare.

#strong[How to run any problem:] save it as `name.sh`, then
`chmod +x name.sh` and `./name.sh`. Problems that need `bc` require
`sudo dnf install bc` (Fedora) or `sudo apt install bc` (Ubuntu).

#strong[Problem index]

#table(
  columns: (auto,)*1 + (1fr,),
  align: (col, row) => (auto,auto,).at(col),
  inset: (x: 7pt, y: 5pt),
  [Group], [Problems],
  [A. Number basics],
  [1 Sum & average · 2 Even/odd · 3 Count even/odd · 4 Largest of three
  · 5 Swap · 6 Sum of even & odd 1..N · 7 Multiplication table · 8 Leap
  year · 9 Temperature · 10 Grade calculator],
  [B. Classic algorithms],
  [11 Factorial (loop) · 12 Factorial (recursion) · 13 Fibonacci series
  · 14 Nth Fibonacci · 15 Prime check · 16 Primes in a range · 17 GCD &
  LCM · 18 Power & square root · 19 Perfect number · 20 Calculator],
  [C. Digits & number types],
  [21 Digit count · 22 Sum of digits · 23 Reverse number · 24 Palindrome
  number · 25 Armstrong · 26 Strong number · 27 Decimal →
  binary/octal/hex],
  [D. Strings, arrays, patterns, files],
  [28 Palindrome string · 29 Reverse string · 30 Vowel count · 31
  Min/max/avg of array · 32 Linear search · 33 Bubble sort · 34 Matrix
  addition · 35 Star patterns · 36 Number patterns · 37 Word frequency ·
  38 Own `wc` · 39 Count files/folders · 40 Guessing game],
)

== Group A: Number basics
<group-a-number-basics>
=== Problem 1: Sum and average of N numbers
<problem-1-sum-and-average-of-n-numbers>
#strong[Logic:] read N, loop N times, add each number to `sum`, divide
by N using `bc` for decimals.

```bash
#!/bin/bash
# Sum and average of N numbers
read -p "How many numbers? " n
sum=0
for ((i = 1; i <= n; i++)); do
    read -p "Number $i: " x
    sum=$((sum + x))
done
avg=$(echo "scale=2; $sum / $n" | bc)
echo "Sum = $sum"
echo "Average = $avg"
```

- `sum=0` starts the total at zero (always initialise counters).
- `scale=2` tells `bc` to keep 2 digits after the point; Bash alone
  would give 18, not 18.33.

```
How many numbers? 3
Number 1: 10
Number 2: 20
Number 3: 25
Sum = 55
Average = 18.33
```

=== Problem 2: Even or odd
<problem-2-even-or-odd>
#strong[Logic:] a number is even if dividing by 2 leaves remainder 0
(`n % 2 == 0`).

```bash
#!/bin/bash
read -p "Enter a number: " n
if (( n % 2 == 0 )); then
    echo "$n is EVEN"
else
    echo "$n is ODD"
fi
```

```
Enter a number: 7
7 is ODD
```

=== Problem 3: Count even and odd numbers in a list
<problem-3-count-even-and-odd-numbers-in-a-list>
#strong[Logic:] loop through an array; increase one of two counters.

```bash
#!/bin/bash
nums=(12 7 9 20 33 46 51 8)
even=0; odd=0
for n in "${nums[@]}"; do
    if (( n % 2 == 0 )); then
        ((even++))
    else
        ((odd++))
    fi
done
echo "Numbers: ${nums[*]}"
echo "Even count: $even"
echo "Odd count : $odd"
```

- `"${nums[@]}"` gives every element; `((even++))` adds 1.
- Variation: read numbers from the user with `read -a nums`.

```
Numbers: 12 7 9 20 33 46 51 8
Even count: 4
Odd count : 4
```

=== Problem 4: Largest of three numbers
<problem-4-largest-of-three-numbers>
```bash
#!/bin/bash
read -p "Enter three numbers: " a b c     # one read, three variables
if (( a >= b && a >= c )); then
    max=$a
elif (( b >= a && b >= c )); then
    max=$b
else
    max=$c
fi
echo "Largest = $max"
```

```
Enter three numbers: 12 45 30
Largest = 45
```

=== Problem 5: Swap two numbers
<problem-5-swap-two-numbers>
#strong[Logic:] method 1 uses a temporary variable; method 2 uses
addition and subtraction (no extra variable).

```bash
#!/bin/bash
read -p "Enter a and b: " a b
echo "Before: a=$a b=$b"
t=$a; a=$b; b=$t
echo "After (temp): a=$a b=$b"
a=$((a + b)); b=$((a - b)); a=$((a - b))
echo "Swapped back (no temp): a=$a b=$b"
```

```
Enter a and b: 5 9
Before: a=5 b=9
After (temp): a=9 b=5
Swapped back (no temp): a=5 b=9
```

=== Problem 6: Sum of even and odd numbers from 1 to N
<problem-6-sum-of-even-and-odd-numbers-from-1-to-n>
```bash
#!/bin/bash
read -p "Enter N: " N
se=0; so=0
for ((i = 1; i <= N; i++)); do
    if (( i % 2 == 0 )); then se=$((se + i)); else so=$((so + i)); fi
done
echo "Sum of even numbers 1..$N = $se"
echo "Sum of odd numbers  1..$N = $so"
```

```
Enter N: 10
Sum of even numbers 1..10 = 30
Sum of odd numbers  1..10 = 25
```

=== Problem 7: Multiplication table
<problem-7-multiplication-table>
```bash
#!/bin/bash
read -p "Enter a number: " n
for i in {1..10}; do
    printf "%2d x %2d = %3d\n" "$n" "$i" $((n * i))
done
```

- `printf "%2d"` pads numbers to width 2, so the columns line up.

```
Enter a number: 7
 7 x  1 =   7
 7 x  2 =  14
 ...
 7 x 10 =  70
```

=== Problem 8: Leap year
<problem-8-leap-year>
#strong[Logic:] leap if divisible by 4 and not by 100, #strong[or]
divisible by 400.

```bash
#!/bin/bash
read -p "Enter a year: " y
if (( (y % 4 == 0 && y % 100 != 0) || y % 400 == 0 )); then
    echo "$y is a LEAP year"
else
    echo "$y is NOT a leap year"
fi
```

```
Enter a year: 2024
2024 is a LEAP year
Enter a year: 1900
1900 is NOT a leap year
```

=== Problem 9: Temperature conversion
<problem-9-temperature-conversion>
#strong[Formula:] F \= C × 9/5 + 32 and C \= (F − 32) × 5/9.

```bash
#!/bin/bash
read -p "Convert (1) C to F or (2) F to C? " ch
read -p "Enter temperature: " t
if [ "$ch" = 1 ]; then
    echo "$t C = $(echo "scale=2; $t * 9 / 5 + 32" | bc) F"
else
    echo "$t F = $(echo "scale=2; ($t - 32) * 5 / 9" | bc) C"
fi
```

```
Convert (1) C to F or (2) F to C? 1
Enter temperature: 37
37 C = 98.60 F
```

=== Problem 10: Grade calculator (BD university GPA scale)
<problem-10-grade-calculator-bd-university-gpa-scale>
```bash
#!/bin/bash
read -p "Enter marks (0-100): " m
if ! [[ $m =~ ^[0-9]+$ ]] || (( m > 100 )); then   # input validation
    echo "Invalid marks"; exit 1
fi
if   (( m >= 80 )); then g="A+"; p=4.00
elif (( m >= 75 )); then g="A";  p=3.75
elif (( m >= 70 )); then g="A-"; p=3.50
elif (( m >= 65 )); then g="B+"; p=3.25
elif (( m >= 60 )); then g="B";  p=3.00
elif (( m >= 55 )); then g="B-"; p=2.75
elif (( m >= 50 )); then g="C+"; p=2.50
elif (( m >= 45 )); then g="C";  p=2.25
elif (( m >= 40 )); then g="D";  p=2.00
else g="F"; p=0.00
fi
echo "Marks: $m  Grade: $g  Point: $p"
```

- `[[ $m =~ ^[0-9]+$ ]]` checks the input is only digits; `!` reverses
  it. Always validate user input.

```
Enter marks (0-100): 76
Marks: 76  Grade: A  Point: 3.75
```

== Group B: Classic algorithms
<group-b-classic-algorithms>
=== Problem 11: Factorial (loop)
<problem-11-factorial-loop>
#strong[Logic:] n! \= 1 × 2 × 3 × … × n, and 0! \= 1. Start `fact=1` and
multiply by each number up to n.

```bash
#!/bin/bash
read -p "Enter a number: " n
if (( n < 0 )); then
    echo "Factorial is not defined for negative numbers"
    exit 1
fi
fact=1
for ((i = 2; i <= n; i++)); do
    fact=$((fact * i))
done
echo "$n! = $fact"
```

- `fact=1` (not 0), because multiplying by 0 always gives 0.
- Limit: Bash integers are 64-bit, so the largest correct factorial is
  #strong[20!]. For bigger values use `bc`.

```
Enter a number: 5
5! = 120
```

=== Problem 12: Factorial (recursion)
<problem-12-factorial-recursion>
#strong[Logic:] n! \= n × (n−1)!, and the function stops (base case) at
n ≤ 1.

```bash
#!/bin/bash
factorial() {
    local n=$1
    if (( n <= 1 )); then
        echo 1                                   # base case
    else
        local prev
        prev=$(factorial $((n - 1)))             # function calls itself
        echo $((n * prev))
    fi
}
read -p "Enter a number: " n
echo "$n! = $(factorial "$n")"
```

- `local` is essential: each call needs its own `n`.

```
Enter a number: 6
6! = 720
```

=== Problem 13: Fibonacci series (first N terms)
<problem-13-fibonacci-series-first-n-terms>
#strong[Logic:] each term is the sum of the previous two: 0, 1, 1, 2, 3,
5, 8 … Keep two variables and slide them forward.

```bash
#!/bin/bash
read -p "How many terms? " n
a=0; b=1
echo -n "Fibonacci: "
for ((i = 1; i <= n; i++)); do
    echo -n "$a "
    next=$((a + b))      # new term
    a=$b                 # slide forward
    b=$next
done
echo
```

```
How many terms? 10
Fibonacci: 0 1 1 2 3 5 8 13 21 34
```

=== Problem 14: Nth Fibonacci number (recursion)
<problem-14-nth-fibonacci-number-recursion>
```bash
#!/bin/bash
fib() {
    local n=$1
    if (( n < 2 )); then
        echo "$n"
    else
        echo $(( $(fib $((n - 1))) + $(fib $((n - 2))) ))
    fi
}
read -p "Which term (n)? " n
echo "F($n) = $(fib "$n")"
```

```
Which term (n)? 10
F(10) = 55
```

#callout("why", "Why?")[
#strong[Why is this slow?] Each call makes two more calls, so the work
doubles with every step (exponential time). Try n\=25 and compare with
Problem 13\'s loop. This is a classic viva question about recursion vs
iteration.

]
=== Problem 15: Prime number check
<problem-15-prime-number-check>
#strong[Logic:] a prime has no divisor other than 1 and itself. Testing
divisors up to √n is enough (`i * i <= n`).

```bash
#!/bin/bash
read -p "Enter a number: " n
if (( n < 2 )); then
    echo "$n is NOT prime"
    exit 0
fi
for ((i = 2; i * i <= n; i++)); do
    if (( n % i == 0 )); then
        echo "$n is NOT prime (divisible by $i)"
        exit 0
    fi
done
echo "$n is PRIME"
```

```
Enter a number: 29
29 is PRIME
Enter a number: 91
91 is NOT prime (divisible by 7)
```

=== Problem 16: All primes from 1 to N
<problem-16-all-primes-from-1-to-n>
```bash
#!/bin/bash
read -p "Enter N: " N
echo -n "Primes up to $N: "
count=0
for ((n = 2; n <= N; n++)); do
    is_prime=1
    for ((i = 2; i * i <= n; i++)); do
        if (( n % i == 0 )); then
            is_prime=0
            break            # no need to test more divisors
        fi
    done
    if (( is_prime )); then
        echo -n "$n "
        ((count++))
    fi
done
echo
echo "Total: $count primes"
```

- A #strong[flag] variable (`is_prime`) remembers the result of the
  inner loop.

```
Enter N: 50
Primes up to 50: 2 3 5 7 11 13 17 19 23 29 31 37 41 43 47
Total: 15 primes
```

=== Problem 17: GCD and LCM
<problem-17-gcd-and-lcm>
#strong[Logic (Euclid):] replace (x, y) with (y, x mod y) until y \= 0;
then x is the GCD. LCM \= a × b ÷ GCD.

```bash
#!/bin/bash
read -p "Enter two numbers: " a b
x=$a; y=$b
while (( y != 0 )); do
    r=$((x % y))
    x=$y
    y=$r
done
gcd=$x
lcm=$(( a * b / gcd ))
echo "GCD($a, $b) = $gcd"
echo "LCM($a, $b) = $lcm"
```

```
Enter two numbers: 12 18
GCD(12, 18) = 6
LCM(12, 18) = 36
```

=== Problem 18: Power and square root
<problem-18-power-and-square-root>
```bash
#!/bin/bash
read -p "Base and exponent: " b e
p=1
for ((i = 1; i <= e; i++)); do p=$((p * b)); done
echo "$b^$e = $p (loop)   = $((b ** e)) (built-in **)"
echo "sqrt($b) = $(echo "scale=4; sqrt($b)" | bc)"
```

```
Base and exponent: 2 10
2^10 = 1024 (loop)   = 1024 (built-in **)
sqrt(2) = 1.4142
```

=== Problem 19: Perfect number
<problem-19-perfect-number>
#strong[Logic:] a perfect number equals the sum of its proper divisors
(6 \= 1 + 2 + 3, 28 \= 1 + 2 + 4 + 7 + 14).

```bash
#!/bin/bash
read -p "Enter a number: " n
sum=0
for ((i = 1; i <= n / 2; i++)); do       # no divisor is bigger than n/2
    (( n % i == 0 )) && sum=$((sum + i))
done
if (( sum == n && n > 0 )); then
    echo "$n is a PERFECT number"
else
    echo "$n is NOT perfect (divisor sum = $sum)"
fi
```

```
Enter a number: 28
28 is a PERFECT number
```

=== Problem 20: Menu-driven calculator (decimals supported)
<problem-20-menu-driven-calculator-decimals-supported>
```bash
#!/bin/bash
read -p "Enter first number: " a
read -p "Enter second number: " b
echo "1) Add  2) Subtract  3) Multiply  4) Divide  5) Power"
read -p "Choose (1-5): " ch
case $ch in
    1) res=$(echo "$a + $b" | bc) ;;
    2) res=$(echo "$a - $b" | bc) ;;
    3) res=$(echo "$a * $b" | bc) ;;
    4) if [ "$(echo "$b == 0" | bc)" -eq 1 ]; then
           echo "Error: division by zero"; exit 1
       fi
       res=$(echo "scale=2; $a / $b" | bc) ;;
    5) res=$(echo "$a ^ $b" | bc) ;;
    *) echo "Invalid choice"; exit 1 ;;
esac
echo "Result = $res"
```

- `"$a * $b"` is inside quotes, so `*` is #strong[not] expanded into
  file names.
- `echo "$b == 0" | bc` prints 1 for true, which works even for `0.0`.

```
Enter first number: 10
Enter second number: 4
1) Add  2) Subtract  3) Multiply  4) Divide  5) Power
Choose (1-5): 4
Result = 2.50
```

== Group C: Digits and number types
<group-c-digits-and-number-types>
#strong[The digit trick used in this whole group:]

#table(
  columns: (auto,)*2 + (1fr,),
  align: (col, row) => (auto,auto,auto,).at(col),
  inset: (x: 7pt, y: 5pt),
  [Expression], [Gives], [Example with 1234],
  [`n % 10`],
  [Last digit],
  [4],
  [`n / 10`],
  [Number without its last digit],
  [123],
  [`rev * 10 + digit`],
  [Adds a digit to the right],
  [43 → 432],
)

Repeat `% 10` and `/ 10` in a `while (( temp > 0 ))` loop to visit every
digit from right to left.

=== Problem 21: Count the digits of a number
<problem-21-count-the-digits-of-a-number>
```bash
#!/bin/bash
read -p "Enter a number: " n
# Method 1: math (divide by 10 until 0)
num=${n#-}            # remove minus sign if any
count=0
temp=$num
while (( temp > 0 )); do
    temp=$((temp / 10))
    ((count++))
done
(( num == 0 )) && count=1
echo "Digits (math method)  : $count"
# Method 2: string length
echo "Digits (string method): ${#num}"
```

- Method 1 is what exams expect; method 2 shows the Bash shortcut
  `${#var}`.

```
Enter a number: 98765
Digits (math method)  : 5
Digits (string method): 5
```

=== Problem 22: Sum of digits
<problem-22-sum-of-digits>
```bash
#!/bin/bash
read -p "Enter a number: " n
sum=0
temp=$n
while (( temp > 0 )); do
    digit=$((temp % 10))      # last digit
    sum=$((sum + digit))
    temp=$((temp / 10))       # remove last digit
done
echo "Sum of digits of $n = $sum"
```

#strong[Dry run] for 1234: digit 4 → sum 4 → temp 123; digit 3 → sum 7 →
temp 12; digit 2 → sum 9 → temp 1; digit 1 → sum 10 → temp 0 → stop.

```
Enter a number: 1234
Sum of digits of 1234 = 10
```

=== Problem 23: Reverse a number
<problem-23-reverse-a-number>
```bash
#!/bin/bash
read -p "Enter a number: " n
rev=0
temp=$n
while (( temp > 0 )); do
    digit=$((temp % 10))
    rev=$((rev * 10 + digit))
    temp=$((temp / 10))
done
echo "Reverse of $n = $rev"
```

```
Enter a number: 12345
Reverse of 12345 = 54321
```

=== Problem 24: Palindrome number
<problem-24-palindrome-number>
#strong[Logic:] reverse it (Problem 23) and compare with the original.

```bash
#!/bin/bash
read -p "Enter a number: " n
rev=0; temp=$n
while (( temp > 0 )); do
    rev=$((rev * 10 + temp % 10))
    temp=$((temp / 10))
done
if (( rev == n )); then
    echo "$n is a PALINDROME"
else
    echo "$n is NOT a palindrome"
fi
```

```
Enter a number: 1331
1331 is a PALINDROME
```

=== Problem 25: Armstrong number
<problem-25-armstrong-number>
#strong[Logic:] sum of each digit raised to the power of the number of
digits equals the number. 153 \= 1³ + 5³ + 3³; 9474 \= 9⁴ + 4⁴ + 7⁴ +
4⁴.

```bash
#!/bin/bash
read -p "Enter a number: " n
len=${#n}                         # number of digits
sum=0; temp=$n
while (( temp > 0 )); do
    d=$((temp % 10))
    sum=$((sum + d ** len))
    temp=$((temp / 10))
done
if (( sum == n )); then
    echo "$n is an ARMSTRONG number"
else
    echo "$n is NOT an Armstrong number (got $sum)"
fi
```

```
Enter a number: 153
153 is an ARMSTRONG number
Enter a number: 9474
9474 is an ARMSTRONG number
```

=== Problem 26: Strong number
<problem-26-strong-number>
#strong[Logic:] sum of the factorials of the digits equals the number.
145 \= 1! + 4! + 5! \= 1 + 24 + 120.

```bash
#!/bin/bash
fact() { local f=1; for ((k = 2; k <= $1; k++)); do f=$((f * k)); done; echo $f; }
read -p "Enter a number: " n
sum=0; temp=$n
while (( temp > 0 )); do
    sum=$((sum + $(fact $((temp % 10)))))
    temp=$((temp / 10))
done
(( sum == n )) && echo "$n is a STRONG number" || echo "$n is NOT strong (got $sum)"
```

```
Enter a number: 145
145 is a STRONG number
```

=== Problem 27: Decimal to binary, octal and hex
<problem-27-decimal-to-binary-octal-and-hex>
#strong[Logic:] divide by 2 repeatedly and write the remainders in
#strong[reverse] order.

```bash
#!/bin/bash
read -p "Enter a decimal number: " n
bin=""; temp=$n
(( temp == 0 )) && bin=0
while (( temp > 0 )); do
    bin="$((temp % 2))$bin"     # put the remainder in front
    temp=$((temp / 2))
done
echo "Binary : $bin"
echo "Octal  : $(printf '%o' "$n")"
echo "Hex    : $(printf '%X' "$n")"
echo "Back to decimal: $((2#$bin))"
```

- `$((2#11001))` reads a number in base 2. Also works for `8#31` and
  `16#19`.

```
Enter a decimal number: 25
Binary : 11001
Octal  : 31
Hex    : 19
Back to decimal: 25
```

== Group D: Strings, arrays, patterns and files
<group-d-strings-arrays-patterns-and-files>
=== Problem 28: Palindrome string (ignores case and spaces)
<problem-28-palindrome-string-ignores-case-and-spaces>
```bash
#!/bin/bash
read -p "Enter a word or sentence: " s
clean=$(echo "$s" | tr -d ' ' | tr 'A-Z' 'a-z')   # remove spaces, lowercase
reversed=$(echo "$clean" | rev)
if [ "$clean" = "$reversed" ]; then
    echo "\"$s\" is a PALINDROME"
else
    echo "\"$s\" is NOT a palindrome"
fi
```

```
Enter a word or sentence: Never Odd Or Even
"Never Odd Or Even" is a PALINDROME
```

=== Problem 29: Reverse a string (without `rev`)
<problem-29-reverse-a-string-without-rev>
```bash
#!/bin/bash
read -p "Enter text: " s
r=""
for ((i = ${#s} - 1; i >= 0; i--)); do   # from last index down to 0
    r+="${s:i:1}"                         # take 1 character at position i
done
echo "Reversed: $r"
```

```
Enter text: Bangladesh
Reversed: hsedalgnaB
```

=== Problem 30: Count vowels, consonants, digits and spaces
<problem-30-count-vowels-consonants-digits-and-spaces>
```bash
#!/bin/bash
read -p "Enter text: " s
vowels=$(echo -n "$s" | tr -cd 'aeiouAEIOU' | wc -c)
consonants=$(echo -n "$s" | tr -cd 'a-zA-Z' | tr -d 'aeiouAEIOU' | wc -c)
digits=$(echo -n "$s" | tr -cd '0-9' | wc -c)
spaces=$(echo -n "$s" | tr -cd ' ' | wc -c)
echo "Vowels: $vowels  Consonants: $consonants  Digits: $digits  Spaces: $spaces"
```

- `tr -cd 'set'` \= #strong[d]elete everything in the
  #strong[c]omplement of the set, i.e. keep only those characters. Then
  `wc -c` counts them.
- `echo -n` avoids counting the newline.

```
Enter text: Hello World 2026
Vowels: 3  Consonants: 7  Digits: 4  Spaces: 2
```

=== Problem 31: Min, max, sum and average of an array
<problem-31-min-max-sum-and-average-of-an-array>
```bash
#!/bin/bash
arr=(45 12 78 3 56 90 23)
min=${arr[0]}; max=${arr[0]}; sum=0      # start with the first element
for x in "${arr[@]}"; do
    (( x < min )) && min=$x
    (( x > max )) && max=$x
    sum=$((sum + x))
done
echo "Array: ${arr[*]}"
echo "Min=$min Max=$max Sum=$sum Avg=$(echo "scale=2; $sum/${#arr[@]}" | bc)"
```

```
Array: 45 12 78 3 56 90 23
Min=3 Max=90 Sum=307 Avg=43.85
```

=== Problem 32: Linear search
<problem-32-linear-search>
```bash
#!/bin/bash
arr=(10 25 37 48 59 61)
read -p "Search for: " key
found=-1
for i in "${!arr[@]}"; do                # loop over indexes
    if (( arr[i] == key )); then found=$i; break; fi
done
if (( found >= 0 )); then
    echo "$key found at index $found"
else
    echo "$key not found"
fi
```

```
Search for: 48
48 found at index 3
```

=== Problem 33: Bubble sort
<problem-33-bubble-sort>
#strong[Logic:] compare neighbours and swap if they are in the wrong
order; after each pass the biggest value \"bubbles\" to the end.

```bash
#!/bin/bash
arr=(64 34 25 12 22 11 90)
echo "Original: ${arr[*]}"
n=${#arr[@]}
for ((i = 0; i < n - 1; i++)); do
    for ((j = 0; j < n - i - 1; j++)); do
        if (( arr[j] > arr[j+1] )); then
            tmp=${arr[j]}; arr[j]=${arr[j+1]}; arr[j+1]=$tmp   # swap
        fi
    done
done
echo "Bubble sorted: ${arr[*]}"
echo "Using sort   : $(printf "%s\n" 64 34 25 12 22 11 90 | sort -n | tr '\n' ' ')"
```

```
Original: 64 34 25 12 22 11 90
Bubble sorted: 11 12 22 25 34 64 90
Using sort   : 11 12 22 25 34 64 90
```

#callout("tip", "Real-world tip")[
in jobs, use `sort -n`. Write bubble sort to understand algorithms and
for exams.

]
=== Problem 34: Matrix addition (2 × 2)
<problem-34-matrix-addition-2-2>
#strong[Logic:] Bash has no 2-D arrays, so store the matrix in one array
using index \= row × cols + col.

```bash
#!/bin/bash
A=(1 2 3 4)
B=(5 6 7 8)
rows=2; cols=2
echo "A + B ="
for ((r = 0; r < rows; r++)); do
    for ((c = 0; c < cols; c++)); do
        i=$((r * cols + c))
        printf "%4d" $(( A[i] + B[i] ))
    done
    echo
done
```

```
A + B =
   6   8
  10  12
```

=== Problem 35: Star patterns (triangle and pyramid)
<problem-35-star-patterns-triangle-and-pyramid>
```bash
#!/bin/bash
read -p "Rows: " n
echo "Right triangle:"
for ((i = 1; i <= n; i++)); do
    for ((j = 1; j <= i; j++)); do echo -n "* "; done
    echo
done
echo "Pyramid:"
for ((i = 1; i <= n; i++)); do
    for ((s = i; s < n; s++)); do echo -n " "; done      # leading spaces
    for ((j = 1; j <= i; j++)); do echo -n "* "; done
    echo
done
```

- Outer loop \= rows; inner loops \= what goes on each row. Row i has (n
  − i) spaces and i stars.

```
Rows: 4
Right triangle:
*
* *
* * *
* * * *
Pyramid:
   *
  * *
 * * *
* * * *
```

=== Problem 36: Number triangle and Floyd\'s triangle
<problem-36-number-triangle-and-floyds-triangle>
```bash
#!/bin/bash
read -p "Rows: " n
echo "Number triangle:"
for ((i = 1; i <= n; i++)); do
    for ((j = 1; j <= i; j++)); do echo -n "$j "; done
    echo
done
echo "Floyd's triangle:"
k=1
for ((i = 1; i <= n; i++)); do
    for ((j = 1; j <= i; j++)); do printf "%-3d" $k; ((k++)); done
    echo
done
```

```
Rows: 4
Number triangle:
1
1 2
1 2 3
1 2 3 4
Floyd's triangle:
1
2  3
4  5  6
7  8  9  10
```

=== Problem 37: Word frequency in a file (top 5)
<problem-37-word-frequency-in-a-file-top-5>
Sample `sample.txt`:

```
Linux is free. Linux is fast.
Bash runs on Linux and Bash is fun.
```

```bash
#!/bin/bash
file=${1:-sample.txt}
[ -f "$file" ] || { echo "File not found: $file"; exit 1; }
tr -cs 'A-Za-z' '\n' < "$file" | tr 'A-Z' 'a-z' | sort | uniq -c | sort -nr | head -5
```

#table(
  columns: (auto,)*1 + (1fr,),
  align: (col, row) => (auto,auto,).at(col),
  inset: (x: 7pt, y: 5pt),
  [Step], [Does],
  [`tr -cs 'A-Za-z' '\n'`],
  [Turn every non-letter run into a newline: one word per line],
  [`tr 'A-Z' 'a-z'`],
  [Lowercase, so Linux \= linux],
  [`sort \| uniq -c`],
  [Count each word],
  [`sort -nr \| head -5`],
  [Highest counts first, top 5],
)

```
$ ./wordfreq.sh sample.txt
      3 linux
      3 is
      2 bash
      1 runs
      1 on
```

=== Problem 38: Your own `wc` (lines, words, characters)
<problem-38-your-own-wc-lines-words-characters>
```bash
#!/bin/bash
file=$1
if [ $# -ne 1 ] || [ ! -f "$file" ]; then
    echo "Usage: $0 <file>"; exit 1
fi
lines=0; words=0; chars=0
while IFS= read -r line; do
    ((lines++))
    set -- $line                      # split the line into $1 $2 ...
    words=$((words + $#))             # $# = how many words
    chars=$((chars + ${#line} + 1))   # +1 for the newline
done < "$file"
echo "Lines: $lines  Words: $words  Chars: $chars"
echo "Check with wc: $(wc -l -w -c < "$file")"
```

```
$ ./mywc.sh sample.txt
Lines: 2  Words: 14  Chars: 66
Check with wc:  2 14 66
```

=== Problem 39: Count files, folders and links in a directory
<problem-39-count-files-folders-and-links-in-a-directory>
```bash
#!/bin/bash
dir=${1:-.}                           # default: current folder
files=0; dirs=0; links=0
for item in "$dir"/*; do
    if   [ -L "$item" ]; then ((links++))   # check links FIRST (a link to a file is also -f)
    elif [ -d "$item" ]; then ((dirs++))
    elif [ -f "$item" ]; then ((files++))
    fi
done
echo "In $dir -> Files: $files  Directories: $dirs  Links: $links"
```

```
$ ./countfiles.sh demo
In demo -> Files: 2  Directories: 1  Links: 1
```

=== Problem 40: Number guessing game
<problem-40-number-guessing-game>
```bash
#!/bin/bash
secret=$(( RANDOM % 100 + 1 ))   # random number 1..100
tries=0
echo "I picked a number between 1 and 100."
while true; do
    read -p "Your guess: " g
    ((tries++))
    if (( g < secret )); then
        echo "Too low!"
    elif (( g > secret )); then
        echo "Too high!"
    else
        echo "Correct! You found $secret in $tries tries."
        break
    fi
done
```

Sample run (your secret number will differ):

```
I picked a number between 1 and 100.
Your guess: 50
Too high!
Your guess: 25
Too low!
Your guess: 37
Correct! You found 37 in 3 tries.
```

#callout("tip", "Idea")[
always guessing the middle of the remaining range finds any number in at
most 7 tries (2⁷ \= 128 \> 100).

]
== More problems to try yourself
<more-problems-to-try-yourself>
+ Print the sum of the series 1 + 1/2 + 1/3 + … + 1/n (use `bc`).
+ Check whether a string is an anagram of another (`fold -w1 | sort`).
+ Print the second largest number in an array.
+ Remove duplicate elements from an array.
+ Count how many times a given character appears in a string.
+ Convert a binary number to decimal without `$((2#...))`.
+ Print Pascal\'s triangle for n rows.
+ Find all Armstrong numbers between 1 and 1000.
+ Read marks of 5 subjects and print total, percentage and grade.
+ Validate a Bangladeshi mobile number (`^01[3-9][0-9]{8}$`).

#part-page("V", "Real-World Automation")
#chapter-heading("17", "Automation with cron, Backups and Logs")
cron runs your scripts automatically at fixed times. Combined with a
good script and a log file, it turns manual admin work into zero-touch
work.

== 17.1 Set up cron
<set-up-cron>
```bash
# Fedora (cron is called cronie)
$ sudo dnf install cronie
$ sudo systemctl enable --now crond      # start now and at every boot

# Ubuntu (usually pre-installed)
$ systemctl status cron
```

== 17.2 crontab commands
<crontab-commands>
```bash
$ crontab -e        # edit your scheduled jobs (choose nano the first time)
$ crontab -l        # list your jobs
$ crontab -r        # remove ALL your jobs (careful!)
$ sudo crontab -e   # root's jobs (for admin tasks)
```

== 17.3 The five time fields
<the-five-time-fields>
```
*  *  *  *  *   command to run
│  │  │  │  └─ day of week (0-7, 0 and 7 = Sunday)
│  │  │  └──── month (1-12)
│  │  └─────── day of month (1-31)
│  └────────── hour (0-23)
└───────────── minute (0-59)
```

#table(
  columns: (auto,)*2 + (1fr,),
  align: (col, row) => (auto,auto,auto,).at(col),
  inset: (x: 7pt, y: 5pt),
  [Symbol], [Meaning], [Example],
  [`*`],
  [Every value],
  [`*` in hour \= every hour],
  [`,`],
  [List],
  [`1,15` \= on the 1st and 15th],
  [`-`],
  [Range],
  [`1-5` \= Monday to Friday],
  [`/`],
  [Step],
  [`*/10` in minute \= every 10 minutes],
)

#table(
  columns: (auto,)*1 + (1fr,),
  align: (col, row) => (auto,auto,).at(col),
  inset: (x: 7pt, y: 5pt),
  [Schedule], [Meaning],
  [`0 2 * * *`],
  [Every day at 02:00],
  [`*/15 * * * *`],
  [Every 15 minutes],
  [`30 9 * * 1-5`],
  [09:30, Monday to Friday],
  [`0 10 * * 5`],
  [Every Friday at 10:00],
  [`0 0 1 * *`],
  [Midnight on the 1st of every month],
  [`@reboot`],
  [Once, when the computer starts],
  [`@daily` / `@hourly` / `@weekly`],
  [Shortcuts],
)

#strong[Example crontab:]

```
# Daily backup at 2 AM, log output and errors
0 2 * * * /home/rahim/scripts/backup.sh /home/rahim/Documents >> /home/rahim/logs/backup.log 2>&1

# Disk check every hour
0 * * * * /home/rahim/scripts/disk_alert.sh 85 >> /home/rahim/logs/disk.log 2>&1
```

#callout("mistake", "Common cron mistakes")[
(1) Using relative paths: cron starts in your home folder with a tiny
`PATH`, so always use #strong[full paths]. (2) Forgetting `chmod +x`.
(3) No logging, so you never see errors: always add `>> file.log 2>&1`.
(4) `%` has a special meaning in crontab; write `\%` (e.g. `date +\%F`).

]
#callout("tip", "Tip")[
use #link("https://crontab.guru")[crontab.guru] to check a schedule in
plain English.

]
== 17.4 One-time jobs: `at`
<one-time-jobs-at>
```bash
$ sudo dnf install at && sudo systemctl enable --now atd
$ echo "/home/rahim/scripts/backup.sh" | at 23:30     # run once tonight
$ atq                                                 # list pending jobs
$ atrm 3                                              # remove job 3
```

== 17.5 Modern alternative: systemd timers
<modern-alternative-systemd-timers>
On Fedora and Ubuntu servers, admins often use systemd timers instead of
cron. They log to `journalctl` and can catch up on missed runs.

`~/.config/systemd/user/backup.service`

```ini
[Unit]
Description=Daily backup

[Service]
Type=oneshot
ExecStart=/home/rahim/scripts/backup.sh /home/rahim/Documents
```

`~/.config/systemd/user/backup.timer`

```ini
[Unit]
Description=Run backup daily

[Timer]
OnCalendar=*-*-* 02:00:00
Persistent=true

[Install]
WantedBy=timers.target
```

```bash
$ systemctl --user daemon-reload
$ systemctl --user enable --now backup.timer
$ systemctl --user list-timers
```

== 17.6 Automatic backup script
<automatic-backup-script>
```bash
#!/bin/bash
# backup.sh - compress a folder into a dated archive and keep only the last 7
set -euo pipefail

SRC="${1:-$HOME/Documents}"          # folder to back up (argument or default)
DEST="${2:-$HOME/backups}"           # where archives go
KEEP=7                               # how many archives to keep
STAMP=$(date +%Y-%m-%d_%H-%M-%S)
NAME="backup_$(basename "$SRC")_$STAMP.tar.gz"

[ -d "$SRC" ] || { echo "ERROR: $SRC does not exist" >&2; exit 1; }
mkdir -p "$DEST"

tar -czf "$DEST/$NAME" -C "$(dirname "$SRC")" "$(basename "$SRC")"
echo "[$(date '+%F %T')] Created $DEST/$NAME ($(du -h "$DEST/$NAME" | cut -f1))"

# delete old backups, keep the newest $KEEP
ls -1t "$DEST"/backup_*.tar.gz | tail -n +$((KEEP + 1)) | xargs -r rm -f
echo "Backups kept: $(ls -1 "$DEST"/backup_*.tar.gz | wc -l)"
```

#table(
  columns: (auto,)*1 + (1fr,),
  align: (col, row) => (auto,auto,).at(col),
  inset: (x: 7pt, y: 5pt),
  [Line], [Why],
  [`set -euo pipefail`],
  [Stop on any error; never continue with a half-made backup],
  [`${1:-$HOME/Documents}`],
  [Use the argument, or a default if none is given],
  [`-C "$(dirname "$SRC")"`],
  [Store a short path inside the archive, not `/home/rahim/...`],
  [`ls -1t … \| tail -n +8`],
  [List newest first, skip the first 7, delete the rest (rotation)],
  [`xargs -r`],
  [Do nothing if there is nothing to delete],
)

```
$ ./backup.sh docs ./bk
[2026-11-23 20:10:52] Created ./bk/backup_docs_2026-11-23_20-10-52.tar.gz (4.0K)
Backups kept: 1
$ ./backup.sh nofolder ./bk
ERROR: nofolder does not exist
```

== 17.7 Disk space alert
<disk-space-alert>
```bash
#!/bin/bash
# disk_alert.sh - warn when any partition is above a limit
LIMIT=${1:-80}
df -h --output=pcent,target -x tmpfs -x devtmpfs | tail -n +2 | while read -r pct mount; do
    use=${pct%\%}                       # "85%" -> 85
    if (( use >= LIMIT )); then
        echo "WARNING: $mount is ${use}% full"
    else
        echo "OK: $mount is ${use}% full"
    fi
done
```

```
$ ./disk_alert.sh 80
OK: / is 29% full
WARNING: /opt/data is 93% full
```

To get an email or desktop notice, replace the `echo` with
`notify-send "Disk almost full"` (desktop) or
`mail -s "Disk alert" you@example.com` (server with mail set up).

== 17.8 Reading logs
<reading-logs>
#table(
  columns: (auto,)*1 + (1fr,),
  align: (col, row) => (auto,auto,).at(col),
  inset: (x: 7pt, y: 5pt),
  [Where], [What],
  [`journalctl`],
  [All systemd logs (Fedora\'s main log system)],
  [`journalctl -p err -b`],
  [Only errors since this boot],
  [`journalctl --since "1 hour ago"`],
  [Recent logs],
  [`/var/log/messages` (Fedora/RHEL)],
  [General system log (if rsyslog is installed)],
  [`/var/log/syslog` (Ubuntu)],
  [General system log],
  [`/var/log/secure` (Fedora) / `/var/log/auth.log` (Ubuntu)],
  [Logins, sudo use],
  [`/var/log/dnf.log` / `/var/log/apt/history.log`],
  [Package installs],
)

#callout("bangla", "বাংলা নোট")[
cron-এ সবসময় full path দিন এবং `>> log 2>&1` দিয়ে output সেভ করুন। নাহলে
script ফেইল করলেও আপনি জানতে পারবেন না।

]
#callout("practice", "Practice 17")[
(a) Schedule `date >> ~/cron_test.log` to run every minute; check the
log after 3 minutes, then remove the job. (b) Schedule `backup.sh` for
every Sunday at 11 PM.

]
#chapter-heading("18", "Mini Projects")
These five projects combine everything from Parts II–IV. Each one is
useful in real life and makes a good lab submission or portfolio piece
on GitHub.

== Project 1: System information report
<project-1-system-information-report>
```bash
#!/bin/bash
# sysinfo.sh - one-screen system report
line() { printf '%*s\n' 40 '' | tr ' ' '-'; }     # draws a 40-character line
line
echo " SYSTEM REPORT - $(date '+%d %b %Y %H:%M')"
line
printf "%-12s %s\n" "Hostname:" "$(hostname)"
printf "%-12s %s\n" "OS:" "$(. /etc/os-release && echo "$PRETTY_NAME")"
printf "%-12s %s\n" "Kernel:" "$(uname -r)"
printf "%-12s %s\n" "Uptime:" "$(uptime -p 2>/dev/null || uptime)"
printf "%-12s %s\n" "CPU cores:" "$(nproc)"
printf "%-12s %s\n" "Memory:" "$(free -h | awk '/Mem:/ {print $3 " used / " $2}')"
printf "%-12s %s\n" "Disk (/):" "$(df -h / | awk 'NR==2 {print $3 " used / " $2 " (" $5 ")"}')"
printf "%-12s %s\n" "Users:" "$(who | wc -l) logged in"
printf "%-12s %s\n" "Processes:" "$(ps -e --no-headers | wc -l)"
line
echo " Top 3 memory users:"
ps -eo pid,comm,%mem --sort=-%mem | head -4
line
```

Sample output (your values will differ):

```
----------------------------------------
 SYSTEM REPORT - 23 Nov 2026 20:10
----------------------------------------
Hostname:    fedora
OS:          Fedora Linux 43 (KDE Plasma Desktop Edition)
Kernel:      6.x.x
Uptime:      up 17 minutes
CPU cores:   8
Memory:      3.1Gi used / 15Gi
Disk (/):    13G used / 252G (6%)
Users:       1 logged in
Processes:   289
----------------------------------------
```

#strong[Concepts used:] functions, command substitution, `printf`
alignment, `awk` column picking, `source` of `/etc/os-release`.

== Project 2: File organizer
<project-2-file-organizer>
Sorts a messy Downloads folder into Images, Documents, Videos, Music,
Archives, Code and Others.

```bash
#!/bin/bash
# organize.sh - sort files into folders by type
DIR="${1:-$HOME/Downloads}"
cd "$DIR" || { echo "Cannot open $DIR"; exit 1; }
moved=0
for f in *; do
    [ -f "$f" ] || continue                     # skip folders
    ext="${f##*.}"; ext="${ext,,}"              # extension, lowercase
    case "$ext" in
        jpg|jpeg|png|gif|webp) folder="Images" ;;
        pdf|doc|docx|txt|odt|pptx|xlsx) folder="Documents" ;;
        mp4|mkv|avi|mov) folder="Videos" ;;
        mp3|wav|flac) folder="Music" ;;
        zip|tar|gz|rar|7z) folder="Archives" ;;
        sh|py|c|cpp|java|js) folder="Code" ;;
        *) folder="Others" ;;
    esac
    mkdir -p "$folder"
    mv -n -- "$f" "$folder/"                    # -n = never overwrite, -- = end of options
    echo "Moved: $f -> $folder/"
    ((moved++))
done
echo "Done. $moved files organized."
```

```
$ ./organize.sh dl
Moved: app.sh -> Code/
Moved: data.zip -> Archives/
Moved: my notes.txt -> Documents/
Moved: photo.JPG -> Images/
Moved: report.pdf -> Documents/
Moved: song.mp3 -> Music/
Moved: unknown.xyz -> Others/
Done. 7 files organized.
```

Note `my notes.txt` (with a space) worked because every variable is
quoted, and `photo.JPG` worked because `${ext,,}` lowercases the
extension.

== Project 3: Web log analyzer
<project-3-web-log-analyzer>
Sample `access.log` lines look like:
`10.0.0.5 - - [23/Nov/2026:10:03:00] "POST /login HTTP/1.1" 401 64`.

```bash
#!/bin/bash
# loganalyzer.sh - summary of a web server access log
LOG="${1:-access.log}"
[ -f "$LOG" ] || { echo "No log file: $LOG"; exit 1; }
echo "Total requests : $(wc -l < "$LOG")"
echo "Unique IPs     : $(awk '{print $1}' "$LOG" | sort -u | wc -l)"
echo
echo "Requests per status code:"
awk '{print $(NF-1)}' "$LOG" | sort | uniq -c | sort -nr
echo
echo "Top IPs:"
awk '{print $1}' "$LOG" | sort | uniq -c | sort -nr | head -3
echo
echo "Possible brute force (3+ failed logins, 401):"
awk '$(NF-1) == 401 {print $1}' "$LOG" | sort | uniq -c | awk '$1 >= 3 {print "  " $2 " -> " $1 " failures"}'
```

- `$(NF-1)` in awk \= the second-to-last field (the HTTP status code).

```
Total requests : 7
Unique IPs     : 3

Requests per status code:
      3 401
      2 200
      1 404
      1 403

Top IPs:
      3 192.168.1.10
      3 10.0.0.5
      1 192.168.1.11

Possible brute force (3+ failed logins, 401):
  10.0.0.5 -> 3 failures
```

== Project 4: Admin toolbox menu
<project-4-admin-toolbox-menu>
```bash
#!/bin/bash
# menu.sh - admin toolbox
while true; do
    clear
    echo "===== ADMIN TOOLBOX ====="
    echo "1) Disk usage"
    echo "2) Memory usage"
    echo "3) Top 5 CPU processes"
    echo "4) Network IPs"
    echo "5) Search a file"
    echo "6) Exit"
    read -p "Choose [1-6]: " c
    case $c in
        1) df -h ;;
        2) free -h ;;
        3) ps -eo pid,comm,%cpu --sort=-%cpu | head -6 ;;
        4) ip -brief address ;;
        5) read -p "File name: " f; find ~ -iname "*$f*" 2>/dev/null | head -20 ;;
        6) echo "Bye!"; exit 0 ;;
        *) echo "Invalid choice" ;;
    esac
    read -p "Press Enter to continue..."
done
```

== Project 5: Bulk user creator (admin, run with sudo)
<project-5-bulk-user-creator-admin-run-with-sudo>
Input file `users.txt`, one username per line. The script creates each
user with a random password and saves the list for the admin.

```bash
#!/bin/bash
# bulk_users.sh - create users from a file (run: sudo ./bulk_users.sh users.txt)
set -euo pipefail
[ "$EUID" -eq 0 ] || { echo "Run as root (sudo)"; exit 1; }   # EUID 0 = root
FILE=${1:?Usage: $0 users.txt}
OUT="created_users_$(date +%F).txt"

while IFS= read -r user; do
    [ -z "$user" ] && continue                          # skip empty lines
    if id "$user" &>/dev/null; then
        echo "SKIP: $user already exists"
        continue
    fi
    pass=$(head -c 200 /dev/urandom | tr -dc 'A-Za-z0-9' | cut -c1-12)   # 12-char random password
    useradd -m -s /bin/bash "$user"
    echo "$user:$pass" | chpasswd
    chage -d 0 "$user"                                  # force password change at first login
    echo "$user $pass" >> "$OUT"
    echo "CREATED: $user"
done < "$FILE"
chmod 600 "$OUT"                                         # only root can read the passwords
echo "Saved to $OUT"
```

Tested output (users.txt \= `testuser1`, an empty line, `root`):

```
$ sudo ./bulk_users.sh users.txt
CREATED: testuser1
SKIP: root already exists
Saved to created_users_2026-11-23.txt
```

#callout("why", "Why?")[
#strong[Why `head -c 200 … | cut -c1-12` and not
`tr … < /dev/urandom | head -c 12`?] The second version looks fine, but
under `set -o pipefail` it kills the script with #strong[exit code 141]
(SIGPIPE). `head` closes the pipe early, so `tr`, which reads the
endless `/dev/urandom`, is killed, and pipefail reports that as a
failure. Reading a fixed amount first avoids it.

]
#callout("danger", "Safety")[
test this inside a VM first. Remove a test user with
`sudo userdel -r username`.

]
== Project ideas for your portfolio
<project-ideas-for-your-portfolio>
#table(
  columns: (auto,)*1 + (1fr,),
  align: (col, row) => (auto,auto,).at(col),
  inset: (x: 7pt, y: 5pt),
  [Project], [Skills practised],
  [Website uptime checker (`curl -s -o /dev/null -w "%{http_code}"`)],
  [Loops, curl, logging, cron],
  [Duplicate file finder (`md5sum`, `sort`, `uniq -w32 -d`)],
  [Pipes, hashing],
  [To-do list manager (add/list/done in a text file)],
  [Arguments, `case`, `sed -i`],
  [Student result processor from a CSV],
  [`awk`, arrays, `printf` reports],
  [Git auto-commit backup of your notes],
  [cron, git, exit codes],
  [Server health dashboard written to an HTML file],
  [Here-docs, system commands],
)

#callout("practice", "Practice 18")[
Upload Projects 1–3 to a GitHub repository with a README that shows how
to run each one.

]
#part-page("VI", "Mastery")
#chapter-heading("19", "Best Practices, Security and ShellCheck")
Master-level scripts are safe, readable and predictable. Follow the
template and rules below, and let ShellCheck catch the rest.

== 19.1 A professional script template
<a-professional-script-template>
```bash
#!/usr/bin/env bash
#
# Name:        script_name.sh
# Description: What this script does in one line
# Author:      Your Name
# Usage:       ./script_name.sh [-v] <input>
#
set -euo pipefail                      # safe mode (Chapter 15)
IFS=$'\n\t'                            # split only on newlines and tabs

SCRIPT_NAME=$(basename "$0")            # assign first, then make readonly
readonly SCRIPT_NAME
readonly LOG_FILE="/tmp/${SCRIPT_NAME%.sh}.log"
VERBOSE=0

log()   { echo "[$(date '+%F %T')] $*" | tee -a "$LOG_FILE"; }
die()   { echo "ERROR: $*" >&2; exit 1; }
usage() { echo "Usage: $SCRIPT_NAME [-v] <input>"; exit 1; }
cleanup() { :; }                       # remove temp files here
trap cleanup EXIT

main() {
    while getopts "vh" opt; do
        case $opt in
            v) VERBOSE=1 ;;
            h|*) usage ;;
        esac
    done
    shift $((OPTIND - 1))
    [ $# -ge 1 ] || usage

    local input=$1
    [ -e "$input" ] || die "Input not found: $input"
    log "Processing $input"
    if (( VERBOSE )); then log "Verbose mode on"; fi
}

main "$@"
```

#callout("why", "Why?")[
#strong[Why `#!/usr/bin/env bash`?] It finds Bash wherever it is
installed (e.g. `/opt/homebrew/bin/bash` on macOS), so the script is
more portable than with `#!/bin/bash`.

]
#callout("mistake", "Common mistake")[
#strong[Common mistake found while testing this template:] the last line
of `main` was first written as `(( VERBOSE )) && log "..."`. Without
`-v`, `(( VERBOSE ))` is false, so the line returns 1 and, with
`set -e`, the #strong[whole script exited with code 1] even though it
worked. Use a full `if ... fi` for the last command of a function or
script under `set -e`.

]
== 19.2 The 15 golden rules
<the-15-golden-rules>
+ Quote every variable: `"$var"`, `"$@"`, `"${arr[@]}"`.
+ Use `set -euo pipefail` in serious scripts.
+ Use `$( )` instead of backticks.
+ Use `[[ ]]` for strings and `(( ))` for numbers in Bash scripts.
+ Use `local` for variables inside functions.
+ Check arguments and inputs before using them.
+ Send errors to stderr: `echo "error" >&2`, and exit with non-zero
  codes.
+ Use `cd dir || exit`, because a failed `cd` followed by `rm` is a
  disaster.
+ Protect dangerous paths: `rm -rf "${dir:?}"/*` stops if `dir` is
  empty.
+ Use `mktemp` for temporary files, never fixed names like
  `/tmp/temp.txt`.
+ Read files with `while IFS= read -r line`, not
  `for line in $(cat file)`.
+ Use meaningful names: `backup_dir` instead of `bd`.
+ Comment the #strong[why], not the obvious #strong[what].
+ Keep functions small: one job each.
+ Run `shellcheck` before every commit.

== 19.3 ShellCheck: your automatic reviewer
<shellcheck-your-automatic-reviewer>
```bash
$ sudo dnf install ShellCheck        # Fedora
$ sudo apt install shellcheck        # Ubuntu
```

A buggy script, `bad.sh`:

```bash
#!/bin/bash
file=$1
if [ $file == "" ]; then
  echo "no file"
fi
cat $file | grep error
cd /tmp/data
rm -rf $dir/*
```

Real ShellCheck output (shortened):

```
In bad.sh line 3:
if [ $file == "" ]; then
     ^---^ SC2086 (info): Double quote to prevent globbing and word splitting.

In bad.sh line 7:
cd /tmp/data
^----------^ SC2164 (warning): Use 'cd ... || exit' or 'cd ... || return' in case cd fails.

In bad.sh line 8:
rm -rf $dir/*
       ^----^ SC2115 (warning): Use "${var:?}" to ensure this never expands to /* .
       ^--^ SC2154 (warning): dir is referenced but not assigned.
```

Fixed version:

```bash
#!/bin/bash
file=${1:-}
if [[ -z $file ]]; then
  echo "no file"; exit 1
fi
grep error "$file"                 # no need for cat
cd /tmp/data || exit 1
dir=/tmp/data/cache
rm -rf "${dir:?}"/*
```

#callout("tip", "Tip")[
Every warning has a wiki page, e.g. shellcheck.net/wiki/SC2086, that
explains the problem and the fix. Reading them is one of the fastest
ways to master Bash.

]
== 19.4 Security checklist
<security-checklist>
#table(
  columns: (auto,)*2 + (1fr,),
  align: (col, row) => (auto,auto,auto,).at(col),
  inset: (x: 7pt, y: 5pt),
  [Risk], [Bad], [Good],
  [Running user input as code],
  [`eval "$input"`],
  [Avoid `eval`; use `case` to allow only known values],
  [Passwords in scripts],
  [`PASS="admin123"`],
  [Read from a file with `chmod 600`, or use `read -s`],
  [Secrets in command lines],
  [`mysql -pSecret` (visible in `ps`)],
  [Config files, environment variables],
  [World-writable scripts],
  [`chmod 777 script.sh`],
  [`chmod 750` or `700`],
  [Predictable temp files],
  [`/tmp/data.txt`],
  [`tmp=$(mktemp)`],
  [Running everything as root],
  [`sudo ./everything.sh`],
  [Use `sudo` only for the commands that need it],
  [Downloading and running],
  [`curl url \| bash`],
  [Download, read it, then run],
  [Unquoted variables in `rm`],
  [`rm -rf $dir/`],
  [`rm -rf "${dir:?}/"`],
)

== 19.5 Performance tips
<performance-tips>
- Prefer Bash built-ins (`${var//a/b}`, `$(( ))`, `[[ ]]`) over starting
  new programs (`sed`, `expr`) inside big loops.
- Avoid `cat file | grep x`; use `grep x file` (one process fewer).
- Process big files with one `awk` command instead of a `while read`
  loop with many commands inside.
- For heavy number crunching or complex data, switch to Python. Bash is
  best for gluing commands together.

== 19.6 Portability: Bash vs POSIX sh
<portability-bash-vs-posix-sh>
#table(
  columns: (auto,)*1 + (1fr,),
  align: (col, row) => (auto,auto,).at(col),
  inset: (x: 7pt, y: 5pt),
  [Bash feature], [POSIX `sh` alternative],
  [`[[ ]]`],
  [`[ ]` with quotes],
  [`(( i++ ))`],
  [`i=$((i + 1))`],
  [Arrays],
  [Positional parameters (`set -- a b c`)],
  [`function name {`],
  [`name() {`],
  [`echo -e`],
  [`printf`],
  [`{1..5}`],
  [`seq 1 5` or a `while` loop],
  [`source file`],
  [`. file`],
)

Use `#!/bin/sh` only if you avoid every Bash feature; test with
`dash script.sh` (Ubuntu) to be sure.

== 19.7 Where to go next
<where-to-go-next>
- #strong[Git and GitHub:] version control for your scripts.
- #strong[Vim] fluency for fast server editing.
- #strong[Docker:] containers are configured with shell commands.
- #strong[Ansible:] automation for many servers (the next step after
  Bash scripts).
- #strong[Python:] for tasks too complex for Bash.
- #strong[Certifications:] Linux Foundation LFCS, Red Hat RHCSA (Fedora
  skills transfer directly), CompTIA Linux+.
- #strong[Practice sites:] OverTheWire Bandit (Linux command games),
  HackerRank Linux Shell, Exercism Bash track.

#callout("bangla", "বাংলা নোট")[
Fedora ব্যবহার করলে RHCSA-এর জন্য আপনি এক ধাপ এগিয়ে আছেন, কারণ Red Hat আর
Fedora-র কমান্ড (dnf, systemctl, SELinux) প্রায় একই।

]
#callout("practice", "Practice 19")[
Run ShellCheck on every script you wrote in Chapters 10–18 and fix every
warning.

]
#part-page("A", "Appendices")
#chapter-heading("A", "One-Page Cheat Sheet")
#table(
  columns: (auto,)*1 + (1fr,),
  align: (col, row) => (auto,auto,).at(col),
  inset: (x: 7pt, y: 5pt),
  [Task], [Command],
  [Where am I / go / list],
  [`pwd` · `cd dir` · `cd ..` · `cd -` · `ls -lah`],
  [Create],
  [`touch f` · `mkdir -p a/b` · `echo text > f`],
  [Copy / move / delete],
  [`cp -r src dst` · `mv old new` · `rm -i f` · `rm -r dir`],
  [View],
  [`cat f` · `less f` · `head -n 5 f` · `tail -f log`],
  [Find],
  [`find . -name "*.sh"` · `grep -rn "text" dir` · `which cmd`],
  [Permissions],
  [`chmod 755 f` · `chmod +x f` · `sudo chown user:group f`],
  [Processes],
  [`ps aux` · `top` · `kill PID` · `kill -9 PID` · `cmd &` · `jobs` ·
  `fg`],
  [Services],
  [`systemctl status/start/stop/enable name` · `journalctl -u name`],
  [Disk / memory],
  [`df -h` · `du -sh dir` · `free -h` · `lsblk`],
  [Network],
  [`ip a` · `ping -c 4 host` · `ss -tuln` · `curl -I url` ·
  `ssh user@host`],
  [Archive],
  [`tar -czvf a.tar.gz dir` · `tar -xzvf a.tar.gz`],
  [Packages],
  [Fedora `sudo dnf install x` · Ubuntu `sudo apt install x`],
  [Redirect],
  [`>` overwrite · `>>` append · `2>` errors · `&>` both · `\|` pipe],
  [Text],
  [`sort` · `uniq -c` · `cut -d, -f1` · `tr a-z A-Z` · `wc -l` ·
  `sed 's/a/b/g'` · `awk '{print $1}'`],
  [Help],
  [`man cmd` · `cmd --help` · `help builtin` · `type cmd`],
)

#strong[Scripting syntax at a glance]

```bash
#!/bin/bash
set -euo pipefail

name="Rahim"                         # variable (no spaces around =)
read -p "Age: " age                  # input
echo "Hi $name, ${#name} letters"    # output, string length
sum=$((a + b))                       # integer math
out=$(date +%F)                      # command substitution

if [[ $age -ge 18 ]]; then echo adult; elif [[ $age -ge 13 ]]; then echo teen; else echo child; fi
case $x in a|b) echo AB ;; *) echo other ;; esac

for i in {1..5}; do echo $i; done
for ((i=0; i<5; i++)); do echo $i; done
while [ $n -gt 0 ]; do ((n--)); done
while IFS= read -r line; do echo "$line"; done < file.txt

f() { local x=$1; echo $((x * 2)); }   # function
r=$(f 5)                                # capture result

arr=(a b c); echo "${arr[0]}" "${#arr[@]}" "${arr[@]}"
declare -A m; m[key]=value; echo "${m[key]}"

[ -f file ] && echo exists            # file test
[ $# -eq 2 ] || { echo "Usage: $0 a b"; exit 1; }
trap 'rm -f "$tmp"' EXIT              # cleanup
```

#table(
  columns: (auto,)*1 + (1fr,),
  align: (col, row) => (auto,auto,).at(col),
  inset: (x: 7pt, y: 5pt),
  [Special variable], [Meaning],
  [`$0 $1 $# $@`],
  [script name, first arg, arg count, all args],
  [`$? $$ $!`],
  [last exit status, shell PID, last background PID],
)

#chapter-heading("B", "Viva and Interview Questions")
== B.1 OS and Linux basics (university viva)
<b.1-os-and-linux-basics-university-viva>
+ #strong[What is an operating system?] Software that manages hardware
  and provides services to programs (process, memory, file, device
  management, security).
+ #strong[Kernel vs shell?] The kernel controls hardware; the shell is a
  user program that reads commands and asks the kernel to run them.
+ #strong[What is a process? A thread?] A process is a running program
  with its own memory. A thread is a smaller unit of execution inside a
  process that shares its memory.
+ #strong[Process states?] New, Ready, Running, Waiting (Blocked),
  Terminated.
+ #strong[What is a zombie process? An orphan?] Zombie: finished, but
  the parent has not read its exit status. Orphan: parent died first;
  systemd (PID 1) adopts it.
+ #strong[What does `fork()` do?] Creates a child process as a copy of
  the parent. `exec()` then replaces it with a new program.
+ #strong[What is a system call?] A request from a user program to the
  kernel, e.g. `open`, `read`, `write`, `fork`.
+ #strong[User space vs kernel space?] User programs run with limited
  rights; the kernel runs with full hardware access.
+ #strong[What is virtual memory? Paging? Swap?] Each process sees its
  own address space; memory is divided into pages; unused pages can be
  moved to swap on disk.
+ #strong[What is a deadlock?] Two or more processes wait for each
  other\'s resources forever. Four conditions: mutual exclusion, hold
  and wait, no preemption, circular wait.
+ #strong[Name CPU scheduling algorithms.] FCFS, SJF, Round Robin,
  Priority, Multilevel Queue. Linux uses a fair scheduler (CFS/EEVDF).
+ #strong[What is an inode?] A data structure storing a file\'s metadata
  (size, owner, permissions, disk location), but not its name.
+ #strong[Hard link vs soft link?] Hard link \= another name for the
  same inode; soft link \= a shortcut file pointing to a path.
+ #strong[What is the root directory? Root user?] `/` is the top of the
  file tree; `root` is the administrator account (UID 0).
+ #strong[What is the boot process?] BIOS/UEFI → GRUB → kernel → systemd
  → services → login.

== B.2 Commands and permissions
<b.2-commands-and-permissions>
#block[
#set enum(numbering: "1.", start: 16)
+ #strong[Explain `chmod 755`.] Owner rwx (7), group r-x (5), others r-x
  (5).
+ #strong[What does `umask 022` do?] Removes write permission for group
  and others from new files (files 644, folders 755).
+ #strong[Difference between `>` and `>>`?] `>` overwrites the file;
  `>>` appends to it.
+ #strong[What does `2>&1` mean?] Send stderr (2) to the same place as
  stdout (1).
+ #strong[What is a pipe?] `|` connects the output of one command to the
  input of the next.
+ #strong[`grep` vs `find`?] `grep` searches inside file contents;
  `find` searches for files by name, size, time, type.
+ #strong[`kill` vs `kill -9`?] `kill` sends SIGTERM (polite, can be
  handled); `-9` sends SIGKILL (immediate, cannot be caught).
+ #strong[What is `sudo`?] Runs one command with root privileges after
  checking your password and permissions.
+ #strong[How do you see which process uses a port?]
  `sudo ss -tulpn | grep :80` (or `lsof -i :80`).
+ #strong[What is SUID?] A permission bit that runs a program with its
  owner\'s privileges (e.g. `passwd`).
]

== B.3 Shell scripting
<b.3-shell-scripting>
#block[
#set enum(numbering: "1.", start: 26)
+ #strong[What is a shebang?] The first line `#!/bin/bash` that tells
  the system which interpreter runs the script.
+ #strong[Why `./script.sh` and not `script.sh`?] The current folder is
  not in `$PATH` for security reasons.
+ #strong[`$*` vs `$@`?] Unquoted they are the same. Quoted, `"$@"`
  keeps each argument separate; `"$*"` joins them into one string.
+ #strong[What is `$?`?] The exit status of the last command; 0 \=
  success.
+ #strong[Single vs double quotes?] Single quotes keep everything
  literal; double quotes allow `$variable` and `$(command)` expansion.
+ #strong[`[ ]` vs `[[ ]]`?] `[ ]` is the POSIX test command; `[[ ]]` is
  a Bash keyword with pattern/regex matching and safer word handling.
+ #strong[How do you do decimal math?] With `bc`
  (`echo "scale=2; 10/3" | bc`) or `awk`.
+ #strong[How do you debug a script?] `bash -x script.sh`,
  `set -x`/`set +x`, `bash -n` for syntax, and `shellcheck`.
+ #strong[What does `set -e` do?] Exits the script as soon as a command
  fails.
+ #strong[What is `trap`?] Runs a command when the script exits or
  receives a signal; used for cleanup.
+ #strong[How do you read a file line by line?]
  `while IFS= read -r line; do ...; done < file`
+ #strong[How do you return a value from a function?] `echo` it and
  capture with `$( )`; `return` only gives an exit status (0–255).
+ #strong[What is the difference between `source script.sh` and
  `./script.sh`?] `source` runs in the current shell (variables stay);
  `./` runs in a new child shell.
+ #strong[Why does `x = 5` fail?] Bash treats `x` as a command;
  assignment must have no spaces around `=`.
+ #strong[How do you schedule a script daily at 2 AM?] `crontab -e` and
  add `0 2 * * * /full/path/script.sh >> /path/log 2>&1`.
]

== B.4 DevOps / SysAdmin job interview
<b.4-devops-sysadmin-job-interview>
#block[
#set enum(numbering: "1.", start: 41)
+ #strong[A disk is 100% full. What do you do?] `df -h` to find the
  partition, `du -h --max-depth=1 / | sort -h` to find big folders,
  check `/var/log` and old backups, `journalctl --vacuum-size=500M`, and
  look for deleted-but-open files with `lsof +L1`.
+ #strong[The server is slow. How do you investigate?] `uptime` (load),
  `top`/`htop` (CPU and memory), `free -h` (swap use), `iostat` or
  `iotop` (disk), `ss -s` (network connections), then
  `journalctl -p err`.
+ #strong[A service will not start.] `systemctl status name`,
  `journalctl -u name -n 50`, check the config syntax, ports
  (`ss -tulpn`), permissions, and SELinux (`ausearch -m avc` on
  Fedora/RHEL).
+ #strong[How do you find the 10 biggest files?]
  `find / -type f -exec du -h {} + 2>/dev/null | sort -rh | head -10`
+ #strong[How do you count unique IPs in an access log?]
  `awk '{print $1}' access.log | sort -u | wc -l`
+ #strong[How do you replace a word in many files?]
  `sed -i 's/old/new/g' *.conf` (back up first or use `-i.bak`).
+ #strong[How do you run a command on 50 servers?] A loop over `ssh` for
  small jobs; Ansible for real infrastructure.
+ #strong[What is the difference between cron and a systemd timer?] Both
  schedule jobs; timers integrate with journald logging, dependencies
  and can catch up on missed runs (`Persistent=true`).
+ #strong[How do you keep secrets out of scripts?] Environment
  variables, protected files (`chmod 600`), or a secret manager; never
  commit them to Git.
+ #strong[Write a one-liner to show the top 5 memory-using processes.]
  `ps -eo pid,comm,%mem --sort=-%mem | head -6`
]

#chapter-heading("C", "Answers to Practice Tasks")
#strong[Practice 1:] (a) A program is a file on disk; a process is that
program running in memory with a PID. (b) systemd (PID 1). (c)
`cat /etc/os-release` shows e.g. `NAME="Fedora Linux"`.

#strong[Practice 2:] `sudo dnf install tree bc`, then `tree ~/practice`
and `echo "2.5 * 4" | bc` → `10.0`.

#strong[Practice 3:] (a) `cd /var/log` then `cd -`. (b) `ls -lah ~`. (c)
`alias c='clear'`.

#strong[Practice 4:] (a) `mkdir -p ~/practice/demo/{docs,img,src}` (b)
`touch file{1..10}.txt` (c) `find ~/practice -name "*.txt"` then
`tar -czvf demo.tar.gz -C ~/practice demo`.

#strong[Practice 5:] (a) `chmod 600 file` (b) `rwxr-x---` \= 750 (c)
Without `x` you cannot `cd` into the folder or reach the files inside
it.

#strong[Practice 6:] (a) `sleep 300 &` → `jobs` → `fg %1` → Ctrl+Z →
`kill %1` (b) `echo $$` (c) SIGKILL (9) and SIGSTOP (19).

#strong[Practice 7:] (a) `ls /etc > etc.txt; wc -l < etc.txt` (b)
`ls /nope 2> err.txt` (c) `cut -d: -f1 /etc/passwd | sort`

#strong[Practice 8:] (a)
`awk -F: '$7 == "/bin/bash" {print $1}' /etc/passwd` (b)
`tr ',' '\t' < people.csv` (c)
`awk -F, '$2 > max {max=$2; name=$1} END {print name}' people.csv` →
`karim`

#strong[Practice 9:] (a) `df -h /` (b) `ip a` (look for `inet`) (c) add
`export PATH="$PATH:$HOME/bin"` to `~/.bashrc`, then `source ~/.bashrc`.

#strong[Practice 10:]

```bash
#!/bin/bash
read -p "Name: " name
read -p "City: " city
echo "Hi $name from $city! Today is $(date +%A). You are using $SHELL."
```

#strong[Practice 11 (fixed):]

```bash
count=0                       # no spaces around =
if [ $count -lt 5 ]; then     # spaces inside [ ]
for i in {1..3}               # no spaces in braces
file="my report.txt"          # quote values with spaces
[ $x -gt 10 ]                 # -gt, because > is redirection
```

#strong[Practice 12 (a):]

```bash
read -p "Enter a number: " n
if (( n > 0 )); then echo "Positive"
elif (( n < 0 )); then echo "Negative"
else echo "Zero"; fi
```

#block[
#set enum(numbering: "(a)", start: 2)
+ Use `[ -e "$f" ]`, then `[ -f "$f" ]` / `[ -d "$f" ]`. (c) See the
  menu in Section 13.6.
]

#strong[Practice 13:] (a) `for ((i=2; i<=20; i+=2)); do echo $i; done`
or `seq 2 2 20` (b)
`for f in *.txt; do mv -- "$f" "${f%.txt}.bak"; done` (c)
`until [ "$p" = "linux123" ]; do read -sp "Password: " p; echo; done`

#strong[Practice 14:] (a)
`max() { if (( $1 > $2 )); then echo $1; else echo $2; fi; }` (b)
`for i in "${!names[@]}"; do echo "$i: ${names[i]}"; done` (c)
`f=report_2026.pdf; echo ${f%.*} ${f##*.}` → `report_2026 pdf`

#strong[Practice 15:]

```bash
#!/bin/bash
set -euo pipefail
trap 'echo "Done"' EXIT
if [ $# -ne 2 ]; then
    echo "Usage: $0 <a> <b>" >&2
    exit 1
fi
if [ "$2" -eq 0 ]; then
    echo "Error: division by zero" >&2
    exit 1
fi
echo "Result: $(echo "scale=2; $1 / $2" | bc)"
```

Tested: `./div.sh 10 4` → `Result: 2.50` then `Done`; `./div.sh 5 0` →
error, `Done`, exit 1.

#strong[Practice 17:] (a) `* * * * * date >> /home/rahim/cron_test.log`,
then remove with `crontab -e`. (b)
`0 23 * * 0 /home/rahim/scripts/backup.sh`

#strong[Practices 16, 18, 19] are open projects: compare your output
with the examples in those chapters and run `shellcheck` on your code.

#chapter-heading("D", "Glossary")
#table(
  columns: (auto,)*1 + (1fr,),
  align: (col, row) => (auto,auto,).at(col),
  inset: (x: 7pt, y: 5pt),
  [Term], [Meaning],
  [Absolute path],
  [A path from root, starting with `/`],
  [Argument],
  [A value given to a command or script (`ls /tmp` → `/tmp`)],
  [Bash],
  [Bourne Again SHell, the default Linux shell],
  [Brace expansion],
  [`{a,b}` or `{1..5}` turned into a list by the shell],
  [Builtin],
  [A command inside Bash itself (`cd`, `echo`, `read`)],
  [Command substitution],
  [`$(cmd)`: replace with the command\'s output],
  [cron],
  [Service that runs scheduled jobs],
  [Daemon],
  [A background service process (names often end in d: `sshd`,
  `crond`)],
  [Environment variable],
  [A variable passed to child processes (`PATH`, `HOME`)],
  [Exit status],
  [Number a command returns; 0 \= success],
  [File descriptor],
  [Number for an open stream: 0 stdin, 1 stdout, 2 stderr],
  [Glob],
  [Wildcard pattern for file names (`*.txt`)],
  [Here document],
  [`<< EOF … EOF`: multi-line input inside a script],
  [IFS],
  [Internal Field Separator: characters used to split words],
  [Inode],
  [Metadata record of a file on disk],
  [Kernel],
  [Core of the OS that controls hardware],
  [PID],
  [Process ID number],
  [Pipe],
  [`\|` connecting one command\'s output to another\'s input],
  [POSIX],
  [Standard that defines portable shell behaviour],
  [Quoting],
  [Using `' '`, `" "` or `\` to control how the shell treats text],
  [Redirection],
  [Sending input/output to or from files (`>`, `<`, `2>`)],
  [Regex],
  [Regular expression: a text-matching pattern],
  [Relative path],
  [A path from the current folder],
  [Root],
  [The admin user, or the top directory `/`],
  [Shebang],
  [`#!` line choosing the interpreter],
  [Signal],
  [A message to a process (SIGTERM, SIGKILL, SIGINT)],
  [stdin / stdout / stderr],
  [Standard input / output / error streams],
  [sudo],
  [Run a command as root],
  [systemd],
  [Init system and service manager (PID 1)],
  [Word splitting],
  [Bash breaking unquoted text into words at spaces],
)

#end-mark()
#callout("bangla", "বাংলা নোট")[
শেখা শেষ হয় না। প্রতিদিন একটা ছোট script লিখুন, এক মাস পর নিজেই পার্থক্য
বুঝতে পারবেন। শুভকামনা!

]
