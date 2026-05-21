---
name: setup-review
description: Audit the user's macOS machine state against what their dotfiles repo tracks, then walk them through approving each missing item one grouped question at a time. Use this skill whenever the user says "review my setup", "review my mac setup", "audit my mac", "what's missing from my dotfiles", or otherwise asks to find drift between their installed software and their dotfiles repo. Honors the repo's IGNORE.md so excluded items never resurface, and does not commit — the user commits when ready.
---

# Setup review

The user keeps personal macOS config in a dotfiles repo. This skill finds drift between the live machine and the repo, then walks the user through approving additions in grouped questions.

## Workflow

1. **Locate the dotfiles repo** — prefer the current working directory if it has `AGENTS.md`; otherwise ask. Read `AGENTS.md` and `IGNORE.md` first — they define the conventions for *where* each kind of thing goes and *what* to skip.

2. **Inventory the machine** in parallel: brews, casks, App Store apps (`mas list`), `/Applications`, Cursor and VS Code extensions, and any settings files the repo already tracks (check for drift against the live copies).

3. **Compute the diff per category**: installed minus tracked minus ignored. Filter out Apple's bundled apps (Safari, Mail, Notes, etc.) — these aren't user choices.

4. **Ask one grouped question per non-empty category** using `AskUserQuestion` with `multiSelect: true`. Each option is one item with a brief one-line description of what it is (look it up if the name isn't obvious — e.g., `colima` → "Docker Desktop alternative"). Split long lists so no single question has more than ~8 options.

5. **After each rejection, offer to add the rejected items to `IGNORE.md`** so they don't surface again. This is the convergence mechanism — every rejection either gets resolved now or silenced permanently.

6. **Apply approved changes** to the files `AGENTS.md` says to use. Don't run any git commands — the user reviews and commits.

7. **Summarize** what was added and what was ignored. If nothing changed, say so.

## Notes

- Trust `AGENTS.md` for "where does this go" — don't re-derive conventions.
- Trust `IGNORE.md` — if it's listed, it's silenced, don't re-surface "just in case".
- Don't expand scope. No tidying unrelated parts of the repo or suggesting "while we're here" changes.
