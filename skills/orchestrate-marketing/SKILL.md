---
name: orchestrate-marketing
description: "Stack orchestrator for marketing-skills. Reads what's already done in `brand/`, `research/`, `.agents/skill-artifacts/mkt/`, and `skills-resources/loops/`, parses your intent, and proposes the next 1–3 skills in the marketing pipeline (brand-system → campaign-plan → copywriting / lp-brief / lp-eval / seo / cold-outreach / short-form-brief → humanize / vn-tone). Use when you don't know which marketing skill to invoke, or want a guided run from brand foundation through content production and measurable evaluation. Not for executing the work itself — it routes to the skill that does. Not for cross-stack workflows (use orchestrate-meta or invoke skills directly). Renamed from `start-marketing` in v4.0.0."
argument-hint: "[free-form ask, or empty to be guided]"
allowed-tools: Read Grep Glob Bash
user-invocable: true
license: MIT
metadata:
  author: hungv47
  version: "1.0.0"
  budget: fast
  estimated-cost: "$0.03-0.10"
promptSignals:
  phrases:
    - "where do i start with marketing"
    - "i want to do marketing"
    - "help me plan marketing"
    - "what skill should i use for marketing"
    - "start marketing"
    - "begin marketing"
    - "marketing workflow"
    - "marketing pipeline"
  allOf:
    - [where, start, marketing]
    - [what, skill, marketing]
  anyOf:
    - "marketing workflow"
    - "marketing pipeline"
    - "guide me through marketing"
    - "set up brand"
    - "build a campaign"
  noneOf:
    - "code review"
    - "system architecture"
    - "user flow"
  minScore: 5
routing:
  intent-tags:
    - marketing-orchestration
    - workflow-routing
    - stack-entry-point
    - marketing-guide
  position: orchestrator
  lifecycle: pipeline
  produces:
    - .agents/experience/marketing-workflow.md
  side-effects:
    - manifest-sync
  consumes:
    - research/product-context.md
    - research/icp-research.md
    - brand/BRAND.md
    - brand/DESIGN.md
    - brand/ASSETS.md
    - .agents/skill-artifacts/mkt/campaign-plan.md
    - .agents/skill-artifacts/mkt/content/*.md
    - .agents/skill-artifacts/mkt/lp-brief/**/brief.md
    - skills-resources/loops/*/evals/*.md
    - skills-resources/loops/*/results.tsv
    - .agents/skill-artifacts/mkt/seo-*.md
    - .agents/skill-artifacts/mkt/cold-outreach/*.md
    - .agents/skill-artifacts/mkt/short-form-brief/**/brief.md
    - .agents/experience/*.md
  requires: []
  defers-to:
    - skill: brand-system
      when: "no brand foundation — entry point of the marketing pipeline"
    - skill: campaign-plan
      when: "brand done, no integrated campaign yet"
    - skill: copywriting
      when: "need specific copy — headline, hook, CTA, section"
    - skill: lp-brief
      when: "building or redesigning a landing page against construction-time conversion best practices"
    - skill: lp-eval
      when: "evaluating launched landing-page performance from analytics, experiments, recordings, or metric notes inside an eval loop"
    - skill: eval-loop
      when: "landing-page performance evaluation is requested but no measurable loop workspace exists"
    - skill: seo
      when: "search visibility — keyword research, AI search, programmatic, technical"
    - skill: short-form-brief
      when: "TikTok / Reels / Shorts video brief"
    - skill: cold-outreach
      when: "cold email, LinkedIn DM, X DM, proposal"
    - skill: humanize
      when: "AI-sounding text needs to be stripped and compressed"
    - skill: vn-tone
      when: "Vietnamese text needs native-register polish"
  parallel-with: []
  interactive: true
  estimated-complexity: low
---

# Orchestrate Marketing

*Meta — Stack orchestrator. The entry point for the marketing-skills stack when you don't know what to invoke.*

**Core Job:** read what's been done in `brand/`, `.agents/skill-artifacts/mkt/`, and `skills-resources/loops/`, infer where you are in the marketing pipeline, propose the next skill.

**Core Question:** "Given the brand foundation, the campaign state, and what you just asked, which content skill produces the highest-leverage next artifact?"

This skill does NOT execute marketing work. It is a router and progress-tracker. The actual work is done by the skill it routes you to.

---

## When To Use

- You just installed the marketing-skills plugin and don't know what to type.
- You're mid-project and forget which skill is next.
- You have a vague marketing need ("I need a landing page", "I want to send cold email", "we need to look on-brand") and want a guided routing.
- You want to resume a workflow across sessions.

## When NOT To Use

- You already know which skill to run — invoke it directly.
- You want cross-stack guidance (research + marketing combined). Use `/orchestrate-meta`.
- You want execution rather than routing.

---

## How It Works

**Tier note (`metadata.budget: fast`):** This is a pure router — no sub-agent dispatch, no critic gate. The body below runs in-line: read state, parse intent, propose next skill, await user confirmation. No `agents/` directory, no L1/L2 layers, no rewrite cycles. The premium-orchestration substrate (multi-agent + critic) lives in the skills this router proposes; running it here would be theater.

1. **State detection** — silently read `research/`, `brand/`, `.agents/skill-artifacts/mkt/`, `.agents/experience/*.md`.
2. **Intention analysis** — parse the user's free-form ask. If empty, ask one bundled scoping question.
3. **Routing decision** — propose the next 1–3 skills with rationale + cost + duration + what each produces.
4. **User confirmation** — user picks one. Skill prints the hand-off `/skill-name` command and exits. Never auto-invokes.

---

## Step 1: State Detection

**Disk snapshot** (rendered inline when `/orchestrate-marketing` is invoked — see this skill's generated support notes for the inline-shell-interpolation convention):

```
Artifacts by domain:
! `[ -d .agents/skill-artifacts ] && find .agents/skill-artifacts -mindepth 2 -name "*.md" -type f 2>/dev/null | awk -F/ '{print $3}' | sort | uniq -c | sort -rn | grep . || echo "  (no .agents/skill-artifacts/ yet)"`

Eval loops:
! `find .agents/skill-artifacts/mkt/loops -maxdepth 2 -type f 2>/dev/null | sed 's#^#  #' | head -30 | grep . || echo "  (no skills-resources/loops/ yet)"`

Top-level canonical folders present:
! `found=0; for d in research brand architecture; do [ -d "$d" ] && { echo "  $d/ ✓"; found=1; }; done; [ $found -eq 0 ] && echo "  (none yet)" || true`

Last 5 commits in this repo:
! `git log --oneline -5 2>/dev/null | grep . || echo "no git history"`
```

The `! \`...\`` lines run at slash-command invocation time and substitute the command output — so the orchestrator starts from concrete state instead of speculating about what's on disk.

Read `.agents/manifest.json` first — it is the canonical state index for all artifact metadata (status, staleness, producer, summary). Filesystem scans are a fallback only.

If `.agents/manifest.json` is missing or its `updated_at` appears stale, refresh it:
```bash
bun scripts/manifest-sync.ts
```

**Status-aware lookup:** for each artifact relevant to the marketing stack, read the manifest entry's `status` and `stale` fields to qualify the state map:

| Manifest signal | State map value |
|---|---|
| `status: done`, `stale: false` | ✅ done |
| `status: done_with_concerns` | ⚠️ done-with-concerns — surface the concern in routing output |
| `status: blocked` or `needs_context` | treat as missing |
| `stale: true` | ✅ done (stale) — propose refresh as an option, don't block |
| `frontmatter_present: false` | ✅ done (legacy, no frontmatter) — quality unknown, suggest refresh |

Staleness is derived per-artifact via the manifest's `stale_after_days` (defaults vary per artifact type — see manifest spec). Read the manifest entry's `stale` field directly; do not apply a fixed-day threshold here.

**Experience block:** also read `manifest.experience` — the `entries` count for `brand.md`, `audience.md`, and `goals.md` indicates Pre-Dispatch coverage for marketing-stack questions. Low entry counts (< 3) signal cold-start conditions.

See [`references/_shared/manifest-spec.md`](references/_shared/manifest-spec.md) for the full contract.

**Path reference / filesystem fallback** — used only when `.agents/manifest.json` doesn't exist (fresh project) or sync hasn't been run.

| Path | What it tells you |
|---|---|
| `research/product-context.md` | ICP foundation exists (cross-stack — comes from research-skills). |
| `research/icp-research.md` | Full ICP exists. |
| `brand/BRAND.md` | Brand narrative + voice + positioning defined. |
| `brand/DESIGN.md` | Visual system + design tokens defined. |
| `brand/ASSETS.md` | Per-platform asset inventory tracked. |
| `.agents/skill-artifacts/mkt/campaign-plan.md` | Integrated campaign plan exists. |
| `.agents/skill-artifacts/mkt/content/*.copy.md` | Specific copy artifacts produced. |
| `.agents/skill-artifacts/mkt/lp-brief/**/brief.md` | LP brief exists. |
| `skills-resources/loops/*/program.md` | Measurable loop exists. |
| `skills-resources/loops/*/evals/*.md` | Loop-local evaluation artifacts exist. |
| `skills-resources/loops/*/results.tsv` | Keep/discard/watch/blocked result ledger exists. |
| `.agents/skill-artifacts/mkt/seo-*.md` | SEO mode artifact (audit / ai / programmatic / competitor / aso). |
| `.agents/skill-artifacts/mkt/cold-outreach/*.md` | Outbound touch composed. |
| `.agents/skill-artifacts/mkt/short-form-brief/**/brief.md` | Video brief exists. |
| `.agents/skill-artifacts/research/short-form-research/*.md` | Short-form best-practice catalogs (from research-skills). |
| `.agents/experience/marketing-workflow.md` | Prior breadcrumb. |
| `.agents/experience/brand.md`, `audience.md`, `content.md` | Persisted cold-start answers. |

Build a state map:

```
icp-foundation:    done | partial | missing  (cross-stack)
brand-narrative:   done | partial | missing
brand-design:      done | partial | missing
campaign-plan:     done | partial | missing
content-produced:  [list of slugs that exist]
lp-brief:          [list of LP brief slugs]
eval-loops:        [list of loop slugs + latest result if any]
seo:               [list of modes run]
cold-outreach:     [list of touches]
short-form:        [list of brief slugs]
```

---

## Step 2: Intention Analysis

Match the user's argument against intent buckets:

| User says | Intent | Pipeline position |
|---|---|---|
| "set up brand", "brand identity", "voice", "logo system", "design tokens", "BRAND.md" | brand-foundation | brand-system |
| "campaign", "marketing plan", "channel strategy", "content calendar", "GTM" | campaign-planning | campaign-plan |
| "write copy", "headline", "tagline", "CTA", "hook", "section copy" | copy-production | copywriting |
| "landing page", "redesign my LP", "new landing page", "LP brief", "page architecture", "hero section", "section spec" | lp-page | lp-brief |
| "landing page analytics", "LP results", "post-launch CRO", "conversion rate changed", "should we keep this page change", "experiment results", "GA4 says", "heatmap / recordings" | lp-eval | lp-eval |
| "SEO", "keywords", "AI search", "programmatic SEO", "ASO", "search rank" | search-visibility | seo |
| "TikTok", "Reels", "Shorts", "short-form video", "video hook" | short-form-video | short-form-brief |
| "Meta ads", "Facebook ads", "Instagram ads", "retargeting ads", "primary text", "ad headline", "paid social", "ad creative copy" | paid-ads | ad-copy |
| "cold email", "LinkedIn DM", "outbound", "proposal", "first-touch" | outbound | cold-outreach |
| "this sounds AI-generated", "humanize this", "strip the slop", "make it sound human" | text-polish | humanize |
| "Vietnamese tone", "polish VN", "this Vietnamese sounds translated" | vn-polish | vn-tone |

**If empty or ambiguous**, ask:

> "What are you trying to do? Pick one or describe in your words:
>
> 1. Set up brand foundation (voice, design system)
> 2. Plan a campaign (channels, calendar, GTM)
> 3. Produce specific content (copy, LP, ad, video, email)
> 4. Evaluate existing content (LP analytics, voice check)
> 5. Polish existing text (humanize, VN tone)"

Wait for answer.

---

## Step 3: Routing Decision

Apply rules in order — first match wins.

**Foundation gates (highest priority):**
1. **No `research/product-context.md`** → defer to research-skills. "Marketing produces hollow output without audience clarity. Run `/orchestrate-research` (specifically `icp-research`) first." Stop here.
2. **No `brand/BRAND.md` AND user wants brand-foundation OR campaign-planning OR copy-production OR lp-page** → propose `brand-system`. Rationale: brand voice and design tokens feed every downstream content skill.

**Pipeline routing:**
3. **brand done + intent: campaign-planning** → propose `campaign-plan`.
4. **brand done + intent: copy-production** → propose `copywriting`. If campaign-plan missing, note: "copywriting works without it but is sharper with campaign positioning context."
5. **brand done + intent: lp-page** → propose `lp-brief`. Rationale: it owns landing-page construction and redesign briefs, with conversion principles applied before launch.
6. **Intent: lp-eval** → if a matching `skills-resources/loops/[slug]/` exists, propose `lp-eval`; otherwise propose `eval-loop` first and explain that `lp-eval` writes into an existing loop. Rationale: post-launch page evidence belongs in the loop ledger, not a one-off audit.
7. **Intent: search-visibility** → propose `seo`. Ask user which mode (audit / ai / programmatic / competitor / aso).
8. **Intent: short-form-video** → propose `short-form-brief`. Note: requires a matching `.agents/skill-artifacts/research/short-form-research/[slug].md` catalog (from research-skills); if missing, recommend `short-form-research` first.
9. **Intent: paid-ads** → propose `ad-copy`. Hard requires `research/icp-research.md`. Ask which audience-temperature (retargeting / cold) — single-temp per invocation; run twice for campaigns spanning both. Meta-only at v1.
10. **Intent: outbound** → propose `cold-outreach`. Hard requires `research/icp-research.md`.
11. **Intent: text-polish** → propose `humanize`. Trivial — no gate.
12. **Intent: vn-polish** → propose `vn-tone`. Note: post-translation only, runs on already-translated VN text.

**Ambiguity rule:** if user's intent matches 2+ buckets ("I need content for my new product"), propose 2 options with rationale. Don't pick for them.

**Polish chain:** if user is producing copy and a `.agents/experience/content.md` says brand_mode=founder OR market includes Vietnamese, mention humanize/vn-tone as the terminal step after copywriting.

---

## Step 4: Present + Confirm

Output format:

```
## Where you are

- ICP foundation: ✅ done (research/icp-research.md, 1 month old)
- Brand narrative: ✅ done (brand/BRAND.md)
- Brand design: ✅ done (brand/DESIGN.md)
- Campaign plan: ❌ missing
- Content produced: hero-copy.md, about-page.md
- LP briefs: not run
- SEO: not run
- Short-form: not run

## What you asked

"I want to plan how we go to market" → campaign-planning intent.

## Recommended next: campaign-plan

Why: brand foundation + ICP are in place. campaign-plan consumes both
and produces the channel strategy + content calendar that downstream
skills (copywriting, seo, short-form-brief, cold-outreach) hang off.

Cost: ~$1–3 · Duration: ~10 min · Produces: .agents/skill-artifacts/mkt/campaign-plan.md

Run it?  →  /campaign-plan
```

If multiple options apply, show 2–3.

---

## Step 5: Persist + Hand Off

Append to `.agents/experience/marketing-workflow.md`:

```markdown
## Session 2026-05-06

- Read state: icp ✅, brand ✅, campaign ❌, copy [hero, about], LP briefs not run
- User intent: campaign-planning
- Recommended: campaign-plan
- User confirmed: yes
```

Print hand-off line:

> Run `/campaign-plan` next. After it completes, re-run `/orchestrate-marketing` to plan the next step.

Exit.

---

## Pipeline Reference

For canonical pipeline, decision rules, per-skill catalog, and polish-chain logic, see [`./references/workflow-graph.md`](./references/workflow-graph.md).

---

## Anti-Patterns

- **Don't ignore the manifest** — always read `.agents/manifest.json` first; per-path filesystem scans are a fallback, not the default.
- **Don't bypass the icp foundation gate.** Marketing without ICP context produces generic output.
- **Don't auto-invoke** the recommended skill. Always print `/skill-name` and let the user type it.
- **Don't recommend more than 3 skills** in one proposal.
- **Don't lecture.** Show only what's relevant to where the user is.
- **Don't recommend skills outside this stack.** If intent is research or product, point at `/orchestrate-research` or `/orchestrate-product`.
- **Don't route landing-page work to deprecated heuristic audit.** `lp-brief` owns construction-time conversion best practices. `lp-eval` owns post-launch metric evidence inside an eval loop.
- **Don't conflate `copywriting` and `humanize`.** Copywriting writes new copy; humanize fixes AI-sounding existing copy. They run in sequence, not in parallel.

---

## Output

- **Inline only** — prints to conversation, no saved artifact.
- **Side effect:** appends one entry to `.agents/experience/marketing-workflow.md`.

## Status

Ends with one of:
- `DONE` — recommendation given, user confirmed, hand-off printed.
- `BLOCKED` — couldn't read state. Ask user where the project lives.
- `NEEDS_CONTEXT` — ask was empty AND no state exists. Ask scoping question.
