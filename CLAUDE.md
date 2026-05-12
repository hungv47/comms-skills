# Marketing Skills

Brand identity, persuasive copy, campaign planning, landing-page architecture, design briefs, search visibility, humanization, localization polish, outbound, paid Meta ads, short-form video briefs, and platform-native social-copy. 12 skills + orchestrate-marketing.

## Pipeline
brand-system (visual identity foundation)
  ↓
campaign-plan (channel strategy + calendar)
  ↓
  ├─ lp-brief (per landing page) → design-brief (per asset slot)
  ├─ seo (per mode: audit / ai / programmatic / competitor / aso)
  ├─ short-form-brief (per video asset) ← reads short-form-research.md from research-skills
  ├─ ad-copy (per audience-temp — Meta retargeting OR cold-traffic)
  └─ cold-outreach (per touch)

Landing pages: lp-brief owns construction-time conversion best practices for new pages and redesigns.

Horizontal: copywriting, humanize, vn-tone — invoked at any stage.

## Recommended Starting Point
Run `icp-research` (from [research-skills](https://github.com/hungv47/research-skills)) first — it creates `research/product-context.md`, the canonical cross-stack record consumed by 12+ downstream skills.

## Artifacts
Pipeline outputs write to `.agents/skill-artifacts/mkt/`; cross-stack records live in the top-level `research/` and `brand/` folders:
- `research/product-context.md` (cross-stack — created by icp-research in research-skills)
- `research/icp-research.md` (canonical audience record — from icp-research in research-skills)
- `.agents/skill-artifacts/research/short-form-research.md` (from short-form-research in research-skills — per-platform best-practice catalog, consumed by short-form-brief)
- `.agents/skill-artifacts/mkt/campaign-plan.md`
- `.agents/skill-artifacts/mkt/content/[slug].copy.md` (from copywriting)
- `.agents/skill-artifacts/mkt/seo-[mode].md` (mode = audit | ai | programmatic | competitor | aso)
- `.agents/skill-artifacts/mkt/content/[slug].humanized.md`
- `.agents/skill-artifacts/mkt/content/[slug].vn-tone.md`
- `.agents/skill-artifacts/mkt/cold-outreach/[slug].md` (+ `[slug].rationale.md` + `[slug].critic-score.md`)
- `.agents/skill-artifacts/mkt/ad-copy/[audience-temp]-[date]-[slug].md` (+ `[slug].rationale.md` + `[slug].critic-score.md`) — from ad-copy
- `brand/BRAND.md` (brand narrative, voice, positioning, archetype)
- `brand/DESIGN.md` (AI-readable design system with palettes, tokens, components)
- `brand/ASSETS.md` (per-platform production inventory with auto-scanned checkboxes)
- `.agents/skill-artifacts/mkt/lp-brief/[slug]/brief.md` (landing-page redesign brief — from lp-brief; rev versions at `v[N]/brief.md`)
- `.agents/skill-artifacts/mkt/lp-brief/[slug]/handoff-*.md` (per-target hand-off prompts — from lp-brief)
- `.agents/skill-artifacts/mkt/lp-brief/[slug]/asset-slots/*.prompt.md` (per-slot generative prompts — written by design-brief when invoked on a slot)
- `.agents/skill-artifacts/mkt/design-briefs/[slug].md` (per-asset graphic-design brief — from design-brief)
- `.agents/skill-artifacts/mkt/short-form-brief/[slug]/brief.md` (hero short-form video brief — from short-form-brief)
- `.agents/skill-artifacts/mkt/short-form-brief/[slug]/variants/[platform].md` (per-platform variant briefs — from short-form-brief, when multi-platform)

## Cross-Stack (Optional)
campaign-plan and lp-brief can read research artifacts for alignment:
- `.agents/skill-artifacts/meta/sketches/prioritize-*.md` (from prioritize in research-skills)
- `.agents/skill-artifacts/meta/records/targets-*.md` (from funnel-planner in research-skills)
`npx skills add hungv47/research-skills`

## Pre-Dispatch Protocol

All 12 skills follow the canonical Pre-Dispatch protocol (`meta-skills/references/pre-dispatch-protocol.md`). Cold Start (3-7 bundled questions, one round-trip) when context is missing; Warm Start (summary + optional probe) when artifacts/experience cover what's needed. Answers persist to `.agents/experience/{product,audience,brand,business,goals,content}.md` so subsequent skills never re-ask. Hard-gated skills (`design-brief`, `lp-brief`) gate before cold-start questioning — recommend `brand-system` when gates fail. `cold-outreach` has the most-elaborate cold-start (7 questions + Missing-Input Hard Blocks for mode/channel/target/proof); `ad-copy` is a close second (7 questions + audience-temp + creative-format hard-blocks). `brand-system` carries the canonical 13-platform target list as a catalog inside its Pre-Dispatch. `short-form-brief` writes brand_mode + production_mode to `.agents/experience/content.md`.

## Complexity Routing

Every skill declares a `budget` tier in frontmatter: `fast`, `standard`, or `deep`. The harness reads the tier and adjusts execution before dispatch:

| Budget | Execution |
|--------|-----------|
| **fast** | Single-agent, no sub-agent dispatch, no critic gate. Respond directly. |
| **standard** | Reduced orchestration — essential agents only, one critic pass. |
| **deep** | Full orchestration as documented — all agents, all layers, full critic gate. |

**Auto-downgrade** (before dispatch): ≤3 sentences AND no prior artifacts AND not deep → fast; single-topic clear-scope → cap at standard; multi-artifact / cross-domain / ambiguous → full tier.

**Override — bidirectional.** Auto-downgrade is heuristic; operator intent wins.

- **Upward (force deeper):** "run this thoroughly", "full analysis", "deep mode" → use the documented tier even on small inputs.
- **Downward (`--fast`):** `--fast` flag on the slash command, OR phrases "fast mode" / "quick pass" / "skip the orchestration" in the same turn → force single-agent execution regardless of tier. No sub-agents, no critic gate, no rewrite loops, no warm-start Pre-Dispatch interrogation. Skill produces its core deliverable in one pass and ends with "Ran in --fast mode; rerun without the flag for full critique."

**`--fast` does NOT skip Cold Start.** When no context is resolvable from artifacts or `.agents/experience/`, the skill still asks its bundled cold-start questions. `--fast` only bypasses multi-agent orchestration *after* context is resolved — it does not authorize hallucinating against missing audience/business/brand decisions.

**Safety gates supersede `--fast`.** Hard-gated skills enforce gates regardless of `--fast`: `design-brief` and `lp-brief` cannot ship a brief without brand-system context (the gate fires before orchestration); `ad-copy`'s Meta policy + claim-substantiation format-checker runs regardless of speed (ad-policy compliance is not optional); `cold-outreach`'s Missing-Input Hard Blocks for mode/channel/target/proof still fire. The contract is "skip the heavy lift, not the guardrails."

Conflict rules: `--fast` on a `fast`-tier skill is a no-op. `--fast` + "run thoroughly" → `--fast` wins (explicit flag > upward phrase). `--fast` + `--deep` → `--fast` wins (downward bias on conflicting explicit flags). Budget is the default — never a ceiling, never a floor.

## Manifest Spec

State detection across all marketing skills (especially `orchestrate-marketing`) reads `.agents/manifest.json` — a derived index of artifact metadata (producer, date, status, schema version, staleness, summary). The manifest is rebuilt from artifact frontmatter by `meta-skills/scripts/manifest-sync.ts`; skills don't write to it directly. See [`../meta-skills/references/manifest-spec.md`](../meta-skills/references/manifest-spec.md) for the full contract. Skills that produce artifacts (brand-system, copywriting, campaign-plan, lp-brief, seo, cold-outreach, design-brief, humanize, vn-tone, short-form-brief) must write the required frontmatter fields (`skill`, `version`, `date`, `status`) and call sync as their last step.

## Multi-Agent Skills

All 12 skills use a two-layer multi-agent orchestration pattern:

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
- `copywriting` — 9 agents (hook, body, CTA, social-proof, variant, voice, psychology, zero-risk, critic).
- `campaign-plan` — 6 agents (pillar, angle, channel, timeline, launch-sequencing, critic). Primarily sequential.
- `humanize` — 6 agents (pattern-scanner, voice-extractor, strip, soul-injection, compression, critic). Layer 1 parallel (scan + extract) → Layer 2 sequential (strip→inject→compress→critic).
- `vn-tone` — 3 agents (diagnostic, polisher, critic). Layer 1 (diagnostic) → Layer 2 sequential (polisher→critic). Post-translation Vietnamese register polish across 4 registers (báo chí, semi-casual, bro, pop-marketing) backed by a live-scraped corpus reference.
- `seo` — 11 agents across 4 modes (technical, AI, programmatic, competitor). Mode-based routing.
- `cold-outreach` — 8 agents (signal-analyst, strategist, proof-selector, composer, voice-auditor, critic, reply-classifier, reply-composer). Two-stage Layer 1 (signal-analyst solo → strategist + proof-selector parallel) → Layer 2 sequential (composer→voice-auditor→critic) → terminal humanize with specificity regression check. Reply route replaces Layer 1 with reply-classifier and Layer 2's composer slot with reply-composer.
- `design-brief` — 7 agents (brand-anchor, concept, copy-anchor, brief-synth, prompt-craft, figma-spec, critic). Layer 1 parallel (brand-anchor + concept + copy-anchor) → Layer 1.5 brief-synth → **Approval Gate 1** → Layer 2 downstream-route augmentation (image-gen prompt-craft OR designer-handoff figma-spec OR vector-tool spec inline) → Layer 3 critic (rubric + generic-AI + platform-fit) → **Approval Gate 2**. Re-scoped from previous render-focused skill (design-create) — now brief-only, rendering happens downstream. Per-platform module specs ship as a skeleton — needs follow-up build pass.
- `lp-brief` — 9 agents (evidence-anchor, brand-anchor, hypothesis, architecture, section-spec, asset-slot, handoff, conversion-critic, brand-voice-critic). Layer 1 parallel (evidence-anchor + brand-anchor) → Layer 1.5 hypothesis → **Approval Gate 1** → Layer 2 architecture → **Approval Gate 2** → Layer 3 section-spec → Layer 3.5 asset-slot (consumes section-spec slot IDs) → Layer 4 handoff → Layer 5 parallel critics (conversion + brand-voice, both binary PASS/FAIL) → **Approval Gate 3**. Page-level orchestrator between strategy and design — produces a campaign-grade landing-page brief with hypothesis, architecture, per-section spec, asset slots, and target-tool hand-off prompts. Owns the local conversion-principles rubric (CP-01 → CP-13) under `references/conversion/`. Tier-1 only (primary + secondary conversion pages); programmatic SEO templates out of scope.
- `short-form-brief` — 9 agents (format, voc-extraction, production-mode, hook, storyboard, audio, copy-pack, platform-tailor, critic). Layer 1 parallel foundation (format + voc-extraction + production-mode) → Layer 1.5 parallel craft (hook + storyboard + audio + copy-pack) → Layer 2 sequential (platform-tailor for variants → critic with 4 sub-critics: hook + production + algorithm-fit + brand-fit). Per-asset video brief consuming `.agents/skill-artifacts/research/short-form-research.md`. Hard cap: 1 hero + 2 variants per invocation. Brand modes: founder | company. Polish chain (vn-tone | humanize) auto-routes per (market, brand_mode) on spoken-line section.
- `social-copy` — 3 agents (copywriter, format-checker, critic). Sequential dispatch: copywriter generates A/B hooks + body + CTA per locked brief or topic → format-checker enforces char/word limits + CTA placement vs algorithm truncation point + format compliance (max 1 revision loop on hard-cap violation; two consecutive failures = FORMAT_FAIL escalated to user) → critic scores against 5-dimension rubric (hook scroll-stop strength / char-word limit compliance / CTA placement vs truncation / pattern-interruption density / format compliance, 0-10 each, total 50, pass ≥ 35, DWC 25-34, fail < 25). Single-platform per invocation: tiktok / reels / shorts / x / linkedin. YouTube long-form excluded. Single-market per artifact. Polish chain default `none`; routes through humanize / vn-tone when set.
- `ad-copy` — 5 agents (strategist, composer, format-checker, voice-auditor, critic). Layer 1 strategist solo (audience-temp framing + per-variant archetype + per-variant anchor + CTA + ceiling warning) → Layer 2 sequential: composer (hero + 2 variants per Meta char-cap discipline) → format-checker (Meta hard caps + policy banned-phrase + measured-claim substantiation; hard-bounce on REVISION_REQUIRED; FORMAT_FAIL on second-pass violation) → voice-auditor (strip vendor-speak + AI tells + em-dashes, BLOCK on structural issues) → critic (6-dimension rubric: hook scroll-stop / component-char compliance / CTA-LP match / pattern-interruption density across variants / policy+claim compliance / Specificity Floor ≥2; pass aggregate ≥ 42/60 with all per-variant per-dim ≥ 6) → terminal humanize per variant with specificity regression check. Meta-only at v1 (retargeting + cold-traffic). Single audience-temp per invocation — run twice for campaigns spanning both. Hero + 2 distinct variants per artifact. Per-surface practitioner refs at `references/ad-intelligence/{meta-retargeting,meta-cold-traffic,creative-cadence}.md` (single-source-tier; calibrate before adopting numeric thresholds).

### Reusable template
`copywriting/agents/_template.md` defines the standard structure for agent instruction files.

## Recent Changes
- 2026-05-11: Marketplace 2.4.0 — added new skill `ad-copy` (Phase 1.2). Meta paid-ad copywriting for retargeting + cold-traffic audiences with 5-agent dispatch (strategist + composer + format-checker + voice-auditor + critic), 6-dimension critic rubric, hard char-cap + policy enforcement, hero + 2 variants per audience-temperature, automatic humanize terminal pass per variant. Pre-staged ad-intelligence references (meta-retargeting / meta-cold-traffic / creative-cadence from REB-3) now consumed by the skill. Meta-only at v1; Google RSA / LinkedIn / TikTok Ads reserved for future expansion. Stack surface: 12 → 13 skills.
- 2026-05-08: Marketplace 2.0.0 wave — renamed `start-marketing` → `orchestrate-marketing` (BREAKING). Added new skill `social-copy` (Phase 1.1 rubric-divergence test passes; operator confirmed Phase 1.2 architecture as separate skills, Option A). Phase 0.5b platform-intel closeout: 11 deferred fresh-eyes findings on tiktok/reels/shorts/x verbatim-example URLs and source attributions resolved (relabeled `[pattern-observed; URL not pinned]` where specific post URLs not locatable; mis-attributions corrected; `s4` X-API doc footnoted for dual API/organic applicability). All 6 platform-intel docs + `_template.md` `last_verified` bumped to 2026-05-08. Stack surface: 11 → 12 skills.
- 2026-05-04: Removed `content-create`, `content-short` (empty stub), `content-long`, `attribution` from the stack. Renamed `design-create` → `design-brief` and re-scoped to brief-only (no rendering); platform-aware module specs ship as a skeleton pending a follow-up build pass.
