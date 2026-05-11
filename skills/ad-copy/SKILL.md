---
name: ad-copy
description: "Writes and evaluates Meta paid-ad copy — retargeting (warm audiences) and cold-traffic (subscription-app primary; cross-vertical with caveats). Audience-temperature-aware framing (warm-objection map vs cold-objection map), hard char-cap enforcement, policy/claim compliance, and 6-dimension rubric scoring. Produces `.agents/skill-artifacts/mkt/ad-copy/[audience-temp]-[date]-[slug].md` (+ `.rationale.md` + `.critic-score.md`). One artifact per audience-temp — run twice for campaigns spanning both. Meta-only at v1 (Google RSA / LinkedIn / TikTok Ads reserved for future expansion). Not for landing-page headlines (use copywriting). Not for cold-outreach DMs (use cold-outreach). AI-sounding cleanup: humanize runs as terminal pass."
argument-hint: "[audience-temp + offer + creative-format, e.g. 'cold-traffic / 14-day trial / dedicated']"
allowed-tools: Read Grep Glob Bash WebSearch WebFetch
license: MIT
metadata:
  author: hungv47
  version: "1.0.0"
  budget: deep
  estimated-cost: "$1-2"
promptSignals:
  phrases:
    - "ad copy"
    - "meta ads"
    - "facebook ads"
    - "instagram ads"
    - "paid social"
    - "retargeting ads"
    - "primary text"
    - "ad headline"
    - "creative copy"
    - "ad creative"
  anyOf:
    - "meta ads"
    - "facebook ads"
    - "instagram ads"
    - "paid ads"
    - "retargeting"
    - "ad copy"
    - "primary text"
  allOf:
    - [write, ad]
  noneOf:
    - "google ads"
    - "linkedin ads"
    - "tiktok ads"
    - "search ads"
    - "youtube ads"
  minScore: 6
routing:
  intent-tags:
    - paid-ads
    - meta-ads
    - facebook-ads
    - instagram-ads
    - ad-copy
    - retargeting-ads
    - cold-traffic-ads
  position: horizontal
  lifecycle: pipeline
  produces:
    - skill-artifacts/mkt/ad-copy/[audience-temp]-[date]-[slug].md
    - skill-artifacts/mkt/ad-copy/[audience-temp]-[date]-[slug].rationale.md
    - skill-artifacts/mkt/ad-copy/[audience-temp]-[date]-[slug].critic-score.md
  consumes:
    - product-context.md
    - icp-research.md
    - skill-artifacts/mkt/campaign-plan.md
    - brand/BRAND.md
  requires: []
  defers-to:
    - skill: copywriting
      when: "need landing page headline, section copy, or tagline (not a paid-ad asset)"
    - skill: campaign-plan
      when: "need channel mix or campaign-level strategy across paid/owned/earned"
    - skill: cold-outreach
      when: "outbound DM or email composition (not paid placement)"
    - skill: lp-brief
      when: "redesigning the landing page the ad clicks to"
  parallel-with: []
  interactive: false
  estimated-complexity: heavy
---

# Ad Copy — Orchestrator

*Communication — Horizontal. Ready-to-publish Meta ad copy across retargeting (warm) and cold-traffic (cold) audiences. Multi-agent strategy → draft → format → voice → critic → humanize pipeline.*

**Core Question:** "Would this ad still make sense if the platform stripped every claim that isn't substantiated by a named entity or measured number?"

## Philosophy

Ad copy is not landing-page copy. It runs in 3 seconds of scrolling attention, against an algorithm that ranks creative as the primary targeting lever. Every variant has to earn its impression — warm audiences want fit/credibility/timing, cold audiences want awareness/positioning, and Meta's policy review will auto-reject claims it can't substantiate.

The orchestrator separates strategy from craft: strategist picks angle + audience-temperature framing + creative format (dedicated vs repurposed-UGC, with spend-ceiling warning attached), composer drafts hero + 2 variants applying Meta-specific char caps, format-checker enforces hard caps + policy compliance, voice-auditor strips vendor-speak + AI tells, critic scores a 6-dimension rubric, `humanize` is the terminal pass. Output is ready-to-publish (one hero + two variants for one audience-temperature) plus rationale and scorecard.

## Scope Boundary

**In scope:**
- Meta paid-ad copy (Facebook + Instagram): primary text, headline, description
- Audience-temperatures: retargeting (warm — IG engagers / IG followers / FB page engagers) and cold-traffic (broad targeting, post-Andromeda)
- Hero + 2 variants per invocation, single audience-temperature per artifact
- Creative formats: dedicated ad creative (carries scaled spend) and repurposed-UGC (capped at lower spend ceiling — surfaced with warning)
- Subscription-app cold-traffic playbook (trial-start optimization, in-creative retargeting)
- Cross-vertical applicability for cold-traffic structural choices (DTC ecom, B2B SaaS) per the matrix in `references/ad-intelligence/meta-cold-traffic.md`

**Out of scope:**
- Google RSA (15 headlines + 4 descriptions per ad — different mechanics; refs not pre-staged)
- LinkedIn ads, TikTok ads, Reddit ads, YouTube pre-roll (refs not pre-staged)
- Audience setup / pixel setup / budget pacing (your Meta Ads Manager workflow)
- Landing page copy (use `copywriting` or `lp-brief`)
- Outbound DMs or cold emails (use `cold-outreach`)
- Creative production (asset generation, video editing, voiceover) — this skill produces the copy spec only
- Multi-campaign sequence orchestration (compose one audience-temperature at a time)

## Inputs Required

**Always:**
- **Audience temperature**: `retargeting | cold` — drives the whole strategist tree (warm objection map vs cold objection map; different creative posture; different CTA tier)
- **Offer**: what the ad sends people to — trial, demo, purchase, lead form, app install
- **Creative format**: `dedicated | repurposed-ugc` — dedicated carries the higher spend ceiling per `creative-cadence.md`; repurposed-UGC is capped (~$10-15K/day per cali-apps source). Composer surfaces ceiling warning at draft time if `repurposed-ugc` is picked.

**Strongly recommended (skill asks if missing and audience-temp is `retargeting`):**
- **Warm-audience source**: which of the three retargeting audiences this ad targets (IG engagers / IG followers / FB page engagers). The three have different intent levels — followers can take direct offers, engagers need more warm-up.
- **Recent organic content**: last 4-6 organic posts (or themes) the audience saw. Offer–content consistency is a documented warm-audience failure mode per `meta-retargeting.md` §3.

**Strongly recommended (skill asks if missing and audience-temp is `cold`):**
- **Conversion event**: `trial_start | purchase | lead | install` — for subscription apps, trial-start is the only signal that lands inside Apple's 24h privacy window (per `meta-cold-traffic.md` §3). Recommending purchase optimization on a 3-day trial is an auto-fail anti-pattern.
- **Production model**: `in-house | affiliate-creator | external-freelance` — informational, drives the rationale's variant-volume sustainability note.

**Always (proof side):**
- **Available proof**: list ALL candidates — named customers, measured outcomes, named research, specific numbers. Composer's variant pass picks one primary anchor per variant (variants must differ in angle, not just paraphrase).

**Optional:**
- **LP description**: 1-2 sentences on what the landing page promises. Critic's CTA-LP-match dimension scores against this; if missing, that dimension downgrades to "scope: ad copy alone" and the rubric warns about message-match risk.
- **Brand voice anchors** auto-consumed from `brand/BRAND.md` if present
- **ICP context** auto-consumed from `research/icp-research.md` if present
- **Product context** auto-consumed from `research/product-context.md` if present

## Output

Writes to `.agents/skill-artifacts/mkt/ad-copy/`:

| File | Content |
|------|---------|
| `[audience-temp]-[date]-[slug].md` | Hero (primary text + headline + description) + Variant A + Variant B, ready-to-publish |
| `[audience-temp]-[date]-[slug].rationale.md` | Angle, audience-temperature framing, creative format, production model, anchor proof, anti-patterns avoided |
| `[audience-temp]-[date]-[slug].critic-score.md` | Rubric scorecard across 6 dimensions, per-variant scores, terminal-humanize regression check |

Slug pattern: `retargeting-2026-05-11-trial-app-followers` or `cold-2026-05-11-app-install-dedicated`. The audience-temp prefix makes campaign-spanning runs land in distinct files even on the same day.

### Artifact Frontmatter (required)

Every `[audience-temp]-[date]-[slug].md` carries:

```yaml
---
skill: ad-copy
version: 1
date: YYYY-MM-DD
status: done | done_with_concerns | blocked | needs_context
network: meta   # v1 hard-locked to meta; widened in future versions
surface: meta-primary-text | meta-headline | meta-description | meta-full-ad
audience_temp: retargeting | cold
creative_format: dedicated | repurposed-ugc
production_model: in-house | affiliate-creator | external-freelance
conversion_event: trial_start | purchase | lead | install | view-content
critic_total: N/60
critic_per_variant:
  hero: N/60
  variant_a: N/60
  variant_b: N/60
---
```

## Quality Gate

Before delivering, the **critic agent** verifies (6 dimensions, 0-10 each):

- [ ] **Hook scroll-stop** ≥ 6 — first line of primary text + headline can stop a thumb; pattern-interrupt present; no generic openers ("Looking for a better way?", "Are you tired of...")
- [ ] **Component-char compliance** ≥ 6 — primary text uses the ~125-char visible-before-truncation window effectively; headline lands in ≤40 chars; description in ≤30 chars; hard caps respected (3,000 char primary text, 40 char headline, 30 char description per Meta spec)
- [ ] **CTA-LP match** ≥ 6 — ad promise = LP promise (no bait-and-switch); CTA verb matches LP primary action; if LP description not provided, dim downgrades with "scope: ad copy alone" annotation
- [ ] **Pattern-interruption density** ≥ 6 — hero + 2 variants are genuinely distinct (different angle archetype, different anchor proof OR different audience-objection addressed); surface-level paraphrase of the same angle = FAIL
- [ ] **Policy + claim compliance** ≥ 6 — no banned claim wording (health/finance/political — see `references/policy-floor.md`); every measured claim has a substantiating source or is hedged ("up to", "in our study", "see disclaimer"); no fabricated stats; no protected-class targeting language
- [ ] **Specificity** ≥ 6 — Specificity Floor of ≥2 verifiable specifics per variant (named entity OR named number-with-context OR named research); generic flavor ("leading", "trusted", "proven") does not count

**Gate:** Total ≥ 42/60 **AND every dim ≥ 6**. Total 42-47 with all dims ≥ 6 = PASS as `DONE_WITH_CONCERNS`. Any dim < 6 = FAIL regardless of total.

Below threshold → full Layer 2 chain (composer → format-checker → voice-auditor → critic) re-runs with feedback (max 2 cycles).

After critic PASS, `humanize` is the terminal pass on each variant. Orchestrator then re-runs critic's **Specificity dimension only** on humanized text — if Specificity drops ≥2 OR any named entity/number present pre-humanize is absent post-humanize, revert to critic-approved draft. Protects the specificity anchor.

## Chain Position

Horizontal — runs standalone or called by `campaign-plan` when paid is part of a broader mix.

**Re-run triggers:** offer changes; LP changes materially; creative fatigue detected (CTR < 1.5% after 48h per `creative-cadence.md`); audience structure changes (new warm-audience source added); platform policy change reported (e.g., Meta tightens health-claim review).

### Skill Deference
- **Landing page headline or section copy?** → `copywriting` (different surface mechanics — LP has scroll, ad doesn't)
- **Outbound DM or cold email?** → `cold-outreach` (different trust model, different framework set)
- **Redesigning the LP this ad clicks to?** → `lp-brief` first; this skill consumes its output
- **Multi-channel campaign across paid/owned/earned?** → `campaign-plan` first
- **No ICP, or ICP stale (>30 days)?** → `icp-research` first (research-skills)
- **Google RSA / LinkedIn / TikTok Ads?** → NOT this skill v1. Refs not pre-staged; would force fabrication.

---

## Agent Manifest

| Agent | Layer | File | Focus |
|-------|-------|------|-------|
| Strategist | 1 (solo) | `agents/strategist.md` | Picks angle archetype, audience-temperature framing (warm-obj-map vs cold-obj-map), CTA verb, creative-format implications, anchor-proof slot per variant. Surfaces spend-ceiling warning if `creative_format=repurposed-ugc`. |
| Composer | 2 (sequential) | `agents/composer.md` | Drafts hero (primary text + headline + description) + Variant A + Variant B, each with a distinct anchor. Applies Meta-specific char-cap discipline (visible-window economy). |
| Format Checker | 2 (sequential, hard-gate) | `agents/format-checker.md` | Hard-bounces on Meta char-cap violation, policy banned-phrase hit, missing substantiation on measured claims. PASS / REVISION_REQUIRED / FORMAT_FAIL. |
| Voice Auditor | 2 (sequential) | `agents/voice-auditor.md` | Peer-voice audit — strips vendor-speak, AI tells, em-dashes, generic "leading provider" language. Same auto-fail discipline as cold-outreach voice-auditor, scoped to ad copy. |
| Critic | 2 (sequential, gate) | `agents/critic.md` | Rubric scoring across 6 dimensions, PASS/FAIL with per-variant scorecards. Reads `references/rubric.md` for bands + `references/policy-floor.md` for banned wording + `references/anti-patterns.md` for structural auto-fails. |

### Shared References

**Ad-intelligence (per-surface practitioner sources):**
- `references/ad-intelligence/meta-retargeting.md` — warm-audience system (3 custom audiences, warm-vs-cold objection map, budget pacing) [clem-2026, secondary]
- `references/ad-intelligence/meta-cold-traffic.md` — subscription-app cold playbook (2-campaign structure, trial-start optimization, 3-layer attribution, cross-vertical matrix) [cali-apps, secondary]
- `references/ad-intelligence/creative-cadence.md` — volume + kill-speed + budget split + dedicated-vs-repurposed creative [simplr-comment, paid-ads-thresholds, cali-apps-creative — confidence mixed; see §8]

**Rubric + craft references:**
- `references/rubric.md` — 6-dimension rubric with 0-2 / 3-5 / 6-8 / 9-10 bands and per-dim auto-fail conditions
- `references/policy-floor.md` — Meta policy banned-claim wording (health, finance, political, protected class) + substantiation hedging patterns
- `references/anti-patterns.md` — AI tells, ad-specific fabrication tells, ceiling-warning triggers, banned phrase list
- `references/examples.md` — 4 worked examples (strong-retargeting / weak-retargeting / strong-cold / weak-cold) with critic scorecards
- `references/format-spec.md` — Meta char caps (hard + soft) per surface, visible-window economics, hashtag/emoji norms

---

## Routing Logic

Single route — no reply mode (paid ads don't have an inbound channel). Optional `called-by-campaign-plan` mode receives campaign context inline.

### Route A: Compose (Single Audience-Temperature)

**When:** User wants hero + 2 variants for one audience-temperature.

```
1. Pre-dispatch: Gather context (Step 0)
   - Audience-temp missing → ask explicitly (no fallback — drives the whole tree)
   - Offer missing → BLOCK (composer fails without a destination)
   - Creative-format missing → ask; default `dedicated`; warn on `repurposed-ugc` ceiling
   - Cold-traffic + subscription-app + conversion_event=purchase → soft warn per cold-traffic §3 (Apple 24h signal); recommend trial-start; proceed if user insists with `done_with_concerns`
   - Retargeting + no warm-audience-source specified → ask which of the three retargeting audiences (IG engagers / IG followers / FB page engagers)
2. LAYER 1 — strategist SOLO:
   - picks angle archetype + audience-temperature framing + CTA verb per variant
   - assigns anchor-proof slot to hero / variant A / variant B (each must be DISTINCT — no repeated anchor)
   - surfaces spend-ceiling warning if creative_format=repurposed-ugc
3. LAYER 2 — SEQUENTIAL:
   - composer (strategy brief → hero + 2 variants)
   - format-checker (Meta char caps + policy banned-phrase + substantiation gate)
   - voice-auditor (strip vendor-speak + AI tells + em-dashes)
   - critic (6-dim rubric, per-variant scores)
4. Critic FAIL → re-dispatch FULL Layer 2 chain with feedback (max 2 cycles). Never feed critic a raw composer draft without format-checker + voice-auditor between.
4a. Format-checker FORMAT_FAIL (second pass, hard caps still violated) → escalate to user; do not consume a critic cycle.
4b. Format-checker REVISION_REQUIRED on policy/substantiation → re-dispatch composer with the named violation; do not consume a critic cycle.
5. TERMINAL: invoke `humanize` per variant with `content-type: "ad-creative"` (Full strip, Full voice, 0-10% compression — ad copy is already tight; further compression kills specificity)
6. POST-HUMANIZE REGRESSION: re-run critic's Specificity dim only per variant. Drops ≥2 OR any named entity/number absent post-humanize → revert to critic-approved variant.
7. Write artifacts to `.agents/skill-artifacts/mkt/ad-copy/[audience-temp]-[date]-[slug].md` (+ .rationale.md + .critic-score.md)
8. Deliver hero + 2 variants + rationale inline; show scorecard only if user asks or any dim scored 6-7 OR if creative_format=repurposed-ugc (variant-level ceiling warning prominent in artifact)
```

### Route B: Called by Another Skill

**When:** Invoked by `campaign-plan` for paid touches in a broader campaign.

```
1. Pre-dispatch: read campaign context from calling skill's artifact
2. Execute Route A per audience-temperature requested (one invocation per temp — not stacked)
3. Return annotated hero + 2 variants + rationale to calling skill
```

---

## Pre-Dispatch

Run the Pre-Dispatch protocol (`meta-skills/references/pre-dispatch-protocol.md`).

**Needed dimensions:** audience-temp (retargeting / cold), offer (destination + value prop), creative-format (dedicated / repurposed-ugc), conversion-event (trial-start / purchase / lead / install), production-model (in-house / affiliate-creator / external-freelance), available-proof (list of named candidates), LP-description (optional but recommended).

**Read order:**
1. Pipeline: `research/product-context.md`, `research/icp-research.md`, `.agents/skill-artifacts/mkt/campaign-plan.md`, `brand/BRAND.md`. Read if present, do not block on missing.
2. Experience: `.agents/experience/{audience,product,business,brand}.md`.

If `icp-research.md` / `product-context.md` >30 days old, warn and recommend re-running `icp-research` (soft gate — proceed with "stale ICP" header note in rationale).

**Warm Start** (audience-temp supplied + ICP exists + brand in context + offer specified):

```
Found:
- ICP context → "[primary persona from icp-research.md]"
- brand voice → "[from brand/BRAND.md voice section]"
- product proof → "[from product-context.md]"

Need before dispatching: creative-format (dedicated | repurposed-ugc),
conversion event, and at least 2 named proof points (case study / number /
named customer / measured outcome).
```

**Cold Start** (no upstream context, fresh ad-copy run):

```
ad-copy writes Meta paid-ad copy that respects audience temperature, hard
char caps, and Meta's policy review. The composer needs precise inputs —
generic prompts produce generic ads that Meta will rank low or auto-reject.

1. **Audience temperature** — retargeting (warm — IG engagers / IG followers /
   FB page engagers) OR cold-traffic (broad targeting, post-Andromeda)?
2. **Offer** — what does the ad send people to? (free trial / demo / purchase
   / lead form / app install — be specific on duration, price, hook)
3. **Creative format** — dedicated ad creative (carries scaled spend, $40K+/day
   per cali-apps) OR repurposed-UGC (capped ~$10-15K/day spend ceiling)?
4. **Conversion event** — trial_start (subscription apps; lands inside Apple
   24h signal window) / purchase / lead / install / view-content?
5. **Production model** — in-house / affiliate-creator (Tribe + WhatsApp
   model from cali-apps) / external-freelance? (informational)
6. **Proof** — list ALL candidates: named customers, measured outcomes,
   named research, specific numbers. Composer picks one anchor per variant
   (hero + 2 variants = 3 distinct anchors). No proof = uncheckable claims
   = critic fail.
7. **LP description (optional but recommended)** — 1-2 sentences on what
   the landing page promises. Critic CTA-LP-match dim scores against this.

If audience-temp=retargeting: which warm audience (IG engagers / IG followers /
FB page engagers)? What were the last 4-6 organic posts the audience saw?
(offer–content consistency check per meta-retargeting §3).

Answer 1-7 in one response (plus the retargeting follow-ups if applicable).
I'll dispatch.
```

### Missing-Input Hard Blocks

These dimensions cannot be substituted via fallback — composer fails without them:

- **Audience-temp missing** → ask explicitly; no fallback (drives the entire strategist tree)
- **Offer missing** → BLOCK (composer needs a destination)
- **Proof missing + no product-context** → ask for at least 2 named candidates; **BLOCK** if user insists "no proof" (uncheckable claims fail Specificity Floor)
- **Cold-traffic + subscription-app + conversion_event=purchase + 3-day-trial** → soft warn per `meta-cold-traffic.md` §3; recommend trial-start; proceed as `done_with_concerns` only if user insists
- **Creative-format = repurposed-ugc + target daily-spend > $15K** → soft warn per `creative-cadence.md` §5; ceiling will be hit; proceed as `done_with_concerns` only if user accepts

**Write-back:**

| Q | File | Key |
|---|---|---|
| 2. Offer | `product.md` | `Product — current offer` (durable across ad-copy + lp-brief + cold-outreach runs) |
| 6. Proof points | `product.md` | `Product — proof points` (durable across ad-copy + lp-brief + cold-outreach + copywriting) |
| 1, 3, 4, 5, 7. Audience-temp + creative-format + conversion-event + production-model + LP-description | (run-specific, lives in the rationale.md artifact) |

If `research/icp-research.md` exists, pull VoC pain language. If `research/product-context.md` exists, pull voice adjectives + accuracy constraints. If `brand/BRAND.md` exists, pull voice anchors and banned-language list.

---

## Dispatch Protocol

### How to spawn a sub-agent

Use the **Agent tool** (general-purpose or Explore) with a prompt built as:

1. **Read** the agent instruction file (e.g., `agents/strategist.md`) — include FULL content in the Agent prompt
2. **Append** pre-writing context + any prior layer's output
3. **Resolve paths to absolute** — rooted at this skill's directory. Example: `references/ad-intelligence/meta-retargeting.md` → `<skill-root>/references/ad-intelligence/meta-retargeting.md` (`<skill-root>` = install path, typically `marketing-skills/skills/ad-copy/`).
4. **Pass upstream artifacts by content, not path** — orchestrator reads `research/*.md`, `brand/*.md`, and `.agents/skill-artifacts/mkt/*.md` FIRST, includes excerpts (VoC quotes, voice adjectives, brand banned-words) in pre-writing. Sub-agents do NOT read artifact files directly.
5. If **feedback** exists (critic FAIL or format-checker REVISION_REQUIRED), append at end with header "## Resolver Feedback — Address Every Point"

### Single-agent fallback

If multi-agent dispatch unavailable, run each agent's instructions sequentially in-context:
- Layer 1: strategist
- Layer 2: composer → format-checker → voice-auditor → critic in order
- Terminal humanize: apply humanize instructions in-context if skill unreachable

Quality is equivalent — multi-agent optimizes parallelism and focus, not capability. (For this skill, Layer 1 is solo and Layer 2 is sequential, so the parallelism advantage is small.)

---

## Layer 1: Strategy (Compose Route)

Strategist runs SOLO. There's no parallel signal-analyst-equivalent because the audience-temperature decision is user-supplied, not derived from a signal score.

| Agent | Instruction File | Pass These Inputs | Reference Files to Resolve |
|-------|-----------------|-------------------|---------------------------|
| Strategist | `agents/strategist.md` | pre-writing (all) + audience-temp + offer + creative-format + conversion-event + available-proof + LP-description | `references/ad-intelligence/meta-retargeting.md` (if audience-temp=retargeting) OR `references/ad-intelligence/meta-cold-traffic.md` (if audience-temp=cold), `references/ad-intelligence/creative-cadence.md`, `references/anti-patterns.md` |

Wait for output. Extract:
- `angle_archetype` per variant (each must differ — 3 distinct archetypes for hero + 2 variants)
- `anchor_proof` per variant (each must differ — no repeated entity/number across variants)
- `cta_verb` per variant
- `ceiling_warning` (set if creative_format=repurposed-ugc)
- `policy_flags` (set if offer hits health/finance/political — composer + format-checker pre-warn)

---

## Layer 2: Sequential Refinement

Agents run in order. Each receives the prior agent's output.

| Order | Agent | Instruction File | Input | Reference Files |
|-------|-------|-----------------|-------|-----------------|
| 1 | Composer | `agents/composer.md` | Strategy brief | `references/format-spec.md`, `references/ad-intelligence/{audience-temp}.md` |
| 2 | Format Checker | `agents/format-checker.md` | Composer draft + composer's claim list | `references/format-spec.md`, `references/policy-floor.md` |
| 3 | Voice Auditor | `agents/voice-auditor.md` | Format-checker-passed draft | `references/anti-patterns.md` |
| 4 | Critic | `agents/critic.md` | Voice-audited draft + `pre_writing` verbatim + strategy brief | `references/rubric.md`, `references/anti-patterns.md`, `references/policy-floor.md` |

### Format-Checker Hard Gate (between composer and voice-auditor)

Format-checker is a HARD gate, not a critic dim — it bounces on:
- Any Meta char-cap violation (40 char headline / 30 char description / 3,000 char primary text)
- Any banned policy phrase (see `references/policy-floor.md`)
- Any measured claim without a substantiating source from `pre_writing.Q6.available_proof[]`

`PASSED` → proceed to voice-auditor. `REVISION_REQUIRED` → re-dispatch composer with violation list (does not consume a critic cycle). `FORMAT_FAIL` (second pass still violating) → escalate to user with violations enumerated.

### Critic Gate

Critic returns:
- **PASS** — scorecard → proceed to terminal humanize
- **FAIL** — scorecard + rewrite feedback → re-dispatch FULL Layer 2 (composer → format-checker → voice-auditor → critic) with feedback (cycle 1 or 2)

After 2 failed critic cycles, surface: "Critic couldn't reach threshold across 2 rewrite cycles — here's the best draft + per-variant scorecard + what's blocking. Your call."

---

## Terminal Pass: Humanize

After critic PASS, invoke `humanize` on each variant (hero / A / B) independently:

1. Spawn agent with humanize's `SKILL.md` content
2. Pass:
   - Final variant text (primary text + headline + description as one unit)
   - `content-type: "ad-creative"` (humanize's Content Type Calibration: ad copy already runs ≤125 chars visible — Full strip on AI tells, Full voice injection, **0-10% compression cap** because further compression strips specificity that critic just scored)
   - Audience-temp (humanize voice-extraction reads brand voice differently for warm vs cold register)
   - `protected_tokens`: every named entity + number + URL in the critic-approved variant (humanize must not remove or paraphrase)
3. Receive humanized variant
4. **Regression check (automatic, not judgment):** re-run critic's **Specificity dimension only** on the humanized variant. Revert to critic-approved variant if any of:
   - Specificity drops ≥ 2 points
   - Any named entity pre-humanize absent post-humanize
   - Any concrete number pre-humanize absent post-humanize
   - Any URL pre-humanize absent post-humanize
5. Otherwise ship humanized variant.

Terminal pass is **automatic**, not opt-in. AI-sounding ad copy is the second-biggest reason ads get scrolled past (creative fatigue is first per `creative-cadence.md`).

---

## Anti-Patterns (Orchestrator-Level)

| Anti-pattern | Why it fails | Guardrail |
|--------------|--------------|-----------|
| Cold-creative reused as retargeting | Warm audiences want fit/credibility/timing, not awareness/positioning per `meta-retargeting.md` §3 | Strategist enforces warm-objection map when audience-temp=retargeting; critic Hook dim weights "is this addressing the warm objection set?" |
| Frequency creep on retargeting | Audience too small for budget; same people seeing same ads | Out of scope for ad-copy (budget pacing); rationale flags it if creative_format=repurposed-ugc + retargeting (volume insufficient to refresh fast enough) |
| Lookalike audiences on cold trial app | Post-Andromeda, lookalikes underperform broad targeting per `meta-cold-traffic.md` §2 | Out of scope for ad-copy (audience setup); rationale flags it if user mentions lookalikes in offer description |
| Repurposed UGC pushed to scale (>$15K/day) | Capped at $10-15K/day spend ceiling per `creative-cadence.md` §5 | Strategist surfaces ceiling warning when creative_format=repurposed-ugc; rationale carries the warning to artifact |
| Optimizing for purchase on 3-day trial subscription | Apple 24h signal window — purchase data arrives too late per `meta-cold-traffic.md` §3 | Pre-Dispatch soft-warns; proceeds as `done_with_concerns` only if user overrides |
| Banned health/finance/political claim | Meta policy review auto-rejects; account-level penalty risk | Format-checker hard-gate via `references/policy-floor.md`; critic Policy dim auto-fail |
| Fabricated stat or named entity | Critic Specificity Floor auto-fail per `references/anti-patterns.md` | Critic verifies every named entity + number traces to `pre_writing.Q6.available_proof[]` |
| Hero + 2 variants are paraphrases | Variant-volume discipline collapses; A/B test signal collapses | Strategist assigns distinct `angle_archetype` per variant; composer enforces distinct `anchor_proof` per variant; critic Pattern-Interruption dim checks variants are genuinely distinct |
| Em-dashes in ad copy | AI rhythm filler; reads instantly fake | Voice-auditor zero-tolerance auto-fail (same rule as cold-outreach) |
| "Quick question?" / "Are you tired of..." hooks | Generic; doesn't earn the 3-second window | Critic Hook dim 0-2 band |
| Multi-CTA in one ad | Splits intent; conversion-event signal degrades | Composer one-CTA-per-variant rule; format-checker flag |
| Running humanize twice | Strips specificity, drifts toward generic | Terminal pass runs ONCE per variant |

---

## What This Skill Pulls From Elsewhere

- **George Clem — Paid House** (X thread, agency at $200k+/mo, overseeing ~$500k/mo client adspend): 3-audience retargeting structure, warm-vs-cold objection map, frequency-creep diagnosis. → `references/ad-intelligence/meta-retargeting.md`.
- **Cali — subscription-app operator** (operator's idea vault, $40K/day spend at scale): 2-campaign structure, trial-start optimization, custom-product-page attribution, in-creative retargeting shortcut, affiliate-creator production model, dedicated-vs-repurposed creative ceiling. → `references/ad-intelligence/meta-cold-traffic.md`, `references/ad-intelligence/creative-cadence.md`.
- **Simplr Intelligence comment** + **paid-ads-thresholds** (uncited operator vault): volume cadence (50+/month), kill speed (1.5% CTR / 48h auto-pause), 80/20 budget split, 2-3% winner rate. → `references/ad-intelligence/creative-cadence.md` (low-confidence sources; numbers calibrated against operator's own account before adoption).

## Completion Status

Every run ends with explicit status:
- **DONE** — passed critic + format-checker + humanize regression, ready-to-publish
- **DONE_WITH_CONCERNS** — delivered, flags noted (stale ICP, ceiling warning on repurposed-UGC, missing LP description, policy soft-warn override, total 42-47 with all dims ≥6)
- **BLOCKED** — missing offer, missing proof + no product-context, or audience-temp missing; state what's needed
- **NEEDS_CONTEXT** — recommend `icp-research` or provide proof candidates

## Next Step

After receiving the artifact:
1. Submit hero to Meta Ads Manager as the primary creative
2. Submit Variant A + Variant B as A/B test against hero
3. Apply auto-pause rule per `creative-cadence.md` §3 (CTR <1.5% after 48h)
4. Re-invoke at creative-fatigue trigger (winner CTR decays >30% from peak) OR offer change OR LP change

---

## References

- `references/ad-intelligence/` — per-surface practitioner sources (retargeting / cold / cadence)
- `references/rubric.md` — 6-dimension scoring bands and per-dim auto-fail conditions
- `references/policy-floor.md` — Meta policy banned-claim wording + substantiation hedging
- `references/anti-patterns.md` — AI tells, fabrication tells, ceiling triggers
- `references/format-spec.md` — Meta char caps + visible-window economics
- `references/examples.md` — 4 worked examples (strong + weak × retargeting + cold) with critic scorecards
