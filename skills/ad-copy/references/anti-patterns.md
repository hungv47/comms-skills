---
type: anti-patterns
schema_version: 1
last_verified: 2026-05-11
verifier: hungv47
---

# Ad-Copy Anti-Patterns

Banned phrases, structural AI tells, and ceiling-warning triggers for Meta paid-ad copy. Used by `agents/voice-auditor.md` (surface edits + structural BLOCK calls) and `agents/critic.md` (auto-fail conditions).

> Inherits from cold-outreach's `anti-patterns.md` where overlap exists (AI tells, vendor-speak), with ad-specific additions for visible-window economy, ceiling triggers, and ad-format fabrication tells.

---

## 1. Banned Phrases — Vendor-Speak

Zero tolerance. Each is a fix-in-place candidate for voice-auditor (replace with the substitution) unless paired with multiple compound issues (then BLOCK).

| Banned | Substitution |
|--------|--------------|
| "leverage" | "use" |
| "unlock" | "get" / "access" |
| "best-in-class" | name a specific outcome instead |
| "industry-leading" | name the specific number ("ranked #2 in [category]") |
| "premier" | name the specific cohort |
| "world-class" | name a specific named customer |
| "next-level" | name the specific outcome |
| "game-changing" | name what changed and for whom |
| "synergy" | omit; restructure |
| "transformative" | name the transformation |
| "innovative" | name what's new |
| "revolutionary" | name the change |
| "cutting-edge" | name the specific tech |
| "trusted by..." | name 1-2 specific customers |
| "powered by AI" | name what the AI does |
| "supercharge your..." | name the specific lift |
| "streamline" | name the specific friction removed |
| "optimize" | name the specific metric improved |

---

## 2. AI Tells — Structural

Voice-auditor auto-checks each. Critic auto-fails any hit at the Hook or Specificity dim.

### 2a. Setup-sentence opener

First sentence is a meta-statement about the ad's existence rather than substance.

**Examples (auto-fail):**
- "I wanted to share..."
- "We're excited to announce..."
- "Looking for [thing]?"
- "Are you tired of [thing]?"
- "Have you ever wondered...?"
- "I'm reaching out because..."

**Fix:** lead with the substance — the specific anchor, the specific observation, the specific number.

### 2b. Rhetorical question hook

AI theater. Real humans don't open ads with rhetorical questions.

**Examples (auto-fail):**
- "Ever wondered why...?"
- "What if I told you...?"
- "Sound familiar?"
- "Imagine if you could..."
- "Curious about [thing]?"

**Fix:** make a direct statement with a specific anchor.

### 2c. "Just" as hedge

AI's favorite softener. A single instance is fix-in-place.

**Examples:**
- "Just one click..."
- "Just $9..."
- "Just for you..."
- "Just wanted to mention..."

**Fix:** delete "just" — the sentence almost always reads stronger without it.

### 2d. "Quick" as hedge

Same pattern as "just".

**Examples:**
- "Quick question..."
- "Quick tip..."
- "Quickly..."
- "Just a quick note..."

**Fix:** delete "quick" or replace with a specific time/effort estimate.

### 2e. Em-dashes

Zero tolerance — same rule as cold-outreach voice-auditor + humanize terminal pass.

**Fix:** replace every em-dash with a comma, period, or parentheses.

### 2f. Metronomic rhythm

In primary text of 5+ sentences, 4+ consecutive sentences within 2 words of each other in length. AI generates at steady cadence; humans vary.

**Fix:** break the rhythm — alternate short (5-8 words) and long (12-18 words) sentences.

### 2g. Fact-free body

A variant whose primary text contains zero concrete nouns, numbers, or named entities.

**Auto-fail:** voice-auditor BLOCKS rather than patches — composer needs to pull a specific from `available_proof[]`. Critic Specificity Floor fires anyway.

### 2h. Compound-praise specificity

"Your great work in the SaaS space" / "Your impressive growth journey" / "Your incredible team" — generic-flavor adjective + generic-flavor noun. AI-tell from internal synthesis.

**Fix:** replace with named specifics or BLOCK (composer rework).

### 2i. Bracketed-variable leak

Template variables that should have been mapped:

**Examples (auto-fail):**
- "Hi [FirstName]" still in draft
- "Customer [X] saw [Result]" still in draft
- "{{ company_name }}" template syntax leaked

**Auto-fail:** voice-auditor BLOCKS — composer needs to map every variable, not just delete brackets.

---

## 3. Ad-Specific Fabrication Tells

### 3a. False-specificity (framework pattern)

Dressed up to sound specific but not actually verifiable.

**Examples:**
- "Hundreds of B2B SaaS founders trust [product]" (number unbounded; cohort generic)
- "Trusted by leading marketers" (no named marketers)
- "Used by top agencies" (no named agencies)
- "Proven across 1,000+ campaigns" (no source, no scope)

**Fix:** replace with a real named entity + real number, OR remove the claim and lean on a verifiable anchor.

### 3b. Stat without source

Numbers presented as fact without traceable origin.

**Examples (auto-fail):**
- "Studies show..." (no source)
- "Research finds..." (no source)
- "Industry data shows..." (no source)
- "97% of users say..." (no methodology disclosed)

**Fix:** either name the study/source explicitly OR remove the claim.

### 3c. Generalizing a testimonial

A single-customer outcome presented as the typical result.

**Examples:**
- Pattern basis: internal research synthesis.
- Bad ad: "Cut close time 55% (typical result)"
- Good ad: "Customer X cut close time 55%" OR "In our cohort, customers cut close time from ~9 days to ~4 days"

### 3d. Hypothetical as measured

Framing a hypothetical scenario as if it were a measured outcome.

**Examples (auto-fail):**
- "Imagine cutting close time 55% — that's exactly what our customers do"
- "What if you could lose 20 lbs in 30 days? Our customers do."

**Fix:** keep the hypothetical FRAMED as hypothetical OR replace with the actual measured outcome.

---

## 4. Ceiling-Warning Triggers (Strategist + Composer)

These trigger the ceiling-warning artifact section.

### 4a. Repurposed-UGC at scale

If `creative_format=repurposed-ugc` AND user mentions target daily spend > $15K:
- Strategist surfaces ceiling warning per `creative-cadence.md` §5
- Composer surfaces the warning verbatim in the artifact
- Critic verifies the warning is present (Policy dim -2 if missing)

### 4b. Lookalike audiences post-Andromeda

If user mentions lookalike audiences as a targeting strategy:
- Strategist flags in rationale per `meta-cold-traffic.md` §2
- Out of scope for ad-copy (audience setup, not copy) but operator should know
- Recommend broad targeting + algo-via-creative instead

### 4c. Purchase optimization on 3-day trial

If `conversion_event=purchase` AND `offer` contains "3-day trial" / "7-day trial" / "free trial":
- Soft warn at pre-dispatch per `meta-cold-traffic.md` §3
- Recommend `trial_start` conversion event instead
- Proceed as `done_with_concerns` only if user overrides

### 4d. In-house production at scale

If `production_model=in-house` AND user mentions target daily spend > $15K:
- Strategist flags in rationale per `creative-cadence.md` §6
- In-house production caps variant volume; cannot sustain the velocity (50+ variants/month) needed at scale
- Recommend affiliate-creator or external-freelance production

---

## 5. Ad-Format Anti-Patterns

### 5a. Multi-CTA in one ad

**Auto-fail:** composer one-CTA-per-variant rule.

**Examples:**
- "Try free → then upgrade!"
- "Sign up now AND book a demo"
- "Download AND share with your team"

**Fix:** pick one CTA per variant.

### 5b. Paragraph walls in primary text

Single 8+ sentence block in primary text. Mobile feed renders short lines better.

**Fix:** break into 1-2 sentence chunks; cut filler sentences.

### 5c. Hashtags in body

Wasted chars. Meta doesn't reward hashtags in paid ads.

**Fix:** remove hashtags from primary text.

### 5d. Excessive emoji

3+ emoji in headline OR 5+ in primary text reads as low-effort.

**Fix:** use one emoji as stop-cue max; remove decorative emoji.

### 5e. ALL-CAPS headline

Meta-policy auto-reject.

**Fix:** sentence case or title case only.

### 5f. Bait-and-switch CTA

CTA verb doesn't match LP primary action.

**Fix:** match ad CTA verb to LP button verbatim.

### 5g. "Click here" as the entire CTA

Generic CTA with no value framing.

**Fix:** pair the CTA verb with what happens ("Start 14-day trial" beats "Learn more").

---

## 6. Variant Distinctness Anti-Patterns

### 6a. Three variants share the same anchor

**Auto-fail:** Pattern-Interruption dim.

**Fix:** strategist assigns 3 distinct anchors from `available_proof[]`. If only 2 distinct anchors are available, return BLOCKED at strategist layer (need 3 minimum).

### 6b. Three variants share the same archetype

**Auto-fail:** Pattern-Interruption dim.

**Fix:** strategist picks 3 distinct angle archetypes (problem-framing / outcome-asymmetry / peer-observation / specific-result / contrast / curiosity-gap).

### 6c. Surface-level paraphrase

Variant B's primary text is hero's primary text with synonyms swapped.

**Auto-fail:** Pattern-Interruption dim.

**Fix:** rewrite variant from a different archetype + different anchor — not from the same skeleton.

### 6d. Headline distinctness < 10 chars

Levenshtein-distance proxy < 10 chars between any pair of headlines.

**Auto-fail:** format-checker + critic Pattern-Interruption.

**Fix:** compose 3 structurally different headlines (different opening verb, different value framing).

---

## 7. Tone / Register Anti-Patterns

### 7a. Sender-first opening

First 30 chars of primary text mention "We", "Our", "I", or product name.

**Examples:**
- "We help [role] do [thing]..."
- "Our [product] is..."
- "I'm reaching out because..."
- "[Product Name] is the leading..."

**Fix:** re-front with "you/your" or a prospect-side noun.

### 7b. Corporate announcement voice

Reads like a press release.

**Examples:**
- "Introducing the all-new..."
- "We're proud to announce..."
- "Welcome to a new era of..."

**Fix:** drop the announcement framing; lead with what's in it for the reader.

### 7c. Excessive politeness

Adds nothing, costs chars.

**Examples:**
- "We hope you'll consider..."
- "If you have a moment..."
- "Please feel free to..."

**Fix:** delete; ad copy doesn't need politeness padding.

---

## 8. Cross-Reference

- **Vendor-speak anti-patterns:** mirror cold-outreach's `anti-patterns.md` §"Banned Phrases" — same banned list, ad-format additions for visible-window economy and ceiling triggers.
- **AI-tell structural fails:** mirror cold-outreach's auto-fail list (em-dash, "just"/"quick", rhetorical-question hook, setup-sentence opener, fact-free body, generic claim soup) — same rules, scoped to primary text + headline + description.
- **Fabrication anti-patterns:** stack-wide rule from v4.0.3 / v4.0.5 / v4.1.1 anti-fabrication patches — every direct quote/blockquote must trace verbatim to a named source; every measured claim must trace to `available_proof[]` via `claim_list`.
