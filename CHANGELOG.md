# Marketing Skills — Changelog

Format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/). Versioning is [SemVer](https://semver.org/spec/v2.0.0.html) — major.minor.patch.

This file tracks stack-level releases. SKILL.md files describe current behavior; this file documents what changed and when.

---

## [4.0.0] - 2026-05-08

### BREAKING
- Renamed `start-marketing` → `orchestrate-marketing`. The skill scans existing artifacts and continues mid-pipeline; the orchestration role now reads explicitly in the slash command. No backward-compat alias — single-rev cutover.
- Update any `/start-marketing` invocations in your workflows to `/orchestrate-marketing`.

### Added
- New skill `social-copy` — generates platform-native social copy (A/B hook variants, body, CTA, format spec) for TikTok, Reels, YouTube Shorts, X, LinkedIn. Three-agent pipeline (copywriter → format-checker with max-1 hard-cap revision loop → critic) with a 5-dimension critic rubric (hook scroll-stop strength / char-word limit compliance / CTA placement vs algorithm truncation / pattern-interruption density / format compliance, 0-10 each, pass ≥35/50). Reads `short-form-brief/references/platform-intelligence/[platform].md` for per-surface Hook Taxonomy + Format Constraints + Algorithm Signals. Single-platform per invocation; YouTube long-form deliberately excluded (different rubric). Polish-chain default `none`, can route through `humanize` or `vn-tone`.
- `social-copy/references/rubric.md` v0.1 — falsifiable thresholds for each of the 5 dimensions with discrimination test protocol baked in (weak brief MUST score <25, strong brief MUST score ≥35; rubric breakage flagged when both pass or both fail).
- `social-copy/references/examples.md` — 10 worked examples (1 strong + 1 weak per platform) with full per-dimension critic verdicts. Discrimination spread on ship: strong totals 44-48 / 50; weak totals 11-23 / 50. Calibration record at `.agents/skill-artifacts/mkt/copy/2026-05-08-calibration-record.md`.
- `social-copy/references/anti-patterns.md` — 10 detection rules (generic hook openers, algorithm-blind CTAs, format mismatch, char-limit-blind copy, brand-voice ignored, pattern-interrupt monotony, pasted-from-blog body, engagement-bait CTA, external link in post body, hook-body disconnect) calibrated per platform.
- Phase 0.5b verbatim-example + source-attribution closeout — 11 deferred fresh-eyes findings from the Phase 0.5 platform-intelligence framework ship (marketplace 1.5.0) resolved across `tiktok.md`, `reels.md`, `shorts.md`, `x.md`. Verbatim hook examples without locatable specific-post URLs relabeled `[pattern-observed; URL not pinned]` (no fabricated URLs); source mis-attributions corrected (S13 ManyChat doc no longer cited as Stephanie Kase; s9 Buffer blog scope clarified as the underlying study, not the X post; s4 X-API doc footnoted to clarify dual API/organic applicability); Shorts March 2025 "loop = view" methodology preserved with practitioner-source caveat. All 6 platform-intel docs + `_template.md` `last_verified` bumped to 2026-05-08.

### Notes
- `social-copy` ships as the Phase 1.1 rubric-divergence test per stack roadmap. Operator confirmed Phase 1.2 architecture as **separate skills** (Option A) per the side-by-side analysis at `.agents/skill-artifacts/meta/records/2026-05-08-phase-1.2-divergence-test.md` — `email-copy` and `ad-copy` will ship as gap-gated standalone skills with their own per-surface reference catalogs (not as `--surface` flags on `copywriting`).
- Phase 0.5b inventory + per-finding fix log at `.agents/skill-artifacts/meta/records/phase-0.5b-inventory.md`.
- Marketing-skills surface area: 12 → 13 skills.

---

## [3.4.3] - 2026-05-08

CLAUDE.md doc cleanup — align stack-level documentation with the new `.agents/skill-artifacts/` taxonomy shipped in v3.4.2 and across the umbrella as marketplace 1.5.0.

### Changed

- `marketing-skills/CLAUDE.md` Artifacts and Cross-Stack sections — every `.agents/mkt/...`, `.agents/prioritize.md`, `.agents/targets.md` reference migrated to the new lifecycle taxonomy (`.agents/skill-artifacts/mkt/...`, `.agents/skill-artifacts/meta/sketches/prioritize-*.md`, `.agents/skill-artifacts/meta/records/targets-*.md`).
- Cross-stack `short-form-research` reference relocated from `mkt/` to `research/` to match where the producer skill writes after its own T33 migration.
- "Pipeline outputs write to `.agents/mkt/`" → "Pipeline outputs write to `.agents/skill-artifacts/mkt/`."
- Manifest Spec section + short-form-brief description updated to the new path.

### Notes

Doc-only patch — no SKILL.md or skill-behavior changes. Per-stack CLAUDE.md was left out of the v3.4.2 T33 pass to keep that pass strictly about skill output declarations; this patch closes the doc-vs-code drift.

---

## [3.4.2] - 2026-05-08

T33 path migration — every skill SKILL.md updated to the new `.agents/skill-artifacts/` lifecycle taxonomy (see `agent-skills/CLAUDE.md` §"Artifact Placement"). Mechanical churn only — no behavior changes.

### Changed

- All 12 SKILL.md files (`brand-system`, `campaign-plan`, `cold-outreach`, `copywriting`, `design-brief`, `humanize`, `lp-brief`, `lp-optimization`, `seo`, `short-form-brief`, `start-marketing`, `vn-tone`) — frontmatter `description`, `routing.produces`, `routing.consumes`, and inline body references updated:
  - `.agents/mkt/...` → `.agents/skill-artifacts/mkt/...`
  - `.agents/prioritize.md` → `.agents/skill-artifacts/meta/sketches/prioritize-*.md`
  - `.agents/targets.md` → `.agents/skill-artifacts/meta/records/targets-*.md`
  - Cross-stack: short-form-brief's reference to `short-form-research` updated to `.agents/skill-artifacts/research/short-form-research.md` (was incorrectly pinned under `mkt/`).
- All 12 SKILL.md files now declare `routing.lifecycle:` — `canonical` for `brand-system` (top-level `brand/` paths unchanged), `pipeline` for the rest.

### Notes

Non-behavioral release. Operator-driven migration to clean two-tier `.agents/` structure; old paths were not breaking but accumulated drift. No skill output changed format. No CHANGELOG entry warranted for downstream skill consumers — the path change is purely substrate-level and the manifest catches up automatically.

---

## [3.4.1] - 2026-05-08

Fresh-eyes mechanical fixes to the v3.3.0 platform-intelligence reference docs. No behavioral changes.

### Fixed

- `short-form-brief/references/platform-intelligence/linkedin.md` — Reclassified the Microsoft Q1 2026 earnings recap (Social Media Today) from `primary` to `secondary` (third-party recap; underlying earnings statements are primary). Split the conflated "Duration sweet spot (organic)" row into two rows so the 30–90s talking-head guidance and the 3+ min retention-lift figure each carry their own citation.
- `short-form-brief/references/platform-intelligence/reels.md` — Reclassified the ManyChat DM-trigger source from `primary` to `secondary` (third-party automation-tool docs documenting an integration mechanism; Mosseri's endorsement is primary, ManyChat's docs are not). Removed the unsourced "Meta's 2024 internal data cited 50% reach lift for Collab posts" claim and replaced with hedged practitioner-consensus phrasing; added a §7 open-question entry to track the citation gap. Hedged the 2,200-char caption limit and ~125-char truncation citations (`S6` was claimed but the underlying URL pin is not in the sources block); added a second §7 open-question entry.
- `short-form-brief/references/platform-intelligence/shorts.md` — Removed the unsupported numeric claim "70–90% of total Shorts views via the Shorts feed traffic source"; rephrased to "the Shorts feed handles the majority of Shorts views" with the 70–90% split flagged as practitioner-estimated and pinned to §7.
- `short-form-brief/references/platform-intelligence/tiktok.md` — Hedged the 4,000-char caption-limit citation (`jera.bean TikTok 2023 announcement` was an inline reference not registered in the frontmatter sources block) to practitioner-derived; added §7 open-question. Hedged the 3–5 hashtag-norm and >7 stuffing-penalty rows (orphan source IDs `accio-hashtag-2025`, `admetrics`, `sproutsocial` not pinned in frontmatter); added §7 open-question entry to register them on a re-research pass.
- `short-form-brief/references/platform-intelligence/youtube.md` — Reclassified the Ritchie + Beaupré algorithm-and-television-strategy recap (Richard Harrington's blog) from `primary` to `secondary` (the presenters are YouTube employees, but the source itself is a third-party blog).

### Notes

These are the 9 mechanical fresh-eyes corrections to the v3.3.0 platform-intelligence ship: tier mis-classifications corrected (3 sources), a fabricated "internal data" claim removed, an orphan source-ID chain hedged, a conflated citation row split, and §7 open-questions seeded so the next re-research pass can close the citation gaps cleanly. No content claim was strengthened — the fix direction is consistently from over-confident attribution to honest hedging plus a registered re-research item.

---

## [3.4.0] - 2026-05-07

`lp-brief` always-emit Implementation Prompt for coding agents + critic-rubric awareness + `pending-media-skill` route.

### Added

- `lp-brief` now writes `handoff-implementation.md` as a paste-ready prompt for any frontier coding agent (Claude Code, Cursor, Codex, etc.) on every brief run, regardless of `target_handoff`. Stack auto-detected from repo (frameworks → that stack; no framework → pure HTML/CSS/Vanilla JS, single index.html). Motion stack from `brand/DESIGN.md` (silent → GSAP+ScrollTrigger+Lenis default). Includes verbatim Asset Placeholder Rule so coding agents never invent stock-photo URLs — missing slot files render as solid-color placeholder blocks with slot-id overlay until a media-briefing skill catches up. New gold-standard format section in `references/handoff-formats.md` modeled on Awwwards-grade single-shot prompts.
- `lp-brief/agents/asset-slot-agent.md` adds `pending-media-skill` route value for slot types not yet covered by an existing media-briefing skill (motion, 3D, video, audio-reactive). Slots flagged this way spec dimensions/format/fallback fully; the implementation prompt renders placeholders until skills like `motion-brief` / `3d-brief` / `video-brief` ship.
- `lp-brief/agents/brand-voice-critic-agent.md` G8b — new gate scoring Implementation Prompt compliance: Asset Placeholder Rule lifted verbatim, "Invent or substitute asset URLs" ban present in DO NOT block, closing-rule presence, and (BUG FIX) callouts for tricky CSS mechanics (clip-path, mix-blend-mode + transform stacking, sticky-inside-overflow). Both critics' input contracts now reference the implementation prompt companion.

### Changed

- `lp-brief` artifact template: `target_handoff` now optional (specialty targets only — implementation prompt is universal default). `pencil` restored to enum (was missing). Array form documented. Hand-Off (Specialty Targets) section explicitly omitted when `target_handoff: null`.
- Brief stays inside the 250–500 line envelope by referencing `handoff-implementation.md` as a companion file, not inlining the 200–350-line prompt body. Prevents auto-FAIL on brand-voice critic G6 (envelope gate).

### Notes

User-driven: improve lp-brief output so coding agents (Cursor / Codex / Claude Code) can implement landing pages from a single paste-ready prompt, with media handled as placeholders deferring to `design-brief` and future media-briefing skills. Independent fresh-eyes review caught and fixed an envelope conflict, a dropped enum value (`pencil`), and a critic blind spot before merge.

---

## [3.3.0] - 2026-05-07

Platform-intelligence references for `short-form-brief` (Phase 0.5).

### Added

- `short-form-brief/references/platform-intelligence/` — 6 per-platform reference docs (LinkedIn, TikTok, Reels, Shorts, X, YouTube long-form) plus a canonical `_template.md`. Each doc covers: ≥3 platform-native hook archetypes with verbatim public-post examples + URLs + engagement metrics, format constraints (numeric over prose), 5–7 ranked algorithm signals with operator levers, anti-patterns with detection rules, hook window + retention curve, CTA placement matrix, and explicit open-questions section. Frontmatter `last_verified: 2026-05-07`. When `last_verified` exceeds 90 days, downstream critics flag `DONE_WITH_CONCERNS` ("platform signal may be stale"). 8–20 cited sources per doc, mix of primary platform docs/exec statements and named-cohort practitioner studies (Richard van der Blom, AuthoredUp, Buffer, Later, Mosseri/Ritchie/Beaupré statements, the open-sourced X algorithm). Replaces the previously-scoped standalone `algo-intel` skill — practitioner-grade reference content, not a new skill.

### Notes

This release lands the practitioner-grade answer to the "algo-master" ask (per stack roadmap). YouTube long-form ships pre-built so it's available when long-form briefs become a Phase 2 candidate. Drafts are `status: draft` until first real-use validation; the `last_verified` 90-day staleness gate is enforced by consuming critics.

---

## [3.2.0] - 2026-05-07

Manifest-aware state detection in `start-marketing`.

### Changed

- `start-marketing` SKILL.md — Step 1 (State Detection) now reads `.agents/manifest.json` first with a status-aware lookup table (`done`, `done_with_concerns`, `blocked`/`needs_context`, `stale`, `frontmatter_present: false`). Per-artifact staleness flows from the manifest's `stale_after_days` field rather than the previous 180-day brand-artifact rule. The manifest's `experience` block surfaces Pre-Dispatch coverage (entries count for `brand.md`, `audience.md`, `goals.md`). Per-path filesystem scan demoted to fallback for fresh projects. Anti-pattern entry added: "Don't ignore the manifest." Added `side-effects: [manifest-sync]` to the skill's routing block.
- `CLAUDE.md` — added "Manifest Spec" section pointing producer skills (brand-system, copywriting, campaign-plan, lp-brief, lp-optimization, seo, cold-outreach, design-brief, humanize, vn-tone, short-form-brief) at the canonical contract in `meta-skills/references/manifest-spec.md` and the frontmatter obligations.

### Notes

This release lands the manifest-spec contract on the consumer side. Per-skill frontmatter retrofit (brand-system, copywriting, etc.) follows in a later release — the spec's graceful fallback (`frontmatter_present: false`) keeps existing artifacts working until producers are migrated.

---

## [3.1.0] - 2026-05-06

Stack orchestrator added; declaration drift fixed.

### Added

- `start-marketing` — Stack orchestrator. Reads `research/`, `brand/`, `.agents/mkt/`, and `.agents/experience/*.md`, parses the user's free-form ask (or asks one bundled scoping question if empty), and proposes the next 1–3 skills in the marketing pipeline (`brand-system` → `campaign-plan` → content layer (`copywriting` / `lp-brief` / `seo` / `cold-outreach` / `short-form-brief`) → polish (`humanize` / `vn-tone`)) with rationale + cost + duration. Honors the brand-foundation gate — defers to `brand-system` (or upstream `icp-research`) when prerequisites are missing. Never auto-invokes — always prints the `/skill-name` for the user to type. Persists a breadcrumb to `.agents/experience/marketing-workflow.md`. Standard budget, ~$0.10–0.30 per run. Pipeline catalog lives in `references/workflow-graph.md`.

### Fixed

- `short-form-brief` was present on disk since v3.0.0 but missing from `.claude-plugin/plugin.json` `skills[]` — declaration restored. Skill now installs correctly via the Claude Code plugin marketplace path.

### Changed

- Plugin `keywords` extended with `short-form` to surface the video-brief capability in marketplace search.

---

## [1.0.0] - 2026-05-05

Initial public release. Brand identity, persuasive copy, campaign planning, landing-page architecture, design briefs, search visibility, humanization, localization polish, and outbound.

### Added

**Skills (10)**

- `brand-system` — Builds brand identity as three artifacts: `brand/BRAND.md` (story, voice, positioning, archetype), `brand/DESIGN.md` (AI-readable design system with palettes, tokens, components, motion), `brand/ASSETS.md` (per-platform production inventory with auto-scanned checkboxes). Carries the canonical 13-platform target catalog inside Pre-Dispatch. 8 agents; Quick Brand (Route A, BRAND.md only) or Full (Route B, all three artifacts).
- `copywriting` — Horizontal copy craft for any surface: landing pages, emails, social posts, headlines, CTAs, taglines, subject lines. Pre-writing framework drives every agent. Produces inline OR `.agents/mkt/content/[slug].copy.md`. 9 agents (hook, body, CTA, social-proof, variant, voice, psychology, zero-risk, critic).
- `campaign-plan` — Coordinates ICP research into integrated marketing communication: 3-5 messaging pillars, 3D angles per pillar, 9-channel evaluation with habitat-informed selection, timeline, ORB launch sequencing. Produces `.agents/mkt/campaign-plan.md`. 6 agents.
- `humanize` — Strips 37 AI writing patterns + injects voice + compresses 15-30%. 5-dimension critic. Produces `.agents/mkt/content/[slug].humanized.md`. 6 agents (Layer 1 parallel: pattern-scanner + voice-extractor; Layer 2 sequential: strip → soul-injection → compression → critic).
- `vn-tone` — Post-translation Vietnamese register polish across 4 registers (báo chí, semi-casual, bro, pop-marketing) backed by a live-scraped corpus reference. Detects 28 EN→VN translation artifacts. 3 agents (diagnostic → polisher → critic).
- `lp-optimization` — Landing-page conversion audit with 4 modes (full audit, AI/agent engine optimization, programmatic, ASO). Message-match verification against traffic source. Produces `.agents/mkt/lp-optimization.md`. 7 agents.
- `lp-brief` — Campaign-grade redesign brief: hypothesis, surface rhythm, section spec, asset slots, hand-off prompts. Internalizes lp-optimization conversion principles via cite-by-line reference (CP-01 → CP-13). **Hard-gated on `brand/BRAND.md` + `brand/DESIGN.md`**. 9 agents with 3 Approval Gates. Tier-1 only (primary + secondary conversion pages).
- `seo` — 4 modes: technical audit, AI/agent engine optimization, programmatic page generation, competitor comparison content, ASO. Mode-based routing dispatches different agents. Produces `.agents/mkt/seo-[mode].md`. 11 agents across modes.
- `cold-outreach` — Touch-based outbound (services-sell / saas-sell / partnership-sell / community-sell). Mode + Channel + Target + Trigger + Outcome + Bridge + Proof — most-elaborate Pre-Dispatch in the stack with Missing-Input Hard Blocks (mode/channel/target/proof cannot be substituted). Compose route + Reply route. 8 agents; terminal humanize with specificity regression check.
- `design-brief` — Per-asset graphic-design brief for downstream renderers (Claude Design / Pencil MCP / Figma / human designer). 4 downstream routes (image-gen / vector-tool / designer-handoff / template-pack) drive Layer 2 agent selection. **Hard-gated on `brand/BRAND.md` + `brand/DESIGN.md`**. 7 agents with 2 Approval Gates.

**Pipeline contract**

```
brand-system (visual identity foundation)
  ↓
campaign-plan (channel strategy + calendar)
  ↓
  ├─ lp-brief (per landing page) → design-brief (per asset slot)
  ├─ seo (per mode)
  └─ cold-outreach (per touch)

Audit existing pages: lp-optimization → (if redesign warranted) lp-brief

Horizontal: copywriting, humanize, vn-tone — invoked at any stage.
```

**Architectural patterns**

- **Pre-Dispatch protocol** — every skill follows the canonical spec at `meta-skills/references/pre-dispatch-protocol.md`. Cold Start / Warm Start flows; answers persist to `.agents/experience/{product,audience,brand,business,goals}.md`. Hard-gated skills (`design-brief`, `lp-brief`) gate before cold-start questioning.
- **Status protocol** — every skill emits `DONE / DONE_WITH_CONCERNS / BLOCKED / NEEDS_CONTEXT`; artifact frontmatter mirrors.
- **Multi-agent orchestration** — Layer 1 (parallel) → Layer 2 (sequential) → Critic gate (PASS/FAIL, max 2 rewrite cycles). `cold-outreach` adds a terminal humanize with specificity regression check.
- **Reusable agent template** — `copywriting/agents/_template.md` defines the standard structure for agent instruction files across the stack.

**Cross-stack**

- `research/product-context.md` (icp-research) read by brand-system, copywriting, campaign-plan, lp-brief, lp-optimization, design-brief, humanize, vn-tone, seo, cold-outreach.
- `research/icp-research.md` (icp-research) read by brand-system, copywriting, campaign-plan, lp-brief, lp-optimization, design-brief, seo, cold-outreach.
- `.agents/prioritize.md` + `.agents/targets.md` (research-skills) optionally read by campaign-plan, lp-brief for strategic alignment.
