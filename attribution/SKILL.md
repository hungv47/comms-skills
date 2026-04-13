---
name: attribution
description: "Maps marketing activities to business outcomes — evaluates channel ROI, identifies what's driving results, and recommends where to double down or cut spend. Produces `.agents/mkt/attribution.md`. Not for setting new KPIs (use funnel-planner) or creating new content (use content-create). For campaign planning, see imc-plan. For experiment design, see experiment."
argument-hint: "[initiatives or KPIs to map]"
allowed-tools: Read Grep Glob Bash WebSearch WebFetch
license: MIT
metadata:
  author: hungv47
  version: "3.0.0"
  budget: deep
  estimated-cost: "$1-3"
routing:
  intent-tags:
    - kpi-mapping
    - channel-roi
    - gap-analysis
    - marketing-measurement
    - channel-attribution
    - multi-touch-attribution
    - cac-by-channel
    - offline-measurement
  position: pipeline
  produces:
    - mkt/attribution.md
  consumes:
    - product-context.md
    - mkt/imc-plan.md
    - mkt/content/[slug].md
    - mkt/content/[slug].humanized.md
    - solution-design.md
    - targets.md
    - experiment-[name].md
  requires: []
  defers-to:
    - skill: funnel-planner
      when: "setting numeric targets, not measuring results"
    - skill: experiment
      when: "designing validation tests, not tracking attribution"
  parallel-with: []
  interactive: false
  estimated-complexity: medium
---

# Attribution Mapping — Orchestrator

*Communication — Step 4 of 4. Validates the system — every initiative and content piece connects to a KPI, with action items for every gap.*

**Core Question:** "Can we trace every initiative to a measurable outcome?"

---

## Critical Gates — Read First

1. **Every KPI has >= 1 initiative** mapped or an explicit action item. No uncovered KPIs.
2. **Every initiative maps to a KPI** or has a Kill/Reframe/Test recommendation with reason.
3. **Every active channel has an attribution model assigned** — first-touch, last-touch, linear, time-decay, or position-based. No channel without a measurement approach.
4. **Offline channels have proxy measurement methods** — QR codes, vanity URLs, promo codes, or branded search lift. No offline channel without a tracking strategy.
5. **Every recommendation is a verb** (Create / Kill / Rebalance / Test / Assign) — not an observation.
6. **Review date is set** (~4 weeks from today).
7. **Critic returns PASS** before delivery. Max 2 rewrite cycles.

---

## Inputs Required
- KPIs from `.agents/targets.md` or existing OKRs
- Initiatives from `.agents/solution-design.md`
- Content from `.agents/mkt/imc-plan.md` or `.agents/mkt/content/`

## Output
- `.agents/mkt/attribution.md`

---

## Agent Manifest

| Agent | File | Focus | Layer |
|-------|------|-------|-------|
| **kpi-hierarchy-agent** | `agents/kpi-hierarchy-agent.md` | Builds North Star → Leading → Supporting metric tree | L1 |
| **initiative-mapper-agent** | `agents/initiative-mapper-agent.md` | Maps initiatives to KPIs with contribution % and confidence | L2 (after kpi-hierarchy) |
| **channel-attribution-agent** | `agents/channel-attribution-agent.md` | Maps each active channel to contribution weight, CAC, payback, and attribution model | L2.5 (after initiative-mapper) |
| **content-mapper-agent** | `agents/content-mapper-agent.md` | Maps content to initiatives with funnel roles | L3 (after channel-attribution) |
| **gap-analysis-agent** | `agents/gap-analysis-agent.md` | Identifies uncovered KPIs, low-confidence initiatives, funnel imbalances | L4 (after content-mapper) |
| **action-agent** | `agents/action-agent.md` | Converts gaps into prioritized action items | L5 (after gap-analysis) |
| **critic-agent** | `agents/critic-agent.md` | Quality gate — PASS/FAIL with rewrite routing | L6 (final) |

### Dependency Chain

```
kpi-hierarchy-agent (L1)
  └─► initiative-mapper-agent (L2) — needs KPI tree to map against
        └─► channel-attribution-agent (L2.5) — needs initiative map to weight channels
              └─► content-mapper-agent (L3) — needs initiative + channel maps to map against
                    └─► gap-analysis-agent (L4) — needs full chain to analyze
                          └─► action-agent (L5) — needs gaps to convert
                                └─► critic-agent (L6) — evaluates merged output
```

**Why fully sequential:** Each agent's output is a required input for the next. Initiative mapping requires the KPI hierarchy (to know what to map to). Content mapping requires the initiative map (to know what to map to). Gap analysis requires all three maps. Actions require the gaps. The critic evaluates everything.

---

## Routing Logic

### Route A: Quick Attribution Check
**Trigger:** User asks to check attribution for specific initiatives or KPIs, or wants a lightweight audit.
**Chain:** kpi-hierarchy → initiative-mapper → channel-attribution → gap-analysis → action → critic
**Skip:** content-mapper (no content audit needed for a quick check)

### Route B: Full Attribution
**Trigger:** User asks for full attribution mapping, or this is a first-time run.
**Chain:** kpi-hierarchy → initiative-mapper → channel-attribution → content-mapper → gap-analysis → action → critic
**Skip:** Nothing — all agents run.

### Route C: Re-Run (Monthly Cadence)
**Trigger:** Previous `.agents/mkt/attribution.md` exists, or user says "re-run" / "monthly review."
**Chain:** Same as Route B, but with these additions:
1. Read previous `attribution.md` before dispatch
2. Pass prior action items to action-agent in pre-writing for progress tracking
3. Rename previous file to `attribution.v[N].md`
4. action-agent checks prior action status and flags escalations

---

## Dispatch Protocol

### Before Starting

#### Step 0: Product Context
Check for `.agents/product-context.md`. If available, read for product context. If missing, strongly recommend running `icp-research` first — attribution mapping is significantly more accurate with product context.
If `.agents/targets.md`, `.agents/solution-design.md`, or `.agents/mkt/imc-plan.md` `date` fields are older than 30 days, recommend re-running upstream skills — stale data produces inaccurate attribution maps. Tip: `/navigate status` (from meta-skills) gives a single-pass freshness report across all upstream artifacts.

#### Required Artifacts
None — can build from scratch by interviewing.

#### Optional Artifacts
| Artifact | Source | Benefit |
|----------|--------|---------|
| `targets.md` | funnel-planner | KPI baselines |
| `solution-design.md` | solution-design (from hungv47/research-skills) | Initiative list to map |
| `imc-plan.md` | imc-plan | Content plan to audit |
| Previous `attribution.md` | attribution | Check progress on prior action items |
| `experiment-*.md` | experiment (from research-skills) | Experiment outcomes as confidence adjustments — concluded experiments update contribution confidence |

Read upstream files if they exist: `.agents/targets.md`, `.agents/solution-design.md`, `.agents/mkt/imc-plan.md`. If previous `.agents/mkt/attribution.md` exists, read it — check progress on prior action items before building the new map.

#### Interview
If no upstream files exist, interview for:
1. "What's your North Star metric?"
2. "What are your 3-5 primary KPIs?"
3. "What initiatives are you running or planning?"
4. "What content are you producing?"

### Cross-Track Prerequisites
This skill maps content → initiatives → KPIs. For full-stack attribution:
1. **Strategy stack first** (optional): Run `problem-analysis` → `solution-design` → `funnel-planner` to generate `.agents/solution-design.md` (initiatives) and `.agents/targets.md` (KPIs).
2. **Comms stack**: Run `icp-research` → `imc-plan` → `content-create` to generate content artifacts.
3. **Then attribution**: Maps content to initiatives to KPIs with gap analysis.

Without strategy artifacts, this skill interviews for KPIs and initiatives directly — it still works, but cross-stack alignment is stronger with upstream artifacts.

### Single-Agent Fallback
If the environment does not support multi-agent dispatch, execute all steps sequentially in a single pass following the same order: build KPI hierarchy → map initiatives → map channels (attribution models, CAC, offline measurement) → map content → analyze gaps → write actions. Apply the critic checklist as a self-check before delivery.

---

## Layer Dispatch

### Pre-writing (gathered before any agent runs)
```yaml
brief: [user's attribution task]
product_context: [from product-context.md if available]
business_model: [from interview or upstream artifacts — informs KPI hierarchy structure]
upstream_artifacts:
  targets: [contents of targets.md or null]
  solution_design: [contents of solution-design.md or null]
  imc_plan: [contents of imc-plan.md or null]
  previous_attribution: [contents of prior attribution.md or null]
  experiments: [contents of experiment-*.md files or null]
route: [A / B / C]
review_date: [today + 4 weeks]
```

### Agent Dispatch Sequence

Each agent receives `brief`, `pre-writing`, and its `upstream` (previous agent's output). References are resolved to absolute paths before dispatch.

| Agent | Upstream | References | Skip on Route A? |
|-------|----------|-----------|-----------------|
| kpi-hierarchy-agent | null (first) | attribution-models.md, attribution-examples.md | No |
| initiative-mapper-agent | kpi-hierarchy output | attribution-examples.md, attribution-models.md | No |
| channel-attribution-agent | initiative-mapper output | attribution-models.md, tracking-guide.md | No |
| content-mapper-agent | channel-attribution output | attribution-examples.md, tracking-guide.md | **Yes** |
| gap-analysis-agent | merged L1-L3 output | attribution-models.md, tracking-guide.md | No |
| action-agent | merged all prior | — | No |
| critic-agent | merged final document | attribution-examples.md | No |

---

## Merge Step

After each agent completes, merge its output into the growing attribution document:

1. **After L1 (kpi-hierarchy):** Document has KPI Hierarchy section
2. **After L2 (initiative-mapper):** Add Initiative → KPI Mapping + Orphan Initiatives sections
3. **After L2.5 (channel-attribution):** Add Channel Attribution + Channel Interaction Map sections
4. **After L3 (content-mapper):** Add Content → Initiative Mapping + Orphan Content sections
5. **After L4 (gap-analysis):** Add Gap Analysis section (not in final artifact — used internally)
6. **After L5 (action-agent):** Add Action Items + Previous Review Progress sections
7. **After L6 (critic):** Evaluate merged document → PASS or FAIL

Gap analysis output is consumed by the action-agent but does NOT appear as a standalone section in the final artifact. The action items table IS the user-facing output of the gap analysis.

---

## Critic Gate

- **Max 2 rewrite cycles.** If the critic returns FAIL, re-dispatch only the named agent(s) with feedback.
- On FAIL, the critic names which agent(s) to re-dispatch and provides specific fix instructions.
- Re-dispatched agents receive the **feedback** field with critic instructions. They MUST address every point.
- After rewrite, re-merge and re-run the critic.
- If still FAIL after 2 cycles: deliver with a `## Known Issues` section listing unresolved failures. Do not loop indefinitely.

### Rewrite Routing

| Failure Type | Re-dispatch to |
|-------------|---------------|
| KPI hierarchy incomplete or has vanity metrics | **kpi-hierarchy-agent** |
| Initiative mapping has unjustified confidence or missing entries | **initiative-mapper-agent** |
| Channel attribution missing models, CAC estimates, or offline measurement | **channel-attribution-agent** |
| Content mapping incomplete or orphans not flagged | **content-mapper-agent** |
| Gaps missed or severity misclassified | **gap-analysis-agent** |
| Actions are observations, missing owners/deadlines, or wrong verbs | **action-agent** |
| Sections contradict each other | Re-merge (orchestrator issue) |

---

## Re-Run Protocol

Review and refresh attribution maps on a regular cadence:

1. **Monthly review cycle:** Set review date ~4 weeks from creation
2. **On re-run:**
   - Read previous `.agents/mkt/attribution.md`
   - Check status of each prior action item (Done / In Progress / Blocked / Dropped)
   - Rename previous file to `attribution.v[N].md`
   - Rebuild map with current state
   - Compare: Did action items move the needle? Which KPIs improved?
3. **Escalation:** If same gaps persist across 2+ reviews, escalate from "Rebalance" to "Kill" or "Create"

**Re-run triggers:** Monthly review cycle (set review date ~4 weeks from creation), after experiments conclude, when KPIs or initiatives change.

### Status Definitions
- **Done** — shipped AND outcome measured. If no outcome data, it's In Progress.
- **In Progress** — started but not complete. Note blocker if any.
- **Parked** — deprioritized deliberately. Note what changed.
- **Dropped** — decided not to pursue. Note explicit reason.

If the same action appears as "Parked" or "Dropped" across 2+ reviews, escalate: either commit to doing it or kill the underlying initiative.

---

## Artifact Template

```markdown
---
skill: attribution
version: 1
date: [today's date]
status: draft
---

# Attribution Map

**Date:** [today]
**Skill:** attribution
**Review date:** [today + 4 weeks]

## KPI Hierarchy

​```
North Star: [metric] — [current] → [target]
├── KPI 1: [metric] — [current] → [target] — Owner: [person]
├── KPI 2: ...
└── KPI 3: ...
​```

## Initiative → KPI Mapping

| Initiative | KPI | Contribution | Confidence |
|------------|-----|-------------|------------|
| ... | ... | ... | ... |

### Orphan Initiatives
| Initiative | Action |
|------------|--------|
| ... | ... |

## Channel Attribution

Maps each active channel from the 9-channel map to its contribution weight and measurement approach.

| Channel | Funnel Role | Attribution Model | Est. CAC | Payback Period | Confidence | Rationale |
|---------|------------|------------------|----------|----------------|------------|-----------|
| [e.g. Search engines/AEO (paid)] | Conversion | Last-touch | [$X] | [X months] | [H/M/L] | [Why this model for this channel] |
| [e.g. Social media (organic)] | Awareness | First-touch | [N/A — organic] | [N/A] | [M] | [Why this model] |
| [e.g. IRL] | Relationship | Position-based | [$X] | [X months] | [L] | [Why this model] |

Split channels by paid vs. organic when they behave differently (e.g., "Search engines/AEO (organic)" and "Search engines/AEO (paid)").

**Attribution model selection guide:**
- **First-touch** — credit the channel that introduced the customer. Best for: brand awareness channels (OOH, PR, social organic, news)
- **Last-touch** — credit the channel that closed the deal. Best for: conversion channels (search ads, retargeting, SMS, email CTA)
- **Linear** — equal credit across all touchpoints. Best for: evaluating channel mix balance
- **Time-decay** — more credit to recent touchpoints. Best for: long sales cycles (SLG/enterprise, 60+ day cycles)
- **Position-based (U-shaped)** — 40% first touch, 40% last touch, 20% middle. Best for: hybrid motions (PLG+SLG), store/listing platforms (marketplace discovery → evaluation → install)

**Channel-specific model recommendations:**

| Channel | Recommended Model | Rationale |
|---------|------------------|-----------|
| Search engines/AEO (organic) | First-touch or linear | Often the first discovery channel |
| Search engines/AEO (paid) | Last-touch | High-intent conversion channel |
| Store/Listing platforms | Position-based | Discovery (first) + install (last) both matter |
| Bounty/Info platforms | Last-touch | Incentivized conversions — credit the converting action |
| News | First-touch | Primarily awareness and trust-building |
| Forums/Communities | First-touch or linear | Discovery and trust, rarely direct conversion |
| Social media (organic) | First-touch | Brand awareness channel |
| Social media (paid) | Last-touch or time-decay | Direct response, retargeting |
| IRL (events/OOH/POS) | First-touch | Awareness, hard to track mid-funnel |
| Mailbox (email) | Time-decay or last-touch | Nurture channel, often in middle/end of path |
| SMS | Last-touch | Direct response, conversion-focused |

### Channel Interaction Map
- **Common conversion paths:** [Channel A] → [Channel B] → Conversion
- **Assist channels:** [channels that rarely convert directly but appear in most paths]
- **Channel velocity:** [average days from first touch to conversion per channel]

### Offline Channel Measurement

For channels without native digital tracking:

| Channel | Proxy Measurement | Implementation |
|---------|-------------------|----------------|
| IRL / Events | Unique QR codes per event, lead capture forms, post-event survey ("How did you hear about us?") | QR → UTM-tagged landing page → GA4 event |
| OOH (billboards) | Branded search lift (compare branded search volume before/after campaign), vanity URLs | Google Trends / GA4 branded search report |
| Point of Sales | Unique promo codes per location, loyalty program attribution | POS system → CRM sync |
| SMS campaigns | Click-through tracking (shortened URLs with UTMs), conversion codes | SMS platform analytics + GA4 |
| PR / News | Referral traffic spikes from publication domains, branded search lift post-article | GA4 referral report + Google Trends |
| Bounty/Info platforms | Unique referral codes per affiliate, conversion tracking via referral links | Affiliate platform dashboard + CRM attribution |
| Store/Listing platforms | App store analytics (impressions → page views → installs), review platform referral tracking | App Store Connect / Google Play Console / G2 analytics |
| Mailbox (direct mail) | Unique promo codes per campaign, dedicated vanity URLs, matchback analysis (match recipient list to conversion list) | CRM matchback + GA4 vanity URL tracking |

## Content → Initiative Mapping

| Content | Initiative | Type | Channel |
|---------|-----------|------|---------|
| ... | ... | ... | ... |

### Orphan Content
| Content | Action |
|---------|--------|
| ... | ... |

## Action Items

| # | Gap | Action | Owner | Deadline |
|---|-----|--------|-------|----------|
| 1 | ... | ... | ... | ... |

## Previous Review Progress

| # | Prior Action | Status | Outcome |
|---|-------------|--------|---------|
| 1 | [action from last review] | Done / In Progress / Parked / Dropped | [Result if Done: what metric moved? If not done: blocker or reason] |

Status definitions:
- **Done** — shipped AND outcome measured. If no outcome data, it's In Progress.
- **In Progress** — started but not complete. Note blocker if any.
- **Parked** — deprioritized deliberately. Note what changed.
- **Dropped** — decided not to pursue. Note explicit reason.

If the same action appears as "Parked" or "Dropped" across 2+ reviews, escalate: either commit to doing it or kill the underlying initiative.

> On re-run: rename existing artifact to `attribution.v[N].md` and create new with incremented version.

## Next Step

Re-run this skill monthly to track action progress (Route C). Run `content-create` for any content gaps identified. Run `experiment` to validate high-uncertainty initiatives.
```

---

## Worked Example

See [references/attribution-examples.md](references/attribution-examples.md) for 3 complete worked examples across business types (B2B SaaS PLG, Developer Tools API Platform, E-Commerce D2C).

**Example 1 summary:** B2B SaaS PLG → Route B → L1 builds KPI tree (North Star: MAU, 4 KPIs: Signups, Activation, Trial-to-Paid, Churn) → L2 maps 5 initiatives to KPIs with confidence levels → L3 maps 7 content pieces to initiatives → L4 flags uncovered KPIs (Churn has 1 low-confidence initiative) and orphan content → L5 generates action items → L6 critic evaluates.

---

## Anti-Patterns

**Vanity metrics as KPIs** — Tracking impressions or followers as primary KPIs. These metrics feel good but don't connect to business outcomes. KPIs must be metrics that, if improved, move the North Star.
INSTEAD: Use vanity metrics as supporting metrics under a leading KPI, not as KPIs themselves.

**Mapping everything to revenue** — Forcing every content piece to show direct revenue impact ignores the awareness and trust stages of the funnel. Map content to its appropriate funnel stage metric, not just revenue.
INSTEAD: Map content to the funnel stage it serves (Reach → Trust → Conversion). Attribution traces the chain, not a shortcut.

**Ignoring time lag** — Expecting attribution results within days for strategies that take weeks or months to show impact. Set appropriate measurement windows — brand content may take 8-12 weeks to influence pipeline.
INSTEAD: Set measurement windows per content type using `references/attribution-models.md`. Review after the window closes, not before.

**Orphan content without initiative links** — Content that exists because "we should post something" rather than supporting a specific initiative. Every piece should trace to an initiative and KPI — orphan content is wasted effort.
INSTEAD: Flag orphans explicitly with Assign / Repurpose / Sunset recommendations. Zero orphan tolerance.

**Static attribution maps** — Building the map once and never updating it. Attribution maps decay as initiatives ship, KPIs shift, and new content is produced. Set a review cadence (monthly minimum).
INSTEAD: Set review date 4 weeks out. Use Route C (re-run) to track action progress and refresh the map.

**Attribution without tracking infrastructure** — Mapping content to KPIs on paper while having no event tracking, UTM parameters, or analytics in place. The map becomes theoretical without implementation. See [references/tracking-guide.md](references/tracking-guide.md) for minimum viable tracking.
INSTEAD: content-mapper-agent flags tracking status for every piece. Untracked content generates a **Create** action item for tracking implementation.

**Wrong attribution model for the business** — Using last-touch attribution for a B2B product with 90-day sales cycles attributes everything to the final touchpoint and misses the content that created awareness. Match model to buying cycle length. See [references/attribution-models.md](references/attribution-models.md).
INSTEAD: kpi-hierarchy-agent sets measurement windows per KPI using the attribution-models reference.

**Metrics without owners** — Every KPI and initiative must have a named person (not "the team"). Unowned metrics don't get improved — they get reported on and shrugged at.
INSTEAD: kpi-hierarchy-agent flags unassigned owners. gap-analysis-agent classifies them as ownership gaps. action-agent generates **Assign** actions.

---

## Chain Position
Previous: `content-create` | Next: Monthly review (re-run this skill)
**Re-run triggers:** Monthly review cycle (set review date ~4 weeks from creation), after experiments conclude, when KPIs or initiatives change.

## References

- [references/attribution-examples.md](references/attribution-examples.md) — Worked examples across business types
- [references/attribution-models.md](references/attribution-models.md) — Model selection guide by business type and buying cycle
- [references/tracking-guide.md](references/tracking-guide.md) — Event naming conventions, UTM standards, minimum viable tracking stack
