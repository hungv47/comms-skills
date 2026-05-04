# Marketing Skills — Changelog

Per-skill release notes and breaking changes. SKILL.md files describe current
behavior; this file documents what changed and when.

---

## brand-system

### v6 — Breaking change

Output moved from `.agents/design/brand-system.md` → `brand/BRAND.md` + `brand/DESIGN.md`.

**Downstream consumers to update:**
- `product-skills/skills/user-flow` — consumes `design/brand-system.md` → update to `brand/DESIGN.md`
- `product-skills/skills/docs-writing` — consumes `.agents/design/brand-system.md` → update to `brand/BRAND.md` (voice/terminology) and `brand/DESIGN.md` (tokens)
- Root `README.md` artifact table → update path

**Duration scale change:** Timings shifted from (100, 200, 300, 500)ms to (75, 150, 250, 400, 600)ms with a new `--duration-emphasis` tier. Brands built on v5 will have different motion timing.

**Quick Brand (Route A)** produces `brand/BRAND.md` only. DESIGN.md and ASSETS.md require the full Route B pipeline.

### v6.1 — ASSETS.md addition

Route B now produces a third artifact: `brand/ASSETS.md`. A production inventory projected deterministically from BRAND.md brand mark + DESIGN.md specs + declared platforms. Every row is a checkbox with a spec reference and a target file path under `brand/`. **Always-on auto-scan**: every brand-system run (fresh or re-run) walks the `brand/` tree and flips `[ ]` → `[x]` for any row whose target file exists. Human-set `[~]` (in progress) and `[!]` (blocked) markers are preserved across runs. No new agent; implemented as an orchestrator post-merge step (Step 8.5).

### v6.2 — Additions

- **voice-agent: Lexicon Rules block** — machine-readable `forbidden_vocabulary`, `preferred_phrases`, `casing`, and `emoji_policy`. Lints downstream copywriting / cold-outreach output.
- **visual-agent: Font Loading & Licensing table** — every font has source, license, free/paid status, and `<link>`/`@font-face` block. Fonts with unclear licenses are flagged `[NEEDS LICENSING]`.
- **visual-agent: Iconography source library + substitution + forbidden icons** — name the source library (Lucide / Tabler / etc.) with CDN/npm link, the fallback library when a glyph is missing, and a YAML list of forbidden glyphs (e.g., never 🔥).
- **AI-slop self-check** — visual-agent and component-token-agent now self-check against `references/ai-slop-detection.md` before returning, instead of leaving every catch to the critic.
- **Step 9 broadened to "Visual Renderings (optional)"** — Paper MCP (existing) + Claude Design (claude.ai/design handoff) + None. Spec stays canonical; rendering is derivative.
- **Anti-pattern: don't round-trip Claude Design exports into `brand/`** — exports are presentation artifacts, not source of truth.
- **Tightened example-design.md disclaimer** — added a paper/solid anti-glass excerpt for Surface & Material to prevent over-anchoring on glassmorphism.
- **OKLCH/hex round-trip fix** — `oklch(0.65 0.15 180) / #2cbaa0` → `oklch(0.7 0.11 180) / #3eb8a4` in the worked example and visual-agent example.
