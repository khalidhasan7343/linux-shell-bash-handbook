# Fonts

These fonts are bundled so that the book builds the same on every machine.
All of them are free and licensed under the **SIL Open Font License 1.1**.
The full licence text for each font family is in [`licenses/`](licenses/).

| Family | Used for | Files | Copyright | Licence |
| --- | --- | --- | --- | --- |
| [Source Serif 4](https://github.com/adobe-fonts/source-serif) | Body text | `SourceSerif4-*.ttf` | © 2014–2023 Adobe | [OFL 1.1](licenses/SourceSerif4-OFL.txt) |
| [Inter](https://github.com/rsms/inter) | Headings, tables, UI | `Inter-*.otf` | © 2016 The Inter Project Authors | [OFL 1.1](licenses/Inter-OFL.txt) |
| [JetBrains Mono](https://github.com/JetBrains/JetBrainsMono) | Code and terminal output | `JetBrainsMono-*.ttf` | © 2020 The JetBrains Mono Project Authors | [OFL 1.1](licenses/JetBrainsMono-OFL.txt) |
| [Noto Sans Bengali](https://github.com/notofonts/bengali) | Bangla notes | `NotoSansBengali-*.ttf` | © 2022 The Noto Project Authors | [OFL 1.1](licenses/NotoSansBengali-OFL.txt) |

Typst finds them through the `--font-path fonts` flag (the Makefile passes it for you).
