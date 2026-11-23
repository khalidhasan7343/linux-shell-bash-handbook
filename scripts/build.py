#!/usr/bin/env python3
"""Regenerate src/body.typ from markdown/body.md (needs pandoc) and compile the PDF (needs typst).

Run from anywhere:  python3 scripts/build.py   (or: make regen)
"""
import os, re, subprocess

# Always work from the repository root, wherever the script is called from.
os.chdir(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

BODY = 'src/body.typ'
PDF = 'build/linux-shell-bash-handbook.pdf'

subprocess.run(['pandoc', 'markdown/body.md', '-f', 'markdown-smart', '-t', 'typst',
                '--lua-filter=markdown/filter.lua', '-o', BODY], check=True)
s = open(BODY, encoding='utf-8').read()
s = re.sub(r'#align\(center\)\[#table\(\n(.*?)\n\)\n\]', lambda m: '#table(\n' + m.group(1) + '\n)', s, flags=re.S)
s = re.sub(r'columns: (\d+),', lambda m: 'columns: ' + ('(auto,)*%d + (1fr,)' % (int(m.group(1)) - 1) if int(m.group(1)) > 1 else '(1fr,)') + ',', s)
s = s.replace('inset: 6pt,', 'inset: (x: 7pt, y: 5pt),')
open(BODY, 'w', encoding='utf-8').write('#import "template.typ": *\n\n' + s)
os.makedirs('build', exist_ok=True)
subprocess.run(['typst', 'compile', '--font-path', 'fonts', '--ignore-system-fonts', 'src/main.typ', PDF], check=True)
print('Built ' + PDF)
