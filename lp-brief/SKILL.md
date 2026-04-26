---
name: lp-brief
description: "Generates a campaign-grade brief for a landing-page redesign — hypothesis, surface rhythm, section-by-section spec, asset slots, copy candidates, hand-off prompts. Internalizes lp-optimization conversion principles as evaluation rubric. Produces `.agents/mkt/lp-brief/[slug]/brief.md` ready to hand to Claude Design, a designer in Figma, or design-create for per-asset rendering. Not for auditing an existing page (use lp-optimization first — its output feeds this skill). Not for non-conversion pages like blogs or docs hubs (those use different rubrics). Not for single-asset creative (use design-create)."
argument-hint: "[page route or campaign name, e.g. '/pricing' or 'q3-launch-lp']"
allowed-tools: Read Grep Glob Bash WebSearch WebFetch
license: MIT
metadata:
  author: hungv47
  version: "0.1.0-draft"
  status: draft
  budget: deep
  estimated-cost: "$2-4"
promptSignals:
  phrases:
    - "page brief"
    - "landing page brief"
    - "redesign brief"
    - "lp brief"
    - "campaign brief"
    - "redesign /[a-z]+"
  allOf:
    - [page, brief]
    - [landing, redesign]
    - [draft, brief]
  anyOf:
    - "landing page"
    - "redesign"
    - "page-brief"
    - "lp-brief"
    - "hero section"
    - "page architecture"
  noneOf:
    - "blog post"
    - "docs page"
    - "single asset"
  minScore: 6
routing:
  intent-tags:
    - landing-page-brief
    - page-redesign-brief
    - campaign-brief
    - conversion-brief
  position: pipeline
  produces:
    - mkt/lp-brief/[slug]/brief.md
  consumes:
    - brand/BRAND.md
    - brand/DESIGN.md
    - mkt/lp-optimization.md
    - research/icp-research.md
    - research/product-context.md
    - mkt/imc-plan.md
    - mkt/content-research.md
  requires:
    - brand/BRAND.md
    - brand/DESIGN.md
  defers-to:
    - skill: lp-optimization
      when: "page exists and the task is diagnosis, not redesign"
    - skill: design-create
      when: "rendering an individual asset slot from this brief (per-asset creative)"
    - skill: brand-system
      when: "no brand identity defined yet"
    - skill: copywriting
      when: "need craft-quality headline variation work in isolation"
  parallel-with: []
  interactive: true
  estimated-complexity: heavy
---

# Landing Page Brief — Orchestrator

*Communication — Step between strategy and design. Coordinates audit anchoring, hypothesis generation, architecture, per-section specification, asset slotting, and hand-off prompt composition into a single approved brief.*

**Core Question:** "Could a designer (or Claude Design) build the right page from this brief without a single follow-up question?"

## Critical Gates — Read First

- **Do NOT generate a brief without brand artifacts.** Missing `brand/BRAND.md` or `brand/DESIGN.md` → return `NEEDS_CONTEXT`. The brief depends on tokens, voice rules, and sacred elements; it cannot be generated without them.
- **Do NOT skip the conversion rubric.** Every section spec is gated by lp-optimization's craft rules (4-U headline, message match, CTA psychology, social proof placement, objection handling, form-field discipline). A brief that scores brand-good but conversion-bad is a failure.
- **Do NOT propose changing sacred elements.** Logo geometry, primary palette anchor, tagline wording, signature treatments are listed as "do not touch" in the brief — they're rails, not options.
- **Do NOT exceed the brief length envelope.** A useful brief is 250–500 lines. Below 250 = insufficient depth (designer will ask follow-ups). Above 500 = bloat (designer skims and misses spec). Critic enforces.
- **Do NOT inline the full skill chain.** If the project uses a shared skill chain doc (e.g., `growth/page-redesigns/_prompts.md`), the brief references it by section header and adds page-specific overrides only.
- **Do NOT inject placeholder testimonials, fake logos, or pretend numbers.** If a proof asset isn't real, the brief specifies the spec ("Customer logo grid, 6 cells × 60px") and notes "delete cell if not real" — never fabricates.

## Philosophy

This skill operates between strategy and design. By the time it runs, the WHY (hypothesis) and WHO (audience) should be stable; the brief turns those into a HOW (architecture + section spec + asset slots) precise enough for execution. The conversion rubric from lp-optimization is internalized — every section is evaluated against the same craft rules used to audit existing pages, but applied at brief time so the page is *built* right rather than *audited* later.

Brand fidelity > aesthetic novelty. Conversion craft > visual flair. Specificity > flexibility. Designer should not have to interpret — only execute.

## Inputs Required

- **Page route or campaign name** — e.g., `/pricing`, `/services`, `q3-launch-lp`. If the page exists, list its current state (URL, code path, screenshots).
- **`brand/BRAND.md`** — voice, archetype, sacred elements, lexicon rules
- **`brand/DESIGN.md`** — palette, typography, surface language, motion tokens

## Inputs Optional (each materially improves the brief)

| Artifact | Source | What it strengthens |
|----------|--------|---------------------|
| `.agents/mkt/lp-optimization.md` | lp-optimization | Audit-anchored hypothesis ("rev N → rev N+1: what changed and why") |
| `research/icp-research.md` | icp-research | Audience-specific objection-handling, VoC for copy candidates |
| `research/product-context.md` | icp-research | Product accuracy in features/proof sections |
| `.agents/mkt/imc-plan.md` | imc-plan | Campaign role of this LP, traffic source, awareness stage |
| `.agents/mkt/content-research.md` | content-research | Winning hero patterns, audience language map, competitor section structures |
| `.agents/targets.md` | funnel-planner | Conversion target the LP must hit; informs CTA hierarchy aggressiveness |

## Output

`.agents/mkt/lp-brief/[slug]/brief.md` — single artifact, structured per the template below.

Optional companions if the project uses them:
- `.agents/mkt/lp-brief/[slug]/handoff-claude-design.md` — verbatim prompt block for claude.ai/design
- `.agents/mkt/lp-brief/[slug]/handoff-figma.md` — design spec for human designer
- `.agents/mkt/lp-brief/[slug]/asset-slots/` — per-asset prompt artifacts (one per generative slot)

## Quality Gate

Before delivering, **two critics run in parallel**:

**Conversion critic** verifies (rubric mirrors lp-optimization):
- [ ] Hero headline scores ≥3/4 on 4-U (Useful, Unique, Urgent, Ultra-specific)
- [ ] Message match: hero copy echoes traffic source (ad headline, link text, search query)
- [ ] One primary CTA per page; secondary CTAs don't compete
- [ ] Trust signals within scroll-distance of every CTA
- [ ] Form ≤5 fields OR exception justified
- [ ] Social proof from last 12 months (or replaced/removed)
- [ ] Every section addresses one objection from ICP research
- [ ] CTA copy uses [action verb] + [outcome] formula, first-person where appropriate ("Get my brief" > "Get your brief")
- [ ] Above-fold value prop understandable in 3 seconds

**Brand-voice critic** verifies:
- [ ] Every visual decision traces to DESIGN.md tokens
- [ ] Sacred elements respected (4/4 — non-negotiable)
- [ ] Voice rules respected — no forbidden vocabulary, preferred phrases used, casing rules followed
- [ ] Surface language matches archetype (no glassmorphism if "anti-glass")
- [ ] Asset slot specs include named generation prompts that respect brand digest
- [ ] Brief stays within 250–500 line envelope

## Chain Position

Previous: `lp-optimization` (optional — if existing page being redesigned), `imc-plan` (optional — campaign context), `brand-system` (required) | Next: `design-create` per asset slot, then implementation (Claude Design / human designer)

**Re-run triggers:** new audit revision, BRAND.md/DESIGN.md update, ICP refresh, traffic source pivot. Increment `--rev=N`.

### Skill Deference

- **Page exists; need to know what to fix?** → `lp-optimization` first. Its output (`.agents/mkt/lp-optimization.md`) feeds this skill as anchored signal.
- **Single visual asset, not whole page?** → `design-create`.
- **No brand?** → `brand-system` first.
- **Need only headline variations?** → `copywriting` for variation work.
- **Non-LP page (blog, docs, navigation hub)?** → Out of scope. The conversion rubric doesn't apply. Use a different brief workflow or commission one.

---

## Agent Manifest

| Agent | Layer | File | Focus |
|-------|-------|------|-------|
| Audit-Anchor Agent | 1 (parallel) | `agents/audit-anchor-agent.md` | Pulls signals from lp-optimization audit (if exists) or gathers signals from page state and ICP |
| Brand-Anchor Agent | 1 (parallel) | `agents/brand-anchor-agent.md` | Pulls relevant tokens, sacred elements, voice rules from BRAND.md + DESIGN.md |
| Hypothesis Agent | 1.5 (after L1) | `agents/hypothesis-agent.md` | Generates 3 hypothesis candidates with 3Q rubric (Visual / Falsifiable / Unique) |
| Architecture Agent | 2 (after hypothesis approved) | `agents/architecture-agent.md` | Surface rhythm + section list + ASCII diagram + scroll velocity plan |
| Section-Spec Agent | 3 (after architecture approved) | `agents/section-spec-agent.md` | Per-section spec — copy slots, layout, motion, asset slots, conversion-checklist embed |
| Asset-Slot Agent | 3 (parallel with section-spec) | `agents/asset-slot-agent.md` | Named asset slots with file paths, dimensions, formats, fallbacks, generation prompt templates |
| Hand-Off Agent | 4 (after L3) | `agents/handoff-agent.md` | Composes Claude Design / Figma / designer hand-off prompt block |
| Conversion Critic | 5 (parallel) | `agents/conversion-critic-agent.md` | Scores brief against lp-optimization rubric |
| Brand-Voice Critic | 5 (parallel) | `agents/brand-voice-critic-agent.md` | Scores brand fidelity + voice + envelope |

### Shared References (read by multiple agents)

- `references/conversion-principles.md` — Curated from lp-optimization (4-U, above-fold, CTA, message-match, objection handling, social proof). Cites lp-optimization references.
- `references/surface-rhythm.md` — Page-architecture patterns (scroll velocity, section beats, breathing room)
- `references/section-templates.md` — Hero, value prop, social proof, features, objection, FAQ, CTA — each with conversion-checklist
- `references/hypothesis-rubric.md` — 3Q scoring (Visual / Falsifiable / Uniquely Ours)
- `references/handoff-formats.md` — Claude Design / Pencil MCP / Figma spec hand-off patterns
- `references/failure-modes.md` — Page-level failures (thin hero, weak CTA, no objection handling, brief bloat)
- `references/examples.md` — Worked LP-brief examples

---

## Routing Logic

### Route A: Fresh LP (no existing page)

```
1. Pre-dispatch: Gather context (Step 0). Verify brand/* present.
2. LAYER 1 — Dispatch IN PARALLEL:
   - audit-anchor-agent (pulls signals from ICP, content-research, product context — no audit input)
   - brand-anchor-agent
3. LAYER 1.5 — hypothesis-agent (3 candidates with 3Q scoring)
4. APPROVAL GATE 1 — Present 3 hypothesis candidates. User picks 1 (or revises, or kills).
5. LAYER 2 — architecture-agent (surface rhythm + section list)
6. APPROVAL GATE 2 — Present architecture. User approves, requests revisions, or kills.
7. LAYER 3 — Dispatch IN PARALLEL:
   - section-spec-agent
   - asset-slot-agent
8. LAYER 4 — handoff-agent (composes hand-off prompts)
9. LAYER 5 — Dispatch IN PARALLEL:
   - conversion-critic-agent
   - brand-voice-critic-agent
10. Critic merge: orchestrator combines reports
11. APPROVAL GATE 3 — Present full brief + critic merge. User approves, requests revisions, or kills.
12. Deliver: brief.md + handoff/* artifacts to .agents/mkt/lp-brief/[slug]/
```

### Route B: Existing LP redesign (audit-anchored)

Same as Route A, but Layer 1 audit-anchor-agent reads `.agents/mkt/lp-optimization.md`. Hypothesis is anchored in audit findings ("rev N → rev N+1: what changed and why"). Architecture and section spec address audit's failure modes explicitly.

### Route C: Re-run with `--rev=N`

```
1. Read prior brief at .agents/mkt/lp-brief/[slug]/v[N-1]/brief.md
2. Read fresh inputs (new audit, new ICP, new content-research)
3. Run Layer 1 — diff prior brief against fresh inputs
4. Hypothesis-agent receives "what's new since rev N-1" context
5. Continue Route A/B from Layer 1.5
6. Save new brief at .agents/mkt/lp-brief/[slug]/v[N]/brief.md, preserve prior versions
```

---

## Step 0: Pre-Dispatch Context Gathering

### Brand Artifact Check

- `brand/BRAND.md` and `brand/DESIGN.md` present? If not → **NEEDS_CONTEXT**.
- Date check: if either is >60 days stale and user hasn't confirmed, warn and ask before proceeding.

### Audit Artifact Check (Route B)

- `.agents/mkt/lp-optimization.md` present? If yes, route B.
- If no but page exists, suggest running lp-optimization first — anchored hypothesis beats unanchored.

### Required Artifacts

| Artifact | Source | If Missing |
|----------|--------|------------|
| `brand/BRAND.md` | brand-system | **NEEDS_CONTEXT.** Run brand-system. |
| `brand/DESIGN.md` | brand-system Route B | **NEEDS_CONTEXT.** Run brand-system Route B. |

### Optional Artifacts (each strengthens output)

| Artifact | Benefit |
|----------|---------|
| `.agents/mkt/lp-optimization.md` | Audit-anchored hypothesis |
| `research/icp-research.md` | Real objections, VoC for copy candidates |
| `research/product-context.md` | Product accuracy |
| `.agents/mkt/imc-plan.md` | Traffic source + awareness stage |
| `.agents/mkt/content-research.md` | Winning patterns, audience language |
| `.agents/targets.md` | Conversion target informs CTA aggressiveness |

### Project-Specific Workflows

If the project has a shared skill chain doc (e.g., `growth/page-redesigns/_prompts.md`), read it once at orchestrator level. The brief will REFERENCE it by section header — never inline-duplicate. Add page-specific overrides only.

### Context to Pass to All Agents

1. **Page identity** — route, name, current state (URL/screenshot/code if exists)
2. **Tier** — conversion-primary (hero LP, /pricing, /services), conversion-secondary (/about, /story), programmatic (/industries/:slug, /workflows/:slug, /compare/:vs:)
3. **Audit signals** — from lp-optimization.md if present
4. **Brand digest** — palette, type, motion, sacred, voice rules (from brand-anchor-agent after L1)
5. **Audience digest** — top 3 ICP objections, top 5 VoC phrases, awareness stage (from audit-anchor after L1)
6. **Campaign context** — traffic source, awareness stage, conversion target

---

## Dispatch Protocol

### How to spawn a sub-agent

1. Read agent instruction file — include FULL content in Agent prompt
2. Append context (digest excerpts, prior layer outputs, asset slot list, etc.)
3. Resolve all file paths to absolute (rooted at this skill's directory)
4. Pass upstream artifacts by content — orchestrator reads `.agents/mkt/lp-optimization.md`, `research/icp-research.md`, etc. FIRST and includes excerpts; sub-agents do not read these directly
5. If feedback exists (from critic FAIL), append with `## Critic Feedback — Address Every Point`

### Single-agent fallback

If multi-agent dispatch is unavailable, execute each layer sequentially. The approval gates remain — single-agent mode does not bypass user gates.

---

## Layer 1: Parallel Foundation

| Agent | Pass These Inputs | Reference Files |
|-------|-------------------|-----------------|
| Audit-Anchor Agent | page identity + tier + lp-optimization.md (if present) + ICP + content-research | — |
| Brand-Anchor Agent | full BRAND.md + DESIGN.md + page identity | — |

Wait for both. Their outputs become inputs for Layer 1.5.

---

## Layer 1.5: Hypothesis

| Agent | Pass These Inputs | Reference Files |
|-------|-------------------|-----------------|
| Hypothesis Agent | audit digest + brand digest + page tier + campaign context | `references/hypothesis-rubric.md`, `references/conversion-principles.md` |

Output: 3 hypothesis candidates, each scored on 3Q (Visual / Falsifiable / Uniquely Ours).

---

## Approval Gate 1 — Hypothesis Selection

**STOP.** Present 3 hypothesis candidates:

```
## Hypothesis Candidates

### A. [Title]
**Claim:** [single sentence — falsifiable]
**3Q score:** Visual [Y/N] / Falsifiable [Y/N] / Unique [Y/N] = N/3
**Why this:** [argument tied to audit findings or audience signals]
**Risk:** [main concern]

### B. [Title]
[same structure]

### C. [Title]
[same structure]

**Pick one (A/B/C), revise, or kill all.**
```

User responses:
- "A" / "B" / "C" → proceed to Layer 2 with that hypothesis
- "Revise X" → re-dispatch hypothesis-agent with feedback
- "None of these" → ask one clarifying question, regenerate
- "Stop" → save candidates, exit BLOCKED

---

## Layer 2: Architecture

| Agent | Pass These Inputs | Reference Files |
|-------|-------------------|-----------------|
| Architecture Agent | approved hypothesis + brand digest + audit digest + tier | `references/surface-rhythm.md`, `references/section-templates.md` |

Output: surface rhythm plan + section list + ASCII page diagram + scroll velocity notes (where the eye accelerates / decelerates / pauses).

---

## Approval Gate 2 — Architecture Approval

**STOP.** Present architecture:

```
## Page Architecture — [Hypothesis Title]

### Surface Rhythm
[3–5 line description of scroll experience: fast/slow/pause beats]

### Section List
1. Hero — [purpose + key message]
2. [section name] — [purpose]
...

### ASCII Page Diagram
[Visual schematic of section stacking, asset positioning, scroll velocity]

### Scroll Velocity Plan
[Where the eye accelerates / decelerates / pauses, tied to conversion gates]

**Approve, revise, or reject.**
```

User responses:
- "Approve" → proceed to Layer 3
- "Revise X" → re-dispatch architecture-agent with feedback (max 1 revise cycle here)
- "Reject" → return to Layer 1.5 to pick a different hypothesis OR exit BLOCKED

---

## Layer 3: Section Spec + Asset Slots (parallel)

| Agent | Pass These Inputs | Reference Files |
|-------|-------------------|-----------------|
| Section-Spec Agent | architecture + audit digest + brand digest + ICP objections + VoC | `references/section-templates.md`, `references/conversion-principles.md`, `references/failure-modes.md` |
| Asset-Slot Agent | architecture + brand digest + format conventions | (from `marketing-skills/design-create/references/asset-types.md`) |

---

## Layer 4: Hand-Off Composition

| Agent | Pass These Inputs | Reference Files |
|-------|-------------------|-----------------|
| Hand-Off Agent | full assembled brief (architecture + section spec + asset slots) + target tool (Claude Design / Figma / designer) | `references/handoff-formats.md` |

Output: hand-off prompt block, ready to paste into the target tool.

---

## Layer 5: Critic Gate (parallel)

| Agent | Pass These Inputs | Reference Files |
|-------|-------------------|-----------------|
| Conversion Critic | full brief | `references/conversion-principles.md`, `references/section-templates.md` |
| Brand-Voice Critic | full brief + brand digest | `references/failure-modes.md` |

Both run in parallel. Orchestrator merges reports.

**Verdict logic:**
- Both PASS → DONE
- One PASS, one DONE_WITH_CONCERNS → DONE_WITH_CONCERNS
- Either FAIL on cycle 1 → re-dispatch named agents (Layer 3 or Layer 4) with combined feedback. Max 2 cycles.
- Either FAIL on cycle 2 → DONE_WITH_CONCERNS, deliver with concerns flagged

---

## Approval Gate 3 — Final Brief Acceptance

**STOP.** Present the full brief + critic merge.

```
## Brief: [Page Slug] [rev N if applicable]

[Brief preview: hypothesis title, section count, asset slot count, hand-off target]

## Critics
- **Conversion:** [PASS / DONE_WITH_CONCERNS / FAIL] — [score]
- **Brand-voice:** [PASS / DONE_WITH_CONCERNS / FAIL] — [score]

[Concerns to monitor, if any]

**Approve, request revisions, or reject.**
```

User responses:
- "Approve" → write brief to `.agents/mkt/lp-brief/[slug]/brief.md` (with version subfolder if rev), status DONE
- "Revise X" → re-dispatch named layer with feedback (1 cycle)
- "Reject" → save as `.agents/mkt/lp-brief/[slug]/rejected.md`, exit BLOCKED

---

## Artifact Template — `.agents/mkt/lp-brief/[slug]/brief.md`

```markdown
---
skill: lp-brief
version: 1
date: [today]
status: [done | done_with_concerns | blocked | needs_context]
page_route: [/pricing | /services | etc.]
tier: [primary | secondary | programmatic]
rev: [N — what revision this is]
hypothesis_title: [from approved hypothesis]
target_handoff: [claude-design | figma | designer]
brand_anchors:
  primary_color: [hex with token name]
  primary_type: [font, weight]
  surface: [paper / matte / glass-if-DESIGN.md-permits]
sacred_respected: [list]
critic_scores:
  conversion: [N/M]
  brand_voice: [N/M]
shared_skill_chain: [path to project's _prompts.md if referenced]
---

# Landing-Page Brief: [Title]

**Page:** [route + name]
**Tier:** [primary / secondary / programmatic]
**Rev:** [N — what changed from rev N-1, if applicable]
**Hand-off target:** [Claude Design / Figma / designer]

## IMC Context

[1–3 lines: where this page sits in the campaign, traffic source, awareness stage, role in funnel.]

## Hypothesis (Approved)

**Claim:** [single sentence — falsifiable]
**3Q score:** Visual [Y/N] / Falsifiable [Y/N] / Unique [Y/N]
**Why this:** [argument tied to audit findings or audience signals]
**What we're betting:** [the falsifiable bet — what success looks like, what failure looks like]

## What Changed from rev N-1 (if rev > 1)

[Bullet list — only present if --rev=N. Tied to audit findings or new ICP signals.]

## Page Architecture

### Surface Rhythm

[3–5 lines: how the page reads at scroll speed. Fast / slow / pause beats.]

### Section List

1. **Hero** — [purpose + headline pull]
2. **[Section name]** — [purpose]
...
N. **CTA Block** — [purpose]

### ASCII Diagram

```
┌─────────────────────────────────────┐
│  HERO    [headline]    [hero CTA]   │  ← 100vh, low velocity
├─────────────────────────────────────┤
│  VALUE PROP — 3 columns             │
├─────────────────────────────────────┤
│  SOCIAL PROOF — logo grid + quote   │
├─────────────────────────────────────┤
│  ...                                 │
└─────────────────────────────────────┘
```

### Scroll Velocity Plan

| Section | Velocity | Why |
|---------|----------|-----|
| Hero | Slow / pause | First-impression gate |
| Value prop | Medium | Argument scan |
| Social proof | Slow | Decision moment |
| Features | Fast | Detail layer |
| Objection | Slow | Decision blocker |
| CTA | Pause | Action moment |

## Section-by-Section Spec

### 1. Hero

**Purpose:** [first-impression conversion gate]

**Headline candidates (3, 4-U scored):**
1. "[copy]" — Useful: Y, Unique: Y, Urgent: Y, Ultra-specific: Y → 4/4
2. "[copy]" — 3/4
3. "[copy]" — 4/4
**Recommended:** #[N] — [why]

**Subhead:** "[copy]"

**Hero CTA:** "[copy]" — primary, action verb + outcome, first-person

**Visual:** [reference to asset slot — see Asset Slots section]

**Layout:**
- Heading: [type token, size]
- Subhead: [type token, size]
- CTA position: [above-fold, button style, contrast pair]
- Background: [hex / asset slot]

**Motion:** [duration token from DESIGN.md if applicable; static otherwise]

**Conversion checklist (gates):**
- [ ] 4-U ≥ 3/4
- [ ] Message match to traffic source
- [ ] Above-fold value clear in 3 seconds
- [ ] Primary CTA visible without scroll
- [ ] Trust signal within scroll-distance (logo grid below or testimonial widget)
- [ ] Voice rules: no forbidden vocab

### 2. [Next Section]

[Same structure: purpose, copy candidates with rubric, visual, layout, motion, conversion checklist.]

[Continue per section...]

## Asset Slots

| Slot | Section | Dimensions | Format | File path | Fallback | Generation prompt |
|------|---------|-----------|--------|-----------|----------|-------------------|
| Hero image | Hero | 1920×1080 | WebP | `growth/[slug]/hero.webp` | solid #004700 | [link to prompt template, see asset-slots/] |
| Logo grid | Social proof | 6 cells × 60px | SVG | `growth/[slug]/logos.svg` | "delete cell if not real" | — |
| Founder portrait | Story | 600×600 | WebP | `growth/[slug]/founder.webp` | spot illustration | [link if generative] |

**Generation prompts** for asset slots that use generative AI live at `.agents/mkt/lp-brief/[slug]/asset-slots/[slot-name].prompt.md`. Each follows design-create Route P prompt-craft conventions.

## What NOT to Do

- [Sacred element 1 — verbatim "do not touch" line]
- [Sacred element 2]
- [Page-specific failure mode — e.g., "do not use stock-photo office imagery; ICP rejects it"]
- [Voice violations — e.g., "no leverage / unlock / seamlessly anywhere"]

## Hand-Off

### To: [Claude Design / Figma / designer]

**Prompt block (paste verbatim):**

```
[Hand-off prompt composed by handoff-agent — concrete enough to execute without follow-up]
```

### Pre-flight Checklist

- [ ] All copy in brief is final (or marked "candidate — pick one")
- [ ] All asset slots have file paths and fallbacks
- [ ] All sacred elements listed under What NOT to Do
- [ ] Critic scores both ≥ pass threshold
- [ ] Shared skill chain referenced (if project uses one) — not duplicated

## Skill Chain (reference, not duplication)

[If project uses a shared chain doc, reference it by section: "See `growth/page-redesigns/_prompts.md` § Phase A". List only page-specific overrides.]

## Launch Plan

[3–5 lines: when, traffic ramp, instrumentation (UTMs, events to fire), success criteria from hypothesis.]

## Results (filled post-launch)

[Empty until launched. After: actual metrics, hypothesis verdict, what to take into rev N+1.]

## Why This Works (sanity check)

[2–4 lines: the brief's load-bearing arguments — why this hero/this architecture/this CTA hierarchy lands the hypothesis.]
```

> Re-run with `--rev=N`: write to `.agents/mkt/lp-brief/[slug]/v[N]/brief.md`, preserve prior versions.

---

## Worked Example — `/pricing` redesign (Route B, audit-anchored, rev=2)

**User invocation:** `/lp-brief /pricing --rev=2`

### Step 0: Pre-Dispatch
- BRAND.md + DESIGN.md present. ICP fresh (last week). Audit at `.agents/mkt/lp-optimization.md` from 3 days ago.
- Tier: primary (conversion-critical).
- Prior brief: `.agents/mkt/lp-brief/pricing/v1/brief.md` (rev 1, launched 6 weeks ago).
- Audit findings: hero CTA buried below fold on mobile; no objection handling for "is this overkill for small teams"; social proof section uses logos from 18 months ago.

### Layer 1 (parallel)
- **Audit-anchor-agent** returns: rev 1 weakness signals — mobile fold issue, missing objection, stale proof. ICP top objection: "is this overkill for small teams?" Top 3 VoC phrases from interviews.
- **Brand-anchor-agent** returns: palette anchor #004700 / #B7FF6E, Geist Sans display, sacred = logo geometry + tagline + signature animation, no glass.

### Layer 1.5: Hypothesis (3 candidates)
- A. **"Right-size proof leads"** — re-architect around team-size segmentation; Visual Y, Falsifiable Y, Unique Y → 3/3
- B. **"Receipt-style transparency"** — full pricing receipt as hero metaphor; Visual Y, Falsifiable Y, Unique Y → 3/3
- C. **"Calculator-led conversion"** — interactive cost calculator above fold; Visual Y, Falsifiable Y, Unique N (every SaaS does this) → 2/3

### Approval Gate 1 → User picks A.

### Layer 2: Architecture
Surface rhythm: fast scan (hero) → slow proof (segmented testimonials) → fast features → slow objection → pause CTA. ASCII diagram + scroll velocity plan returned.

### Approval Gate 2 → User approves with one revise: "Tighten the features section to 4 rows max."
Architecture-agent re-dispatched with feedback. Returns. → Approved.

### Layer 3 (parallel)
- **Section-spec-agent** returns: 7 sections, each with 3 copy candidates per slot scored on 4-U, conversion checklist embedded.
- **Asset-slot-agent** returns: 6 slots — hero photo, logo grid (with "delete if not real" notes), 3 testimonial portraits, OG image.

### Layer 4: Hand-Off
Hand-off-agent composes Claude Design prompt block: full architecture + section spec + asset slot list + sacred elements + voice rules. ~120 lines.

### Layer 5: Critics
- **Conversion critic** scores brief 27/30 (4-U all hero candidates ≥3, message match strong, single primary CTA, trust within scroll, form not present, social proof note "verify dates"). Concerns: features section objection mapping could be tighter.
- **Brand-voice critic** scores 19/20 (sacred 4/4, voice clean, envelope 412 lines — within range). Single concern: subhead candidate #2 uses "leverage" — flagged for replacement. Section-spec-agent re-dispatched on that one slot. Returns clean. → PASS.

### Approval Gate 3 → User approves.

### Output
`.agents/mkt/lp-brief/pricing/v2/brief.md` — 412 lines, both critics PASS. Companion `handoff-claude-design.md` written. 6 asset-slot prompt files written.

**Status: DONE.** Next step: run `design-create` per asset slot, then hand to Claude Design for layout exploration.

---

## Anti-Patterns

**Skipping audit when page exists** — Route A on an existing page wastes the rev signal. INSTEAD: run lp-optimization first, anchor the hypothesis in real findings.

**Generic hypothesis** — "This page should convert better." Not falsifiable. INSTEAD: "Engineering managers reject /pricing because they perceive overkill for small teams; segmenting proof by team size lifts conversion."

**Inlining the shared skill chain** — Duplicating the project's `_prompts.md` content into every brief. INSTEAD: reference by section header, add page-specific overrides only.

**Stale or fake proof** — Logo grid from 2023, testimonials with no source, "Trusted by 1000+ teams" with no link. INSTEAD: "delete cell if not real" — every proof element has a verifiable source.

**Ignoring sacred elements** — Brief proposes new logo treatment for "freshness." Auto-FAIL. INSTEAD: sacred elements are rails. Inside-the-rails creativity only.

**No objection handling** — Brief has hero, features, CTA — no rebuttal of the audience's stated objections. ICP research lists them; the brief must address the top 1–2.

**Brief too short** — Under 250 lines. Designer asks 5 follow-up questions. INSTEAD: spec everything: every section, every slot, every fallback.

**Brief too long** — Over 500 lines. Designer skims; misses critical spec. INSTEAD: cite shared chain instead of duplicating; cap section spec at the conversion-checklist gates.

**Hero copy violating voice** — "Unlock seamless leverage" passes 4-U but fails brand. The brand-voice critic catches this before delivery.

---

## Completion Status Protocol

- **DONE** — both critics PASS, brief approved, artifacts written
- **DONE_WITH_CONCERNS** — both critics deliver, but ≥1 concern flagged in frontmatter
- **BLOCKED** — user rejected at a gate, or required input missing mid-flow
- **NEEDS_CONTEXT** — BRAND.md or DESIGN.md missing; cannot proceed

---

## Agent Files

### Sub-Agent Instructions (agents/)

- [agents/audit-anchor-agent.md](agents/audit-anchor-agent.md) — Audit signal pull
- [agents/brand-anchor-agent.md](agents/brand-anchor-agent.md) — Token + sacred + voice digest
- [agents/hypothesis-agent.md](agents/hypothesis-agent.md) — 3 hypothesis candidates with 3Q
- [agents/architecture-agent.md](agents/architecture-agent.md) — Surface rhythm + section list
- [agents/section-spec-agent.md](agents/section-spec-agent.md) — Per-section spec
- [agents/asset-slot-agent.md](agents/asset-slot-agent.md) — Named asset slots with prompts
- [agents/handoff-agent.md](agents/handoff-agent.md) — Tool-specific hand-off
- [agents/conversion-critic-agent.md](agents/conversion-critic-agent.md) — lp-optimization rubric
- [agents/brand-voice-critic-agent.md](agents/brand-voice-critic-agent.md) — Brand fidelity + voice + envelope

### Shared References (references/)

- [references/conversion-principles.md](references/conversion-principles.md) — Curated from lp-optimization
- [references/surface-rhythm.md](references/surface-rhythm.md) — Page architecture patterns
- [references/section-templates.md](references/section-templates.md) — Per-section templates with checklists
- [references/hypothesis-rubric.md](references/hypothesis-rubric.md) — 3Q scoring
- [references/handoff-formats.md](references/handoff-formats.md) — Tool-specific hand-off patterns
- [references/failure-modes.md](references/failure-modes.md) — Page-level failures
- [references/examples.md](references/examples.md) — Worked examples
