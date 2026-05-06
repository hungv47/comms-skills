# Marketing Skills — Changelog

Format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/). Versioning is [SemVer](https://semver.org/spec/v2.0.0.html) — major.minor.patch.

This file tracks stack-level releases. SKILL.md files describe current behavior; this file documents what changed and when.

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
