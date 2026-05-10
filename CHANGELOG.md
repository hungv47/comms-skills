# Marketing Skills — Changelog

Format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/). Versioning is [SemVer](https://semver.org/spec/v2.0.0.html) — major.minor.patch.

This file tracks stack-level releases. SKILL.md files describe current behavior; this file documents what changed and when.

---

## [4.0.4] - 2026-05-10

REB-3 ad-intelligence reference seedbank lands. No new skills, no breaking changes — pre-staged references for the future `ad-copy` skill (skill scaffold pending; ≤6 months out per T53 operator gate). Sourced from 4 practitioner files in operator's idea vault. Audited under the "default SKIP / only signal" bar codified in agent-skills CLAUDE.md.

### Added
- `skills/ad-copy/references/ad-intelligence/meta-retargeting.md` — warm-audience retargeting system: 3 custom audiences (IG engagers 180d / IG followers / FB page engagers from cold-traffic interactions), warm-vs-cold objection map (warm = fit/credibility/timing, NOT awareness/positioning), creative posture differentiation, frequency-driven budget pacing (`$20-50/day` starter, `$100-200/day` mature), 4-step Meta Ads Manager setup, compounding effect rationale, 7 named failure modes. Source: George Clem (Paid House, $200k+/mo agency). Numeric examples (`$2k cold / $500 retargeting / 4x`) labeled illustrative, not benchmarks.
- `skills/ad-copy/references/ad-intelligence/meta-cold-traffic.md` — subscription-app cold-traffic playbook: pre-conditions for paid (organic warmth + first-year profitability + founder hands-on learning), 2-campaign structure (Scale CBO + Testing), broad targeting + algo-via-creative (post-Andromeda), conversion-event choice (trial-start NOT purchase, due to Apple privacy 24h signal window), 3-layer attribution (custom product pages + MMP + incrementality testing), 6 anti-patterns, cross-vertical applicability matrix (apps vs DTC vs B2B SaaS — what transfers, what doesn't). Source: Cali (`$2M/mo influencer-only` → `$5.7M/mo` with paid layer; in-house ads run by Zach after agency `$5K/day` cap).
- `skills/ad-copy/references/ad-intelligence/creative-cadence.md` — paid-ad creative cadence discipline: variant volume (master brief → many angles), kill-speed thresholds (`1.5% CTR / 48h` auto-pause; "3 days not 3 weeks"), winner-vs-test budget split (`80/20` directional), dedicated-vs-repurposed creative spend ceiling differential (`$10-15K/day` repurposed vs `$40K/day` dedicated), affiliate-creator production model (Tribe + WhatsApp), 6 failure modes, source-confidence reconciliation (3 sources of varying confidence with explicit per-claim attribution). Sources: Simplr Intelligence commenter + uncited operator-vault thresholds + Cali creative-strategy section.
- `skills/ad-copy/README.md` — directory-level note flagging `ad-copy/` as a pre-staged seedbank (no SKILL.md, no plugin-manifest entry, intentionally absent from `skills` array). Protects against future cleanup-artifacts orphan flags by stating re-entry trigger explicitly.

### Notes
- Bump kind: PATCH. Pre-stage of references only — no skill scaffold, no plugin-manifest changes (`.claude-plugin/plugin.json` `skills` array unchanged because `ad-copy/` has no SKILL.md to register), no contract changes for downstream consumers, no behavioral change to any active skill. Driven by Reference Enrichment Backlog REB-3 in `.agents/skill-artifacts/meta/roadmap.md`. Operator T53 gate (2026-05-10): ad-copy build ≤6 months out → REB-3 executes vs SKIP-and-rot.
- The 3 reference docs each carry explicit source-confidence labels and re-verification triggers in their frontmatter and footer. When `ad-copy` skill scaffolds, refs should be re-verified before consumption — Meta's ad system shifts on quarter cadences.
- Anti-fabrication discipline (per the v4.0.3 fresh-eyes patch lessons): every numeric threshold is attributed to a specific source ID; illustrative examples are explicitly labeled as such; no invented metrics presented in verbatim format.

---

## [4.0.3] - 2026-05-10

Fresh-eyes review of v4.0.2 caught 4 real issues. Patch closes them before any user-facing announcement.

### Fixed
- **3 fabricated illustrative examples in `copywriting/references/emotional-triggers.md`** — Trigger 5 (Curiosity Gap) "Strong gap" comparison table contained 2 invented rows (`"the cold email template that opened a $150k deal in 8 minutes"` and `"the 3-second hook structure that took my app from 0 to #1 in 3 days"`) that did not appear in the Paolo Scales source; Trigger 5 "compound hooks" bullet list contained a fabricated third bullet (`"the silent reason your sales calls don't close (it's not the offer)"`) presented in the same italicized verbatim-quote format as 2 legitimate Paolo quotes; Trigger 6 (Aspiration) skepticism-vs-aspiration table contained a fabricated 2nd row with invented `$5M business` / `$90k → $11k MRR` figures. Per the stack's anti-fabrication norm (auto-FAIL), all four were ship-blockers. **Resolution:** fabricated rows replaced with explicit illustrative-paraphrase placeholders that name the structural ingredients (e.g., "specific framework + specific outcome + specific timeframe") and instruct the reader to instantiate from real data — with an anti-fabrication warning ("invented results are detectable and burn the account permanently"). Comparison-table teaching pattern preserved; false-attribution risk removed.
- **`copywriting/agents/hook-agent.md` + `copywriting/agents/psychology-agent.md` body wiring** — v4.0.2 added `references/emotional-triggers.md`, `belief-disruption.md`, `lead-magnet-stack.md` to SKILL.md's Layer 1 + Layer 2 dispatch matrices, but the agent bodies had no instruction on how to integrate the new refs into the existing Headline Formula Catalog (hook-agent) or Sweep 6: Heightened Emotion (psychology-agent). The dispatch protocol passes the path, but agents would have landed cold. **Resolution:** `hook-agent.md` gains an "Engagement-Driven Hook References" sub-section (peer to Headline Formula Catalog) explicitly listing when to invoke each new ref (TOF / lead-magnet / persuasion-heavy hooks only — not tactical product/nav/label copy). `psychology-agent.md` Sweep 6 gains an "Engagement-driven sub-pass — when to invoke" addition with the same triage. Both agents' input-contract `references` fields updated to reflect the new state.

### Notes
- The fresh-eyes report driving this patch is at `.agents/skill-artifacts/meta/records/2026-05-10-fresh-eyes-reb-2.md` (local-only).
- v4.0.2 was pushed remotely before these gaps surfaced. Anyone who ran `/plugin install marketing-skills@4.0.2` would have received the v4.0.2 emotional-triggers.md with fabricated examples; v4.0.3 corrects this. Patch ships hours after v4.0.2 — no v4.0.2-based work is at risk.
- `belief-disruption.md` and `lead-magnet-stack.md` cleared review with no findings — fabrication issues were concentrated in one file.
- `research-skills` not affected (REB-2c synthesis-heuristic addition cleared review). No companion patch needed in research-skills.

---

## [4.0.2] - 2026-05-10

REB-2 marketing reference enrichment lands. No new skills, no breaking changes — additive references and one critic dimension across `copywriting` and `short-form-brief`. Sourced from external practitioner content (Paolo Scales viral-LinkedIn breakdown + Roman Khaves UGC playbook). Audited and committed under the "default SKIP / only signal" bar codified in agent-skills CLAUDE.md.

### Added
- `copywriting/references/emotional-triggers.md` — 6-lever framework (identity validation / status signaling / tribal belonging / productive discomfort / curiosity gap / aspiration+believability) with worked examples per lever, stack rules, authenticity filter, and anti-patterns. Loaded by `hook-agent` (TOF/lead-magnet hooks), `psychology-agent` (Layer 2 emotion pass), and `critic-agent` (trigger-density gate).
- `copywriting/references/belief-disruption.md` — TOF ragebait 5-step structure (state common belief → create doubt → introduce alternative frame → show implication → optional path forward) for problem-unaware audiences. 3 worked examples with step-by-step decomposition. Pairing rules with the 6-trigger stack.
- `copywriting/references/lead-magnet-stack.md` — 5-element lead-magnet post (curiosity hook → identity validation → tribal belonging → investment signaling → aspiration+CTA) and 4-layer FOMO sequence (social proof → transformation → exclusivity → urgency) for high-friction CTAs. Worked full-post example. Stack-when matrix.

### Changed
- `copywriting/agents/critic-agent.md` — added **emotional-trigger density** dimension. 0-2 triggers = WEAK (FAIL — fold in another lever), 3-4 = STRONG (target zone), 5-6 = GURU-ENERGY RISK (FAIL — cut to 3-4). Applies to TOF / lead-magnet / persuasion-heavy copy only; N/A for tactical product / nav / label copy. Score on craft, not trigger-count alone — V/F/U upstream gate must pass first. Routing for trigger-density and authenticity-filter failures added to the Rewrite Routing table. Quality Gate Checklist + Self-Check items added.
- `copywriting/SKILL.md` — Layer 1 dispatch matrix now lists the 3 new ref files against `hook-agent` / `cta-agent` / `social-proof-agent`. Layer 2 dispatch matrix now lists `emotional-triggers.md` + `belief-disruption.md` against `psychology-agent` and `emotional-triggers.md` against `critic-agent`. Shared References section enumerates the 3 new docs with which agents consume each.
- `short-form-brief/agents/critic-agent.md` — added **format-fit test** to Brand-Fit Critic (Roman Khaves' 2-failure-modes: viral-but-no-convert vs converts-but-no-views). Critic now answers "is the product the punchline of the format, or pasted on top?" with quoted shot-or-beat evidence. Routing table gains `format-fit pasted-on` → `hook-agent + storyboard-agent` (re-architect product reveal as payoff) and `format-fit heavy-integration` → `format-agent + storyboard-agent` (loosen integration). Self-check item added.

### Notes
- Driven by Reference Enrichment Backlog REB-2 in `.agents/skill-artifacts/meta/roadmap.md`. REB-2c (`short-form-research/pattern-extractor` synthesis heuristic) ships in the matching `research-skills` patch (3.0.1) — separate stack, separate plugin manifest.
- Bump kind: PATCH. Additive content + one critic dimension that strengthens existing rubric (no contract changes for downstream consumers, no behavioral change to skill outputs that already passed v4.0.1's gates).

---

## [4.0.1] - 2026-05-09

Fresh-eyes review of v4.0.0 caught real gaps. Patch closes them before any user-facing announcement.

### Fixed
- **plugin.json `skills` array was missing `social-copy`** — installed copies of marketing-skills@4.0.0 wouldn't have surfaced the new skill at all (skill files on disk but not in the plugin manifest). Added `./skills/social-copy/` to the array. **This is the load-bearing fix in this patch.**
- `orchestrate-marketing/SKILL.md` body H1 still said `# Start Marketing` — T41 rename missed the body title. Fixed to `# Orchestrate Marketing`.
- `orchestrate-marketing/references/workflow-graph.md` did not list `social-copy` — the orchestrator could not route users to the new skill. Added social-copy to the pipeline diagram, per-skill catalog, and routing rules (h. social-post → social-copy with soft-gate on short-form-brief OR brand). Also corrected stale `.agents/mkt/...` paths under short-form-brief to the post-T33 `.agents/skill-artifacts/` taxonomy.
- Phase 0.5b CHANGELOG claim in v4.0.0 said TikTok Findings 1-4 were closed; actually only Finding 1 was. Findings 2 (Billie Eilish stitch), 3 (@mckenzibrooke × Prime Video brand stitch), 4 (Codie Sanchez laundromat) now relabeled `[pattern-observed; URL not pinned]` matching the inventory's proposed fix shape. No fabricated URLs.
- Phase 0.5b §8 changelog audit-trail rows were missing in `tiktok.md`, `reels.md`, `x.md` (only `shorts.md` had a 2026-05-08 row). Added matching entries describing which findings each file closed.
- `social-copy/SKILL.md` did not state the spec-locked default "single-market per artifact (matches short-form-brief)". Added the constraint inline alongside the polish-chain section.
- `marketing-skills/CLAUDE.md` skill counts ("11 skills") and "Skills using this pattern" enumeration not updated for social-copy. Counts now read 12; social-copy added with its 3-agent dispatch description; "Recent Changes" entry added for the 2026-05-08 wave.
- plugin.json description updated: "11 skills" → "12 skills" + named social-copy in the description blurb. Added `social-copy` keyword.

### Notes
- The fresh-eyes report driving this patch is at `.agents/skill-artifacts/meta/records/2026-05-09-fresh-eyes-marketplace-2.0.0.md` (local-only).
- v4.0.0 was pushed remotely before these gaps surfaced. Anyone who ran `/plugin install marketing-skills@4.0.0` would not have received `social-copy` in the install. v4.0.1 corrects this.

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
