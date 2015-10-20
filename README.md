# Text embed

## Intro

Super simple embeding of lines from one document into another. Something like an iframe for markdown.

## Usage

Given a "parent" file`./test/input.md`:

```markdown
# Tester

A simple markdown file

* Demonstrate
* Test

↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓
--text-embed:test/i-see-stars.txt::lines:3-4
↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑
```

and an embed source `./test/i-see-stars.txt`:

```txt

*******************
**Test successful**
*                 *
```

You can invoke this module, to grab the specified lines, from the specified file and combine it with the host to create a new output file:

```shell
node src/index.js ./test/input.md ./dist/output.md '--text-embed:'
```

and you will end up with `./dist/output.md`:

```markdown
# Tester

A simple markdown file

* Demonstrate
* Test

↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓
**Test successful**
*                 *
↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑
```
