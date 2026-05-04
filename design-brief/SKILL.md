---
name: design-create
description: "Drafts visual creative assets — social posts, ads, OG images, banners, hero illustrations, spot graphics — by pulling brand-system tokens, generating concept briefs for approval, then either rendering directly (Pencil/Paper MCP) or producing prompts for generative tools (Claude Design, Midjourney, Imagen, DALL·E, Veo). Produces `.agents/mkt/design/[slug]/` with brief, render-or-prompt, and critic report. Not for brand identity definition (use brand-system) or whole-page redesigns (page-level briefs are separate). Not for writing copy (use content-create or copywriting). For copy IN a creative, pipe content-create output as input."
argument-hint: "[asset description, e.g. 'instagram carousel about pricing tiers']"
allowed-tools: Read Edit Grep Glob Bash WebSearch WebFetch
license: MIT
metadata:
  author: hungv47
  version: "1.0.0"
  budget: standard
  estimated-cost: "$1-2"
promptSignals:
  phrases:
    - "design a"
    - "create graphic"
    - "design asset"
    - "social graphic"
    - "ad creative"
    - "og image"
    - "hero image"
    - "banner design"
    - "carousel design"
    - "thumbnail"
    - "illustration for"
  allOf:
    - [design, asset]
    - [create, graphic]
    - [generate, image]
  anyOf:
    - "graphic"
    - "creative"
    - "visual"
    - "illustration"
    - "carousel"
    - "banner"
    - "thumbnail"
    - "midjourney"
    - "imagen"
    - "dall-e"
    - "claude design"
    - "pencil"
    - "figma"
  noneOf:
    - "brand identity"
    - "design system"
    - "design tokens"
    - "user flow"
    - "wireframe"
  minScore: 6
routing:
  intent-tags:
    - visual-asset
    - graphic-design
    - ad-creative
    - social-graphic
    - og-image
    - illustration-prompt
    - generative-prompt
  position: pipeline
  produces:
    - mkt/design/[slug]/brief.md
    - mkt/design/[slug]/render.* (when direct-render route)
    - mkt/design/[slug]/prompt.md (when generative-AI route)
    - mkt/design/[slug]/critic.md
  consumes:
    - brand/BRAND.md
    - brand/DESIGN.md
    - brand/ASSETS.md
    - mkt/content/[slug].md
    - mkt/content-research.md
  requires:
    - brand/BRAND.md
    - brand/DESIGN.md
  defers-to:
    - skill: brand-system
      when: "need to define brand identity, logo, palette, or full design system"
    - skill: content-create
      when: "need to write the copy that goes IN the creative"
    - skill: copywriting
      when: "need craft-quality headline or CTA copy"
  parallel-with: []
  interactive: true
  estimated-complexity: medium
---

# Design Creation — Orchestrator

*Communication — visual layer. Coordinates concept generation, brand anchoring, tool routing, and critic gates to produce per-asset creative.*

**Core Question:** "Would this asset be unmistakable as ours, and does it land the message in one glance?"

## Critical Gates — Read First

- **Do NOT render before brief approval.** Visual revision is expensive (Midjourney credits, Pencil edits, designer time). The user picks ONE concept of three before any rendering happens.
- **Do NOT proceed without brand anchors.** Missing `brand/BRAND.md` or `brand/DESIGN.md` → return `NEEDS_CONTEXT` with a recommendation to run `brand-system` first. Generic-AI-aesthetic output is the failure mode this skill exists to prevent.
- **Do NOT invent tokens, fonts, or motion specs.** Every visual decision must trace to DESIGN.md. If DESIGN.md doesn't cover what's needed (e.g. illustration style), call it out in the brief — don't guess.
- **Do NOT use stock-AI defaults.** No default purple-blue gradients, no centered isolated subjects on white, no faux-3D bevels, no glassmorphism unless DESIGN.md specifies it. The critic agent scores generic-AI smell explicitly.
- **Do NOT skip the second approval gate.** Render/prompt is a candidate, not a delivery. The user reviews and accepts/rejects/iterates.

## Philosophy

This skill is the visual analog of `content-create`. Where content-create produces copy, design-create produces visual creative — bound to the same brand system, same audience, same campaign. Output is either a directly rendered file (vector, layout, branded template) or a generation-prompt artifact (for Claude Design / Midjourney / Imagen / DALL·E / Veo / Suno) that the user runs in the external tool.

Brand fidelity > aesthetic novelty. A boring on-brand asset beats a striking off-brand one every time.

## Inputs Required

- **Asset request** — type (e.g. Instagram carousel, OG image, banner ad), platform/format if relevant, purpose (announce, educate, convert, recruit), copy if available
- **`brand/BRAND.md`** — voice, archetype, sacred elements
- **`brand/DESIGN.md`** — palette, typography, surface language, motion (if applicable)

## Inputs Optional

- **`brand/ASSETS.md`** — if the asset request matches a row in the production inventory, pre-fills format/dimensions and ticks the box on completion
- **`.agents/mkt/content/[slug].md`** — copy to use IN the asset (headline, body, CTA)
- **`.agents/mkt/content-research.md`** — winning visual patterns from competitor scan
- **`.agents/mkt/imc-plan.md`** — campaign context, channel placement, awareness stage

## Output

`.agents/mkt/design/[slug]/` containing:
- `brief.md` — approved concept brief (artifact of record)
- `render.[ext]` — direct render if Route PE/PA/C (.pen / Paper artboard / Canva spec)
- `prompt.md` — generation prompt artifact if Route P (Claude Design / Midjourney / Imagen / DALL·E / Veo / Suno)
- `figma-spec.md` — design spec doc if Route F (Figma handoff for human designer)
- `critic.md` — visual rubric score + concerns

## Quality Gate

Before delivering, the **critic agent** verifies:
- [ ] Brand fidelity — palette, typography, motion all trace to DESIGN.md
- [ ] Sacred elements respected (no proposed change to logo, primary palette anchor, tagline, etc. unless brief explicitly authorizes)
- [ ] Hierarchy — clear focal point, scannable in 1 second
- [ ] Composition — balance, rule of thirds, intentional white space
- [ ] Typography — pairing/sizing/leading consistent with DESIGN.md
- [ ] Contrast — text passes WCAG AA (≥4.5:1 normal, ≥3:1 large) on its actual background
- [ ] Format fit — dimensions, safe zones, platform crop behavior verified
- [ ] CTA clarity (if applicable) — readable at preview size, action verb visible
- [ ] **Generic-AI-aesthetic check — score 0-3 on each: default-gradient smell, centered-isolated-on-white, stock-3D bevels, faux-glass, AI-uncanny-photo. Total ≥4 = FAIL.**

## Chain Position

Previous: `brand-system` (required), `content-create` (optional, supplies copy) | Next: external rendering or human handoff

**Re-run triggers:** When BRAND.md or DESIGN.md updates, when a new asset row is added to ASSETS.md, when content-create produces copy that needs visual treatment, when a campaign launches.

### Skill Deference

- **No brand system yet?** → Run `brand-system` first. design-create hard-blocks without it.
- **Need the copy that goes in the creative?** → Run `content-create` first or in parallel.
- **Whole-page redesign brief, not single asset?** → Out of scope. Use a page-level brief workflow (see project's `growth/page-redesigns/` if it exists).
- **Generic asset that doesn't need brand fidelity?** → Question whether you actually need this skill. If yes, run with `--ungrounded` flag (see Routing below).

---

## Agent Manifest

| Agent | Layer | File | Focus |
|-------|-------|------|-------|
| Brand-Anchor Agent | 1 (parallel) | `agents/brand-anchor-agent.md` | Pulls relevant tokens, sacred elements, lexicon, motion spec from BRAND.md + DESIGN.md |
| Concept Agent | 1 (parallel) | `agents/concept-agent.md` | Generates 3 distinct concept directions (mood, composition, references) |
| Copy-Anchor Agent | 1 (parallel) | `agents/copy-anchor-agent.md` | Resolves copy that appears IN the asset (from content-create artifact, or interview the user) |
| Brief Synthesizer | 1.5 (after L1) | `agents/brief-synth-agent.md` | Merges anchor + 3 concepts + copy into 3 candidate briefs with format spec, hierarchy, asset slots |
| Prompt-Craft Agent | 2P (route P) | `agents/prompt-craft-agent.md` | Produces tool-specific generation prompts (Claude Design / Midjourney / Imagen / DALL·E / Veo / Suno) |
| Pencil-Render Agent | 2PE (route PE) | `agents/pencil-render-agent.md` | Renders directly to `.pen` via Pencil MCP |
| Paper-Render Agent | 2PA (route PA) | `agents/paper-render-agent.md` | Renders artboard via Paper MCP using brand-system Paper conventions |
| Figma-Spec Agent | 2F (route F) | `agents/figma-spec-agent.md` | Produces design spec markdown for human designer in Figma |
| Critic Agent | 3 (final) | `agents/critic-agent.md` | Visual rubric scoring + generic-AI-aesthetic detection |

### Shared References (read by multiple agents)

- `references/asset-types.md` — Dimensions, safe zones, format conventions per asset type (IG carousel, OG, banner, etc.)
- `references/prompt-patterns.md` — Generative AI prompt structures, parameter cheatsheets, model strengths
- `references/visual-rubric.md` — Critic scoring dimensions with worked examples
- `references/failure-modes.md` — Generic-AI-aesthetic catalog, brand-drift patterns, accessibility violations
- `references/tool-routing.md` — Which tool for which asset type, decision tree
- `references/examples.md` — End-to-end worked examples per route

---

## Routing Logic

**Tool selection happens BEFORE concept generation** — concept must respect tool constraints (Pencil = vector/layout; generative = photo/illustration/abstract).

### Route P — Prompt artifact (generative AI)

**When:** Photographic, illustrative, abstract, or compositionally complex creative. Hero images, OG images, blog illustrations, ad backgrounds, video thumbnails. Anything that benefits from generative diversity.

**Targets:** Claude Design (claude.ai/design), Midjourney, Imagen, DALL·E, Ideogram, Veo (video), Suno (audio).

```
1. Pre-dispatch: Gather brand artifacts + brief
2. LAYER 1 — Dispatch IN PARALLEL:
   - brand-anchor-agent
   - concept-agent (3 concepts)
   - copy-anchor-agent (if copy goes in the asset)
3. LAYER 1.5 — brief-synth-agent (merges into 3 candidate briefs)
4. APPROVAL GATE 1 — Present 3 briefs. User selects 1 (or revises, or kills all).
5. LAYER 2P — prompt-craft-agent (tool-specific prompt + variant prompts)
6. LAYER 3 — critic-agent (scores prompt against rubric)
7. APPROVAL GATE 2 — Present prompt artifact. User approves to copy/run, or requests revision.
8. Deliver: brief.md + prompt.md + critic.md to .agents/mkt/design/[slug]/
```

### Route PE — Pencil direct render

**When:** Vector layouts, UI mockups, branded social templates, multi-format size variants, infographics with strict typographic hierarchy. Anything where Pencil's flex-based vector engine fits.

```
1-4. Same as Route P (brief approval first)
5. LAYER 2PE — pencil-render-agent (writes .pen via Pencil MCP)
6. LAYER 3 — critic-agent (scores rendered output)
7. APPROVAL GATE 2 — Present render. User approves, requests revision, or kills.
8. Deliver: brief.md + render.pen + critic.md
```

### Route PA — Paper direct render

**When:** Brand guideline artboards, identity rendering aligned with brand-system Paper conventions (flex-only, inline-only, hex-only). Use when the asset is a brand-system extension piece (e.g. a new ASSETS.md row that fits the artboard pattern).

```
1-4. Same as Route P
5. LAYER 2PA — paper-render-agent (writes Paper artboard)
6. LAYER 3 — critic-agent
7. APPROVAL GATE 2
8. Deliver: brief.md + render.html (Paper-compatible) + critic.md
```

### Route F — Figma handoff spec

**When:** Asset will be executed by a human designer in Figma. Skill produces a design-spec markdown precise enough for Figma execution without further clarification.

```
1-4. Same as Route P
5. LAYER 2F — figma-spec-agent (produces structured design spec)
6. LAYER 3 — critic-agent
7. APPROVAL GATE 2 — Present spec. User approves and hands to designer.
8. Deliver: brief.md + figma-spec.md + critic.md
```

### Route C — Canva direct (DEFERRED to v1.1)

Canva MCP currently exposes only authentication. When `mcp__claude_ai_Canva__*` adds template tools, add `canva-template-agent.md` and route here for multi-format social packs. For now, route Canva-style requests through Route P (prompt artifact) or Route F (spec).

### Tool Routing Decision Tree

| Asset Type | Default Route | Why |
|-----------|--------------|-----|
| OG image / blog hero / ad photo | P | Generative gives photo/illustration diversity |
| Instagram carousel (typographic) | PE | Vector + multi-slide layout = Pencil |
| Instagram carousel (image-led) | P (per slide) | Generate slides, assemble |
| Banner / display ad (text-heavy) | PE | Pencil's vector text + crop variants |
| Banner / display ad (visual-led) | P | Generate the visual, overlay text |
| Brand guideline artboard | PA | Paper conventions exist in brand-system |
| Hero illustration (custom) | P | Generative or human-designer |
| Logo variant / mark | PE or PA | Vector — Pencil for free-form, Paper for brand-system aligned |
| OOH / billboard | F | Print-grade, needs human designer in Figma |
| Email hero | P or PE | Depends on photo vs. typographic |
| YouTube thumbnail | P | Photo-based + bold text overlay |
| Spot icon / decoration | PE | Vector |

User can override with `--route=P|PE|PA|F`.

---

## Step 0: Pre-Dispatch Context Gathering

### Brand Artifact Check

Check for `brand/BRAND.md` and `brand/DESIGN.md`. If missing → **NEEDS_CONTEXT**. Recommend running `brand-system` first.

If `brand/ASSETS.md` exists, scan for a row matching the requested asset. If found, pre-fill format/dimensions/file path from the spec and prepare to tick the box on completion.

If artifact dates are >60 days old (brand systems update less often than IMC plans) and the user hasn't explicitly confirmed they're current, **warn** and ask before proceeding.

### Required Artifacts

| Artifact | Source | If Missing |
|----------|--------|------------|
| `brand/BRAND.md` | brand-system | **NEEDS_CONTEXT.** Run brand-system Route A or B first. |
| `brand/DESIGN.md` | brand-system Route B | **NEEDS_CONTEXT.** Run brand-system Route B for full design tokens. |

### Optional Artifacts

| Artifact | Source | Benefit |
|----------|--------|---------|
| `brand/ASSETS.md` | brand-system Route B | Auto-fill dimensions, tick checkbox on completion |
| `.agents/mkt/content/[slug].md` | content-create | Copy to use in the creative |
| `.agents/mkt/content-research.md` | content-research | Winning visual patterns |
| `.agents/mkt/imc-plan.md` | imc-plan | Campaign context, awareness stage |
| `research/icp-research.md` | icp-research | Audience visual preferences |

---

## Step 0.5: Route Selection (Orchestrator)

Before dispatching Layer 1, the orchestrator picks a route AND (for Route P) a target generative tool. Sub-agents downstream require both as input.

1. **If user passed `--route=P|PE|PA|F`** → honor override. Warn if asset-type default differs (e.g., user requests Route P for a logo variant — note that vector mark is better in Pencil but proceed).
2. **Else, walk the decision tree** in `references/tool-routing.md` against the asset request. The asset-type → default route table is the fast path; the decision tree handles edge cases.
3. **State the route + rationale in 1 line to the user** before Layer 1 dispatches:
   > "Route auto-selected: P (photographic OG image). Target tool: midjourney-v6 (editorial mood, MJ stronger here than Imagen). Override with `--route=` if needed."
4. **For Route P, also pick `target_tool`** from `references/prompt-patterns.md` "Quick reference: tool → asset type" table — record both. Pass `target_tool` (e.g., `claude-design`, `midjourney-v6`, `imagen-3`, `dall-e-3`, `ideogram`, `veo`, `suno`) into the context object that Layer 1 agents and Layer 2P (prompt-craft-agent) receive.
5. **For Routes PE/PA/F**, `target_tool` = the route's renderer (Pencil / Paper / Figma-as-handoff-target). No sub-tool selection needed.
6. **If the asset is in `references/tool-routing.md` Out of Scope (v1)** (code-driven generative art, Lottie/AE animation, glTF, standalone audio), return **NEEDS_CONTEXT** with the right destination — do not silently dispatch.

The selected `route` and `target_tool` are part of the context every agent receives.

---

### Context to Pass to All Agents

1. **Asset request** — type, platform/format, purpose, dimensions if known
2. **Brand anchor digest** — palette, type, motion, sacred elements (from brand-anchor-agent after L1)
3. **Copy** — if any goes IN the asset (from copy-anchor-agent after L1)
4. **Tool route** — selected route determines downstream agent
5. **Awareness stage** — affects density, complexity, CTA prominence
6. **Reference patterns** — winning visuals from content-research if available

---

## Dispatch Protocol

### How to spawn a sub-agent

1. **Read** the agent instruction file — include its FULL content in the Agent prompt
2. **Append** context (asset request, brand digest, copy, route)
3. **Resolve file paths to absolute** — replace relative paths with absolute paths rooted at this skill's directory
4. **Pass upstream artifacts by content** — orchestrator reads `brand/BRAND.md`, `brand/DESIGN.md`, `brand/ASSETS.md`, content artifacts FIRST, then includes relevant excerpts in context. Sub-agents should NOT read brand files directly (lexicon and sacred elements must pass through brand-anchor-agent for consistency).
5. If **feedback** exists (from critic FAIL), append with header "## Critic Feedback — Address Every Point"

### Single-agent fallback

If multi-agent dispatch is unavailable, execute each agent's instructions sequentially:
- Layer 1: pull brand anchors, generate 3 concepts, resolve copy
- Layer 1.5: synthesize 3 briefs
- Approval gate 1
- Layer 2 (route-specific): produce render or prompt
- Layer 3: critic scoring
- Approval gate 2

---

## Layer 1: Parallel Foundation

Spawn **IN PARALLEL**:

| Agent | Instruction File | Pass These Inputs | Reference Files |
|-------|-----------------|-------------------|-----------------|
| Brand-Anchor Agent | `agents/brand-anchor-agent.md` | full BRAND.md + DESIGN.md content + asset request | — |
| Concept Agent | `agents/concept-agent.md` | asset request + brand digest excerpt + content-research patterns (if available) | `references/asset-types.md`, `references/failure-modes.md` |
| Copy-Anchor Agent | `agents/copy-anchor-agent.md` | asset request + content-create artifact (if exists) + brand voice rules | — |

Wait for all to complete. Their outputs become inputs for Layer 1.5.

---

## Layer 1.5: Brief Synthesis

| Agent | Instruction File | Pass These Inputs | Reference Files |
|-------|-----------------|-------------------|-----------------|
| Brief Synthesizer | `agents/brief-synth-agent.md` | brand anchor + 3 concepts + copy + route + asset request | `references/asset-types.md` |

Output: 3 candidate briefs, each with concept name, visual direction, hierarchy, asset slot specs (dimensions/format/safe zones), copy placement, motion notes (if applicable), failure modes to avoid.

---

## Approval Gate 1 — Brief Selection

**STOP and present** the 3 candidate briefs to the user. Do not proceed to rendering.

Format:

```
## Brief Candidates

### A. [Concept Name]
[Visual direction, mood, references — 3-5 lines]
**Why this:** [argument]
**Risk:** [main concern]

### B. [Concept Name]
...

### C. [Concept Name]
...

**Pick one (A/B/C), request revisions, or specify your own direction.**
```

User responses handled:
- **"A" / "B" / "C"** → proceed with that brief to Layer 2.
- **"Revise X"** → re-dispatch concept-agent with feedback, regenerate briefs, re-present.
- **"None of these"** → ask one clarifying question (what's missing?), regenerate.
- **"Switch route to X"** → user wants the same concept rendered via a different route (e.g., "B is good but I want Figma handoff, not generative"). Re-dispatch Layer 1.5 brief-synth with the new route. Concept-agent's tool-feasibility lines drive whether the chosen concept survives the route change — if a concept's feasibility was RETHINK for the new route, re-run concept-agent for that concept before brief synthesis.
- **"Stop"** → save brief candidates as `.agents/mkt/design/[slug]/brief-candidates.md`, exit with status BLOCKED.

---

## Layer 2: Tool-Specific Render or Prompt

Dispatch ONE based on route:

| Route | Agent | Output |
|-------|-------|--------|
| P | `agents/prompt-craft-agent.md` | `prompt.md` — generation prompt + 2 variant prompts |
| PE | `agents/pencil-render-agent.md` | `render.pen` (via Pencil MCP `batch_design`) |
| PA | `agents/paper-render-agent.md` | `render.html` (Paper artboard, brand-system conventions) |
| F | `agents/figma-spec-agent.md` | `figma-spec.md` — design spec for human designer |

---

## Layer 3: Critic Gate

| Agent | Instruction File | Receives |
|-------|-----------------|----------|
| Critic Agent | `agents/critic-agent.md` | Approved brief + Layer 2 output |

Critic produces `critic.md` with rubric scores and PASS / FAIL.

- **PASS** → proceed to Approval Gate 2
- **FAIL** → re-dispatch Layer 2 agent with critic feedback. Max 2 rewrite cycles. After 2 failures, deliver with critic annotations and flag to user as DONE_WITH_CONCERNS.

---

## Approval Gate 2 — Output Acceptance

**STOP and present** the rendered output (or prompt artifact) + critic report.

Format:

```
## [Asset Name] — [Route]

**Brief:** [concept name selected]
**Critic:** [PASS / DONE_WITH_CONCERNS]
**Score:** [/40 with sub-scores]

[Render preview, prompt text, or spec link]

[Critic notes — concerns to monitor]

**Approve, revise, or reject.**
```

User responses:
- **"Approve"** →
  1. Write artifact files to `.agents/mkt/design/[slug]/` (brief.md + render/prompt + critic.md per route).
  2. **ASSETS.md auto-tick:** if a render is exported to a path that matches a `brand/ASSETS.md` row's path field (literal string match against the row's `path` — never auto-tick on slug or asset-type heuristic), use the Edit tool to flip the row's `[ ]` checkbox to `[x]` and append a date stamp. If no path match (campaign-specific asset, ad-hoc), skip — design-create does not own ASSETS.md row creation; that belongs to brand-system.
  3. Status DONE.
- **"Revise X"** → re-dispatch Layer 2 agent with user feedback (1 cycle), re-present.
- **"Reject"** →
  1. **Preserve `brief.md`** — it was approved at Gate 1 and remains the artifact of record.
  2. Save Layer 2 output as `[slug]/v1-rejected.[ext]` (the rejected render or prompt — kept for diagnostic).
  3. Append `[slug]/rejection-notes.md` with the user's reason.
  4. Exit BLOCKED. On re-run with the same slug, brief.md is reused; only Layer 2 re-runs (skip Layer 1 + Gate 1).

---

## Artifact Template — `.agents/mkt/design/[slug]/brief.md`

```markdown
---
skill: design-create
version: 1
date: [today]
status: [done | done_with_concerns | blocked | needs_context]
route: [P | PE | PA | F]
asset_type: [og-image | ig-carousel | banner | ...]
platform: [instagram | linkedin | web | print | ...]
dimensions: [WxH or per-format list]
brand_anchors:
  primary_color: [hex]
  primary_type: [font, weight]
  motion: [duration token if applicable]
sacred_respected: [list of sacred elements honored]
---

# Design Brief: [Asset Name]

**Asset:** [type + platform]
**Purpose:** [announce | educate | convert | recruit | brand-build]
**Source copy:** [path or "none"]
**Tool route:** [P / PE / PA / F]

## Concept (Approved)

**Name:** [concept name]
**Visual direction:** [3-5 lines — mood, composition, palette emphasis, type role, motion if applicable]
**References:** [3 reference URLs or named brands/artworks IF applicable — never copy, only direction]

## Brand Anchors

- **Palette pull:** [3-5 hex values from DESIGN.md, with token name]
- **Typography:** [primary + secondary from DESIGN.md, sizes for this asset]
- **Sacred elements respected:** [list — what was preserved]
- **Lexicon:** [forbidden phrases avoided, preferred phrases used if copy is in asset]

## Format Spec

| Field | Value |
|-------|-------|
| Dimensions | [WxH px] |
| Safe zone | [px from edges, platform-specific] |
| File format | [PNG / SVG / .pen / WebP / MP4] |
| Color mode | [sRGB / DCI-P3] |
| File size cap | [KB if platform enforces] |
| Background | [hex or "transparent"] |

## Hierarchy

1. **Focal point:** [what the eye lands on first]
2. **Supporting:** [secondary element]
3. **Tertiary:** [text body, fine detail]

## Asset Slots

| Slot | Dimensions | Format | Fallback | Generation prompt template (if Route P) |
|------|-----------|--------|----------|---|
| [Hero image] | [WxH] | [PNG] | [solid hex if missing] | [link to prompt.md] |
| [Spot illustration] | [WxH] | [SVG] | [emoji or icon ref] | — |

## Copy Placement (if any)

- **Headline:** "[exact copy]" — [position, type token]
- **Body:** "[exact copy]" — [position, type token]
- **CTA:** "[exact copy]" — [position, type token, contrast pair]

## Failure Modes to Avoid

- [Page-specific or asset-specific traps — generic-AI smell, brand drift, etc.]

## What NOT to Do

- [Sacred elements: do not propose changing X, Y, Z]
- [Off-brand defaults to reject]
```

(Full template includes references to `prompt.md`, `figma-spec.md`, `critic.md` per route.)

> On re-run with same slug: rename existing artifact to `[slug]/v[N]/` and create new with incremented version. Preserves history for A/B comparison.

---

## Worked Example — OG image for blog post (Route P)

**Brief:** OG image for blog post "Why we killed standups"
**Audience:** Engineering managers, problem-aware
**Route:** P (generative — photo-like aesthetic better than vector)

### Step 0: Pre-Dispatch
- BRAND.md present (forsvn brand). DESIGN.md present (Deep Forest #004700, Signal Lime #B7FF6E, Geist Sans).
- ASSETS.md row matches: `brand/og/blog/standups-killed.png — 1200x630 — [ ]`
- Awareness: problem-aware. Channel: Twitter/LinkedIn share preview.

### Layer 1 (parallel)
- **Brand-anchor-agent** returns: palette anchor #004700, accent #B7FF6E, type Geist Sans Bold for headline, sacred = logo bottom-right at 60px height, motion = N/A (static)
- **Concept-agent** returns 3 concepts:
  - **A. Empty meeting room** — wide shot, abandoned chairs, low light, lime accent on "12 hours" callout
  - **B. Time-loss receipt** — photographic receipt with hours stacking, type-led
  - **C. Calendar emptied** — overhead photo of calendar with "STANDUP" entries crossed out in lime
- **Copy-anchor-agent** returns: headline "12 hours/week. Gone." — pulled from blog title rephrase, voice-checked.

### Layer 1.5
- **Brief-synth-agent** merges into 3 candidate briefs with format spec (1200x630, sRGB, ≤500KB), hierarchy, copy placement.

### Approval Gate 1
User picks **A** ("Empty meeting room").

### Layer 2P — Prompt-Craft
Returns:
- **Primary prompt (Midjourney v6):** "wide-angle photograph of an empty corporate conference room at dusk, abandoned ergonomic chairs scattered around an oval table, low-key lighting, deep forest green accent wall, single shaft of cold daylight from blinds, melancholic mood, editorial photography style, shot on Hasselblad, 35mm, --ar 1200:630 --style raw --v 6"
- **Variant 1:** [tighter framing variant]
- **Variant 2:** [warmer light variant]
- Post-processing note: "Add 'Geist Sans Bold 96px headline "12 hours/week. Gone." in #B7FF6E, bottom-left, 60px from edges; logo #FFFFFF bottom-right 60px from edges' as Pencil overlay or Photoshop step."

### Layer 3 — Critic
- Brand fidelity: 4/4 (palette + type traceable)
- Sacred respected: 4/4
- Hierarchy: 3/4 (focal point clear, but text overlay risk if MJ output is busy)
- Composition: 3/4
- Typography: N/A (overlay step)
- Contrast: 4/4 (lime on dark green = WCAG AA pass)
- Format fit: 4/4
- Generic-AI: 3/4 (slight risk of "stock corporate" feel — variant 1 mitigates)
- **Score: 25/28 → PASS with note**

### Approval Gate 2
User approves. Artifact saved to `.agents/mkt/design/standups-killed-og/`. ASSETS.md row ticked once render exists at `brand/og/blog/standups-killed.png`.

---

## Anti-Patterns

**Skipping the brief approval gate** — Going straight to render burns Midjourney credits or Pencil time on a misaligned concept. INSTEAD: 3 briefs, user picks one, then render.

**Inventing tokens** — Using a color or font not in DESIGN.md because it "fits the mood." INSTEAD: If DESIGN.md is incomplete for this asset's needs, flag it in the brief and ask the user — either expand DESIGN.md (re-run brand-system) or accept the limitation.

**Stock-AI defaults** — Default purple-blue gradient, centered isolated subject on white, glassmorphism, faux-3D bevels. INSTEAD: Critic-agent's generic-AI rubric explicitly catches these. If a concept relies on them, score it down before rendering.

**Generic-photo prompts** — "Modern office, professional, 4k, hyperrealistic." Looks like every other AI-stock-photo. INSTEAD: Specific lens, lighting, mood, era, composition, color cast. Make the prompt specific enough that two generations look like the same photographer's work.

**Ignoring safe zones** — Designing edge-to-edge for Instagram and losing CTA to the crop. INSTEAD: Asset-types.md defines safe zones per platform — concept must fit them.

**Round-tripping AI renders into brand/** — Treating a Midjourney output as a brand asset of record. INSTEAD: Renders are presentation artifacts; brand/ holds source-of-truth specs only. Generated images live under `.agents/mkt/design/[slug]/` or per-campaign asset folders.

**Treating Claude Design output as design system** — claude.ai/design generates exploration. It's a starting point, not a brand commitment.

---

## Completion Status Protocol

Per project standard, every run ends with explicit status:

- **DONE** — brief approved, render/prompt approved, critic PASS, artifacts written
- **DONE_WITH_CONCERNS** — approved but critic flagged issues; concerns documented in artifact frontmatter
- **BLOCKED** — user rejected at a gate, or external dependency missing (Pencil MCP unavailable for Route PE, etc.)
- **NEEDS_CONTEXT** — BRAND.md or DESIGN.md missing; cannot proceed without brand-system

---

## Agent Files

### Sub-Agent Instructions (agents/)

- [agents/brand-anchor-agent.md](agents/brand-anchor-agent.md) — Token + sacred element pull
- [agents/concept-agent.md](agents/concept-agent.md) — 3 concept directions
- [agents/copy-anchor-agent.md](agents/copy-anchor-agent.md) — In-asset copy resolution
- [agents/brief-synth-agent.md](agents/brief-synth-agent.md) — 3 candidate briefs
- [agents/prompt-craft-agent.md](agents/prompt-craft-agent.md) — Generative AI prompts
- [agents/pencil-render-agent.md](agents/pencil-render-agent.md) — Pencil .pen render
- [agents/paper-render-agent.md](agents/paper-render-agent.md) — Paper artboard render
- [agents/figma-spec-agent.md](agents/figma-spec-agent.md) — Figma handoff spec
- [agents/critic-agent.md](agents/critic-agent.md) — Visual rubric + AI-aesthetic check

### Shared References (references/)

- [references/asset-types.md](references/asset-types.md) — Per-asset format specs
- [references/prompt-patterns.md](references/prompt-patterns.md) — Generative AI prompt structures
- [references/visual-rubric.md](references/visual-rubric.md) — Critic scoring dimensions
- [references/failure-modes.md](references/failure-modes.md) — Generic-AI catalog, brand drift
- [references/tool-routing.md](references/tool-routing.md) — Decision tree
- [references/examples.md](references/examples.md) — End-to-end worked examples
