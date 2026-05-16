---
name: social-copy
description: "Generates platform-native social copy (hooks, body, CTA, format spec) for tiktok, reels, shorts, x, linkedin. Enforces char/word limits, CTA placement vs algorithm truncation point, and hook archetype compliance. Produces .agents/skill-artifacts/mkt/copy/[platform]-[date]-[slug].md. Not for ad-copy (paid-platform bidding/compliance), email-copy (subject lines, deliverability), or long-form articles (LinkedIn articles, Substack). For landing page copy use copywriting. For video brief + storyboard use short-form-brief."
argument-hint: "<topic-or-brief-path> <platform> [--variants N] [--polish-chain humanize|vn-tone|none] [--goal awareness|engagement|click|save|share]"
allowed-tools: Read Write Bash Grep Glob
license: MIT
metadata:
  author: hungv47
  version: "1.0.0"
  budget: standard
  estimated-cost: "$0.50-1.50"
promptSignals:
  phrases:
    - "write a tweet"
    - "write a linkedin post"
    - "tiktok caption"
    - "reels caption"
    - "shorts caption"
    - "social post"
    - "social copy"
    - "social media copy"
    - "hook variants"
    - "write a hook"
    - "post copy"
    - "caption for"
  allOf:
    - [write, post]
    - [write, caption]
    - [social, copy]
    - [social, media, copy]
  anyOf:
    - "tiktok"
    - "reels"
    - "shorts"
    - "linkedin post"
    - "tweet"
    - "x post"
    - "hook variant"
    - "social hook"
  noneOf:
    - "ad copy"
    - "email subject"
    - "newsletter"
    - "youtube video"
    - "blog post"
  minScore: 5
routing:
  intent-tags:
    - marketing
    - copy
    - social
    - hook
    - platform
  position: horizontal
  lifecycle: pipeline
  produces:
    - .agents/skill-artifacts/mkt/copy/[platform]-[date]-[slug].md
  consumes:
    - .agents/skill-artifacts/mkt/short-form-brief/[slug]/brief.md
    - .agents/skill-artifacts/mkt/campaign-plan.md
    - brand/BRAND.md
    - brand/DESIGN.md
  requires:
    - brand/BRAND.md OR brand_mode=founder fallback
  defers-to:
    - skill: short-form-brief
      when: "need a full video brief with storyboard + audio + production spec"
    - skill: copywriting
      when: "writing landing page copy, headlines, or CTA text for a non-social surface"
    - skill: humanize
      when: "polish_chain=humanize requested or AI-sounding copy detected post-generation"
    - skill: vn-tone
      when: "polish_chain=vn-tone requested or Vietnamese-market copy needed"
  parallel-with: []
  interactive: false
  estimated-complexity: standard
---

# Social Copy — Orchestrator

*Marketing — Horizontal. Dispatches 3 specialist agents (copywriter → format-checker → critic) to generate platform-native social copy with enforced limits, hook archetype compliance, and rubric scoring.*

**Core Question:** "Does this copy stop the scroll, clear all platform limits, and earn the click — on THIS platform?"

## What It Does

Social copy generator for 5 platforms: **tiktok, reels, shorts, x, linkedin**. Consumes a brief (from `short-form-brief` or `campaign-plan`) or an inline topic, plus brand voice and platform-intelligence references. Produces hook variants (A/B), body, CTA, with platform char/word/format limits enforced and CTA placement validated against each platform's algorithm truncation point.

**Not in scope:** ad-copy (paid-platform bidding, audience tags, compliance), email-copy (subject lines, deliverability, sequence logic), long-form posts (LinkedIn articles, Substack).

**5 platforms at launch:** `tiktok`, `reels`, `shorts`, `x`, `linkedin`. YouTube long-form excluded.

**Single-platform per artifact.** Multi-platform = re-invoke with a different `platform` argument.

**Single-market per artifact** (matches `short-form-brief`). Multi-market campaigns re-run per market. Vietnamese-market copy auto-routes through `vn-tone` via `--polish-chain vn-tone`.

**Polish chain default:** `none`. Set `--polish-chain humanize` or `--polish-chain vn-tone` to route the critic-passed copy through a terminal pass.

---

## Inputs

| Field | Required | Source | Notes |
|---|---|---|---|
| `brief_artifact_path` | ONE OF (brief or topic) | `.agents/skill-artifacts/mkt/short-form-brief/...` OR `.agents/skill-artifacts/mkt/campaign-plan.md` | Hook angle + audience already locked when brief exists |
| `topic` | ONE OF (brief or topic) | inline | Fallback when no brief exists. Pre-Dispatch round asks hook-angle + audience |
| `platform` | required | inline arg | `tiktok | reels | shorts | x | linkedin`. Maps to `references/_shared/platform-intelligence/[platform].md` |
| `brand_system` | required if exists | `brand/BRAND.md` + `brand/DESIGN.md` | Voice, archetype, lexicon, banned words |
| `brand_mode` | required | inline | `founder` (single-author voice) or `company` (multi-author brand voice) |
| `goal` | optional | inline | `awareness | engagement | click | save | share`. Determines CTA type. Default `engagement` |
| `variant_count` | optional | inline | 1–3 hooks. Default 2 (A/B). Hard cap 3 |
| `polish_chain` | optional | inline | `humanize | vn-tone | none`. Default `none` |

---

## Pre-Dispatch

Run the Pre-Dispatch protocol (`references/_shared/pre-dispatch-protocol.md`). Read `skills-resources/experience/audience.md`, `skills-resources/experience/brand.md`, and `skills-resources/experience/product.md` BEFORE asking.

**Needed dimensions:** platform, brand_mode, audience (who this is for + one pain), the one shift (what should reader do/believe after), topic or brief path.

**Per-skill cold-start question registry (social-copy):**

1. **Platform** — tiktok / reels / shorts / x / linkedin? → routing only
2. **Topic or brief** — paste a brief path OR describe the topic in 1–2 sentences → `content.md`
3. **Brand mode** — founder (personal voice) or company (brand voice)? → `brand.md` if novel
4. **Audience** — who is this for? (role + one pain, or "use icp-research.md") → `audience.md` if novel
5. **Goal** — awareness / engagement / click / save / share? (default: engagement) → `goals.md`

**Write-back:** answers persist to the mapped `skills-resources/experience/{domain}.md` files per protocol.

**Warm Start:** if `short-form-brief` artifact exists for this topic, extract platform, audience, hook angle, and goal from it — skip all five questions.

---

## Agent Roster

| Agent | Layer | File | Focus |
|-------|-------|------|-------|
| Copywriter Agent | 1 | `agents/copywriter-agent.md` | Hook variants (A/B/C), body, CTA, format spec. Platform-aware. Hook MUST match Tier 1 or Tier 2 archetype from platform-intelligence Hook Taxonomy |
| Format Checker Agent | 2 (sequential) | `agents/format-checker-agent.md` | Enforces char/word limits, CTA placement vs truncation, format-spec correctness. Hard-cap violations bounce back to copywriter (max 1 revision loop) |
| Critic Agent | 3 (final) | `agents/critic-agent.md` | Scores against 5-dim rubric (references/rubric.md). Outputs per-dimension score table + verdict + anti-patterns triggered |

**Why 3 agents:** Social copy is short-form by design. Splitting into more agents (hook-agent + body-agent) introduces collision risk during merge — flagged in copywriting contract `unknowns_pending_observation.layer_1_agent_collision_frequency`. Three agents is the floor for multi-agent dispatch and the ceiling for short-form-craft skills.

---

## Dispatch Matrix

| Step | Agent | Named Inputs | Named Outputs |
|------|-------|-------------|---------------|
| 1 | copywriter-agent | brief OR topic + brand-system + platform-intel/[platform].md + Pre-Dispatch answers + variant_count + goal | structured-draft (hook-variants + body + CTA + format-spec) |
| 2 | format-checker-agent | structured-draft + platform-intel format-constraints section | passed-draft OR revision-request (named violations) |
| 2a (if revision) | copywriter-agent (revision) | structured-draft + revision-request (critic feedback appended) | revised-draft |
| 2b (if revised) | format-checker-agent (re-check) | revised-draft + platform-intel format-constraints | final-passed-draft OR format-fail |
| 3 | critic-agent | final-passed-draft + brief + brand-voice context + references/rubric.md + references/anti-patterns.md | scored verdict (pass/DWC/fail) + per-dimension table + anti-patterns list |

**Format-check bounce rule:** hard-cap violations send the draft back to copywriter ONCE. Two consecutive violations = `format-fail` — escalate to user with: "Format-fail: [platform] [violation]. Manual fix required before publish."

---

## Execution Flow

```
Pre-Dispatch (read experience/ first; ask ≤5 questions if missing)
     ↓
1. Dispatch copywriter-agent
     ↓
2. Dispatch format-checker-agent
     ↓ (if hard-cap violation)
   2a. Bounce to copywriter-agent with revision-request (max 1 time)
     ↓
   2b. Re-check with format-checker-agent
     ↓ (two consecutive failures → format-fail → escalate to user)
3. Dispatch critic-agent
     ↓
   PASS (score ≥35)       → assemble artifact → optional polish chain → DONE
   DONE_WITH_CONCERNS     → assemble artifact with concerns flagged → DONE_WITH_CONCERNS
   FAIL (score <25)       → deliver artifact with critic annotations flagged to user
     ↓
4. [Optional] Polish chain
   polish_chain=humanize  → route to humanize skill as terminal pass
   polish_chain=vn-tone   → route to vn-tone skill as terminal pass
   polish_chain=none      → skip
```

### How to spawn a sub-agent

For each agent dispatched, use the **Agent tool** with a prompt constructed as follows:

1. **Read** the agent instruction file (e.g., `agents/copywriter-agent.md`) — include its FULL content in the Agent prompt
2. **Append** the brief and Pre-Dispatch context after the instructions
3. **Resolve file paths to absolute**: replace relative paths with absolute paths rooted at this skill's directory (e.g., `references/rubric.md` → `/absolute/path/social-copy/references/rubric.md`). Tell the agent: "Read the reference file at [absolute path]."
4. **Pass upstream artifacts by content, not path**: orchestrator reads `brand/BRAND.md` and platform-intelligence docs FIRST, then includes relevant excerpts in the dispatch payload. Sub-agents should NOT read brand files directly — the orchestrator curates what they need.
5. If **feedback** exists (from format-checker bounce), append it with the header: `## Format-Checker Feedback — Address Every Violation`

### Single-agent fallback

If multi-agent dispatch is unavailable, execute each agent's instructions sequentially in-context in this order: copywriter-agent → format-checker-agent → critic-agent. The output quality should be equivalent — multi-agent pattern optimizes for focus, not capability.

---

## Output Artifact

**Path:** `.agents/skill-artifacts/mkt/copy/[platform]-[YYYY-MM-DD]-[slug].md`

**Frontmatter schema (verbatim from spec — match exactly):**

```yaml
type: social-copy-artifact
platform: tiktok | reels | shorts | x | linkedin
date: YYYY-MM-DD
slug: short-kebab-slug
brand_mode: founder | company
goal: awareness | engagement | click | save | share
variant_count: 1-3
brief_source: <path or inline-topic>
platform_intel_version: <last_verified date from platform-intelligence/[platform].md>
critic_score: <numeric, 0-50 across 5 dimensions × 0-10>
critic_verdict: pass | done_with_concerns | fail
status: done | done_with_concerns | blocked | needs_context
polish_chain_applied: vn-tone | humanize | none
```

**Body schema (sectioned markdown — match exactly):**

```markdown
## Hook variants
### Variant A
<verbatim hook text — character count enforced>
**Char count:** N / [platform limit]
**Algorithm signal targeted:** <one of platform-intel top-5 signals>

### Variant B
<verbatim hook text — character count enforced>
**Char count:** N / [platform limit]
**Algorithm signal targeted:** <one of platform-intel top-5 signals>

## Body
<verbatim body text — character/word count enforced>
**Char count:** N / [platform limit]

## CTA
<verbatim CTA text>
**Placement:** <line N of M; relative position to algorithm truncation point>

## Format spec
- Single post / thread (X) / carousel (LinkedIn) / vertical-video-caption (TikTok/Reels/Shorts)
- Aspect ratio (if media-coupled): N:M
- Pattern-interruption density: <count of interrupts per 100 chars>

## Critic verdict
| Dimension | Score | Notes |
|---|---|---|
| Hook scroll-stop strength | 0-10 | scored vs platform-intel Hook Taxonomy |
| Char/word limit compliance | 0-10 | hard cap or violation reason |
| CTA placement vs truncation | 0-10 | for platforms with truncation lines |
| Pattern-interruption density | 0-10 | scored against platform anti-patterns |
| Format compliance | 0-10 | single post vs thread vs carousel correctness |
| **Total** | / 50 | pass ≥ 35; done_with_concerns 25-34; fail < 25 |

## Anti-patterns triggered (if any)
- <list of detected anti-patterns from references/anti-patterns.md>
```

---

## Critic Gate

Read `references/rubric.md` for full dimension definitions and thresholds.

**Pass threshold:** total ≥ 35/50 AND no individual dimension scores 0.
**Done with concerns:** 25–34 OR any individual dimension below 4.
**Fail:** < 25.

**If critic returns fail:** deliver the artifact with annotations and flag to user: "Copy scored [X] — manual review recommended on [specific dimensions]." Do NOT silently discard — failed copy still ships as an artifact with `status: done_with_concerns` so the user can decide.

**Discrimination test:** a weak brief MUST score < 25; a strong brief MUST score ≥ 35. If both pass or both fail, the rubric is broken — flag this. (Implemented inside `agents/critic-agent.md`.)

---

## Anti-Patterns

1. **Generic hook openers** — "Have you ever...", "Did you know...", "In this video I'll..." These match no Tier 1 or Tier 2 archetype and signal platform-blind writing.
2. **Algorithm-blind CTAs** — CTA placed below the truncation line on X (280 chars visible) or LinkedIn (first 3 lines visible). Reader won't reach it.
3. **Format mismatch** — carousel content delivered as a thread; video caption written as feed-post body; long-form LinkedIn article draft dropped into a native post slot.
4. **Char-limit-blind copy** — writing to 500 chars when the platform truncates at 280; writing to 3,000 chars when the feed shows ~200.
5. **Brand-voice ignored** — corporate-cliché copy when `brand_mode=founder`; personal diary voice when `brand_mode=company`.
6. **Pattern-interrupt monotony** — same interrupt type (question / pivot / stats-drop) repeated 3+ times in a row; density score drops.
7. **Pasted-from-blog body** — long-form prose dropped into a short-form surface without compression. Identifiable by avg sentence length > 20 words AND no visual breaks (line breaks, numbers, em-dashes) in caption body.

---

## Completion Status

Every run ends with explicit status:

- **DONE** — copy generated, all format limits passed, critic score ≥35, variant_count hooks delivered
- **DONE_WITH_CONCERNS** — copy delivered; critic score 25–34 OR individual dimension below 4; concerns annotated in artifact
- **BLOCKED** — platform not in supported set (tiktok/reels/shorts/x/linkedin); or brief contradicts brand_mode (e.g., VN market + brand_mode=company but no company voice defined); needs user resolution
- **NEEDS_CONTEXT** — no brief, no topic, no brand voice, and no experience/ entries to derive from; recommend running `short-form-brief` or `brand-system` first, or answer Pre-Dispatch questions
