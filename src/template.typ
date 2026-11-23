// template.typ — colours, fonts, part data and reusable components
// (no set/show rules here: those live in main.typ)

// ============================================================

// ---------- Palette & fonts ----------
#let ink      = rgb("#1B2430")
#let muted    = rgb("#5B6573")
#let navy     = rgb("#0B1626")
#let navy2    = rgb("#13223A")
#let green    = rgb("#3DDC84")
#let rule-c   = rgb("#D9DEE5")
#let serif    = ("Source Serif 4", "Noto Sans Bengali")
#let sans     = ("Inter", "Noto Sans Bengali")
#let mono     = ("JetBrains Mono", "DejaVu Sans Mono")

#let part-info = (
  "I":   (color: rgb("#2563EB"), title: "Foundations", level: "Beginner",
          blurb: "What an operating system is, how Linux is organised, and how to build a practice lab on any computer.",
          chapters: (("1", "Operating System Foundations"), ("2", "Lab Setup for Every Platform"))),
  "II":  (color: rgb("#0D9488"), title: "Everyday Commands", level: "Beginner → Intermediate",
          blurb: "The commands you will type every day: navigating, managing files, permissions, processes, pipes and text tools.",
          chapters: (("3", "First Commands and Navigation"), ("4", "Working with Files and Directories"),
                     ("5", "Permissions, Users and Groups"), ("6", "Processes and Jobs"),
                     ("7", "Redirection, Pipes and Filters"), ("8", "Text Power Tools: grep, Regex, sed, awk"),
                     ("9", "System, Disk, Network and Packages"))),
  "III": (color: rgb("#7C3AED"), title: "Shell Scripting Core", level: "Intermediate",
          blurb: "Write real scripts: variables, quoting and spaces, conditions, loops, functions, arrays and error handling.",
          chapters: (("10", "Your First Shell Script"), ("11", "Spaces and Quoting: The Space-Sensitivity Chapter"),
                     ("12", "Arithmetic, Conditions and case"), ("13", "Loops"),
                     ("14", "Functions, Arrays and Strings"), ("15", "Arguments, Exit Codes, Error Handling and Debugging"))),
  "IV":  (color: rgb("#D97706"), title: "Problem-Solving Lab", level: "Intermediate → Advanced",
          blurb: "Forty classic programming problems solved in Bash, each with logic, code, explanation and real output.",
          chapters: (("16", "40 Solved Problems in Bash"),)),
  "V":   (color: rgb("#16A34A"), title: "Real-World Automation", level: "Advanced",
          blurb: "Schedule work with cron and systemd timers, write backup and monitoring scripts, and build five mini projects.",
          chapters: (("17", "Automation with cron, Backups and Logs"), ("18", "Mini Projects"))),
  "VI":  (color: rgb("#DB2777"), title: "Mastery", level: "Master",
          blurb: "Write scripts like a professional: templates, golden rules, ShellCheck, security and portability.",
          chapters: (("19", "Best Practices, Security and ShellCheck"),)),
  "A":   (color: rgb("#475569"), title: "Appendices", level: "Reference",
          blurb: "Keep these pages open while you work: cheat sheet, viva and interview questions, answers and glossary.",
          chapters: (("A", "One-Page Cheat Sheet"), ("B", "Viva and Interview Questions"),
                     ("C", "Answers to Practice Tasks"), ("D", "Glossary"))),
)

#let part-color = state("part-color", navy)
#let chap-num   = state("chap-num", "")

// ---------- Components ----------
#let callout-styles = (
  why:      (c: rgb("#2563EB"), tag: "WHY?"),
  tip:      (c: rgb("#16A34A"), tag: "TIP"),
  mistake:  (c: rgb("#DC2626"), tag: "COMMON MISTAKE"),
  danger:   (c: rgb("#B91C1C"), tag: "DANGER"),
  space:    (c: rgb("#D97706"), tag: "SPACE CHECK"),
  bangla:   (c: rgb("#7C3AED"), tag: "বাংলা নোট"),
  practice: (c: rgb("#0D9488"), tag: "PRACTICE"),
  note:     (c: rgb("#475569"), tag: "NOTE"),
)

#let callout(kind, title, body) = {
  let s = callout-styles.at(kind, default: callout-styles.note)
  let label = if title == "" { s.tag } else { upper(title) }
  block(width: 100%, fill: s.c.lighten(93%), stroke: (left: 3pt + s.c),
    radius: (right: 4pt), inset: (left: 12pt, right: 12pt, y: 9pt),
    above: 11pt, below: 11pt, breakable: false)[
    #text(font: sans, size: 7.6pt, weight: 750, tracking: 1pt, fill: s.c)[#label]
    #v(3pt, weak: true)
    #set text(size: 9.8pt)
    #set par(spacing: 0.7em)
    #if kind == "bangla" { set text(font: ("Noto Sans Bengali", "Inter"), size: 9.6pt); body } else { body }
  ]
}

#let chapter-heading(num, title) = {
  pagebreak(weak: true)
  chap-num.update(num)
  heading(level: 1, title)
}

#let part-page(num, title) = {
  let p = part-info.at(num)
  part-color.update(p.color)
  page(margin: 0pt, header: none, footer: none, fill: white)[
    #if num == "I" { counter(page).update(1); [#metadata("main") <mainstart>] }
    #[#metadata((num: num, title: title)) <part>]
    // colour band
    #place(top, block(width: 100%, height: 46%, fill: p.color)[
      #place(horizon + right, dx: -16mm, dy: 6mm,
        text(font: serif, size: if num == "A" { 120pt } else { 170pt }, weight: 700, fill: white.transparentize(78%),
          top-edge: "cap-height", bottom-edge: "baseline",
          if num == "A" { "A–D" } else { num }))
      #place(top + left, dx: 22mm, dy: 26mm,
        text(font: sans, size: 9pt, weight: 700, tracking: 3pt, fill: white.transparentize(15%),
          if num == "A" { "REFERENCE" } else { "PART " + num }))
      #place(bottom + left, dx: 22mm, dy: -20mm, block(width: 150mm)[
        #text(font: sans, size: 38pt, weight: 800, fill: white, hyphenate: false)[#p.title]
        #v(6pt)
        #box(fill: white.transparentize(80%), radius: 20pt, inset: (x: 10pt, y: 5pt),
          text(font: sans, size: 8.5pt, weight: 600, fill: white)[Level: #p.level])
      ])
    ])
    #place(top + left, dx: 22mm, dy: 46% + 18mm, block(width: 166mm)[
      #text(font: serif, size: 13pt, style: "italic", fill: muted)[#p.blurb]
      #v(14mm)
      #text(font: sans, size: 8.5pt, weight: 700, tracking: 2pt, fill: p.color)[IN THIS PART]
      #v(4mm)
      #for (n, t) in p.chapters {
        block(below: 0pt, above: 0pt, width: 100%, stroke: (bottom: 0.5pt + rule-c), inset: (y: 9pt))[
          #grid(columns: (16mm, 1fr), align: horizon,
            text(font: sans, size: 18pt, weight: 800, fill: p.color.lighten(10%))[#n],
            text(font: sans, size: 11.5pt, weight: 500, fill: ink)[#t])
        ]
      }
    ])
  ]
}

#let layers-diagram() = {
  let row(name, body, accent: false) = block(width: 100%, radius: 6pt,
    fill: if accent { rgb("#2563EB").lighten(88%) } else { white },
    stroke: if accent { 1.6pt + rgb("#2563EB") } else { 0.8pt + rgb("#B8C1CC") },
    inset: (x: 12pt, y: 8pt))[
    #text(font: sans, size: 9.5pt, weight: 700)[#name] \
    #text(font: sans, size: 8.5pt, fill: muted)[#body]
  ]
  let arrow(label) = grid(columns: (50%, 50%), align: (right + horizon, left + horizon),
    text(size: 13pt, fill: rgb("#8A94A3"))[↓],
    pad(left: 6pt, text(font: sans, size: 7.8pt, style: "italic", fill: muted)[#label]))
  figure(kind: "diagram", supplement: [Figure], placement: auto, caption: [How a command travels from you to the hardware, and how the output comes back.],
    block(width: 88%, fill: rgb("#F6F8FB"), radius: 8pt, inset: 14pt)[
      #set par(justify: false)
      #grid(columns: (1fr, 26pt), column-gutter: 8pt,
        stack(spacing: 3pt,
          row([You (the user)], [Type a command such as `ls -l` and press Enter]),
          arrow[keystrokes],
          row([Terminal (Konsole, GNOME Terminal)], [The window: sends your keys to the shell and shows its text]),
          arrow[command line text],
          row([Shell (Bash) — this book], [Splits the line into words, expands \$vars and \*, finds the program], accent: true),
          arrow[system calls: fork, exec, read],
          row([Kernel (Linux)], [Creates the process, gives it CPU time and memory, reads the disk]),
          arrow[device drivers],
          row([Hardware], [CPU, RAM, disk, keyboard, screen, network card]),
        ),
        align(center + horizon, stack(spacing: 4pt,
          text(size: 13pt, fill: green.darken(25%))[↑],
          rotate(-90deg, reflow: true, text(font: sans, size: 7.8pt, weight: 600, fill: green.darken(30%))[output flows back up]),
          text(size: 13pt, fill: green.darken(25%))[↑])),
      )
    ])
}

#let end-mark() = align(center, block(above: 18pt)[
  #line(length: 30%, stroke: 0.6pt + rule-c)
  #text(font: sans, size: 9pt, fill: muted, style: "italic")[End of handbook. Keep practising: the terminal rewards daily use.]
])

// ---------- Page furniture ----------
#let page-label(loc) = {
  let ms = query(<mainstart>)
  let is-main = ms.len() > 0 and ms.first().location().page() <= loc.page()
  numbering(if is-main { "1" } else { "i" }, counter(page).at(loc).first())
}

