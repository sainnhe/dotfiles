# Agent Behavioral Guidelines

> Behavioral guidelines to reduce common LLM coding mistakes, derived from [Andrej Karpathy's observations](https://x.com/karpathy/status/2015883857489522876) on LLM coding pitfalls, with some personal enhancements.

## 1. Think Before Coding

**Don't assume. Don't hide confusion. Surface tradeoffs.**

Before implementing:

- State your assumptions explicitly. If uncertain, ask.
- If multiple interpretations exist, present them - don't pick silently.
- If a simpler approach exists, say so. Push back when warranted.
- If something is unclear, stop. Name what's confusing. Ask.

## 2. Surgical Changes

**Touch only what you must. Clean up only your own mess.**

When editing existing code:

- Don't "improve" adjacent code, comments, or formatting.
- Don't refactor things that aren't broken.
- Match existing style, even if you'd do it differently.
- If you notice unrelated dead code, mention it - don't delete it.

When your changes create orphans:

- Remove imports/variables/functions that YOUR changes made unused.
- Don't remove pre-existing dead code unless asked.

The test: Every changed line should trace directly to the user's request.

## 3. Goal-Driven Execution

**Define success criteria. Loop until verified.**

Transform tasks into verifiable goals:

- "Add validation" → "Write tests for invalid inputs, then make them pass"
- "Fix the bug" → "Write a test that reproduces it, then make it pass"
- "Refactor X" → "Ensure tests pass before and after"

For multi-step tasks, state a brief plan:

```
1. [Step] → verify: [check]
2. [Step] → verify: [check]
3. [Step] → verify: [check]
```

Strong success criteria let you loop independently. Weak criteria ("make it work") require constant clarification.

## 4. Keep It Simple & Stupid (KISS)

**Minimum code that solves the problem. Boring is better than clever.**

- No over-engineering: Build only what is explicitly requested using the simplest, most intuitive data structures. Do not introduce unrequested features or complex models unless strictly necessary.
- No showing off: If you can implement a feature in one line, don't use three. However, never use obscure language features just to be brief. Write "boring," straightforward code. Readability is paramount.
- Fail fast over silent errors: Think twice before adding defensive checks or complex exception handling for uncertain assumptions. Exposing an error loudly is almost always better than letting the system run in an invalid state. If an assumption needs later verification, mark it with a `TODO`.
- Zero unnecessary dependencies: If a problem can be solved elegantly using the standard library, strictly avoid introducing third-party packages.
- Don't Repeat Yourself (DRY): If two or more pieces of code are highly similar, extract and refactor them immediately to maintain an elegant code structure. However, do not create abstractions for single-use code.

Solve the exact problem with the absolute minimum code required.
