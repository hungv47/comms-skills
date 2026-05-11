---
type: rubric
schema_version: 1
last_verified: 2026-05-11
verifier: hungv47
---

# Ad-Copy Rubric (v0.1)

6-dimension rubric for Meta paid-ad copy. Used by `agents/critic.md` to score hero + Variant A + Variant B independently, then aggregate.

**Pass gate:** aggregate average ≥ 42/60 across the 3 variants AND every per-variant per-dim score ≥ 6.

Any single per-variant per-dim score < 6 = FAIL even if aggregate ≥ 42.
Total 42-47 with all per-dim floors met = PASS as `DONE_WITH_CONCERNS`.

---

## 1. Hook scroll-stop (0-10)

| Band | Description |
|------|-------------|
| 9-10 | Pattern-interrupt hook anchored on a named specific in first ~50 chars of primary text. Headline carries the value (not just CTA verb). Reader's world dominates first clause. Sharp observation or surprising number. |
| 7-8 | Hook is anchored but slightly soft. Anchor lands, rhythm could be tighter. Headline carries some value but could be sharper. |
| 5-6 | Hook lands inside the visible 125-char window but not in the first ~50 chars. Reader has to read 80+ chars before the hook crystallizes. Weak pattern-interrupt. |
| 3-4 | Generic opener present ("Looking for...", "Are you tired of...", "We're excited to..."). No specific anchor in visible window. Headline is generic. |
| 0-2 | Headline is "Learn more" / "Click here" / product-name-only with no value framing. Primary text opens with vendor-speak ("Industry-leading..."). Reader's first impression is corporate. |

**Auto-fail conditions:**
- Rhetorical question opener ("Ever wondered...?", "What if I told you...?", "Are you tired of...?")
- Setup-sentence opener ("I wanted to share...", "We're excited to announce...")
- Headline is generic CTA only ("Learn more", "Click here", "Sign up") with no value framing

---

## 2. Component-char compliance (0-10)

| Band | Description |
|------|-------------|
| 9-10 | Primary text hook + anchor land in first ~125 chars. Headline ≤27 chars (always-visible on mobile feed). Description ≤25 chars. Visible-window economy maximized. |
| 7-8 | Visible window used well; slight overrun (hook lands at ~140 chars instead of ~125). Headline 28-40 chars (within hard cap, truncates on some mobile placements). Description ≤30 chars. |
| 5-6 | Hook is in visible window but anchor falls past truncation point. Headline near hard cap edge (38-40 chars). |
| 3-4 | Hook or anchor falls past 125-char visible window. Headline at hard cap. Description at hard cap. Reads as wall-of-text. |
| 0-2 | Component pushes hard cap; key claim is invisible to scrolling user; format reads as desperate. |

**Auto-fail conditions:**
- Any component exceeds Meta hard cap (3,000 primary text / 40 headline / 30 description) — this should have been caught by format-checker; if it reaches critic, format-checker failed AND critic auto-fails
- All-caps headline (Meta policy banned — format-checker should also catch this)

---

## 3. CTA-LP match (0-10)

| Band | Description |
|------|-------------|
| 9-10 | CTA verb verbatim matches LP primary button ("Start free trial" → LP "Start free trial"). Offer noun matches LP headline noun ("14-day trial" → LP "14-day trial"). Benefit framing aligns. |
| 7-8 | CTA verb category matches (both trial-start type). Offer detail aligns. Minor phrasing drift acceptable. |
| 5-6 | CTA verb roughly aligned. Some offer-detail drift (ad: "free trial"; LP: "14-day free trial"). Operator should tighten. |
| 3-4 | CTA verb mismatch (ad: "Sign up"; LP button: "Start trial"). Ad benefit framing differs from LP promise. |
| 0-2 | Bait-and-switch: ad promises X, LP delivers Y. CTA verb doesn't exist on the LP. |

**If `lp_description` is null:** score at 6 with annotation "scope: ad copy alone — no LP description supplied; operator must verify message-match independently." This is a scope limitation, not a draft quality issue.

**Auto-fail conditions:**
- Engagement-bait CTA ("Like if you agree", "Comment YES below", "Tag a friend")
- Misleading button (CTA verb doesn't match destination)

---

## 4. Pattern-interruption density (0-10)

Cross-variant test — scored once per variant but reflects the trio's collective distinctness.

| Band | Description |
|------|-------------|
| 9-10 | 3 distinct angle archetypes across hero + A + B (problem-framing / outcome-asymmetry / peer-observation, e.g.). 3 distinct anchor proofs (different named entities/numbers). Structurally different openings (Levenshtein distance ≥30 chars). |
| 7-8 | Archetypes + anchors are distinct, but openings share rhythm. Or one variant is clearly weaker but the trio still tests 3 different angles. |
| 5-6 | 2 of 3 variants are distinct; third is a paraphrase of one of the first two. A/B signal degrades but doesn't collapse. |
| 3-4 | Variants share archetype with different words. A/B test signal will collapse to noise. |
| 0-2 | All 3 variants are paraphrases of the same angle and same anchor. No A/B testable signal possible. |

**Auto-fail conditions:**
- Two variants share the exact same anchor proof (e.g., both reference "Customer X · 9→4 day close")
- All three variants share the same angle archetype with surface-level paraphrasing only
- Headline distinctness < 10 chars Levenshtein-distance proxy across any pair

---

## 5. Policy + claim compliance (0-10)

| Band | Description |
|------|-------------|
| 9-10 | Every measured claim mapped to a source in `available_proof[]`. Claim wording precisely matches what source supports. Aggregate or testimonial claims carry appropriate hedges ("in our cohort, customers reported..."). No banned-phrase hits. |
| 7-8 | Substantiation clean. Minor over-claim that hedging language softens adequately. |
| 5-6 | One claim slightly broader than source supports (source: "50 customers"; ad: "hundreds"). Hedge needed but missing. |
| 3-4 | One claim unsupported by `available_proof[]` (no source ID maps). OR one banned phrase requires removal. |
| 0-2 | Fabricated metric (no source ID). Banned-phrase hit ("guaranteed", "FDA-approved" without approval). Engagement-bait CTA. |

**Auto-fail conditions:**
- ANY claim cannot be traced to a source in `available_proof[]` via `claim_list`
- ANY banned-phrase hit per `references/policy-floor.md`
- Protected-class targeting language
- Click-bait wording ("You won't believe...", "Doctors hate this")
- For `creative_format=repurposed-ugc`: ceiling warning absent from artifact → Policy dim -2 points (transparency requirement)

---

## 6. Specificity (0-10)

| Band | Description |
|------|-------------|
| 9-10 | ≥3 verifiable specifics per variant in visible window. Specifics integrate naturally with hook. |
| 7-8 | 2 verifiable specifics per variant. Integration mostly clean. |
| 5-6 | Exactly 2 verifiable specifics per variant (meets Floor but barely). |
| 3-4 | 1 verifiable specific per variant (FAILS Floor). Generic flavor fills the rest. |
| 0-2 | 0 verifiable specifics. Pure generic claim soup ("leading", "trusted", "proven", "transformative"). |

**Specificity Floor — auto-fail.** A variant with fewer than 2 verifiable specifics in the visible-window primary text auto-fails Specificity. The Floor overrides bands — a "5-6 band" variant has exactly 2 specifics; below 2 → auto-fail at 0-4.

**A "verifiable specific" is:**
- Named entity (a specific customer, a specific product, a specific named cohort — e.g., "Ramp", "Cali Apps cohort")
- Named number with context (`9 days → 4 days`, `20 lbs in 30 days`, `$50/month`, `$2,000 → $500 CPA`)
- Named research or source (`Clem 2026 retargeting thread`, `Cali Apps subscription playbook`, `Saraev's $15M template`)

Pure generic flavor ("great work in SaaS", "leading B2B brands", "proven results", "industry-leading", "best-in-class") does NOT count.

---

## Aggregate Calculation

```
hero_total       = sum(6 dim scores)
variant_a_total  = sum(6 dim scores)
variant_b_total  = sum(6 dim scores)

aggregate = avg(hero_total, variant_a_total, variant_b_total)
```

**Verdict:**
- aggregate ≥ 42 AND every per-variant per-dim ≥ 6 → **PASS**
- aggregate ≥ 42 AND any per-variant per-dim < 6 → **FAIL** (per-dim floor unmet)
- aggregate < 42 → **FAIL** (aggregate threshold unmet)
- 42 ≤ aggregate < 48 AND every per-dim ≥ 6 → PASS as **DONE_WITH_CONCERNS**

**Cycle 3 auto-surface:** if cycle == 3 and verdict would still be FAIL, return PASS_WITH_CONCERNS with current scorecards and the auto-surface banner.

---

## Worked Score Examples

See `references/examples.md` for 4 full worked examples (strong-retargeting / weak-retargeting / strong-cold / weak-cold) with per-variant per-dim scorecards.

---

**Rubric version:** v0.1 (initial; revise after first 5 real-world ad-copy invocations).

**Mandatory revision triggers:**
1. Aggregate ≥ 42 passes consistently while real-world ad performance underperforms benchmarks → re-examine which dim's threshold is too lenient.
2. Multiple cycle-3 auto-surfaces in close succession → re-examine whether the per-dim floor at 6 is too aggressive for the rubric's current bands.
3. Meta policy change (e.g., tightens substantiation rules on health claims) → update Policy dim auto-fails.
