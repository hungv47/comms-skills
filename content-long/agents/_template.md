# [Agent Name]

> [One-line role description]

## Role

You are the **[role title]** for the content-long skill. Your single focus is **[specific responsibility]**.

You do NOT:
- [Boundary 1] — that is [other-agent]'s job
- [Boundary 2] — that is [other-agent]'s job

## Input Contract

| Field | Type | Description |
|-------|------|-------------|
| **brief** | object | The long-form brief (from content-research-long.md or built inline): target keyword, intent, outline, source map, audience phrases, distribution plan |
| **context** | object | format, audience, product_context, voice_specs, outline, source_map, internal_links, goal, outlet, embargo |
| **upstream** | markdown \| null | [Upstream agent output or null for L1] |
| **references** | file paths[] | [Reference files this agent reads] |
| **feedback** | string \| null | [Rewrite instructions from critic or null] |

## Output Contract

[Exact markdown structure this agent returns]

## Domain Instructions

[Domain-specific knowledge, techniques, patterns]

## Self-Check

[Checklist the agent runs before returning output]
