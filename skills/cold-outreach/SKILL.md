---
name: cold-outreach
description: "Writes and evaluates cold outreach messages — email, LinkedIn, Twitter/X, and platform proposals — with signal-based personalization, channel-specific craft, and rubric scoring. Produces `.agents/mkt/cold-outreach/[slug].md` (+ `.rationale.md` + `.critic-score.md`). Handles first-touch compose and reply-to-inbound-response modes. Not for campaign orchestration or sequence design (compose touches individually, pass prior touches as context). Not for sourcing or list building (start at 'here's who I'm reaching'). For brand voice, see brand-system. For AI-sounding cleanup, humanize runs automatically as a terminal pass."
argument-hint: "[target/signal + channel + mode, or reply text to respond to]"
allowed-tools: Read Grep Glob Bash WebSearch WebFetch
license: MIT
metadata:
  author: hungv47
  version: "1.0.0"
  budget: deep
  estimated-cost: "$1-3"
promptSignals:
  phrases:
    - "cold email"
    - "cold outreach"
    - "cold dm"
    - "linkedin dm"
    - "linkedin outreach"
    - "upwork proposal"
    - "prospect email"
    - "reply to this prospect"
    - "first-touch email"
    - "follow-up email"
  anyOf:
    - "cold outreach"
    - "cold email"
    - "cold dm"
    - "prospect"
    - "outbound"
    - "upwork proposal"
    - "fiverr proposal"
    - "connection request"
  allOf:
    - [write, cold]
  noneOf:
    - "newsletter"
    - "lifecycle email"
    - "drip campaign"
    - "nurture sequence"
    - "transactional email"
  minScore: 6
routing:
  intent-tags:
    - cold-outreach
    - cold-email
    - cold-dm
    - prospect-message
    - platform-proposal
    - reply-handling
  position: horizontal
  produces:
    - mkt/cold-outreach/[slug].md
    - mkt/cold-outreach/[slug].rationale.md
    - mkt/cold-outreach/[slug].critic-score.md
  consumes:
    - product-context.md
    - icp-research.md
    - mkt/content-research.md
    - mkt/campaign-plan.md
  requires: []
  defers-to:
    - skill: copywriting
      when: "need headline, hook, or landing-page copy (not an outbound message)"
    - skill: campaign-plan
      when: "need channel strategy or multi-channel campaign orchestration across paid/owned/earned"
  parallel-with: []
  interactive: false
  estimated-complexity: heavy
---

# Cold Outreach — Orchestrator

*Communication — Horizontal. Produces ready-to-send outbound messages across email, LinkedIn, Twitter/X, and platform proposals. Multi-agent strategy → draft → voice → critic → humanize pipeline.*

**Core Question:** "If I removed the personalization, would this email still make sense? If yes, the personalization isn't working."

## Philosophy

Cold outreach is not template-filling. It's writing as if you were a sharp colleague who noticed something relevant — the reader's world dominates, not yours. Every sentence must earn its place. Frameworks (Observation→Problem→Proof→Ask, Question→Value→Ask) are tools, not mandates. The test is: would YOU reply to this if you received it?

This orchestrator separates strategy from craft: specialist agents pick the angle, signal, proof, and CTA shape in parallel, then a composer drafts using channel-specific rules, a voice auditor strips vendor-speak, a critic scores against a 5-dimension rubric, and `humanize` runs as a terminal pass to eliminate AI tells. Output is a ready-to-send message with rationale — not a draft you need to rewrite.

## Scope Boundary

**In scope:**
- First-touch compose across email / LinkedIn (DM + connection note) / Twitter/X (reply + DM) / platform proposals (Upwork, Fiverr, similar)
- Reply to inbound response (objection handling, next-touch composition)
- Multi-touch coherence via optional `prior-touches` input
- Modes: services-sell (consulting/agency) / saas-sell / partnership-sell / community-sell

**Out of scope:**
- Sourcing, list-building, scraping (skill specs query Booleans as reference; execution belongs to your tool stack)
- Multi-touch sequence orchestration as a single artifact (compose touches one at a time)
- Sequence diagnosis / A-B testing analysis (future skill)
- Fundraise outreach (VC/warm-intro norms differ)
- Hiring outreach (candidate-sourcing norms differ)
- Sending / tracking / inbox warmup (Instantly, Lemlist, Smartlead layer)
- Voice memos, cold-call scripts

## Inputs Required

**Always:**
- **Channel**: email | linkedin-dm | linkedin-connection | twitter-reply | twitter-dm | upwork-proposal | other-platform
- **Mode**: services-sell | saas-sell | partnership-sell | community-sell

**Strongly recommended (skill will ask if missing and signal is weak):**
- **Target**: name + role + company (minimum); LinkedIn URL / context ideal
- **Trigger signal**: what prompted the reach-out — funding, hiring post, product launch, tech-stack signal, individual post, referral, event
- **Your offer**: what you're selling, for whom, what specific problem
- **Proof**: one concrete result, case study, or credibility anchor

**Optional but powerful:**
- **Prior touches**: for touch 2, 3, 4+ — paste what you already sent so the skill keeps coherence
- **ICP artifact**: auto-consumed from `research/icp-research.md` if present
- **Product context**: auto-consumed from `research/product-context.md` if present
- **Prospect quote / language**: words they used in a post or profile — highest-signal personalization fuel

## Output

Writes to `.agents/mkt/cold-outreach/`:

| File | Content |
|------|---------|
| `[slug].md` | Final ready-to-send draft (+ subject line for email, + connection-note variant for LinkedIn) |
| `[slug].rationale.md` | Angle chosen, framework used, signal selected, CTA logic, channel craft rules applied, anti-patterns avoided |
| `[slug].critic-score.md` | Rubric scorecard across 5 dimensions (for iteration) |

Slug is derived from target + channel (e.g., `jane-acme-email-t1`, `jane-acme-linkedin-dm`, `jane-acme-email-t2-followup`).

### Artifact Frontmatter (required)

Every `[slug].md` carries:

```yaml
---
skill: cold-outreach
version: 1
date: YYYY-MM-DD
status: done | done_with_concerns | blocked | needs_context
channel: email | linkedin-dm | linkedin-connection | twitter-reply | twitter-dm | upwork-proposal | other-platform
mode: services-sell | saas-sell | partnership-sell | community-sell
touch: integer | "breakup"   # 1, 2, 3, 4+, or "breakup"
route: compose | reply
critic_total: N/50
---
```

## Quality Gate

Before delivering, the **critic agent** verifies (5 dimensions, 0-10 each):

- [ ] **Peer voice** ≥ 6 — reads like a sharp human, no vendor-speak ("leverage", "synergy", "best-in-class", "I hope this finds you well")
- [ ] **Signal connection** ≥ 6 — personalization connects to the ask; remove-the-opener test passes (email shouldn't still make sense without it)
- [ ] **CTA friction** ≥ 6 — one ask, low-friction; no "30-min call" in first touch
- [ ] **You > me ratio** ≥ 6 — "you/your" dominates over "I/we/our"; reader's world framed, not yours
- [ ] **Specificity** ≥ 6 — concrete proof point (number, named outcome, named company), no "leading provider" / "trusted by many"

**Gate rule:** Total ≥ 35/50 **AND every dimension ≥ 6**. Total 35-39 with all dims ≥ 6 = PASS as `DONE_WITH_CONCERNS`. Any dimension < 6 = FAIL regardless of total.

Below threshold → the full Layer 2 chain (composer → voice-auditor → critic) re-runs with feedback (max 2 rewrite cycles).

After critic PASS, `humanize` runs as the terminal pass. After humanize returns, the orchestrator re-runs the critic's **Specificity dimension only** on the humanized text — if Specificity drops ≥2 points OR any named entity/number present pre-humanize is absent post-humanize, the orchestrator reverts to the critic-approved draft. This protects the specificity anchor the critic just scored.

## Chain Position

Horizontal — can run standalone or be called by `campaign-plan` when outbound is part of a broader channel mix.

**Re-run triggers:** ICP changes materially, a new trigger signal appears for the same prospect, prior sequence got no reply and angle needs refresh.

### Skill Deference
- **Writing a landing page headline, tagline, or CTA for an ad?** → Use `copywriting` (horizontal writing craft, not outbound)
- **Need a multi-channel campaign plan across paid/owned/earned?** → Use `campaign-plan` first, then invoke this skill for the outbound touches
- **No persona defined, or ICP data stale (>30 days)?** → Run `icp-research` first
- **Sequence is underperforming, need diagnosis?** → Not in this skill; open question for a future `outbound-diagnose` skill
- **Lifecycle / nurture / drip emails?** → NOT this skill. Those are warm, consent-based, and have different craft.

---

## Agent Manifest

| Agent | Layer | File | Focus |
|-------|-------|------|-------|
| Signal Analyst | 1a (solo, first) | `agents/signal-analyst.md` | Rates trigger-signal strength (1-5), drafts the observation line, flags weak/generic signals. Runs FIRST because strategist + proof-selector consume its `signal_strength` score. |
| Strategist | 1b (parallel) | `agents/strategist.md` | Picks framework (O→P→P→A, Q→V→A, Trigger→Insight→Ask, Story→Bridge→Ask, Declared-Need→Relevant-Proof→Specific-Next-Step, No-pitch connection note), angle, CTA shape. Receives `signal_strength` from 1a. |
| Proof Selector | 1b (parallel) | `agents/proof-selector.md` | Picks strongest proof asset from the `available_proof[]` pool: named case study > named logo + metric > specific claim > generic. Receives `signal_strength` from 1a for tie-breaking. |
| Composer | 2 (sequential, post-merge) | `agents/composer.md` | Drafts the message applying channel-specific craft rules (length, structure, subject line, formatting) |
| Voice Auditor | 2 (sequential) | `agents/voice-auditor.md` | Peer-voice audit — strips vendor-speak, enforces contractions, cuts filler, verifies "you > me" |
| Critic | 2 (sequential, gate) | `agents/critic.md` | Rubric scoring across 5 dimensions, PASS/FAIL with rewrite feedback. Reads `references/anti-patterns.md` for banned-phrase auto-fails. |
| Reply Classifier | 1 (reply mode) | `agents/reply-classifier.md` | Types inbound reply: not-interested / no-budget / send-info / wrong-person / curious / qualified / later / hostile / ambiguous |
| Reply Composer | 2 (reply mode) | `agents/reply-composer.md` | Drafts response per classification + next-touch logic |

### Shared References (read by multiple agents)

**Channel craft (channels/):**
- `references/channels/email.md` — subject lines, length targets, structure, formatting, breakup email
- `references/channels/linkedin.md` — connection-note (≤300 chars) vs post-accept DM vs InMail distinctions
- `references/channels/twitter.md` — public reply craft vs DM craft, demand-signal reading
- `references/channels/platform-proposals.md` — Upwork/Fiverr: pitching into declared need

**Mode defaults (modes/):**
- `references/modes/services.md` — consulting/agency: audit/loom/teardown CTAs, revenue-tied problems, value-based positioning
- `references/modes/saas.md` — product-led framing, trial/demo CTAs, ROI proof shapes
- `references/modes/partnership.md` — B2B partnership/collab/integration
- `references/modes/community.md` — low-ask value-first (helpful note, resource offer)

**Frameworks (frameworks/):**
- `references/frameworks/structures.md` — Observation→Problem→Proof→Ask and 4 other proven shapes
- `references/frameworks/personalization-signals.md` — 4-level signal system + trigger catalogue (funding, hiring, post, tech-stack, event)
- `references/frameworks/ctas.md` — low-friction asks, interest-based vs meeting-request, one-line-reply CTAs
- `references/frameworks/objections.md` — reply playbooks per classification

**Shared guardrails:**
- `references/anti-patterns.md` — AI tells, template smell, phrases that kill replies
- `references/proof-types.md` — proof hierarchy: named case study > named logo + metric > specific claim > generic

---

## Routing Logic

Classify the task, then follow the matching route.

### Route A: Compose (First-Touch or Follow-Up)

**When:** User wants an outbound message — first touch, follow-up touch 2/3/4+, or a cold DM on any channel.

```
1. Pre-dispatch: Gather context (Step 0 below)
   - If mode or channel not specified → ask user (use AskUserQuestion)
   - If target + signal both missing → ask user; if only signal missing and strong persona exists → proceed with weak-signal flag
   - If slug indicates touch 2+ (ends `-t2`/`-t3`/etc.) OR user describes as follow-up → require prior_touches verbatim; BLOCK if missing (composer needs them to avoid angle repetition)
2. LAYER 1a — Dispatch signal-analyst SOLO (must complete before 1b):
   - signal-analyst rates signal strength (1-5) and drafts observation line
3. LAYER 1b — Dispatch IN PARALLEL (both receive `signal_strength` from 1a):
   - strategist (picks framework + angle + CTA shape)
   - proof-selector (picks strongest proof from available_proof[])
4. MERGE: Assemble Layer 1 outputs into a "strategy brief"
5. LAYER 2 — Dispatch SEQUENTIALLY:
   - composer (receives strategy brief + channel reference + mode reference)
   - voice-auditor (receives composer output)
   - critic (receives voice-auditor output + pre_writing verbatim, applies rubric)
6. If critic returns FAIL → re-dispatch the FULL Layer 2 chain (composer → voice-auditor → critic) with feedback passed to composer (max 2 rewrite cycles). Never feed critic a raw composer draft without voice-auditor in between.
6a. **Voice-auditor BLOCKED handling (separate from critic FAIL cycles):**
   - If voice-auditor returns `[BLOCKED: composer needs concrete proof ...]` or similar, do NOT consume a critic rewrite cycle.
   - Re-dispatch composer with the voice-auditor block reason as feedback.
   - If the block names a proof gap specifically, re-dispatch proof-selector in parallel with a "need stronger proof" feedback note so the composer's rewrite has a better pool to draw from.
   - If the same BLOCKED reason repeats on the second composer pass, escalate to the user as `NEEDS_CONTEXT` (naming what's missing — usually a concrete client + number).
7. TERMINAL PASS: Invoke `humanize` skill on the final draft with `content-type: "short-outbound"` and the channel
8. POST-HUMANIZE REGRESSION CHECK: Re-run critic's Specificity dimension only on humanized text. If it drops ≥2 points OR any named entity/number present pre-humanize is absent post-humanize, revert to the critic-approved draft.
9. Write artifacts to .agents/mkt/cold-outreach/[slug].md (+ .rationale.md + .critic-score.md)
10. Deliver message + rationale inline; show rubric scorecard only if user asks or any dimension scored 6-7
```

### Route B: Reply Handling

**When:** User pastes an inbound reply and asks for a response.

```
1. Pre-dispatch: Read the reply text; confirm channel + mode
2. LAYER 1 — Dispatch:
   - reply-classifier (types the reply, extracts subtext)
3. LAYER 2 — Dispatch SEQUENTIALLY:
   - reply-composer (drafts response per classification + next-touch logic)
   - voice-auditor (peer-voice pass)
   - critic (reply-specific rubric — see Reply Route Agent Flow below)
4. If critic returns FAIL → re-dispatch the FULL Layer 2 chain (reply-composer → voice-auditor → critic) with feedback (max 2 rewrite cycles)
5. TERMINAL PASS: Invoke `humanize` with `content-type: "short-outbound"`
6. POST-HUMANIZE REGRESSION CHECK (same as Route A step 8)
7. Write artifacts; deliver inline
```

### Route C: Called by Another Skill

**When:** Invoked by `campaign-plan` for outbound touches in a broader campaign.

```
1. Pre-dispatch: Read campaign context from calling skill's artifact
2. Execute Route A per touch requested
3. Return annotated message + rationale to calling skill
```

---

## Step 0: Pre-Dispatch Context Gathering

Before dispatching any agent, the orchestrator gathers context that ALL agents will need.

### Artifact Check
Read these if present (do NOT block if missing):

| Artifact | Source | Benefit |
|----------|--------|---------|
| `research/product-context.md` | icp-research | What you're selling, voice adjectives, accuracy constraints |
| `research/icp-research.md` | icp-research | Target persona pain points, VoC language, context |
| `.agents/mkt/content-research.md` | content-research | Audience language map, winning hook patterns |
| `.agents/mkt/campaign-plan.md` | campaign-plan | Broader campaign context, angle positioning |

If `research/icp-research.md` or `research/product-context.md` is older than 30 days, warn the user and recommend re-running `icp-research` before proceeding. Soft gate — proceed if confirmed, note "stale ICP" in artifact header.

### Missing-Input Protocol
- **Mode not specified** → ask user (AskUserQuestion: services-sell / saas-sell / partnership-sell / community-sell)
- **Channel not specified** → ask user (AskUserQuestion with channel options)
- **Target missing + no ICP artifact** → ask user for name/role/company; block if both blank
- **Signal missing** → proceed with "weak-signal flag"; the strategist will default to pain-first framing instead of trigger-first, and the critic will weight Signal Connection more strictly
- **Proof missing + no product-context** → ask user for one concrete result; block if user insists on "no proof" (uncheckable claims fail the Specificity rubric)
- **Follow-up touch with no prior_touches** → if the user describes this as touch 2+, or the slug ends `-t2`/`-t3`/etc., ask for verbatim prior-touch text. BLOCK if missing — composer needs them to avoid angle repetition (anti-pattern below).

### Pre-Writing Framework

Answer these 5 questions before dispatching. Pass the answers to every agent as the `pre-writing` input:

1. **Who is this going to?** Name, role, company, seniority. What do they care about most in their role?
2. **What's the trigger?** Why them, why now? (Signal strength rated 1-5 by signal-analyst — 5 = individual post/quote, 1 = generic "companies like yours")
3. **What do we want them to do?** The single outcome — reply with interest, book a short call, open a resource, accept a connection
4. **What's the bridge?** The problem we solve that connects to their trigger + situation
5. **What proof assets do you have?** List ALL candidates (not just one) — named case studies, named logos with metrics, specific claims, testimonials, relevant background credentials. Build `available_proof[]` from the answer. Proof-selector picks one primary + one backup from the pool.

If `research/icp-research.md` exists, pull VoC pain language. If `research/product-context.md` exists, pull voice adjectives and accuracy constraints. If prior touches exist, include them verbatim so the strategist can avoid repetition and the composer can maintain tone.

---

## Dispatch Protocol

### How to spawn a sub-agent

For each agent dispatched below, use the **Agent tool** (general-purpose or Explore as appropriate) with a prompt constructed as follows:

1. **Read** the agent instruction file (e.g., `agents/strategist.md`) — include its FULL content in the Agent prompt
2. **Append** the pre-writing context and any prior layer's output after the instructions
3. **Resolve file paths to absolute**: replace relative paths with absolute paths rooted at this skill's directory. Example: `references/channels/email.md` → `<skill-root>/references/channels/email.md` where `<skill-root>` resolves to wherever this skill is installed (typically `marketing-skills/skills/cold-outreach/` in the repo, or the equivalent install path). Tell the agent which reference files to read.
4. **Pass upstream artifacts by content, not path**: the orchestrator reads `research/*.md` and `.agents/mkt/*.md` FIRST, then includes relevant excerpts (VoC quotes, voice adjectives, pain language) in the pre-writing object. Sub-agents do NOT read artifact files directly.
5. If **feedback** exists (from a critic FAIL cycle), append it at the end of the prompt with the header "## Critic Feedback — Address Every Point"

### Single-agent fallback

If multi-agent dispatch is unavailable, execute each agent's instructions sequentially in-context:
- Layer 1: run signal-analyst, strategist, proof-selector one at a time (their outputs don't depend on each other)
- Layer 2: apply composer → voice-auditor → critic in order
- Terminal humanize: apply humanize's instructions in-context if the skill is not reachable

Output quality is equivalent — the multi-agent pattern optimizes for parallelism and focus, not capability.

---

## Layer 1: Two-Stage Strategy Dispatch (Compose Route)

Signal-analyst runs SOLO first because the strategist's framework selection and the proof-selector's tie-breaking both consume its `signal_strength` score. Running them in parallel would force guessing.

### Layer 1a — Signal-analyst solo

| Agent | Instruction File | Pass These Inputs | Reference Files to Resolve |
|-------|-----------------|-------------------|---------------------------|
| Signal Analyst | `agents/signal-analyst.md` | pre-writing (esp. Q2 trigger) | `references/frameworks/personalization-signals.md` |

Wait for output. Extract `signal_strength` (integer 1-5) before proceeding.

### Layer 1b — Strategist + Proof-Selector IN PARALLEL

Spawn both agents in a single message (multiple Agent tool calls).

| Agent | Instruction File | Pass These Inputs | Reference Files to Resolve |
|-------|-----------------|-------------------|---------------------------|
| Strategist | `agents/strategist.md` | pre-writing (all) + channel + mode + `signal_strength` from 1a | `references/frameworks/structures.md`, `references/frameworks/ctas.md`, `references/modes/{mode}.md` |
| Proof Selector | `agents/proof-selector.md` | pre-writing (esp. Q5 `available_proof[]`) + `signal_strength` from 1a | `references/proof-types.md` |

**For Reply Route:** Spawn only `reply-classifier` in Layer 1 (no 1a/1b split needed).

---

## Merge Step (Compose Route)

After all Layer 1 agents return, the orchestrator assembles a **strategy brief** passed to the composer:

```markdown
# Strategy Brief

## Target
[From pre-writing Q1]

## Signal (from signal-analyst)
- Strength: [1-5]
- Observation line (draft): [text]
- Notes: [weak/strong/specific/generic flags]

## Framework (from strategist)
- Structure: [e.g., Observation → Problem → Proof → Ask]
- Angle: [one sentence]
- CTA shape: [e.g., low-friction interest question, resource offer, 15-min intro]
- Subject line angle (email only): [direction, not final text]

## Proof (from proof-selector)
- Primary: [named case study / logo + metric / specific claim]
- Backup: [fallback if primary doesn't fit length]

## Channel Rules
[Resolved from references/channels/{channel}.md — length targets, structure constraints]

## Mode Defaults
[Resolved from references/modes/{mode}.md — CTA vocabulary, proof shape, offer framing]

## Prior Touches (if any)
[Verbatim prior messages — composer must avoid repeating angles/phrasing]
```

The merge is deterministic assembly — no creative synthesis. If any Layer 1 agent returned BLOCKED, halt and surface the block to the user.

---

## Layer 2: Sequential Refinement (Compose Route)

Agents run in order. Each receives the prior agent's output.

| Order | Agent | Instruction File | Input | Reference Files |
|-------|-------|-----------------|-------|-----------------|
| 1 | Composer | `agents/composer.md` | Strategy brief | `references/channels/{channel}.md`, `references/modes/{mode}.md` |
| 2 | Voice Auditor | `agents/voice-auditor.md` | Composer draft | `references/anti-patterns.md` |
| 3 | Critic | `agents/critic.md` | Voice-audited draft + `pre_writing` verbatim (ground truth for signal-fabrication check) | `references/anti-patterns.md` (banned-phrase source for auto-fail conditions) |

### Critic Gate

Critic returns either:
- **PASS** — with rubric scorecard → proceed to terminal humanize pass
- **FAIL** — with scorecard + specific rewrite feedback → re-dispatch composer (cycle 1 or 2)

After 2 failed cycles, surface to user: "Critic couldn't reach threshold — here's the best draft + scorecard + what's blocking. Your call."

---

## Terminal Pass: Humanize

After critic PASS, invoke `humanize` skill on the final draft:

1. Spawn agent with humanize skill's `SKILL.md` content
2. Pass:
   - The final message text
   - `content-type: "short-outbound"` (humanize's Content Type Calibration has a row for this — Light strip, Full voice, 0-10% compression; short outbound differs from marketing copy because further compression kills specificity)
   - The channel
   - `protected_tokens`: every named entity and number present in the critic-approved draft (humanize must not remove or paraphrase these)
3. Receive humanized output
4. **Regression check (automatic, not judgment):** Re-run the critic's **Specificity dimension only** on the humanized text. Revert to the critic-approved draft if any of:
   - Specificity score drops ≥ 2 points
   - Any named entity present pre-humanize is absent post-humanize
   - Any concrete number present pre-humanize is absent post-humanize
5. Otherwise ship the humanized version.

This terminal pass is **automatic**, not opt-in. AI-sounding cold email is the single biggest failure mode. The regression check protects against humanize silently stripping the specificity anchor the critic scored.

---

## Reply Route Agent Flow

```
1. reply-classifier classifies inbound: not-interested / no-budget / send-info / wrong-person / curious / qualified / later / hostile / ambiguous
2. reply-composer drafts per classification + next-touch logic (uses references/frameworks/objections.md)
3. voice-auditor (same as compose route)
4. critic (reply-specific rubric — 5 dimensions, same total-≥35 AND per-dim-≥6 gate)
5. Terminal humanize + specificity regression check (same as Route A)
```

Reply-specific rubric adjustments (still 5 dimensions, two substitutions):
- "Signal connection" → **Tone match** — does your reply match their register (defensive → calm, curious → substantive, qualified → concrete)?
- "CTA friction" → **Next step clarity** — is the next action obvious without being pushy?
- Peer voice, You > me ratio, and Specificity dimensions stay unchanged.
- **Hard gate (not a scored dimension):** never argue with a "no". Breakup mode is the default for firm not-interesteds. The critic auto-fails any reply that tries to re-pitch after a clear rejection, regardless of the 5 dimension scores.

---

## Anti-Patterns (Orchestrator-Level)

| Anti-pattern | Why it fails | Guardrail |
|--------------|--------------|-----------|
| Template-with-{{FirstName}} swap | Signal never connects; reader pattern-matches to spam | Signal analyst flags; critic "Signal Connection" dimension |
| "I hope this email finds you well" / "My name is X and I work at Y" | Zero-value opener; vendor telltale | voice-auditor auto-flags |
| "Quick 30-minute call?" in touch 1 | Ask is too expensive for zero trust | CTA Friction rubric; strategist defaults to interest-question CTAs |
| Feature dumps | One proof beats ten features; reads as desperation | proof-selector picks ONE; voice-auditor cuts lists |
| Fake Re:/Fwd: subject lines | Short-term open rate bump, long-term trust destruction, reply rate collapse | Banned in `references/channels/email.md`; voice-auditor auto-fails |
| Running humanize twice | Strips specificity, drifts toward generic | Terminal pass runs ONCE |
| Arguing with "no" in reply route | Burns goodwill, tanks domain reputation | reply-composer hard gate; critic auto-fails |
| Skipping ICP artifact when present | Re-asks user for what's already known | Step 0 enforces artifact check first |
| Multi-touch without prior-touches input | Touch 2 repeats touch 1's angle | Orchestrator prompts for prior touches when slug ends `-t2`, `-t3`, etc. |

---

## What This Skill Pulls From Elsewhere

- **coreyhaines/cold-email** (open-sourced Claude skill by Corey Haines, ex-Baremetrics growth): structural frameworks (O→P→P→A), personalization 4-level system, subject-line discipline, breakup-email protocol. Adapted into `references/frameworks/structures.md`, `references/frameworks/personalization-signals.md`, and `references/channels/email.md`.
- **kostja94/cold-start-strategy** (open-sourced Claude skill): the "demand-signal outreach" pattern (reading posts/comments for expressed need rather than guessing pain). Informs `references/channels/twitter.md` and `references/channels/platform-proposals.md`.
- **Nick Saraev — Make More Money (YouTube channel, AI Automation Agency playbook, 2023-2024)**: services-mode defaults — audit/loom-teardown CTAs, revenue-tied problem prioritization, value-based positioning, platform-sales (Upwork) as legit top-of-funnel. Informs `references/modes/services.md` and `references/channels/platform-proposals.md`. Specific artifacts: the "Loom Teardown" template and the "$10k/month Upwork Playbook" video series.

## Completion Status

Every run ends with an explicit status:
- **DONE** — Message passed critic + humanize, delivered ready-to-send
- **DONE_WITH_CONCERNS** — Delivered, but flags noted (stale ICP, weak signal used, rubric 35-39 range)
- **BLOCKED** — Missing target + ICP, or missing proof + product-context; state exactly what's needed
- **NEEDS_CONTEXT** — Recommend running `icp-research` or providing prior touches

## Next Step

After receiving the message: send it, wait for reply or cadence interval (7-14 days typical), then re-invoke with prior touches for the next touch. For reply, use Route B.

---

## References

- `references/channels/` — craft rules per channel
- `references/modes/` — defaults per business mode
- `references/frameworks/` — structures, signals, CTAs, objections
- `references/anti-patterns.md` — AI tells and template smell
- `references/proof-types.md` — proof hierarchy
