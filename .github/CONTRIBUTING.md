# Contributing

Thank you for helping improve the handbook! Every fix, however small, helps the next reader.

## Ways to help

- **Report a mistake**: a typo, a wrong command output, a broken example, or an
  explanation that is hard to follow. [Open an issue](../../../issues/new/choose) and
  mention the chapter and section.
- **Suggest content**: a missing command, a better example, or a new practice problem.
- **Send a fix**: open a pull request (see below).

## Making a change

1. Fork the repository and create a branch:
   ```bash
   git checkout -b fix/chapter-11-quoting-typo
   ```
2. Edit **`src/body.typ`** for text and examples.
   Layout, colours and components live in `src/template.typ` and `src/main.typ`.
3. Build the PDF and check your change looks right:
   ```bash
   make            # creates build/linux-shell-bash-handbook.pdf
   ```
   You don't need to update `book/`. The maintainer refreshes the published PDF.
4. Commit with a clear message and open a pull request. The CI workflow
   compiles the book automatically, so a broken build shows up on the PR.

## Style guide

- Use **simple English**; short sentences; explain every new term once.
- Every command example should show its **real output** in a plain code block
  (no language tag; these render as terminal boxes).
- Script examples use a language tag, e.g. ```` ```bash ````.
- Bangla notes are welcome where they help understanding.
- Test every script on Bash before submitting, and run it through
  [ShellCheck](https://www.shellcheck.net) where possible.

## Licensing of contributions

By contributing, you agree that your contributions to the book content are
licensed under [CC BY-NC-SA 4.0](../LICENSE), and contributions to the build
tooling under the [MIT License](../LICENSE-CODE).
