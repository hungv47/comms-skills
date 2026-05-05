---
name: brand-system
description: "Builds brand identity systems as three artifacts — BRAND.md (story, voice, positioning, archetype), DESIGN.md (AI-readable design system with palettes, tokens, components, motion), and ASSETS.md (per-platform production inventory with auto-scanned checkboxes for what's done vs. still needed). Not for writing marketing copy (use copywriting) or mapping user flows (use user-flow). For campaign planning, see campaign-plan. For audience research, see icp-research."
argument-hint: "[product or brand to design]"
allowed-tools: Read Grep Glob Bash WebSearch WebFetch mcp__paper__* mcp__pencil__*
license: MIT
metadata:
  author: hungv47
  version: "6.2.0"
  budget: deep
  estimated-cost: "$2-5"
promptSignals:
  phrases:
    - "brand identity"
    - "brand voice"
    - "design system"
    - "brand guidelines"
    - "visual identity"
    - "brand book"
  allOf:
    - [brand, identity]
    - [design, system]
  anyOf:
    - "typography"
    - "color system"
    - "design tokens"
    - "brand voice"
    - "brand identity"
    - "visual system"
    - "design language"
  noneOf:
    - "landing page audit"
    - "conversion rate"
    - "asset brief"
    - "single asset"
  minScore: 6
routing:
  intent-tags:
    - brand-identity
    - design-tokens
    - visual-system
    - color-system
    - typography-system
    - brand-voice
  position: pipeline
  produces:
    - brand/BRAND.md
    - brand/DESIGN.md  # Route B (full) only. Quick Brand (Route A) produces BRAND.md only.
    - brand/ASSETS.md  # Route B only. Production inventory projected from BRAND.md + DESIGN.md + declared platforms.
  consumes:
    - product-context.md
  requires: []
  defers-to:
    - skill: user-flow
      when: "need screen mapping, not brand identity"
    - skill: copywriting
      when: "need copy craft, not brand voice definition"
  parallel-with:
    - campaign-plan
  interactive: false
  estimated-complexity: heavy
---

# Brand Identity & Design System — Orchestrator

*Design — Step 1 of 2. Coordinates specialized agents to transform product artifacts into a complete brand narrative and AI-readable design system.*

**Core Question:** "Does every visual decision trace back to who we are?"

## Critical Gates — Read First

- **No colors/fonts before strategy.** Visual-agent runs parallel with strategy-agent; orchestrator verifies coherence in merge. Unjustified visual choices get flagged by critic.
- **No Layer 2 before Layer 1 completes.** Token-architect needs visual-agent output; component-token needs token-architect output. Chain is strict.
- **Don't skip critic's cross-element coherence check.** Radius↔archetype, type↔personality, color↔emotion — the critic checks the matrix no individual agent can see.
- **Stale upstream data (>30 days) → generic archetypes.** Recommend re-running `icp-research` if artifact dates are old.
- **BRAND.md is prose, DESIGN.md is specification.** BRAND.md = brand book (narrative, story, voice). DESIGN.md = API reference (tables, formulas, exact values). Never mix registers.

## Inputs Required
- Product description or PRD (what the product does, who it serves)
- Target audience profile (demographics, psychographics, context of use)
- Competitive context (who else serves this audience, how they're positioned)

## Output — Three Files (Route B) / One File (Route A)

Up to three complementary files, each serving a different audience:

### `BRAND.md` — Brand Narrative & Voice
**Audience:** founders, marketers, copywriters, designers. **Register:** prose — reads like a brand book. **Contains:** origin story, naming, purpose/mission/vision, values, positioning, archetype, personality traits, emotional journey, voice chart, tone spectrum, messaging architecture, brand mark, product-specific sections, digital touchpoints.

### `DESIGN.md` — AI-Readable Design System
**Audience:** AI coding agents, frontend engineers, design system consumers. **Register:** specification — tables, formulas, exact values; an AI reading this alone should produce on-brand UI. **Contains:** visual atmosphere, per-theme color palettes, typography rules, component stylings, layout principles, shadows & elevation, iconography, imagery direction, motion & animation, accessibility, do's and don'ts.

### `ASSETS.md` — Production Inventory (Route B only)
**Audience:** designers, art directors, asset producers, PMs tracking what to ship. **Register:** checklist — every row is a GFM checkbox with spec ref and target path under `brand/`. **Contains:** Universal assets (logo, fonts, tokens) + social & sharing + favicon/web metadata + imagery/illustration + one per-declared-platform block. Auto-scanned each run (`[x]` if target exists, `[ ]` if not). Human-owned `[~]` (in-progress) and `[!]` (blocked) markers preserved across runs. Deterministically projected from BRAND.md + DESIGN.md + declared platforms — no new research, only production tracking.

**Output location:** `brand/BRAND.md`, `brand/DESIGN.md`, `brand/ASSETS.md`. Optional visual renderings via Paper MCP artboards (`brand/artboards/`) or a Claude Design handoff — see Step 9.

### Agent-to-File Routing

| Agent Output | → BRAND.md | → DESIGN.md | → ASSETS.md |
|-------------|-----------|------------|------------|
| Strategy Agent | Origin story, naming, purpose/mission/vision, values, positioning, competitive landscape, product-specific sections, digital touchpoints (universal + per-declared-platform surfaces) | — | — |
| Personality Agent | Archetype, personality traits, emotional journey map | — | — |
| Voice Agent | Voice attributes (Do/Don't), tone range (3 contexts), tagline | — | — |
| Visual Agent | Brand mark / logo system | Visual atmosphere, color system, per-theme palettes, typography, imagery, iconography (including **per-declared-platform icon specs**: sizes, safe zones, state variants), surface & material language, shadow system, z-index, do's and don'ts | — |
| Token Architect Agent | — | Primitive scales, semantic token map, spacing, radius | — |
| Component Token Agent | — | Component specs, product-specific components, motion tokens, named animations | — |
| Accessibility Agent | — | Contrast audit, touch targets, focus states, dark mode, color independence, motion safety | — |
| Orchestrator (Step 8.5) | — | — | Projects brand mark + DESIGN.md Platform Icon Specs + declared platforms into a checkable inventory. Deterministic — no new agent. |

## Quality Gate
Before delivery, the **critic agent** verifies both files:

**BRAND.md checks:**
- [ ] Origin story and naming have cultural/etymological depth (not just "we named it X")
- [ ] Values have real tradeoffs (not generic "innovation, quality, integrity")
- [ ] Voice attributes have Do/Don't examples from real brand contexts
- [ ] Tone range covers 3 key contexts with clear shift across the range
- [ ] Tagline scored V/F/U (min 6/9), passes competitor swap test
- [ ] **Lexicon Rules block present:** `forbidden_vocabulary` (5-15 `term`+`reason` pairs), `preferred_phrases` (5-12 brand-native strings), `casing`, `emoji_policy` — all concrete, not "TBD". Reasons live in YAML keys, not comments.
- [ ] No copywriting scope creep (no boilerplate, pillars, elevator pitch, tagline variants)
- [ ] Emotional journey is touchpoint-level with design/interaction triggers (not copy triggers)
- [ ] Brand mark described in commission/generation-ready detail
- [ ] Digital touchpoints scoped to visual expression (not verbal)
- [ ] **Route B platform coverage:** Universal Surfaces table filled + one Digital Touchpoints subsection per declared platform; every surface entry concrete (no blanks/TBDs). Zero undeclared platforms.
- [ ] **Route A platform coverage:** Digital Touchpoints contains only the `Platforms declared at intake` line + deferral note. Per-platform tables ABSENT.
- [ ] **Register separation:** Digital Touchpoints rows describe brand expression (mood, motion cue, color role, density) — never geometry. Geometry lives in DESIGN.md Platform Icon Specifications.
- [ ] Prose quality: reads like a brand book, not fill-in-the-blank templates

**DESIGN.md checks:**
- [ ] AI-readable header summarizes key decisions (archetype, metaphor, fonts, primary color)
- [ ] **Font Loading & Licensing table:** every font has source, license, status, load method. Unclear licenses flagged `[NEEDS LICENSING]`
- [ ] **Iconography source library named** (with CDN/npm link), **fallback library named**, **Forbidden Icons YAML emitted** (3-8 entries with reasons, or empty list with explanation)
- [ ] Complete color palette tables per theme (not just primary + neutrals)
- [ ] All semantic tokens have values for every theme
- [ ] Every token pair meets WCAG AA (4.5:1 normal text, 3:1 large/UI)
- [ ] Bg/fg convention used consistently (`bg-primary text-primary-foreground`)
- [ ] One global `--radius` — archetype-justified
- [ ] Surface/material language documented with CSS formulas
- [ ] Shadow system with multiple elevation levels
- [ ] Named animations with physics values (spring stiffness, damping, mass)
- [ ] **Platform Icon Specifications:** one subsection per declared platform with sizes, safe-area rules, state variants (dark/tinted/themed/monochrome as applicable), derivative size list. Zero undeclared platforms.
- [ ] Do's and Don'ts section with concrete rules

**ASSETS.md checks (Route B only):**
- [ ] One section per declared platform; zero undeclared platforms
- [ ] Every row has spec ref (BRAND.md / DESIGN.md / platform-surfaces.md) and **fully-substituted** target path under `brand/` (no unfilled `{host}`/`{count}`/`{token}` placeholders)
- [ ] No invented assets — every row traces to upstream spec
- [ ] No duplicated spec (sizes, safe zones) — ASSETS.md cites, doesn't re-define
- [ ] Legend present; Summary counts present; `## Orphaned` handled (present if platforms dropped, absent otherwise)
- [ ] Prior `[~]` and `[!]` markers preserved from previous run (verify by diff if re-run)

**Cross-file coherence:**
- [ ] Cross-element coherence: radius↔archetype, type personality↔archetype, color emotion↔brand personality, imagery direction↔archetype's visual world
- [ ] Voice tone (BRAND.md) matches visual atmosphere (DESIGN.md)
- [ ] ASSETS.md platform blocks === BRAND.md Digital Touchpoints platforms === DESIGN.md Platform Icon Specifications platforms (same set, same order)
- [ ] AI slop check via `references/ai-slop-detection.md` — 0-1 clean, 2-3 review, 4+ regenerate

**Reference quality bar:** Compare against `references/example-brand.md` and `references/example-design.md`. Match "good" patterns, avoid "bad" patterns. Use example-design.md tests (copy-paste, blind build, competitor swap, implementation gap) as final validation.

## Chain Position
Previous: `icp-research` (product context) | Next: `campaign-plan`, `copywriting`, `lp-brief`, `design-brief`

**Re-run triggers:** Major product pivots, new markets, audience shifts, or annual brand refresh.

**Related (non-chain):** `icp-research` (audience data), `copywriting` (consumes voice guidelines), `humanize` (uses voice adjectives), `design-brief` (consumes DESIGN.md)

### Skill Deference
- **Need audience research first?** Run `icp-research` — brand without audience research → generic archetypes.
- **Need user flows after brand?** Run `user-flow` — consumes design tokens and component context.
- **Need marketing copy?** Run `copywriting` — consumes voice guidelines.

---

## Agent Manifest

| Agent | Layer | File | Routes to | Focus |
|-------|-------|------|-----------|-------|
| Strategy Agent | 1 (parallel) | `agents/strategy-agent.md` | BRAND.md | Purpose, mission, vision, values, positioning, competitive landscape, **brand narrative (origin/naming), product-specific sections, digital touchpoints** |
| Personality Agent | 1 (parallel) | `agents/personality-agent.md` | BRAND.md | Jungian archetype (70/30 blend), personality traits, **touchpoint-level emotional journey** |
| Voice Agent | 1 (parallel) | `agents/voice-agent.md` | BRAND.md | Voice attributes (Do/Don't), tone range (3 key contexts), primary tagline with V/F/U score |
| Visual Agent | 1 (parallel) | `agents/visual-agent.md` | Both | Logo → BRAND.md. **Visual atmosphere, color system, per-theme palettes, typography, imagery, surface & material language, shadow system, z-index, do's and don'ts** → DESIGN.md |
| Token Architect Agent | 2 (sequential) | `agents/token-architect-agent.md` | DESIGN.md | 3-layer W3C token system, semantic map, radius-to-archetype, **per-theme token tables** |
| Component Token Agent | 2 (sequential) | `agents/component-token-agent.md` | DESIGN.md | Button 6 variants, input specs, card specs, **product-specific components, named animations with physics values**, motion tokens |
| Accessibility Agent | 2 (sequential) | `agents/accessibility-agent.md` | DESIGN.md | WCAG AA contrast, touch targets, dark mode audit, focus states |
| Critic Agent | 2 (final) | `agents/critic-agent.md` | Both | Cross-element coherence, **BRAND.md narrative quality, DESIGN.md AI-readability**, PASS/FAIL |

### Quality-Bar Reference Examples
- `references/example-brand.md` — Annotated quality guide: good vs bad excerpts for every BRAND.md section
- `references/example-design.md` — Annotated quality guide: good vs bad excerpts for every DESIGN.md section

---

## Routing Logic

### Mode Selection

Ask: *"Full brand system or quick brand for MVP?"*

### Route A: Quick Brand (MVP)
**When:** MVP, early-stage, need to ship fast with basic brand foundations.

```
1. Pre-dispatch: Gather context (Step 0)
2. LAYER 1 — Dispatch IN PARALLEL:
   - strategy-agent (purpose, values, positioning)
   - visual-agent (color + typography only — logo deferred)
3. Dispatch: critic-agent (coherence check — strategy-to-visual only)
4. If FAIL → re-dispatch named agent(s) with feedback (max 2 cycles)
5. Deliver Quick Brand artifact
```

**Quick Brand scope:** Purpose/mission/vision, core values, positioning, primary color + neutrals, display + body font, basic type hierarchy. **Target platforms still captured at intake** and recorded in BRAND.md as one line ("Ships on: iOS, macOS, Web") so Route B picks them up later. Defers: archetype analysis, voice/tone system, messaging architecture, full visual identity, token architecture, component tokens, accessibility audit, dark mode, Visual Renderings (Step 9), per-platform Digital Touchpoints surfaces and icon specs.

**Output includes note:** "Run full brand-system when ready to build the design system."

### Route B: Full Brand System
**When:** Established product, full rebrand, comprehensive guidelines needed.

```
Step 0    Pre-dispatch: Gather context
Step 1    LAYER 1 — Dispatch IN PARALLEL:
          - strategy-agent
          - personality-agent
          - voice-agent
          - visual-agent
Step 2    MERGE: Assemble Layer 1 outputs into brand identity sections
Step 3    LAYER 2 — Dispatch SEQUENTIALLY:
          - token-architect-agent (receives visual-agent + personality-agent output)
          - component-token-agent (receives token-architect-agent output)
          - accessibility-agent (receives token-architect + component-token outputs)
Step 4    Dispatch: critic-agent (receives BRAND.md + DESIGN.md)
Step 5    If FAIL → re-dispatch named agent(s) with feedback (max 2 cycles)
Step 8.5  ASSETS.md projection — deterministic, no new agent, always-on auto-scan
Step 9    Visual Renderings (optional) — Paper MCP / Claude Design / none
Step 10   Deliver artifacts (BRAND.md + DESIGN.md + ASSETS.md)
```

*Why 5 → 8.5:* `8.5` is a **section header**, not a sequence index — chosen so ASSETS.md projection slots after the critic gate but before pre-existing Step 9 (Visual Renderings) without renumbering downstream refs. Steps 6/7/8 are intentionally absent (legacy flow used unnumbered "Critic Gate", "re-dispatch", "deliver" labels). Reading order: 0 → 1 → 2 → 3 → 4 → 5 → 8.5 → 9 → 10.

---

## Step 0: Pre-Dispatch Context Gathering

### Product Context Check
Check for `research/product-context.md` and `research/icp-research.md`. If `date` fields are older than 30 days, **warn the user** and recommend re-running upstream skills.

### Required Inputs — Interview If Missing
- Product description or PRD
- Target audience profile
- Competitive context
- **Target platforms** — which surfaces the brand ships on. Multi-select; ask explicitly, don't assume "a web app." Canonical set:
  - **Web** (marketing site, in-product web UI, PWA)
  - **iOS / iPadOS**
  - **Android**
  - **macOS** (native AppKit/SwiftUI, or cross-platform shell like Electron/Tauri — ask which)
  - **Windows** (native WinUI/Win32, or cross-platform shell)
  - **Linux desktop** (GTK/Qt, or shell)
  - **watchOS** / **Wear OS**
  - **tvOS**
  - **CarPlay / Android Auto**
  - **Browser extension** (Chrome / Firefox / Safari / Edge — ask which)
  - **CLI / terminal**
  - **Email** (first-class brand channel — transactional + newsletter)
  - **Embedded app** (Slack / Notion / Discord / Teams / Linear / GitHub — ask which host)

  **Disambiguate vagueness:** "mobile app" → iOS, Android, or both? "desktop app" → native or Electron? "web app" → marketing site + product, or one? If user names a cross-platform shell (Electron, Tauri, Flutter, RN, Capacitor), still enumerate host OSes — each gets its own surface set.

### Strongly Recommended
- Existing brand assets (logos, colors, fonts, past guidelines)
- Founder/team values and origin story
- Key differentiators

### Helpful
- Admired brands (aspirational and anti-aspirational)
- Market positioning intent (premium, accessible, disruptive, trusted)

### Optional Artifacts
| Artifact | Source | Benefit |
|----------|--------|---------|
| `research/product-context.md` | icp-research (from `hungv47/research-skills`) | Product positioning, audience, and voice adjectives — grounds brand strategy in audience research |
| `research/icp-research.md` | icp-research (from `hungv47/research-skills`) | Audience personas, pain profiles, and VoC quotes — brand strategy without audience research produces generic archetypes |

**Strongly recommended:** Run `icp-research` (from research-skills) first if audience research hasn't been done.

### Context to Pass to All Agents
1. **Product:** description, audience, competitive landscape
2. **Existing assets:** logos, colors, fonts, guidelines to preserve or evolve
3. **Positioning intent:** premium, accessible, disruptive, trusted
4. **Upstream artifacts:** excerpts from product-context.md and icp-research.md if available
5. **Target platforms:** declared platform list from intake. **Strategy-agent renders a Digital Touchpoints subsection per declared platform; visual-agent renders per-platform icon specs. Undeclared platforms MUST NOT appear.** If user declared "iOS + web" only, do not pad with Android/Windows sections.

Missing product details are not guessable — interview for them.

---

## Dispatch Protocol

### How to spawn a sub-agent

1. **Read** the agent instruction file — include FULL content in the Agent prompt
2. **Append** context (product, audience, competitive landscape, existing assets) after instructions
3. **Resolve file paths to absolute** — rooted at this skill's directory
4. **Pass upstream artifacts by content** — orchestrator reads `.agents/` files FIRST, includes excerpts in context. Sub-agents do NOT read artifact files directly.
5. If **feedback** exists (from critic FAIL), append with header "## Critic Feedback — Address Every Point"

### Conventions

- **Source citation:** Cite sources for brand psychology, color theory, archetype effectiveness facts. Web search → include URL. Unattributable → flag `[UNVERIFIED]`.
- **Context loaded:** Include which upstream artifacts were read (with versions/dates) in the artifact body. Creates audit trail for downstream skills.

### Single-agent fallback

If multi-agent dispatch is unavailable, execute each agent's instructions sequentially in-context:
- Layer 1: define strategy, select archetype, write voice chart, design visual identity
- Layer 2: build token architecture, map component tokens, audit accessibility
- Final: evaluate with critic rubric, check cross-element coherence

---

## Layer 1: Parallel Foundation

Spawn **IN PARALLEL**:

| Agent | Instruction File | Pass These Inputs | Reference Files |
|-------|-----------------|-------------------|-----------------|
| Strategy Agent | `agents/strategy-agent.md` | brief (product + audience + competitors + declared platforms) | `references/platform-surfaces.md` (Route B only) |
| Personality Agent | `agents/personality-agent.md` | brief (product + audience) | `references/brand-archetypes.md` |
| Voice Agent | `agents/voice-agent.md` | brief (product + audience) | `references/brand-voice.md` |
| Visual Agent | `agents/visual-agent.md` | brief (product + audience + existing assets + declared platforms) | `references/color-emotion.md`, `references/typography-psychology.md`, `references/visual-identity.md`, `references/platform-surfaces.md` |

Wait for all to complete. Their outputs feed the merge step and Layer 2.

---

## Merge Step — Brand File Assembly (BRAND.md + DESIGN.md)

Before assembling, read `references/artifact-templates.md` for the complete section structure, field specifications, and ordering for both files. **ASSETS.md is assembled separately in Step 8.5 after the critic gate passes — it does not merge in this step.**

After Layer 1 completes, assemble outputs into **two separate files** simultaneously:

### BRAND.md Assembly (from Layer 1)

| Section | Owner Agent | Notes |
|---------|-----------|-------|
| The Origin Story | Strategy Agent | Narrative prose, not bullet points |
| The Name | Strategy Agent | Etymology, meaning, cultural context |
| Purpose, Mission & Vision | Strategy Agent | — |
| Core Values | Strategy Agent | "X over Y" format with real tradeoffs |
| Brand Positioning | Strategy Agent | Positioning statement, value prop, what we are/aren't |
| Brand Archetype | Personality Agent | 70/30 blend with "in action" section |
| Personality Traits | Personality Agent | "Trait, but not extreme" table |
| Emotional Journey Map | Personality Agent | Touchpoint-by-touchpoint, not before/during/after |
| Brand Voice DNA | Voice Agent | Voice attributes (Do/Don't) + tone range (3 contexts) + tagline |
| The Brand Mark | Visual Agent (logo section) | Visual description, variations, color combos, rules |
| [Product-Specific Sections] | Strategy Agent | Differentiators, pricing as brand, parent brand relationship |
| Digital Touchpoints | Strategy Agent | How brand expresses at each surface |

### DESIGN.md Assembly (starts from Layer 1, completed by Layer 2)

| Section | Owner Agent | Notes |
|---------|-----------|-------|
| AI-Readable Header | Orchestrator synthesis | Archetype, visual metaphor, fonts, primary color |
| 1. Visual Theme & Atmosphere | Visual Agent | Mood, density, metaphor — prose introduction |
| 2. Color Palette & Roles | Visual Agent + Token Architect | Primary colors, semantic, per-theme palettes, neutrals, distribution rules |
| 3. Typography Rules | Visual Agent | Font stack, type scale, typography rules |
| 4. Component Stylings | Component Token Agent | Product-specific core components + standard components |
| 5. Layout Principles | Token Architect Agent | Spacing scale, border radius |
| 6. Shadows & Elevation | Visual Agent + Component Token | Shadow scale, z-index scale |
| 7. Iconography | Visual Agent | System icons, product-specific icons, **Platform Icon Specifications** (per declared platform) |
| 8. Imagery & Visual Direction | Visual Agent | Photography, brand devices |
| 9. Motion & Animation | Component Token Agent | Principles, duration scale, easing, named animations, motion safety |
| 10. Accessibility | Accessibility Agent | Contrast, focus, touch targets, color independence |
| 11. Do's and Don'ts | Visual Agent | Concrete rules synthesized from all decisions |

**Coherence check before Layer 2:** Verify that the archetype selected by personality-agent aligns with the visual choices made by visual-agent. If they contradict (e.g., Caregiver archetype with sharp/aggressive typography), resolve before dispatching Layer 2.

---

## Layer 2: Sequential Chain

Dispatch **ONE AT A TIME, IN ORDER**:

| Step | Agent | Instruction File | Receives |
|------|-------|-----------------|----------|
| 1 | Token Architect Agent | `agents/token-architect-agent.md` | Visual-agent output (colors, fonts, **complete theme palettes**) + personality-agent output (archetype for radius) |
| 2 | Component Token Agent | `agents/component-token-agent.md` | Token-architect-agent output (semantic token map) |
| 3 | Accessibility Agent | `agents/accessibility-agent.md` | Token-architect + component-token outputs |
| 4 | Critic Agent | `agents/critic-agent.md` | Complete assembled brand system (both BRAND.md and DESIGN.md) |

**Palette ownership rule:** Visual-agent is authoritative for color choices and theme palette values. Token-architect systematizes them into the three-layer architecture (primitive → semantic → component) and adds missing infrastructure tokens (`--popover`, `--popover-foreground`). On conflict, visual-agent wins.

**Accessibility hand-back:** Accessibility-agent runs after shadow tokens are set. If its audit demands changes to upstream values (shadow color failing contrast against its surface, primary lightness failing 3:1 against `--primary-foreground`), it does NOT edit the upstream table directly. It reports the failing pair to the critic, which fails the gate and re-dispatches the upstream owner — visual-agent (shadows/colors), token-architect (semantic values), or component-token (component-level overrides). Accessibility-agent owns the audit, not the fix.

---

## Critic Gate

- **PASS:** Proceed to ASSETS.md projection (Step 8.5), then optional Visual Renderings (Step 9 — Paper MCP / Claude Design / none).
- **FAIL:** Re-dispatch named agent(s) with critic feedback. Max 2 rewrite cycles. After 2 failures, deliver with critic annotations and flag to user.

---

## Step 8.5: ASSETS.md Projection (Route B only, always-on)

**No sub-agent.** Deterministic orchestrator step, after critic passes, before Step 9.

Read `references/assets-inventory.md` for full emission rules, per-platform templates, and file template. Procedure summary:

1. **Load prior state:** Read existing `brand/ASSETS.md`. Preserve `[~]` (in progress) and `[!]` (blocked) rows verbatim. Note platforms present in old file but no longer declared — those rows go to `## Orphaned` on emit.
2. **Project fresh inventory:** Using BRAND.md brand mark section, DESIGN.md §2/§3/§7/§8/§9, and declared-platforms list, emit rows in order: Universal → Social & Sharing → Favicon & Web Metadata (if Web declared) → Imagery & Illustration (if DESIGN.md §8 declares direction) → one per-platform block in declared order. Every row: name, spec ref, target path, status. **Expand every `{placeholder}` first:** for each declared embedded host emit one full row set with `{host}` substituted; for imagery rows substitute `{count}` from DESIGN.md §8. No row reaches substep 3 with an unfilled placeholder.
3. **Auto-scan for `[x]`:** File-typed rows — `Bash: test -e <path>` → `[x]`/`[ ]`. Directory-typed rows (path ends `/`) require at least one non-`.gitkeep` file: ``test -d <path> && [ -n "$(ls -A <path> 2>/dev/null | grep -v '^\.gitkeep$')" ]`` → `[x]`/`[ ]`. Prevents scaffolded-empty-directory false-completion.
4. **Merge human markers:** Overlay preserved `[~]`/`[!]` rows (matched by name) onto fresh inventory. Human markers override auto-computed status.
5. **Compute summary:** Total / Done / In progress / Blocked / Not started counts.
6. **Write `brand/ASSETS.md`** with frontmatter (declared platforms, last scan ISO timestamp, BRAND.md/DESIGN.md versions), legend, sections, summary, and `## Orphaned` block if any.
7. **Re-run versioning:** ASSETS.md is a **living file** — always updated in place. Dropped-platform rows move to `## Orphaned` (NOT removed), preserving tracking state. Only version (`ASSETS.v[N].md`) when the user **explicitly** requests a fresh inventory (e.g., after major product pivot). The Orphaned block, not versioning, is the primary handler for "platform dropped between runs."

**Quality gate (orchestrator self-check before write):**
- Every row has spec ref and target path.
- ASSETS.md platform block set === declared platforms === BRAND.md Digital Touchpoints === DESIGN.md Platform Icon Specifications.
- No human-set `[~]`/`[!]` markers overwritten.
- No invented rows (every row traces to `references/assets-inventory.md` templates).

**Scope:** Route B only. Route A captures platform list but emits no inventory until the full pipeline runs.

---

## Step 9: Visual Renderings (optional)

The spec — BRAND.md / DESIGN.md / ASSETS.md — is canonical. Renderings are **derivative presentations**, not source of truth. Three optional paths:

### 9a. Paper MCP — programmatic artboards
If Paper MCP is available, render 5 presentation artboards. See `references/artboard-generation.md` for specs, workflow, prerequisites.

After generating, run AI slop detection (`references/ai-slop-detection.md`) — artboards are highest-risk for AI default patterns.

Artboards: Color Palette | Typography System | Spacing & Tokens | UI Style Principles | Logo System. Save to `brand/artboards/`.

### 9b. Claude Design — interactive prototypes (claude.ai/design)
Claude Design is an Anthropic Labs UI product at `claude.ai/design` (Pro/Max/Team/Enterprise tiers). Produces designs, prototypes, slides, one-pagers via text prompts, document/image uploads, and codebase context for design-system grounding.

**This skill does not dispatch to Claude Design** (no API/MCP). It hands off by giving the user precise sharing/scoping instructions.

**Pre-flight checks (all must pass):**
1. `brand/DESIGN.md` exists with complete theme palette tables.
2. `brand/BRAND.md` Brand Mark section is commission-grade.
3. At least one of `brand/logo/logo-full.svg` or a placeholder logo asset exists.
4. `brand/font/` has downloaded woff2s or link comments for each declared font.

If any check fails, say so — don't send the user to Claude Design with an incomplete spec.

**Handoff message (if checks pass):**
> Your brand spec is ready for Claude Design. Open `claude.ai/design` (requires Pro/Max/Team/Enterprise) and start a session by sharing your `brand/` folder — at minimum paste `DESIGN.md` (grounds tokens, theme palettes, component specs) and `BRAND.md` (grounds voice and brand mark). `ASSETS.md` tells Claude Design what already exists vs. still needs making. Outputs (prototypes, slides, one-pagers, HTML/PPTX/Canva exports) are presentation artifacts — keep them outside `brand/`. To update the brand source, re-run brand-system; share the updated spec with Claude Design next session.

### 9c. None
If neither renderer is available/wanted, skip — the spec stands alone. Downstream skills (user-flow, design-brief) consume DESIGN.md directly without rendering.

---

## Artifact Templates

Save to `brand/BRAND.md`, `brand/DESIGN.md`, `brand/ASSETS.md`. Create `brand/` if missing, plus `brand/logo/`, `brand/font/`, `brand/inspiration/`, `brand/social/`, `brand/favicon/`, `brand/tokens/`, `brand/imagery/`, `brand/platforms/` subdirs with `.gitkeep` files.

On re-run: rename existing `BRAND.md`/`DESIGN.md` to `BRAND.v[N].md`/`DESIGN.v[N].md` and create new with incremented version. **`ASSETS.md` is always updated in place** — living inventory. Dropped-platform rows move to `## Orphaned` (preserved, not deleted). Only version ASSETS.md (`ASSETS.v[N].md`) when explicitly requested.

**Full templates:** See [references/artifact-templates.md](references/artifact-templates.md).

**Template summary:**

**BRAND.md** (11 sections): Origin Story → Name → Purpose/Mission/Vision → Core Values ("X over Y") → Brand Positioning → Brand Archetype (Primary 70% + Secondary 30%) → Personality Traits → Emotional Journey Map → Brand Voice DNA (attributes + tone range + tagline with V/F/U) → Brand Mark → Digital Touchpoints.

**DESIGN.md** (11 sections): Visual Theme & Atmosphere → Color Palette & Roles (OKLCH, themes, neutral scale, 60/30/10) → Typography Rules (font stack, type scale) → Component Stylings (core + cards + buttons + inputs) → Layout Principles (spacing, radius) → Shadows & Elevation (z-index) → Iconography → Imagery & Visual Direction → Motion & Animation (duration, easing, spring physics) → Accessibility (contrast, focus, touch targets) → Do's and Don'ts.

**ASSETS.md** (5 fixed + per-platform): Universal → Social & Sharing → Favicon & Web Metadata (if Web declared) → Imagery & Illustration (if DESIGN.md §8 declares direction) → Platforms (one subsection per declared, in order) → Summary → Orphaned (only if platforms dropped). Full template in [references/assets-inventory.md](references/assets-inventory.md).

**Quality-bar examples:** [references/example-brand.md](references/example-brand.md), [references/example-design.md](references/example-design.md).

---

## Worked Example (Condensed) — Route B: Full Brand System

**Input**: FinLit — a personal finance app for young professionals (22-30), positioned against intimidating banking apps.

### Step 0: Pre-Dispatch
Product: personal finance app. Audience: young professionals 22-30. Competitors: traditional banking apps (Mint, bank mobile apps). **Platforms declared:** iOS, Web (marketing site + PWA), Email.

### Layer 1: Parallel Foundation
All 4 agents dispatched in parallel:
- **Strategy agent** returns: Origin story ("born from a founder's shame spiral at 24"), name ("FinLit — financial literacy, shortened to feel casual"), purpose "make finance empowering, not shameful." Positioning: "the only finance app that feels like a supportive friend." Values: transparency over comfort, simplicity over completeness, progress over perfection. Digital touchpoints mapped across 6 surfaces. Product-specific: "Streak System as brand expression" section.
- **Personality agent** returns: Caregiver (70%) + Explorer (30%). Traits: encouraging but not patronizing, clear but not dumbed-down, warm but not saccharine. Emotional journey: 8-touchpoint map (first encounter → app store → onboarding → first budget → daily check → missed goal → annual review → telling a friend).
- **Voice agent** returns: Voice DNA with 3 attributes (straight-talking, encouraging, honest) with real-context Do/Don't examples. Tone range across 3 contexts (marketing: inviting + confident, product UI: minimal + clear, errors: calm + honest). Tagline: "Money, minus the shame." V:3 F:2 U:3 = 8/9.
- **Visual agent** returns: **For BRAND.md:** Logo system (4 variations, color combos, rules). **For DESIGN.md:** Visual atmosphere ("warm kitchen table, not bank lobby"). Primary warm teal `oklch(0.7 0.11 180)` / `#3eb8a4`. Complete light + dark theme palettes (18 tokens each). Neutral base: Stone. Display: Plus Jakarta Sans. Body: Inter. Shadow system (5 levels). Surface material: soft matte (no glass). Imagery: real people, natural light, warm tones. Do's and Don'ts (12 items each).

### Merge — Brand File Assembly (BRAND.md + DESIGN.md)
**BRAND.md assembled** from strategy (origin/name/purpose/values/positioning/touchpoints) + personality (archetype/traits/journey) + voice (voice DNA/tone range/tagline) + visual (logo only).
**DESIGN.md started** from visual (atmosphere/colors/typography/shadows/imagery/do's-don'ts). AI-readable header generated.

Coherence check: Caregiver archetype aligns with warm teal (trust + growth), humanist-leaning typography (approachable), 0.5rem radius (soft). PASS — proceed to Layer 2.

### Layer 2: Sequential Chain
All outputs go to DESIGN.md:
- **Token architect** returns: Stone 50-950 neutral scale, teal 50-950 primary scale, `--radius: 0.5rem`, 19 semantic tokens with light + dark values. Spacing scale.
- **Component token** returns: 6 button variants mapped to semantic tokens, input specs with blur validation, card specs. Product-specific: "Budget Card" component with progress ring. Named animations: `progress-fill` (spring, stiffness 180), `goal-celebrate` (confetti, 600ms). Motion tokens (75-500ms).
- **Accessibility** returns: All token pairs pass 4.5:1. Dark mode surface hierarchy (stone.950 → stone.900 → stone.800). Primary shifts to teal.400 in dark mode. Touch targets ≥44px.
- **Critic** returns: PASS on both files. BRAND.md narrative quality strong, emotional journey touchpoint-level. DESIGN.md AI-readable, all themes complete. Cross-element coherence verified. AI slop score: 1 item (clean).

### Step 8.5: ASSETS.md Projection
Orchestrator projects declared platforms (iOS, Web, Email) against `references/assets-inventory.md` templates. Emits 18 Universal rows + 13 Social & Sharing + 8 Favicon/Web + 8 Imagery + 13 iOS + 7 Web-platform + 7 Email-platform = 74 rows. Auto-scans `brand/` — logo-full.svg exists → `[x]`; all others `[ ]` (fresh run). Writes `brand/ASSETS.md` with legend, sections, summary (Done: 1 / 74), no orphaned block (first run). On re-run, Done count rises as the designer drops files into `brand/` subdirs.

### Deliver
`brand/BRAND.md`, `brand/DESIGN.md`, and `brand/ASSETS.md` saved.

---

## Worked Example (Condensed) — Route A: Quick Brand

**Input**: TaskFlow — a new project management tool, pre-MVP, needs basic brand to start building.

### Step 0: Pre-Dispatch
Product: project management tool. Audience: small team leads. **Platforms declared:** Web, macOS (Electron). Quick Brand selected — platforms captured as one line in BRAND.md; per-platform surfaces and icon specs deferred to Route B.

### Layer 1: Parallel (reduced)
- **Strategy agent** returns: Purpose, values (clarity over complexity, speed over ceremony), positioning. Origin story deferred.
- **Visual agent** returns: Primary blue `oklch(0.623 0.214 259)` / `#3b82f6`. Neutral: Slate. Display: Inter. Body: Inter.

### Critic (reduced)
Checks strategy-to-visual coherence only. PASS.

### Deliver
Quick Brand artifact saved as single `brand/BRAND.md` with note: "Run full brand-system when ready to produce DESIGN.md."

**Quick Brand produces BRAND.md only.** DESIGN.md requires the full Route B pipeline (token architect, component tokens, accessibility audit).

---

## Anti-Patterns

**Aesthetics without strategy** — Picking colors or fonts because they "look nice" without tracing back to archetype and positioning. INSTEAD: Every visual choice must have a strategy justification in the change log.

**Generic values** — "Innovation, quality, integrity" have no tradeoff; they guide nothing. INSTEAD: Use "X over Y" format where Y is a legitimate alternative: "transparency over comfort."

**Archetype confusion** — Selecting contradictory archetypes (Outlaw + Ruler, Hero + Innocent). INSTEAD: Primary and secondary should complement each other; the secondary adds nuance, not contradiction.

**Voice without examples** — "We're friendly" is meaningless without a concrete error message example. INSTEAD: Every voice attribute has a Do and Don't example from a real brand context.

**Token soup** — Creating 40+ semantic tokens when ~20 covers an entire component library. INSTEAD: Keep the semantic layer tight. If you're inventing `--subtle-muted-foreground-alt`, the system is too granular.

**Skipping semantic layer** — Components referencing primitives (`oklch(0.546...)`) instead of semantic tokens (`var(--primary)`). INSTEAD: Always reference semantic tokens. The three-layer chain is Primitive -> Semantic -> Component.

**Mismatched bg/fg pairs** — `bg-primary text-primary` is wrong; use `bg-primary text-primary-foreground`. INSTEAD: Every semantic color role is a pair. Base = background. `-foreground` = text on that surface.

**Dark mode as inversion** — Simply swapping black/white produces unusable surfaces. INSTEAD: Deliberate surface hierarchy (background -> card -> popover), reduced saturation, shifted primary lightness.

**Dispatching all agents for Quick Brand** — Route A exists for MVPs. INSTEAD: Quick Brand uses only strategy + visual + critic. No archetype analysis, no tokens, no components.

**Inventing ASSETS.md rows** — Adding checklist rows for assets not traceable to BRAND.md / DESIGN.md / `platform-surfaces.md`. INSTEAD: every row cites its spec. If you can't point to the spec, the asset doesn't belong in the inventory.

**Overwriting human `[~]` or `[!]` markers in ASSETS.md** — The auto-scan only flips `[ ]` ↔ `[x]` based on file existence. In-progress and blocked markers are human-owned. INSTEAD: preserve them verbatim across re-runs; merge after the fresh projection.

**Silently dropping ASSETS.md rows when a platform is un-declared** — Erases tracking state the user may have been maintaining. INSTEAD: move the dropped-platform rows to `## Orphaned (platform no longer declared)` on emit, so the user can review before losing status.

**Round-tripping Claude Design exports into `brand/`** — Claude Design produces interactive prototypes, slides, one-pagers, and HTML/PPTX/Canva exports. These are **derivative presentation artifacts**, not source of truth. Saving them into `BRAND.md` / `DESIGN.md` / `ASSETS.md` corrupts the spec. INSTEAD: Claude Design exports go to a separate location (e.g., `presentations/`, or a Claude Design folder/Canva account). To update the spec, re-run brand-system; Claude Design will re-render from the updated source on the next visit.

---

## Agent Files

### Sub-Agent Instructions (agents/)
- [agents/strategy-agent.md](agents/strategy-agent.md) — Purpose, mission, vision, values, positioning
- [agents/personality-agent.md](agents/personality-agent.md) — Jungian archetype blend, personality traits, emotional journey
- [agents/voice-agent.md](agents/voice-agent.md) — Voice chart, tone spectrum, messaging architecture
- [agents/visual-agent.md](agents/visual-agent.md) — Logo, color system, typography, imagery
- [agents/token-architect-agent.md](agents/token-architect-agent.md) — 3-layer W3C token system, semantic map
- [agents/component-token-agent.md](agents/component-token-agent.md) — Button variants, input/card specs, motion tokens
- [agents/accessibility-agent.md](agents/accessibility-agent.md) — WCAG AA, dark mode, touch targets, focus states
- [agents/critic-agent.md](agents/critic-agent.md) — Cross-element coherence, PASS/FAIL

### Shared References (references/)
- [references/assets-inventory.md](references/assets-inventory.md) — ASSETS.md per-platform templates, emission rules, auto-scan protocol (orchestrator Step 8.5)
- [references/brand-archetypes.md](references/brand-archetypes.md) — 12 Jungian archetypes with visual and verbal mappings
- [references/brand-voice.md](references/brand-voice.md) — Voice frameworks, tone dimensions, messaging architecture
- [references/visual-identity.md](references/visual-identity.md) — Logo systems, imagery direction, iconography, graphic elements
- [references/token-architecture.md](references/token-architecture.md) — Three-layer token system, semantic token map, neutral presets
- [references/token-templates.md](references/token-templates.md) — Primitive scales, semantic token map, radius-archetype mapping, mapping example
- [references/component-tokens.md](references/component-tokens.md) — Component token map, button/input/card specs, motion tokens
- [references/implementation-rules.md](references/implementation-rules.md) — Accessibility baseline, dark mode rules, brand applications
- [references/platform-surfaces.md](references/platform-surfaces.md) — Per-platform brand-expression surfaces + icon specifications (single source of truth for both strategy-agent and visual-agent)
- [references/artboard-generation.md](references/artboard-generation.md) — Paper MCP artboard specs and workflow
- [references/typography-psychology.md](references/typography-psychology.md) — Font personality mappings and pairing rules
- [references/color-emotion.md](references/color-emotion.md) — Color psychology, OKLCH values, audience palettes
- [references/component-patterns.md](references/component-patterns.md) — Extended UI component patterns with token consumption maps
- [references/paper-artboard-templates.md](references/paper-artboard-templates.md) — Paper MCP HTML/CSS templates
- [references/ai-slop-detection.md](references/ai-slop-detection.md) — AI-generated design anti-patterns checklist
- [references/artifact-templates.md](references/artifact-templates.md) — Complete BRAND.md and DESIGN.md output templates with all sections and field specifications

### Quality-Bar Reference Examples (references/)
- [references/example-brand.md](references/example-brand.md) — Worked example: Conquistador BRAND.md (narrative brand book at quality bar)
- [references/example-design.md](references/example-design.md) — Worked example: Conquistador DESIGN.md (AI-readable design system at quality bar)
