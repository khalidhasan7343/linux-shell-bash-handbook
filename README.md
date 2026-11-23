# The Complete Linux Shell & Bash Scripting Handbook

**From Zero to Master** — operating system basics, everyday Linux commands and Bash shell
scripting, with real terminal outputs, a full chapter on space-sensitivity and quoting,
**40 solved problems** and **5 mini projects**. Written in simple English with Bangla notes.

[![License: CC BY-NC-SA 4.0](https://img.shields.io/badge/License-CC%20BY--NC--SA%204.0-lightgrey.svg)](LICENSE)
[![Made with Typst](https://img.shields.io/badge/Made%20with-Typst-239DAD.svg)](https://typst.app)
![Language: English + Bangla](https://img.shields.io/badge/Language-English%20%2B%20Bangla-blue.svg)

Prepared by **MD Khalid Hasan**, Computer Science and Engineering, United International University.

---

## 📥 Download the PDF

Get the latest ready-to-read PDF from the **[Releases page](../../releases/latest)**.

No installation needed. Just download and read.

---

## 📚 What's inside

| Part | Level | Chapters |
| --- | --- | --- |
| **I. Foundations** | Beginner | 1 Operating System Foundations · 2 Lab Setup for Every Platform |
| **II. Everyday Commands** | Beginner → Intermediate | 3 First Commands and Navigation · 4 Working with Files and Directories · 5 Permissions, Users and Groups · 6 Processes and Jobs · 7 Redirection, Pipes and Filters · 8 Text Power Tools: grep, Regex, sed, awk · 9 System, Disk, Network and Packages |
| **III. Shell Scripting Core** | Intermediate | 10 Your First Shell Script · 11 Spaces and Quoting: The Space-Sensitivity Chapter · 12 Arithmetic, Conditions and `case` · 13 Loops · 14 Functions, Arrays and Strings · 15 Arguments, Exit Codes, Error Handling and Debugging |
| **IV. Problem-Solving Lab** | Intermediate → Advanced | 16 40 Solved Problems in Bash |
| **V. Real-World Automation** | Advanced | 17 Automation with cron, Backups and Logs · 18 Mini Projects |
| **VI. Mastery** | Master | 19 Best Practices, Security and ShellCheck |
| **Appendices** | Reference | A One-Page Cheat Sheet · B Viva and Interview Questions · C Answers to Practice Tasks · D Glossary |

### Who is this for?

- Students taking an Operating Systems or Linux lab course
- Beginners who have never opened a terminal
- Anyone preparing for viva, lab exams or technical interviews
- Developers who want to automate everyday work with Bash

---

## 🛠️ Build the PDF yourself

### 1. Install Typst

| Platform | Command |
| --- | --- |
| macOS | `brew install typst` |
| Windows | `winget install --id Typst.Typst` |
| Linux / any | Download from [typst/typst releases](https://github.com/typst/typst/releases) or `cargo install --locked typst-cli` |

### 2. Compile

```bash
git clone <this-repo-url>
cd linux-shell-bash-handbook
make            # builds build/linux-shell-bash-handbook.pdf
```

No `make`? Run Typst directly from the repository root:

```bash
mkdir -p build
typst compile --font-path fonts src/main.typ build/linux-shell-bash-handbook.pdf
```

### 3. Live preview while editing

```bash
make watch
```

VS Code users can install the **Tinymist Typst** extension for a live side-by-side preview.

All fonts are bundled in [`fonts/`](fonts/), so the PDF looks identical on every machine.

---

## 📁 Repository structure

```text
linux-shell-bash-handbook/
├── src/                      # Typst source of the book
│   ├── main.typ              #   Entry point: page setup, styles, cover, title page, contents
│   ├── template.typ          #   Colours, fonts, Part data and components (callouts, Part pages, chapter openers)
│   └── body.typ              #   All chapter content — edit this to change the text
├── fonts/                    # Bundled fonts (SIL Open Font License)
│   ├── README.md             #   Font credits
│   └── licenses/             #   Licence text for each font family
├── markdown/                 # Optional: Markdown version of the chapters
│   ├── body.md               #   Markdown source
│   └── filter.lua            #   Pandoc Lua filter (Markdown → Typst components)
├── scripts/
│   └── build.py              # Regenerates src/body.typ from markdown/ and builds the PDF
├── build/                    # Generated PDF goes here (not committed)
├── .github/
│   ├── workflows/build.yml   #   CI: builds the PDF and publishes it on tagged releases
│   ├── ISSUE_TEMPLATE/       #   Issue forms for mistakes and suggestions
│   └── CONTRIBUTING.md       #   How to contribute
├── Makefile                  # make / make watch / make regen / make clean
├── CHANGELOG.md
├── LICENSE                   # Book content: CC BY-NC-SA 4.0
└── LICENSE-CODE              # Build tooling: MIT
```

> **Note:** `src/body.typ` is the main source. The `markdown/` folder is only needed if you prefer
> writing in Markdown; `make regen` (requires [Pandoc](https://pandoc.org)) overwrites
> `src/body.typ` from `markdown/body.md`.

---

## 🤝 Contributing

Found a typo, a wrong output or a command that behaves differently on your system?
Please [open an issue](../../issues/new/choose) or send a pull request. See
[CONTRIBUTING.md](.github/CONTRIBUTING.md) for details.

---

## 📄 License

- **Book content** (text, examples, figures) — [CC BY-NC-SA 4.0](LICENSE).
  You may share and adapt it for non-commercial purposes with credit, under the same licence.
- **Build tooling** (`src/main.typ`, `src/template.typ`, `scripts/`, `markdown/filter.lua`, Makefile, workflows) — [MIT](LICENSE-CODE).
- **Fonts** — SIL Open Font License 1.1, see [`fonts/README.md`](fonts/README.md).

---

If this handbook helped you, please ⭐ star the repository and share it with your classmates!
