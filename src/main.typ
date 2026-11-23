// ============================================================
//  The Complete Linux Shell & Bash Scripting Handbook
//  Typst source — compile from the repo root:  make   (or: typst compile --font-path fonts src/main.typ build/linux-shell-bash-handbook.pdf)
// ============================================================

#import "template.typ": *

// ---------- Document setup ----------
#show raw: set text(ligatures: false, features: ("calt": 0, "liga": 0))
// ✅ / ❌ drawn with bundled fonts (no emoji font needed)
#show "✅": box(text(font: "Inter", weight: 800, fill: rgb("#16A34A"))[✓])
#show "❌": box(text(font: "Inter", weight: 800, fill: rgb("#DC2626"))[✗])
#set document(title: "The Complete Linux Shell & Bash Scripting Handbook", author: "MD Khalid Hasan")
#set text(font: serif, size: 10.5pt, fill: ink, lang: "en", hyphenate: true)
#set par(justify: false, leading: 0.68em, spacing: 0.95em)
#set list(marker: ([•], [–]), indent: 4pt, body-indent: 6pt)
#set enum(indent: 4pt, body-indent: 6pt)

// Headings
#show heading: set text(font: sans)
#show heading.where(level: 1): it => context {
  let num = chap-num.get()
  let c = part-color.get()
  let kind = if num.match(regex("^[A-Z]$")) != none { "APPENDIX" } else { "CHAPTER" }
  block(width: 100%, above: 0pt, below: 20pt, breakable: false)[
    #grid(columns: (1fr, auto), align: (left + bottom, right + bottom), column-gutter: 10pt,
      [
        #text(size: 9pt, weight: 700, tracking: 2.2pt, fill: c)[#if num != "" [#kind #num] else [START HERE]]
        #v(6pt)
        #set par(justify: false, leading: 0.45em)
        #text(size: 23pt, weight: 750, fill: ink, hyphenate: false)[#it.body]
      ],
      if num != "" { text(font: serif, size: 64pt, weight: 700, fill: c.lighten(72%), top-edge: "cap-height", bottom-edge: "baseline")[#num] },
    )
    #v(8pt)
    #line(length: 100%, stroke: 2.2pt + c)
  ]
}
#show heading.where(level: 2): it => context {
  let c = part-color.get()
  block(above: 18pt, below: 9pt, sticky: true)[
    #text(size: 13.5pt, weight: 650, fill: c.darken(10%))[#it.body]
  ]
}
#show heading.where(level: 3): it => block(above: 15pt, below: 8pt, sticky: true)[
  #text(size: 11.2pt, weight: 700, fill: ink)[#it.body]
]

// Inline code
#show raw.where(block: false): it => box(
  fill: rgb("#EEF1F5"), inset: (x: 2.6pt, y: 0pt), outset: (y: 2.4pt), radius: 2pt,
  text(font: mono, size: 0.86em, fill: rgb("#B4235A"), it))

// Code blocks: scripts (with a language) are light; output / plain blocks look like a terminal
#show raw.where(block: true): it => {
  set text(font: mono, size: 8.3pt)
  set par(justify: false, leading: 0.55em)
  if it.lang == none or it.lang == "" {
    block(width: 100%, fill: rgb("#0F1B2D"), radius: 5pt, inset: (x: 11pt, y: 9pt),
      above: 9pt, below: 11pt, breakable: true,
      text(fill: rgb("#D7E3F4"), it))
  } else {
    block(width: 100%, fill: rgb("#F6F8FA"), stroke: 0.6pt + rgb("#D0D7DE"), radius: 5pt,
      inset: (x: 11pt, top: 9pt, bottom: 9pt), above: 9pt, below: 11pt, breakable: true)[
      #place(top + right, dx: 6pt, dy: -6pt,
        text(font: sans, size: 6.5pt, weight: 700, tracking: 1pt, fill: rgb("#8A94A3"), upper(it.lang)))
      #it
    ]
  }
}

// Tables
#set table(
  stroke: (x, y) => (bottom: 0.5pt + rule-c),
  fill: (x, y) => if y == 0 { navy2 } else if calc.even(y) { rgb("#F6F8FB") },
)
#show table: set text(size: 9pt)
#show table: set par(justify: false, leading: 0.55em)
#show table.cell.where(y: 0): set text(fill: white, weight: 600, font: sans, size: 8.6pt)
#show table.cell.where(y: 0): it => { show raw: r => text(font: mono, size: 0.95em, fill: white, r.text); it }
#show table: it => block(width: 100%, above: 10pt, below: 12pt, breakable: it.children.len() > 60, it)

// Strong in sans for a crisp look
#show strong: set text(weight: 650)

#set page(
  paper: "a4",
  margin: (top: 24mm, bottom: 22mm, inside: 22mm, outside: 20mm),
  header: context {
    let pg = here().page()
    let heads = query(heading.where(level: 1))
    // no header on chapter-opening pages
    if heads.any(h => h.location().page() == pg) { return }
    let before = heads.filter(h => h.location().page() < pg)
    if before.len() == 0 { return }
    let hd = before.last()
    let num = chap-num.at(hd.location())
    let c = part-color.at(hd.location())
    set text(font: sans, size: 7.8pt, fill: muted)
    grid(columns: (1fr, auto),
      [Linux Shell & Bash Scripting Handbook],
      [#if num != "" [#text(fill: c, weight: 700)[#num] #h(4pt)] #hd.body])
    v(-5pt)
    line(length: 100%, stroke: 0.4pt + rule-c)
  },
  footer: context {
    let c = part-color.get()
    set text(font: sans, size: 8pt, fill: muted)
    align(center)[#box(inset: (x: 8pt, y: 3pt), radius: 10pt, stroke: 0.5pt + c.lighten(40%))[#text(fill: c, weight: 700)[#page-label(here())]]]
  },
)

// ============================================================
//  COVER
// ============================================================
#page(margin: 0pt, header: none, footer: none, fill: navy)[
  // subtle dot grid
  #place(top + left, for y in range(0, 60) {
    for x in range(0, 44) {
      place(dx: x * 5mm + 1.5mm, dy: y * 5mm + 1.5mm, circle(radius: 0.25mm, fill: white.transparentize(94%)))
    }
  })
  // accent bar
  #place(top + left, rect(width: 6mm, height: 100%, fill: green))

  #place(top + left, dx: 20mm, dy: 20mm, block(width: 170mm)[
    #text(font: sans, size: 8.5pt, weight: 700, tracking: 3pt, fill: green)[OPERATING SYSTEMS · LINUX · BASH]
    #v(10mm)
    #set par(leading: 0.62em, justify: false)
    #set text(hyphenate: false)
    #text(font: sans, size: 21pt, weight: 300, fill: white.transparentize(20%))[The Complete] \
    #text(font: sans, size: 44pt, weight: 800, fill: white)[Linux Shell &] \
    #text(font: sans, size: 44pt, weight: 800, fill: white)[Bash Scripting] \
    #text(font: sans, size: 44pt, weight: 800, fill: green)[Handbook]
    #v(7mm)
    #set par(leading: 0.6em)
    #text(font: sans, size: 13.5pt, weight: 600, fill: white)[From Zero to Master] \
    #text(font: sans, size: 10.5pt, fill: white.transparentize(30%))[Operating system basics, Linux commands and Bash shell scripting, step by step, with real outputs.]
  ])

  // terminal window
  #place(top + left, dx: 20mm, dy: 122mm, block(width: 170mm, radius: 8pt, fill: rgb("#060D18"), stroke: 0.8pt + white.transparentize(85%), clip: true)[
    #block(width: 100%, fill: rgb("#1A2A42"), inset: (x: 10pt, y: 7pt))[
      #box(circle(radius: 3.2pt, fill: rgb("#FF5F57"))) #h(3pt)
      #box(circle(radius: 3.2pt, fill: rgb("#FEBC2E"))) #h(3pt)
      #box(circle(radius: 3.2pt, fill: rgb("#28C840")))
      #h(1fr) #text(font: mono, size: 7.5pt, fill: white.transparentize(45%))[you\@fedora: \~/practice — bash] #h(1fr)
    ]
    #block(inset: (x: 14pt, top: 10pt, bottom: 14pt))[
      #set text(font: mono, size: 9.2pt, fill: rgb("#D7E3F4"), ligatures: false, features: ("calt": 0))
      #set par(leading: 0.62em, justify: false)
      #text(fill: green, "[you@fedora ~]$") #"./learn.sh --from zero --to master" \
      #text(fill: white.transparentize(40%), "Loading chapters 1-19 ............... done") \
      #text(fill: white.transparentize(40%), "Running 40 solved problems .......... done") \
      #text(fill: white.transparentize(40%), "Space check:  name=\"Rahim\"  OK    name = \"Rahim\"  ERROR") \
      #text(fill: green, "[you@fedora ~]$") #"echo \"Ready to master the shell\"" \
      #"Ready to master the shell" \
      #text(fill: green, "[you@fedora ~]$") #box(fill: green, width: 6pt, height: 10pt, baseline: 1.5pt)
    ]
  ])

  #place(top + left, dx: 20mm, dy: 196mm,
    text(font: "Noto Sans Bengali", size: 12pt, weight: 600, fill: white.transparentize(10%))[শূন্য থেকে দক্ষতা — ধাপে ধাপে লিনাক্স ও ব্যাশ শিখুন])

  // platform chips
  #place(top + left, dx: 20mm, dy: 208mm, {
    set text(font: sans, size: 8pt, weight: 600, fill: white)
    for t in ("Fedora KDE", "Ubuntu", "Windows WSL", "macOS", "GNU Bash 5.2") {
      box(stroke: 0.7pt + white.transparentize(60%), radius: 10pt, inset: (x: 8pt, y: 4pt))[#t]
      h(5pt)
    }
  })

  // prepared-by panel
  #place(bottom + left, dx: 0mm, dy: 0mm, block(width: 100%, height: 60mm, fill: navy2, inset: (left: 20mm, right: 20mm, top: 10mm))[
    #let field(label, value) = block(width: 100%)[
      #text(font: sans, size: 7pt, weight: 700, tracking: 1.5pt, fill: green)[#upper(label)]
      #v(2.5mm)
      #text(font: sans, size: 12pt, weight: 600, fill: white)[#value]
      #v(-1.5mm)
      #line(length: 100%, stroke: 0.6pt + white.transparentize(55%))
    ]
    #grid(columns: (1fr, 1fr), column-gutter: 14mm, row-gutter: 6mm,
      grid.cell(colspan: 2, field("Prepared by", "MD Khalid Hasan")),
      field("Department", "Computer Science and Engineering"),
      field("Institution", "United International University"))
    #v(5mm)
    #grid(columns: (1fr, auto),
      text(font: sans, size: 7.5pt, fill: white.transparentize(45%))[1st Edition · November 2026],
      text(font: sans, size: 7.5pt, fill: white.transparentize(45%))[Simple English · বাংলা নোট সহ])
  ])
]

// ============================================================
//  TITLE PAGE
// ============================================================
#page(header: none, footer: none)[
  #v(18mm)
  #text(font: sans, size: 8.5pt, weight: 700, tracking: 3pt, fill: green.darken(35%))[OPERATING SYSTEMS · LINUX · BASH]
  #v(4mm)
  #text(font: sans, size: 30pt, weight: 800, fill: ink)[The Complete Linux Shell & Bash Scripting Handbook]
  #v(2mm)
  #text(font: serif, size: 14pt, style: "italic", fill: muted)[From Zero to Master: Operating System Basics, Linux Commands and Bash Shell Scripting]
  #v(10mm)
  #line(length: 100%, stroke: 1.5pt + navy)
  #v(6mm)
  #set text(size: 10pt)
  #grid(columns: (38mm, 1fr), row-gutter: 9pt,
    text(font: sans, weight: 700, size: 8.5pt, fill: muted)[EDITION], [1st Edition, November 2026],
    text(font: sans, weight: 700, size: 8.5pt, fill: muted)[SHELL COVERED], [GNU Bash 5.x (every example run on Bash 5.2)],
    text(font: sans, weight: 700, size: 8.5pt, fill: muted)[TESTED ON], [Fedora KDE Plasma (main) · Ubuntu · Windows WSL · macOS (notes)],
    text(font: sans, weight: 700, size: 8.5pt, fill: muted)[LANGUAGE], [Simple English with short Bangla notes (বাংলা টিপস)],
    text(font: sans, weight: 700, size: 8.5pt, fill: muted)[FOR], [University OS course & lab · DevOps / SysAdmin jobs · Self-learners],
    text(font: sans, weight: 700, size: 8.5pt, fill: muted)[PREPARED BY], [*MD Khalid Hasan* \ Computer Science and Engineering, United International University],
  )
  #v(10mm)
  #text(font: sans, size: 8.5pt, weight: 700, tracking: 2pt, fill: muted)[WHAT'S INSIDE]
  #v(3mm)
  #{
    let rows = ()
    for k in ("I", "II", "III", "IV", "V", "VI", "A") {
      let p = part-info.at(k)
      let chs = p.chapters.map(c => c.at(0))
      rows.push(grid(columns: (8mm, 58mm, 30mm, 1fr), align: horizon, column-gutter: 4pt,
        box(width: 5mm, height: 5mm, radius: 1.5pt, fill: p.color),
        text(font: sans, size: 9.5pt, weight: 600)[#if k == "A" [Appendices] else [Part #k: #p.title]],
        text(font: sans, size: 9pt, fill: muted)[#if k == "A" [A–D] else [Ch. #chs.first()#if chs.len() > 1 [–#chs.last()]]],
        text(font: sans, size: 9pt, fill: p.color.darken(10%), weight: 600)[#p.level]))
    }
    stack(spacing: 7pt, ..rows)
  }
  #v(1fr)
  #block(width: 100%, inset: (left: 14pt, y: 6pt), stroke: (left: 2pt + green.darken(20%)))[
    #text(style: "italic", size: 12pt, hyphenate: false)["The terminal is not scary. It is just a place where you talk to your computer in short sentences."]
    #v(3pt)
    #text(font: "Noto Sans Bengali", size: 10pt, fill: muted)[ভয় পাবেন না। প্রতিটি কমান্ড নিজে টাইপ করে চালান, তাহলেই শেখা হবে।]
  ]
  #v(8mm)
]

// ============================================================
//  CONTENTS
// ============================================================
#page(header: none)[
  #text(font: sans, size: 9pt, weight: 700, tracking: 2.2pt, fill: navy)[CONTENTS]
  #v(2pt)
  #text(font: sans, size: 26pt, weight: 800)[Table of Contents]
  #v(-2pt)
  #line(length: 100%, stroke: 2.2pt + navy)
  #v(8pt)
  #context {
    let items = query(selector(<part>).or(heading.where(level: 1)))
    set text(font: sans)
    for it in items {
      if it.func() == metadata {
        let p = part-info.at(it.value.num)
        block(above: 12pt, below: 5pt, width: 100%, fill: p.color.lighten(90%), radius: 3pt, inset: (x: 8pt, y: 5pt))[
          #text(size: 8.5pt, weight: 800, tracking: 1.5pt, fill: p.color.darken(10%))[#if it.value.num == "A" [APPENDICES] else [PART #it.value.num · #upper(p.title)]]
          #h(1fr) #text(size: 8.5pt, weight: 700, fill: p.color.darken(10%))[#page-label(it.location())]
        ]
      } else {
        let num = chap-num.at(it.location())
        let c = part-color.at(it.location())
        block(above: 0pt, below: 0pt, inset: (x: 8pt, y: 4.2pt))[
          #grid(columns: (9mm, 1fr, auto), align: (left, left, right),
            text(size: 9.5pt, weight: 700, fill: c)[#num],
            [#text(size: 9.8pt)[#it.body] #box(width: 1fr, repeat(text(fill: rule-c)[.#h(3pt)]))],
            text(size: 9.5pt, weight: 600)[#h(4pt)#page-label(it.location())])
        ]
      }
    }
  }
]

// ============================================================
//  BODY
// ============================================================
#include "body.typ"
