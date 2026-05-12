---
name: lp-optimization
description: "Deprecated heuristic landing-page audit. Use `lp-brief` to build or redesign high-converting landing pages; it now owns the conversion-principles rubric. This skill remains only for explicit best-practice teardown requests and is not true CRO unless the user supplies analytics, recordings, experiments, or conversion data. Future work should rebuild this as post-launch CRO analysis. Not for new landing pages, redesign briefs, A/B test design, or full site SEO audits (use seo)."
argument-hint: "[url or description]"
allowed-tools: Read Grep Glob Bash WebSearch WebFetch
license: MIT
metadata:
  author: hungv47
  version: "3.1.0"
  budget: deep
  deprecated: true
  replacement: "lp-brief for construction/redesign; future CRO skill for data-backed optimization"
  estimated-cost: "$1-3"
promptSignals:
  phrases:
    - "lp-optimization"
    - "heuristic lp audit"
    - "best-practice landing page teardown"
    - "quick landing page teardown"
  allOf:
    - [landing, page, teardown]
    - [heuristic, audit]
  anyOf:
    - "teardown"
    - "heuristic"
    - "best-practice"
    - "audit"
  noneOf:
    - "write copy"
    - "brand identity"
    - "redesign"
    - "page brief"
    - "new landing page"
    - "build landing page"
  minScore: 10
routing:
  intent-tags:
    - conversion-audit
    - landing-page-audit
    - page-optimization
    - cro
  position: horizontal
  lifecycle: pipeline
  produces:
    - skill-artifacts/mkt/lp-optimization.md
  consumes:
    - product-context.md
    - icp-research.md
  requires: []
  defers-to:
    - skill: lp-brief
      when: "building, redesigning, or creating a high-converting landing page brief"
    - skill: copywriting
      when: "need to write new copy, not audit existing page"
    - skill: seo
      when: "optimizing for search, not conversion"
  parallel-with:
    - seo
  interactive: false
  estimated-complexity: medium
---

# Landing Page Heuristic Audit — Deprecated Orchestrator

*Communication — Horizontal. Coordinates specialized audit agents to produce a best-practice teardown of an existing page. Deprecated as a normal pipeline step; `lp-brief` owns landing-page construction and conversion-principles gating.*

**Core Question:** "Which visible page issues violate landing-page conversion principles?"

> **Deprecation note:** This is not true CRO by itself. True optimization needs post-launch behavioral evidence: analytics, recordings, funnel dropoff, experiments, traffic-source data, or sales/support feedback. Without that evidence, this skill must label output as a heuristic teardown.

## Philosophy

The frameworks here (PAS, 4-U, social proof hierarchy) are evidence-backed defaults. They now live under `lp-brief/references/conversion/` as the construction-time rubric. This deprecated skill can still inspect an existing page against those defaults, but it must not claim optimization unless actual behavioral evidence is supplied. When your data or testing reveals a different optimal approach, follow the data.

## Critical Gates — Read First

1. **Do NOT call heuristic review optimization.** If there is no analytics/recording/experiment/conversion evidence, label the output `Heuristic teardown`, not CRO.
2. **Check message match BEFORE optimizing copy.** A perfectly written headline that doesn't match the traffic source will still bounce visitors. Message match is the first conversion gate.
3. **Form fields: every field >5 costs ~10% conversion.** This is an evidence-backed default (Unbounce/HubSpot research). Exceptions exist for high-intent enterprise traffic — but the exception must be justified, not assumed.
4. **Do NOT create new pages here.** New landing pages and redesign briefs route to `lp-brief`, which already embeds the full conversion rubric.

## Inputs Required
- Landing page URL or description of the page
- ICP research from `research/icp-research.md` (recommended — VoC language strengthens copy)
- Traffic source context (where visitors come from)

## Output
- Heuristic teardown or data-backed CRO findings, clearly labeled
- Specific copy/structure recommendations for the existing page only

## Quality Gate
Before delivering, the **critic agent** verifies:
- [ ] Headline scores >=3 out of 4 on the U's (Useful, Unique, Urgent, Ultra-specific)
- [ ] Message matches the traffic source (headline echoes the ad/link that brought them)
- [ ] One primary CTA per page (secondary CTAs don't compete)
- [ ] Trust signals appear within scroll-distance of every CTA
- [ ] Form has <=5 fields (or justified why more are needed)
- [ ] Social proof is from the last 12 months (older proof replaced or removed)
- [ ] Every audit finding includes: what was observed, which principle it violates, and a specific recommended fix
- [ ] Prioritized fix list has ICE scores with documented reasoning
- [ ] No vague recommendations ("improve the headline" — must be specific replacement text)

## Chain Position
Deprecated horizontal teardown — works with `icp-research` (audience data) and `copywriting` (copy craft). `lp-brief` is the normal landing-page build/redesign path.
**Re-run triggers:** Only when explicitly requested for a teardown, or when post-launch behavioral evidence exists and no dedicated CRO skill has been built yet.

### Skill Deference
- **Need a redesigned or new page?** → Run `lp-brief` — it owns page construction and conversion-principles gating.
- **Need craft-quality headline rewrites or CTA copy?** → Run `copywriting` for variation workflow and evaluation rubric.
- **AI pattern cleanup needed?** → Use `humanize` — this skill focuses on conversion mechanics, not voice/pattern editing.

---

## Agent Manifest

| Agent | Layer | File | Focus |
|-------|-------|------|-------|
| Hero Audit | 1 (parallel) | `agents/hero-audit-agent.md` | Headline, subheadline, hero CTA, above-the-fold assessment |
| Trust Audit | 1 (parallel) | `agents/trust-audit-agent.md` | Social proof, testimonials, credibility signals, trust hierarchy |
| CTA Audit | 1 (parallel) | `agents/cta-audit-agent.md` | All CTAs, risk reversal, form fields, conversion friction |
| UX Audit | 1 (parallel) | `agents/ux-audit-agent.md` | Navigation, mobile, load speed, cognitive load, visual hierarchy |
| Message Match | 2 (sequential) | `agents/message-match-agent.md` | Ad/email/search-to-LP message continuity |
| Prioritization | 2 (sequential) | `agents/prioritization-agent.md` | Ranks findings by conversion impact, ICE scoring |
| Critic | 2 (final) | `agents/critic-agent.md` | Quality gate — PASS/FAIL with rewrite routing |

---

## Routing Logic

Classify the task, then follow the matching route.

### Route A: Quick Audit
**When:** User wants a fast assessment of a specific concern (headline, CTA, or form) — not a full-page audit.

```
1. Pre-dispatch: Gather context (Step 0 below)
2. Dispatch 1-2 relevant agents:
   - Headline concern → hero-audit-agent
   - CTA/form concern → cta-audit-agent
   - Both → hero-audit-agent + cta-audit-agent in parallel
3. Dispatch: prioritization-agent (on selected agent outputs)
4. Dispatch: critic-agent
5. If critic returns FAIL → re-dispatch named agent(s) with feedback (max 2 cycles)
6. Deliver prioritized fix list
```

### Route B: Full Audit
**When:** User wants a comprehensive landing page conversion audit.

```
1. Pre-dispatch: Gather context (Step 0 below)
2. LAYER 1 — Dispatch IN PARALLEL:
   - hero-audit-agent
   - trust-audit-agent
   - cta-audit-agent
   - ux-audit-agent
3. MERGE: Combine all Layer 1 outputs into unified audit findings
4. LAYER 2 — Dispatch SEQUENTIALLY:
   - message-match-agent (receives merged L1 output)
   - prioritization-agent (receives message-match output)
   - critic-agent (receives prioritization output)
5. If critic returns FAIL → re-dispatch named agent(s) with feedback (max 2 cycles)
6. Deliver final audit artifact
```

### Removed Route: New Landing Page / Write Mode

New landing pages and redesigns now route to `lp-brief`. The conversion best practices that used to make write-mode useful have been moved into `lp-brief/references/conversion/` and enforced by `lp-brief`'s section-spec and conversion-critic agents.

---

## Pre-Dispatch

Run the Pre-Dispatch protocol (`meta-skills/references/pre-dispatch-protocol.md`).

**Needed dimensions:** URL or page paste, primary conversion goal, traffic source(s), traffic source copy (ad headlines, email subject, search meta), known conversion baseline if any.

**Read order:**
1. Pipeline: `research/icp-research.md` for VoC + audience belief mapping. `research/product-context.md` for product accuracy constraints.
2. Experience: `.agents/experience/{audience,goals}.md`.
3. Page itself: fetch URL or read paste.

If pipeline artifact `date` fields >30 days old, warn and recommend re-running `icp-research` (soft gate — proceed with "stale ICP" header note).

**Warm Start** (URL supplied + audience known + goal clear from invocation):

```
Found:
- page → "[URL]"
- audience → "[from icp-research.md]"
- inferred goal → "[from URL pattern: /pricing → purchase, /signup → signup, etc.]"

Need before auditing: traffic source(s) and source copy (for message-match check)?
```

**Cold Start** (URL only, no context):

```
lp-optimization audits a landing page for conversion friction. The audit's
specificity depends on knowing the goal, audience, and traffic source —
without them, recommendations stay generic.

1. **URL or paste** — page to audit. (If URL is auth-walled, paste HTML or
   screenshots of all sections.)
2. **Primary conversion goal** — signup / purchase / demo request / download
   / lead capture / other?
3. **Traffic source(s)** — paid ad / SEO / email / social / direct / referral.
   Multiple OK. Drives message-match analysis.
4. **Source copy** (for any traffic source named in Q3) — ad headlines,
   email subject lines, search meta descriptions, social post copy.
   Without this, message-match agent can only guess at coherence.
5. **Audience** — primary buyer (or point me at `research/icp-research.md`).
6. **Conversion baseline** if known — current conversion rate or volume.

Answer 1-6 (skip Q4 if no traffic sources, Q6 if unknown) in one response.
I'll dispatch the audit.
```

**Write-back:**

| Q | File | Key |
|---|---|---|
| 2. Goal | `goals.md` | `Goals — page conversion goal: [URL/route]` |
| 5. Audience | `audience.md` | `Audience — primary persona` (only if novel) |
| 6. Baseline | `goals.md` | `Goals — baseline conversion: [URL/route]` |
| 1, 3, 4. URL + traffic + source copy | (page-specific, not persisted) |

---

## Dispatch Protocol

### How to spawn a sub-agent

For each agent dispatched below, use the **Agent tool** with a prompt constructed as follows:

1. **Read** the agent instruction file (e.g., `agents/hero-audit-agent.md`) — include its FULL content in the Agent prompt
2. **Append** the brief and pre-writing context after the instructions
3. **Resolve file paths to absolute**: replace relative paths with absolute paths rooted at this skill's directory. Example: if this skill is at `/Users/you/skills/lp-optimization/`, then `references/core-principles.md` becomes `/Users/you/skills/lp-optimization/references/core-principles.md`. Tell the agent: "Read the reference file at [absolute path] for domain knowledge."
4. **Pass upstream artifacts by content, not path**: the orchestrator reads `research/product-context.md` and `research/icp-research.md` FIRST, then includes relevant excerpts (VoC quotes, pain language, product details) in the pre-writing object. Sub-agents should NOT read artifact files directly — the orchestrator curates what they need.
5. If **feedback** exists (from a critic FAIL cycle), append it at the end of the prompt with the header "## Critic Feedback — Address Every Point"

### Single-agent fallback

If multi-agent dispatch is unavailable (no Agent tool, single-agent runtime, or context constraints), execute each agent's instructions sequentially in-context:
- Layer 1: run each agent's domain instructions one at a time, writing each section
- Layer 2: apply each refinement pass to the full document in order
- Critic: self-evaluate using the critic-agent's rubric and quality gate

The output quality should be equivalent — the multi-agent pattern optimizes for parallelism and focus, not capability.

---

## Layer 1: Parallel Audit Agents

Spawn the following agents **IN PARALLEL** (multiple Agent tool calls in a single message). For each agent, follow the Dispatch Protocol above.

| Agent | Instruction File | Pass These Inputs | Reference Files to Resolve |
|-------|-----------------|-------------------|---------------------------|
| Hero Audit | `agents/hero-audit-agent.md` | brief + pre-writing | `references/core-principles.md`, `references/advanced-psychology.md` |
| Trust Audit | `agents/trust-audit-agent.md` | brief + pre-writing | `references/social-proof-trust.md` |
| CTA Audit | `agents/cta-audit-agent.md` | brief + pre-writing | `references/core-principles.md` |
| UX Audit | `agents/ux-audit-agent.md` | brief + pre-writing | `references/ux-design.md` |

**For quick audit tasks (Route A):** Dispatch only the relevant agent(s), not all four.

---

## Merge Step

After all Layer 1 agents return, assemble their outputs into a unified audit document.

### Section Order (full audit)
1. **Hero Assessment** — hero-audit-agent's headline, subheadline, and hero CTA evaluation
2. **Trust & Social Proof Assessment** — trust-audit-agent's proof inventory, gaps, and recommendations
3. **CTA & Conversion Assessment** — cta-audit-agent's CTA inventory, form audit, risk reversal, friction analysis
4. **UX & Page Experience Assessment** — ux-audit-agent's navigation, mobile, speed, cognitive load findings

### Assembly Rules
The merge is deterministic assembly, not creative synthesis. Slot each agent's output into the unified document by ownership:

| Section | Owner Agent |
|---------|-----------|
| Headline Assessment | Hero Audit |
| Subheadline Assessment | Hero Audit |
| Hero CTA Assessment | Hero Audit |
| Above-the-Fold Verdict | Hero Audit |
| Social Proof Inventory | Trust Audit |
| Recency Assessment | Trust Audit |
| Cognitive Bias Utilization | Trust Audit |
| Trust Signal Clustering | Trust Audit |
| CTA Inventory | CTA Audit |
| Form Audit | CTA Audit |
| Risk Reversal Audit | CTA Audit |
| Conversion Friction Analysis | CTA Audit |
| Navigation Assessment | UX Audit |
| Visual Hierarchy | UX Audit |
| Mobile Experience | UX Audit |
| Page Speed | UX Audit |
| Cognitive Load | UX Audit |

### Conflict Resolution
- Each agent owns specific sections (table above). If two agents mention the same element (e.g., both hero-audit and cta-audit reference the hero CTA), keep the version from the section owner.
- If hero-audit's headline assessment contradicts ux-audit's visual hierarchy assessment, note both perspectives and let the prioritization agent resolve via ICE scoring.

---

## Layer 2: Sequential Analysis

Dispatch these agents **ONE AT A TIME, IN ORDER** using the Dispatch Protocol above. Each receives the previous agent's full output as the `upstream` field.

```
message-match-agent → prioritization-agent → critic-agent
```

| Step | Agent | Instruction File | Receives |
|------|-------|-----------------|----------|
| 1 | Message Match | `agents/message-match-agent.md` | Merged Layer 1 output + traffic source data |
| 2 | Prioritization | `agents/prioritization-agent.md` | Message match output (includes all findings) |
| 3 | Critic | `agents/critic-agent.md` | Prioritization output (final document) |

Each agent returns the full document with their analysis added + a change log.

---

## Critic Gate

The critic agent returns one of two verdicts:

### PASS
The audit meets all quality standards. Deliver the critic's approved output as the final artifact.

### FAIL
The critic returns specific failures with:
- Which sections failed and why
- Specific fix instructions
- Which agent to re-dispatch

**Rewrite loop:**
1. Read the critic's failure report
2. Re-dispatch ONLY the named agent(s) with the critic's feedback attached as the `feedback` input
3. Run the modified output back through the critic
4. **Maximum 2 rewrite cycles.** After 2 failures, deliver the audit with the critic's annotations and flag to the user: "Audit scored [X] — manual review recommended on [specific sections]."

---

## Artifact Template

When saving teardown artifacts, use this frontmatter:

```yaml
---
skill: lp-optimization
version: 1
date: [today's date]
status: done | done_with_concerns | blocked | needs_context
analysis_type: heuristic_teardown | data_backed_cro
evidence_supplied: true | false
---
```

> On re-run: rename existing artifact to `[name].v[N].md` and create new with incremented version.

## Next Step

Run `copywriting` to rewrite specific sections. Run `seo` for technical search optimization. For sweeping redesigns or new pages, run `lp-brief` to spec the next iteration.

---

## Worked Example — Full Audit (Route B)

**Brief:** Heuristically audit the Acme Analytics free trial page and label findings that need behavioral evidence.
**Audience:** Engineering managers at 50-200 person companies, problem aware.
**Traffic:** Google Ads ("real-time analytics dashboard"), LinkedIn ads (cold), and organic search.

### Step 0: Pre-Dispatch
1. Conversion goal: Free trial signup
2. Audience: EMs who need real-time visibility but feel buried in tool sprawl
3. Traffic: Google Ads (warm, searched for solution), LinkedIn (cold, interrupted), organic
4. Traffic source copy: Google Ad headline: "Real-time analytics dashboard — 14-day free trial"

### Layer 1: Parallel Dispatch
--> **Hero audit agent** returns: Headline "The Best Analytics Platform for Modern Teams" scores 1/4 on 4-U. Recommends: "See every metric your team tracks — one screen, updated every 5 minutes." (4/4). 5 variations provided.
--> **Trust audit agent** returns: No testimonials above fold. Customer logos present but below fold. No recency dates on testimonials. Tier 1 proof missing entirely. Recommends: add strongest result quote near hero CTA, move 3 logos above fold, date-stamp all testimonials.
--> **CTA audit agent** returns: Hero CTA "Get Started" (no first-person, no specificity). Form has 7 fields (name, email, company, role, size, phone, referral source). No risk reversal near any CTA. Recommends: "Start My Free Trial" + cut to 3 fields + "14-day free trial. No credit card."
--> **UX audit agent** returns: Full site nav present (7 links). Mobile CTA below fold. Page load 3.8s due to uncompressed hero image. No sticky CTA on mobile.

### Merge (orchestrator assembles)
Slots all Layer 1 outputs into unified audit: Hero Assessment -> Trust Assessment -> CTA Assessment -> UX Assessment.

### Layer 2: Sequential Dispatch
--> **Message match agent** receives merged output + traffic source data. Finds: Google Ad promises "real-time" and "dashboard" — headline mentions neither. Ad says "14-day free trial" — page says "Get Started" with no trial mention. LinkedIn ad not checked (`[BLOCKED: no ad copy provided]`). Organic meta title partially matches. Scores: Google Ads = Mismatch, Organic = Partial Match.
--> **Prioritization agent** receives message-match output. Consolidates all findings. Ranks by ICE:
  1. Rewrite headline for message match (ICE: 9.3)
  2. Cut form from 7 to 3 fields (ICE: 8.7)
  3. Add risk reversal near hero CTA (ICE: 8.0)
  4. Move testimonial above fold (ICE: 7.0)
  5. Remove navigation links (ICE: 6.7)
  6. Compress hero image for speed (ICE: 6.3)
  7. Add sticky CTA on mobile (ICE: 6.0)

### Dispatch: Critic Agent --> PASS
Scores: Completeness 5, Specificity 5, Evidence 4, Prioritization 5, Actionability 5. Average: 4.8/5. All quality gate items checked. Approved.

### Final Artifact

```markdown
---
skill: lp-optimization
version: 1
date: 2026-03-17
status: done
analysis_type: heuristic_teardown
evidence_supplied: false
---

# LP Audit — Acme Analytics Free Trial Page

## Headline Assessment

Current: "The Best Analytics Platform for Modern Teams"
4-U Score: 1/4 (Useful only — not Unique, not Urgent, not Ultra-specific)

Recommended: "See every metric your team tracks — one screen, updated every 5 minutes."
4-U Score: 4/4

## Message Match
Traffic source: Google Ads — "real-time analytics dashboard"
Current headline mentions neither "real-time" nor "dashboard" → broken match.
Fix: Echo "real-time dashboard" in headline.

## Social Proof Audit
- No testimonials above fold → add strongest result quote near hero CTA
- Customer logos present but below fold → move 3 logos above fold

## Form Audit
Current: 7 fields (name, email, company, role, size, phone, referral source)
Recommended: 3 fields (name, email, company) — collect rest via progressive profiling after signup
Expected impact: ~40% form completion improvement

## Priority Action Items
| # | Fix | Expected Impact | Effort | ICE |
|---|-----|----------------|--------|-----|
| 1 | Rewrite headline for message match | High | Low | 9.3 |
| 2 | Cut form to 3 fields | High | Low | 8.7 |
| 3 | Add risk reversal near hero CTA | High | Low | 8.0 |
| 4 | Move testimonial above fold | Medium | Low | 7.0 |
| 5 | Remove navigation links | Medium | Low | 6.7 |
| 6 | Compress hero image | Medium | Low | 6.3 |
| 7 | Add sticky CTA on mobile | Medium | Medium | 6.0 |
```

---

## Anti-Patterns

**Calling heuristic review CRO** — A best-practice teardown can find obvious friction, but it cannot prove what is stopping conversion. **INSTEAD:** Label the output heuristic unless analytics, recordings, experiments, or conversion data were supplied.

**Building pages here** — Using this deprecated skill to create a new page or redesign brief. **INSTEAD:** Run `lp-brief`; it owns construction-time conversion best practices.

**Testing design before copy** — A/B testing button colors or layouts when the headline doesn't pass the 4-U test. Copy is responsible for 80%+ of conversion impact. **INSTEAD:** Fix the words before the visuals. Follow the testing priority order: headlines > offers > CTAs > layout > forms.

**Ignoring mobile experience** — Optimizing for desktop when 60%+ of traffic is mobile. **INSTEAD:** Check thumb zone placement for CTAs, ensure forms are completable one-handed, verify load time on mobile networks, add sticky CTA for long pages.

**Social proof without specificity** — "Trusted by thousands of companies" is weaker than "Used by 3,247 teams including Stripe and Notion." **INSTEAD:** Every social proof element must include specific numbers, named companies, or measurable results.

**Multiple competing CTAs** — Primary CTA, secondary CTA, sidebar CTA, and exit-intent popup all fighting for attention. **INSTEAD:** One primary CTA per page — secondary CTAs must not visually compete. Audit the CTA hierarchy.

**Vague audit recommendations** — "Improve the headline" or "Add social proof" without specifics. **INSTEAD:** Every recommendation must include: what was observed, which principle it violates, and exact replacement text or action.

**Skipping message match** — Optimizing page copy without checking if it matches the traffic source. **INSTEAD:** Always verify message match first. A perfectly written headline that doesn't match the ad will still bounce visitors.

---

## Completion Status

Every run ends with explicit status:
- **DONE** — teardown complete (Route A or B), findings prioritized by ICE, critic PASS, recommendations specific and actionable; `analysis_type` states whether evidence made it data-backed
- **DONE_WITH_CONCERNS** — teardown delivered but with limited evidence (page rendered but analytics unavailable, traffic source unclear); recommendations note evidence gaps
- **BLOCKED** — page URL inaccessible or behind auth wall the agent cannot pass; needs user-supplied screenshots or paste
- **NEEDS_CONTEXT** — audit useful but `research/icp-research.md` missing for audience-fit checks; recommend `icp-research` or proceed with reduced scope

---

## Agent Files

### Sub-Agent Instructions (agents/)
- [agents/hero-audit-agent.md](agents/hero-audit-agent.md) — Headline, subheadline, hero CTA, above-the-fold
- [agents/trust-audit-agent.md](agents/trust-audit-agent.md) — Social proof, testimonials, credibility signals
- [agents/cta-audit-agent.md](agents/cta-audit-agent.md) — CTAs, risk reversal, form fields, conversion friction
- [agents/ux-audit-agent.md](agents/ux-audit-agent.md) — Navigation, mobile, speed, cognitive load
- [agents/message-match-agent.md](agents/message-match-agent.md) — Traffic source message continuity
- [agents/prioritization-agent.md](agents/prioritization-agent.md) — ICE scoring, testing roadmap
- [agents/critic-agent.md](agents/critic-agent.md) — Quality gate, PASS/FAIL, rewrite routing
- [agents/_template.md](agents/_template.md) — Reusable template for creating new agent files

### Shared References (references/)
- [references/core-principles.md](references/core-principles.md) — Headlines, value props, CTAs, forms, message match, PAS
- [references/social-proof-trust.md](references/social-proof-trust.md) — Social proof hierarchy, biases, trust signals
- [references/ux-design.md](references/ux-design.md) — Visual hierarchy, mobile optimization
- [references/advanced-psychology.md](references/advanced-psychology.md) — Headline formulas, close sequences, pricing, urgency
- [references/testing-optimization.md](references/testing-optimization.md) — A/B testing, tracking
- [references/implementation-checklist.md](references/implementation-checklist.md) — Pre-launch checklists

**Sources:** [CopyHackers](https://copyhackers.com), [CXL](https://cxl.com), [Unbounce](https://unbounce.com/landing-page-articles/)
