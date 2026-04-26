# Marketing Skills

Brand identity, content creation, campaign planning, optimization, outbound, and attribution.

## Pipeline
brand-system (visual identity foundation)

content-research (research-skills) → imc-plan → content-short → attribution
content-research-long (research-skills) → imc-plan → content-long → attribution

content-short / content-long + brand-system → design-create (visual creative for the copy)
lp-optimization (audit existing page) → lp-brief (redesign spec) → design-create (per asset slot)

Horizontal: copywriting, seo, humanize, vn-tone, cold-outreach, creator-brief

Legacy (being retired): content-create — superseded by content-short + content-long + creator-brief.

## Recommended Starting Point
Run `icp-research` (from [research-skills](https://github.com/hungv47/research-skills)) first — it creates `research/product-context.md`, the canonical cross-stack record consumed by 12+ downstream skills.

## Artifacts
Pipeline outputs write to `.agents/mkt/`; cross-stack records live in the top-level `research/` folder:
- `research/product-context.md` (cross-stack — created by icp-research in research-skills)
- `research/icp-research.md` (canonical audience record — from icp-research in research-skills)
- `.agents/mkt/content-research.md` (from content-research in research-skills — short-form)
- `.agents/mkt/content-research-long.md` (from content-research-long in research-skills — long-form)
- `.agents/mkt/imc-plan.md`
- `.agents/mkt/content/[slug].md` (from content-short or content-long)
- `.agents/mkt/content/[slug].meta.md` (title + meta variants + schema + distribution checklist — from content-long)
- `.agents/mkt/content/[slug].copy.md`
- `.agents/mkt/attribution.md`
- `.agents/mkt/seo-[mode].md` (mode = audit | ai | programmatic | competitor)
- `.agents/mkt/content/[slug].humanized.md`
- `.agents/mkt/content/[slug].vn-tone.md`
- `.agents/mkt/cold-outreach/[slug].md` (+ `[slug].rationale.md` + `[slug].critic-score.md`)
- `brand/BRAND.md` (brand narrative, voice, positioning, archetype)
- `brand/DESIGN.md` (AI-readable design system with palettes, tokens, components)
- `.agents/mkt/design/[slug]/brief.md` (approved concept brief — from design-create)
- `.agents/mkt/design/[slug]/render.[ext]` (Pencil/Paper render — from design-create routes PE/PA)
- `.agents/mkt/design/[slug]/prompt.md` (generative AI prompt — from design-create route P)
- `.agents/mkt/design/[slug]/figma-spec.md` (Figma handoff spec — from design-create route F)
- `.agents/mkt/design/[slug]/critic.md` (visual rubric report — from design-create)
- `.agents/mkt/lp-brief/[slug]/brief.md` (landing-page redesign brief — from lp-brief; rev versions at `v[N]/brief.md`)
- `.agents/mkt/lp-brief/[slug]/handoff-*.md` (per-target hand-off prompts — from lp-brief)
- `.agents/mkt/lp-brief/[slug]/asset-slots/*.prompt.md` (per-slot generative prompts — from lp-brief, consumed by design-create)

## Cross-Stack (Optional)
Attribution and IMC Plan can read research artifacts for alignment:
- `.agents/solution-design.md` (from solution-design in research-skills)
- `.agents/targets.md` (from funnel-planner in research-skills)
`npx skills add hungv47/research-skills`

## Multi-Agent Skills

All 13 skills use a two-layer multi-agent orchestration pattern:

- `SKILL.md` = **orchestrator** — dispatch graph, routing logic, merge step, critic gate
- `agents/` = **sub-agent instruction files** — each with role, input/output contracts, domain knowledge, self-check
- `references/` = **shared data catalogs** — formula lists, template libraries read by multiple agents

### How it works
1. Orchestrator gathers context (pre-writing, artifacts, brief)
2. **Layer 1** agents run in parallel — each writes one section independently
3. Orchestrator merges outputs into the artifact template
4. **Layer 2** agents run sequentially — each refines the full document through one lens
5. **Critic agent** scores the output and returns PASS or FAIL (max 2 rewrite cycles)

### Skills using this pattern
- `brand-system` — 8 agents (strategy, personality, voice, visual, token-architect, component-token, accessibility, critic). Layer 1 parallel (strategy + personality) → Layer 2 sequential (voice→visual→token-architect→component-token→accessibility→critic).
- `copywriting` — 9 agents (hook, body, CTA, social-proof, variant, voice, psychology, zero-risk, critic)
- `content-create` — 8 agents (format, voc-extraction, hook, body, CTA, platform-compliance, ab-variant, critic). Layer 1→1.5→2 pattern. **Legacy — being retired in favor of content-short + content-long + creator-brief.**
- `content-long` — 8 agents (format, voc-extraction, lede, body, cta, seo-compliance, title-variant, critic). Layer 1 parallel (format + voc-extraction) → Layer 1.5 parallel writers (lede + body + cta) → Layer 2 sequential (seo-compliance → title-variant) → critic. Long-form analog of content-create — produces blog, pillar, case study, byline, PR, newsletter, app store/G2 listings. Consumes content-research-long briefs.
- `imc-plan` — 6 agents (pillar, angle, channel, timeline, launch-sequencing, critic). Primarily sequential.
- `humanize` — 6 agents (pattern-scanner, voice-extractor, strip, soul-injection, compression, critic). Layer 1 parallel (scan + extract) → Layer 2 sequential (strip→inject→compress→critic).
- `vn-tone` — 3 agents (diagnostic, polisher, critic). Layer 1 (diagnostic) → Layer 2 sequential (polisher→critic). Post-translation Vietnamese register polish across 4 registers (báo chí, semi-casual, bro, pop-marketing) backed by a live-scraped corpus reference.
- `lp-optimization` — 7 agents (hero-audit, trust-audit, cta-audit, ux-audit, message-match, prioritization, critic). Layer 1 parallel (4 audit agents) → Layer 2 sequential (message-match→prioritization→critic).
- `seo` — 11 agents across 4 modes (technical, AI, programmatic, competitor). Mode-based routing.
- `attribution` — 7 agents (kpi-hierarchy, initiative-mapper, channel-attribution, content-mapper, gap-analysis, action, critic). Fully sequential.
- `cold-outreach` — 8 agents (signal-analyst, strategist, proof-selector, composer, voice-auditor, critic, reply-classifier, reply-composer). Two-stage Layer 1 (signal-analyst solo → strategist + proof-selector parallel) → Layer 2 sequential (composer→voice-auditor→critic) → terminal humanize with specificity regression check. Reply route replaces Layer 1 with reply-classifier and Layer 2's composer slot with reply-composer.
- `design-create` — 9 agents (brand-anchor, concept, copy-anchor, brief-synth, prompt-craft, pencil-render, paper-render, figma-spec, critic). Layer 1 parallel (brand-anchor + concept + copy-anchor) → Layer 1.5 brief-synth → **Approval Gate 1** → Layer 2 route-specific renderer (P/PE/PA/F) → Layer 3 critic → **Approval Gate 2**. Visual analog of content-create — produces per-asset creative briefs and renders, gated by user approval at brief and output stages.
- `lp-brief` — 9 agents (audit-anchor, brand-anchor, hypothesis, architecture, section-spec, asset-slot, handoff, conversion-critic, brand-voice-critic). Layer 1 parallel (audit-anchor + brand-anchor) → Layer 1.5 hypothesis → **Approval Gate 1** → Layer 2 architecture → **Approval Gate 2** → Layer 3 section-spec → Layer 3.5 asset-slot (consumes section-spec slot IDs) → Layer 4 handoff → Layer 5 parallel critics (conversion + brand-voice, both binary PASS/FAIL) → **Approval Gate 3**. Page-level orchestrator between strategy and design — produces a campaign-grade landing-page redesign brief with hypothesis, architecture, per-section spec, asset slots, and target-tool hand-off prompts. Internalizes lp-optimization conversion principles via cite-by-line reference (CP-01 → CP-13). Tier-1 only (primary + secondary conversion pages); programmatic SEO templates out of scope.

### Reusable template
`copywriting/agents/_template.md` defines the standard structure for agent instruction files.
