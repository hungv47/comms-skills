# lp-brief — DRAFT (WIP)

**Status: not production-ready. Do not invoke until completed.**

This skill is scaffolded but incomplete. SKILL.md and the first 3 agents are drafted; the remaining 6 agents and 7 references are placeholders.

## What's done

- `SKILL.md` — full orchestrator (routes, gates, dispatch protocol, artifact template, worked example) — version 0.1.0-draft
- `agents/audit-anchor-agent.md`
- `agents/brand-anchor-agent.md`
- `agents/hypothesis-agent.md`
- `agents/_template.md`

## What's remaining

### Agents
- `agents/architecture-agent.md` — surface rhythm + section list + ASCII diagram
- `agents/section-spec-agent.md` — per-section spec with conversion-checklist embedded
- `agents/asset-slot-agent.md` — named asset slots with prompt templates (delegates to design-create patterns)
- `agents/handoff-agent.md` — Claude Design / Figma / designer hand-off composition
- `agents/conversion-critic-agent.md` — scoring against lp-optimization rubric
- `agents/brand-voice-critic-agent.md` — brand fidelity + voice + envelope (250–500 line)

### References
- `references/conversion-principles.md` — curated/cited from `marketing-skills/lp-optimization/references/core-principles.md` (4-U, above-fold, CTA, message-match, social proof, objection handling). Reference, do not duplicate.
- `references/surface-rhythm.md` — page-architecture patterns (scroll velocity, beats, breathing room)
- `references/section-templates.md` — hero, value prop, social proof, features, objection, FAQ, CTA — each with conversion-checklist
- `references/hypothesis-rubric.md` — 3Q scoring (Visual / Falsifiable / Uniquely Ours) with worked examples
- `references/handoff-formats.md` — Claude Design / Pencil MCP / Figma spec hand-off patterns
- `references/failure-modes.md` — page-level failures (thin hero, weak CTA, no objection handling, brief bloat, fake proof)
- `references/examples.md` — worked LP-brief examples (fresh LP, audit-anchored redesign, rev-N continuation)

### Registration

- Not yet registered in `marketing-skills/CLAUDE.md` Pipeline / Multi-Agent Skills sections (do this when v1.0.0 ships).

## Architecture decisions made (don't re-litigate)

- **Scope:** landing pages only. Blog/docs/navigation hubs use different rubrics — out of scope for v1.
- **Conversion rubric internalized via reference** — not chained to lp-optimization. The audit chain remains as an optional input (`mkt/lp-optimization.md` consumed if present).
- **Two parallel critics in Layer 5** — conversion-critic AND brand-voice-critic. Both must pass.
- **Three approval gates** — hypothesis (Gate 1) → architecture (Gate 2) → final brief (Gate 3). Long pipeline justified by brief deliverable being load-bearing for downstream work.
- **Brief envelope: 250–500 lines.** Below = thin; above = bloat. Critic enforces.
- **Sacred elements:** verbatim from BRAND.md, listed under "What NOT to Do" in every brief.
- **Per-asset rendering chains to design-create** — lp-brief produces asset slot specs; `design-create` renders each slot.

## Open questions for the user (resolve before v1.0.0)

1. **Tier system depth.** SKILL.md mentions tier 1/2/3 (primary / secondary / programmatic). Do programmatic-SEO templates (industries, workflows, compare pages) need a separate route, or stay inside this skill? The page-brief workflow user shared had 4 tiers.
2. **Shared skill chain.** SKILL.md says "if project uses a shared chain doc (e.g., `growth/page-redesigns/_prompts.md`), reference it." Is this lp-brief's job to reference, or should we ship a default shared chain inside the skill?
3. **Hypothesis rubric authority.** 3Q (Visual / Falsifiable / Uniquely Ours) — is that the canonical rubric, or should it borrow from copywriting's hook 3Q?
4. **lp-optimization audit anchoring strength.** Current spec says audit input is *optional*. Should it be *required* for Route B (existing-page redesigns)?
5. **Critic merge semantics.** Both critics PASS = DONE; both FAIL = re-dispatch. What about mixed (one PASS, one FAIL)? Currently caps at DONE_WITH_CONCERNS — confirm.

## Resume instructions

When you're ready to ship v1.0.0:
1. Resolve open questions above.
2. Write the 6 remaining agents using the existing 3 as patterns (input contract, output contract, domain instructions, self-check).
3. Write the 7 references — `conversion-principles.md` is the most load-bearing; reference lp-optimization aggressively, do not duplicate.
4. Run `/review-chain` on the completed skill before promoting to v1.0.0.
5. Bump version `0.1.0-draft` → `1.0.0` and remove `status: draft` from frontmatter.
6. Register in `marketing-skills/CLAUDE.md` Pipeline + Multi-Agent Skills sections.
7. Update `STATUS.md` to reflect production-ready state, or delete it (skill is no longer draft).

## Why this exists in the repo as a draft

User decision: save the skeleton + decisions here so the next session has full context, rather than redo the architecture work. Per project pattern (similar to `.agents/meta/content-create-split-assessment.md` for the content-create split decision), the design context is preserved.
