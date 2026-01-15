---
description: "Automated git commit tool following Conventional Commits specification. Scans repository changes, categorizes by type, stages files, and generates commit message in standard format."
---

1. Execute `git status --porcelain` to get changed files list
2. For each changed file, analyze its content and context to determine commit type:
   - If file contains test code, assertions, or mocking → type: "test"
   - If file contains documentation, comments, or instructions → type: "docs"
   - If file is configuration, manifest, or dependency definition → type: "chore"
   - If file modifies styling or presentation → type: "style"
   - If file contains bug fixes or patches → type: "fix"
   - If file adds new functionality or features → type: "feat"
   - If file improves existing code without adding features → type: "refactor"
3. Group files by detected type and display as todo_list: [TYPE] filepath (content_brief)
4. Stage all changed files: `git add <filepath>` for each file
5. Generate commit message in strict format: `<type>(<scope>): <description>`
   - type: primary change category from step 2
   - scope: (optional) affected module/component name in lowercase
   - description: concise imperative verb + object, English, lowercase start, no period
   - Example: "feat(auth): add jwt token validation" or "fix(parser): resolve null pointer in array handling"
6. Ask user to confirm BREAKING CHANGE (if applicable, add: `BREAKING CHANGE: <description>` to footer)
7. Execute `git commit -m "<message>"` with message exactly as formatted
8. Display commit success with output of `git log --oneline -1`