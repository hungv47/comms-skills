---
name: lp-eval
description: "Evaluates a launched landing page from real performance evidence inside an existing eval loop. Use for post-launch CRO cycles with analytics, experiment results, recordings, form-funnel data, or qualified manual metric notes. Produces `skills-resources/marketing/loops/[slug]/evals/[date]-cycle-N.md` and appends `results.tsv`. Requires an existing `/eval-loop` workspace; does not scaffold loops, redesign pages, or perform generic best-practice audits without measurement evidence."
argument-hint: "[loop slug or path] [page URL/route] [metric window]"
allowed-tools: Read Write Edit Grep Glob Bash WebSearch WebFetch
license: MIT
metadata:
  author: hungv47
  version: "0.1.0"
  budget: standard
  estimated-cost: "$0.75-1.50"
promptSignals:
  phrases:
    - "landing page eval"
    - "lp eval"
    - "evaluate landing page performance"
    - "evaluate landing page analytics"
    - "post-launch cro"
    - "conversion rate changed"
    - "analyze landing page analytics"
    - "landing page results"
    - "should we keep this page change"
    - "cycle results for landing page"
    - "landing page isn't converting"
    - "landing page is not converting"
    - "page isn't converting"
    - "page is not converting"
    - "landing page performance"
  allOf:
    - [landing, analytics]
    - [landing, conversion, rate]
    - [page, results]
    - [landing, not, converting]
    - [landing, performance]
  anyOf:
    - "experiment results"
    - "conversion data"
    - "GA4"
    - "heatmap"
    - "session recording"
    - "form funnel"
    - "A/B test"
    - "CRO"
  noneOf:
    - "new landing page"
    - "landing page brief"
    - "design brief"
    - "single asset"
  minScore: 6
routing:
  intent-tags:
    - landing-page-evaluation
    - post-launch-cro
    - eval-loop-cycle
    - conversion-analysis
  position: evaluation
  lifecycle: evaluation
  produces:
    - skills-resources/marketing/loops/[slug]/evals/[date]-cycle-N.md
    - skills-resources/marketing/loops/[slug]/results.tsv
    - skills-resources/marketing/loops/[slug]/learnings.md
  consumes:
    - skills-resources/marketing/loops/[slug]/program.md
    - skills-resources/marketing/loops/[slug]/context.md
    - skills-resources/marketing/loops/[slug]/results.tsv
    - skills-resources/marketing/loops/[slug]/strategy/*.md
    - skills-resources/marketing/loops/[slug]/execution/*.md
    - brand/BRAND.md
    - research/icp-research.md
    - research/product-context.md
  requires:
    - skills-resources/marketing/loops/[slug]/program.md
    - skills-resources/marketing/loops/[slug]/context.md
    - measurement evidence for the current cycle
  defers-to:
    - skill: eval-loop
      when: "no existing measurable loop workspace exists"
    - skill: lp-brief
      when: "the user needs the next page brief/redesign, not post-launch scoring"
    - skill: campaign-plan
      when: "the issue is channel strategy rather than landing-page evidence"
  parallel-with: []
  interactive: true
  estimated-complexity: medium
---

# Landing Page Eval — Orchestrator

*Evaluation skill. Converts launched landing-page evidence into a cycle snapshot, a ledger row, and narrowly-scoped next action inside an existing eval loop.*

**Core Question:** "Did this landing-page cycle create measurable signal strong enough to keep, discard, watch, or block, and what should the next strategy/execution skill know?"

## Critical Gates

1. **Existing eval loop required.** If `skills-resources/marketing/loops/[slug]/program.md` and `context.md` do not exist, return `NEEDS_CONTEXT` and recommend `/eval-loop`. This skill does not create loops.
2. **Measurement evidence required.** Do not run as a generic heuristic audit. Require at least one metric source, measurement window, and current value for the loop's primary metric.
3. **One primary metric decides the ledger row.** Secondary metrics and qualitative evidence explain diagnosis; they do not override the loop's primary metric unless `program.md` defines an explicit guardrail failure.
4. **No fabricated analytics.** Unknown values stay unknown. Manual notes are allowed only when labeled as operator-supplied and tied to a date/window/source.
5. **Attribution confidence must be explicit.** Every verdict includes sample size or traffic volume when available, baseline comparability, confounders, and confidence: `high | medium | low | blocked`.
6. **Evaluation does not redesign.** Recommend next changes, but route actual page brief/revision work to `lp-brief` and execution artifacts to the appropriate content/design/build workflow.

## Responsibility Split

- `/eval-loop` owns loop setup, `program.md`, `context.md`, `results.tsv` schema, and the durable learning ledger.
- `/lp-eval` owns post-launch landing-page evidence snapshots for a loop cycle.
- `/lp-brief` owns new page and redesign briefs after an eval identifies what should change.

## Inputs

| Input | Required? | What it provides |
|---|---:|---|
| Loop slug or path | **required** | Locates `skills-resources/marketing/loops/[slug]/` |
| Page URL or route | **required** | Evaluated surface |
| Measurement window | **required** | Date range for the current cycle |
| Primary metric value + source | **required** | Ledger decision metric |
| Baseline or prior cycle row | required if available | Comparison point |
| Traffic/sample size | recommended | Confidence and power |
| Guardrail metrics | optional | Bounce, form completion, qualified lead rate, revenue, page speed, spend efficiency |
| Experiment notes | optional | Variant split, assignment, test integrity |
| Qualitative evidence | optional | Heatmaps, recordings, user comments, sales notes |
| Strategy/execution artifacts | optional | What was changed this cycle |

## Outputs

Primary artifact:

```text
skills-resources/marketing/loops/[slug]/evals/YYYY-MM-DD-cycle-N.md
```

Side effects:

- Append one row to `skills-resources/marketing/loops/[slug]/results.tsv` with `meta-skills/scripts/append-loop-result.ts`.
- Update `skills-resources/marketing/loops/[slug]/learnings.md` only for high-confidence `keep` or `discard` lessons that are reusable beyond this exact page state.
- Run `manifest-sync` after writing.

## Agent Manifest

| Agent | Layer | File | Focus |
|---|---|---|---|
| Metric Ingest | 1 (parallel) | `agents/metric-ingest-agent.md` | Normalizes primary metric, baseline, sample, window, guardrails, source caveats |
| Diagnosis | 1 (parallel) | `agents/diagnosis-agent.md` | Connects observed outcomes to page hypothesis, execution delta, traffic/source context, and user behavior |
| Recommendation | 2 | `agents/recommendation-agent.md` | Chooses keep/discard/watch/blocked and next-cycle actions |
| Critic | 3 | `agents/critic-agent.md` | Enforces evidence discipline, loop boundary, ledger correctness, and no fake analytics |

## Pre-Dispatch

Read `../../../meta-skills/references/eval-loop-spec.md` before writing artifacts when available. In an installed skill checkout, use `${SKILLS_ROOT}/meta-skills/references/eval-loop-spec.md` as the equivalent path.

### Read Order

1. `skills-resources/marketing/loops/[slug]/program.md`
2. `skills-resources/marketing/loops/[slug]/context.md`
3. `skills-resources/marketing/loops/[slug]/results.tsv`
4. Latest files in `skills-resources/marketing/loops/[slug]/strategy/`, `execution/`, and `evals/`
5. Relevant canonical artifacts: `brand/BRAND.md`, `research/product-context.md`, `research/icp-research.md`, campaign plan if present

If `skills-resources/manifest.json` is stale or missing, run:

```bash
bun ${SKILLS_ROOT:-.claude/skills}/meta-skills/scripts/manifest-sync.ts
```

### Warm Start

When the loop exists and metric evidence is present:

```text
Found:
- loop: skills-resources/marketing/loops/[slug]/
- primary metric: [from program.md]
- baseline/prior result: [from context.md or results.tsv]
- latest strategy/execution artifact: [path]
- current evidence window: [window + source]

Proceeding to evaluate cycle [N].
```

### Cold Start / Missing Evidence

Ask one bundled question set, then stop until answered:

1. Which loop slug/path should this evaluation write into?
2. What page URL or route is being evaluated?
3. What measurement window and source should be used?
4. What is the primary metric value for this window, and what baseline should it compare against?
5. What changed this cycle? Link or summarize strategy/execution artifacts if they exist.

If the loop itself does not exist, return `NEEDS_CONTEXT` and recommend `/eval-loop` instead of asking the rest.

## Dispatch

1. Resolve loop path and next cycle number. Cycle number is `last results.tsv cycle + 1`, unless the user explicitly names a cycle that has no existing eval artifact.
2. Layer 1 parallel: Metric Ingest + Diagnosis.
3. Layer 2: Recommendation consumes both Layer 1 outputs and proposes verdict, next actions, ledger row, and learning promotion.
4. Layer 3: Critic validates artifact, ledger row, and learning update.
5. If Critic FAIL, revise once. If still failing, write no ledger row and return `BLOCKED` with missing evidence.
6. Write eval artifact and append exactly one `results.tsv` row using `append-loop-result.ts`.
7. Promote learning only when Critic allows it.
8. Run manifest sync.

## Evaluation Artifact Template

```markdown
---
skill: lp-eval
version: 1
date: YYYY-MM-DD
status: done | done_with_concerns | blocked | needs_context
summary: "[page] cycle N landing-page evaluation"
purpose: "Post-launch evidence snapshot for a landing-page eval loop"
lifecycle: evaluation
use_when: "Deciding whether to keep, discard, watch, or block the current landing-page cycle"
do_not_use_when: "Designing the next page revision without reading the latest loop context and results"
upstream: "skills-resources/marketing/loops/[slug]/program.md, context.md, strategy/, execution/, metric source"
downstream: "results.tsv, learnings.md, lp-brief next-cycle brief"
---

# [Page] Cycle N Evaluation

## Verdict

- Status: keep | discard | watch | blocked
- Confidence: high | medium | low | blocked
- Primary metric: [name] = [value] vs [baseline]
- Decision: [one sentence]

## Evidence

| Signal | Current | Baseline | Window | Source | Caveat |
|---|---:|---:|---|---|---|
| primary metric |  |  |  |  |  |

## What Changed This Cycle

- [strategy/execution artifact or operator note]

## Diagnosis

### Likely Drivers

- [driver tied to evidence]

### Confounders

- [traffic mix, seasonality, campaign change, tracking issue, sample size]

## Next Cycle Recommendation

- Keep:
- Discard:
- Watch:
- Route next work to:

## Results Row

```tsv
cycle	date	artifact	primary_metric	value	baseline	status	description
N	YYYY-MM-DD	evals/YYYY-MM-DD-cycle-N.md	metric	value	baseline	keep|discard|watch|blocked	description
```

## Learning Promotion

- Promote to `learnings.md`: yes | no
- Lesson:
- Expiry / caveat:
```

## Results Row Discipline

Append exactly one row in this shape:

```text
cycle	date	artifact	primary_metric	value	baseline	status	description
```

Rules:

- `artifact` is relative to the loop folder, e.g. `evals/2026-05-13-cycle-2.md`.
- `status` must be `keep`, `discard`, `watch`, or `blocked`.
- `description` is one sentence without tabs.
- Use the validated helper:

```bash
bun ${SKILLS_ROOT:-.claude/skills}/meta-skills/scripts/append-loop-result.ts "<loop slug>" \
  --artifact evals/YYYY-MM-DD-cycle-N.md \
  --metric "<primary metric>" \
  --value "<current value>" \
  --baseline "<baseline value>" \
  --status "<keep|discard|watch|blocked>" \
  --description "<one sentence without tabs>"
```

- Do not append a row if the Critic verdict is FAIL. Return `BLOCKED`.

## Completion

End with one status:

- `DONE` — eval artifact written, ledger row appended, critic passed
- `DONE_WITH_CONCERNS` — artifact and row written, but confidence is low/medium or confounders are material
- `NEEDS_CONTEXT` — missing loop or required metric evidence
- `BLOCKED` — contradictory data, filesystem failure, or critic failed after revision
