---
name: content-long
description: "Drafts long-form content assets — blog posts, pillar guides, case studies, byline articles, press releases, newsletter features, and app store/G2/Capterra listings. Produces `.agents/mkt/content/[slug].md`. Optimized for dwell time, search ranking, citations, and earned media — not feed scrolls. For short-form (social, ads, SMS, OOH, drip email, threads, Reels) use content-short. For UGC/affiliate/bounty briefs use creator-brief. For research before writing, see content-research-long."
argument-hint: "[topic, target keyword, or brief slug]"
allowed-tools: Read Grep Glob Bash WebSearch WebFetch
license: MIT
metadata:
  author: hungv47
  version: "0.1.0"
  budget: deep
  estimated-cost: "$1-3"
promptSignals:
  phrases:
    - "write a blog"
    - "write a blog post"
    - "write a pillar"
    - "write a case study"
    - "write a byline"
    - "write a press release"
    - "write the newsletter"
    - "long-form content"
    - "in-depth article"
    - "app store listing"
    - "G2 listing"
    - "guest post"
    - "byline article"
    - "press release"
    - "evergreen guide"
    - "pillar guide"
    - "topic cluster piece"
  allOf:
    - [write, blog]
    - [write, case-study]
    - [write, byline]
    - [write, press]
  anyOf:
    - "blog"
    - "case study"
    - "byline"
    - "press release"
    - "PR"
    - "newsletter"
    - "pillar"
    - "long-form"
    - "in-depth"
    - "G2"
    - "App Store"
  noneOf:
    - "TikTok"
    - "Reels"
    - "Instagram post"
    - "tweet"
    - "thread"
    - "carousel"
    - "ad creative"
    - "SMS"
    - "OOH"
    - "billboard"
    - "drip"
  minScore: 6
routing:
  intent-tags:
    - long-form-content
    - blog-post
    - pillar-guide
    - case-study
    - byline-article
    - press-release
    - newsletter-feature
    - app-store-listing
    - g2-listing
    - evergreen-content
  position: pipeline
  produces:
    - mkt/content/[slug].md
  consumes:
    - product-context.md
    - icp-research.md
    - mkt/imc-plan.md
    - mkt/content-research-long.md
    - brand/BRAND.md
  requires: []
  defers-to:
    - skill: content-short
      when: "asset is short-form (social, ad, SMS, OOH, drip email, thread, Reel script)"
    - skill: creator-brief
      when: "asset is a brief for a third party (UGC, affiliate, bounty, referral) — not consumer copy"
    - skill: copywriting
      when: "need craft-quality headlines/CTAs/taglines as standalone units, not as part of a long-form piece"
    - skill: humanize
      when: "editing existing AI-sounding text"
    - skill: content-research-long
      when: "need to research what long-form to create before writing"
    - skill: seo
      when: "need to audit a published page for technical SEO, not write a new one"
  parallel-with:
    - design-create
  interactive: false
  estimated-complexity: heavy
---

# Content Long — Orchestrator

*Communication — Long-form content execution. Coordinates specialized agents to turn briefs (from `content-research-long` or direct user input) into production-ready long-form assets optimized for dwell time, search ranking, citations, and earned media.*

**Core Question:** "Would the target reader spend 8+ minutes on this — and would an authority feel honored to be cited in it?"

## When to use this vs. `content-short`

| If your asset is... | Use |
|---|---|
| Blog post, pillar guide, case study, byline, press release, newsletter (feature-length), app store / G2 / Capterra listing, evergreen guide, in-depth Quora answer | **content-long** (this skill) |
| Social post (LinkedIn, X, IG, FB), thread, carousel, Reel/Short script, ad creative, SMS, OOH, drip email, marketing email | **content-short** |
| UGC brief, affiliate description, bounty brief, referral page, internal UGC guidelines | **creator-brief** |

## Critical Gates — Read First

1. **Do NOT write without an outline.** Long-form without an outline becomes shapeless prose. Outline-agent runs first; body-agent works section-by-section from the outline.
2. **Do NOT write outlines or placeholders.** Every agent produces complete copy — every paragraph, every section. "Discuss the trade-offs" is not a deliverable.
3. **Citations are spec, not decoration.** Every claim that requires evidence must cite a source from the brief's Source Map (or be flagged as needing one). "Studies show" without a study is a failure.
4. **Schema markup is part of writing, not after.** SEO-compliance-agent verifies schema before delivery. The outline determines schema (HowTo for procedural, FAQPage for FAQs, Comparison for vs-pieces).
5. **Stale brief data (>30 days for SERP, >90 days for audience research) produces misaligned content.** Recommend re-running `content-research-long` if the brief is old.
6. **Format-specific compliance is non-negotiable for regulated formats.** Press releases need embargo metadata, dateline, boilerplate. Case studies need protagonist consent. App store/G2 listings must follow platform metadata policies. Bylines must follow outlet style guides.

## Philosophy

Long-form earns its place through depth, citations, and a reading experience that rewards time spent. The job is not to fill word count — it's to deliver a complete answer to a real question, with evidence the reader trusts and structure they can navigate.

Where `content-short` competes for attention in a feed, `content-long` competes for ranking, dwell time, citations, and subscriptions. Different game, different craft.

For copy craft (variation workflows, evaluation rubrics, annotation), use `copywriting`. This skill produces the long-form asset; `copywriting` polishes individual lines (titles, ledes, CTAs) at the unit level.

## Inputs Required

- A long-form brief — ideally from `.agents/mkt/content-research-long.md` (Route E briefs); otherwise built inline from user input
- Target format (pillar / case study / byline / press release / newsletter / listing) — derived from brief or user input
- Audience and angle — from brief or `.agents/mkt/imc-plan.md`

## Output

- `.agents/mkt/content/[slug].md` (the long-form asset)
- `.agents/mkt/content/[slug].meta.md` (title variants, meta description variants, schema markup, distribution checklist)

## Quality Gate

Before delivering, the **critic agent** verifies:
- [ ] Lede + nut graf land within first 100 words and pass the "would an editor cut this?" test
- [ ] Outline depth matches brief target (≥4 H2s, sub-H3s where outline calls for them)
- [ ] Word count within ±20% of brief target — depth justifies length
- [ ] ≥3 external citations from Source Map with URL + author + publication
- [ ] ≥3 internal links to related domain content (or flagged "no existing coverage")
- [ ] ≥1 counter-argument from brief's Deep Listening addressed in dedicated H2
- [ ] Audience language present (≥3 phrases from brief's deep-listening pulled in)
- [ ] Schema markup correct for intent (Article + FAQPage + HowTo / Comparison / Review as appropriate)
- [ ] Meta description ≤155 chars, primary keyword in first 60 chars, CTA-shaped
- [ ] Title ≤60 chars (or formatted to wrap), primary keyword present
- [ ] SERP feature target addressed (answer-first paragraph for snippet, structured data for AI Overview, PAA-shaped H2s)
- [ ] CTA(s) present and intent-appropriate (not a hard sell at the top of a TOFU informational piece)
- [ ] No "outline" placeholders ("[expand]", "discuss X", "TBD")
- [ ] No fabricated citations, statistics, or quotes — every claim is sourced
- [ ] Reads cleanly aloud — sentence rhythm varied, no repetitive structures

## Chain Position

Previous: `content-research-long`, `imc-plan` | Next: `seo` (post-publish audit), `attribution` (track impact), `humanize` (if reads AI-y)

**Re-run triggers:** When the brief is updated, when SERP shifts (new ranker, new AI Overview cited URLs), when a Tier-1 authority publishes the same angle (re-position), when ranking plateaus and structural rewrite is needed.

### Skill Deference

- **Need craft-quality headlines or unit-level copy refinement?** → Run `copywriting` on the title/lede/CTA after this skill.
- **Asset reads AI-generated?** → Run `humanize` after.
- **Need to research what to write?** → Run `content-research-long` first.
- **Optimizing already-published page for SEO?** → Run `seo` instead — that audits live; this writes new.
- **Asset is short-form?** → Use `content-short` instead.

---

## Agent Manifest

8 agents across 3 layers:

| Agent | Layer | File | Focus |
|-------|-------|------|-------|
| format-agent | 1 (parallel) | `agents/format-agent.md` | Resolves long-form format (pillar / case study / byline / PR / newsletter / listing) and pulls format-specific specs (word count, structure, schema, distribution requirements) |
| voc-extraction-agent | 1 (parallel) | `agents/voc-extraction-agent.md` | Pulls audience language from brief's deep-listening + ICP research; surfaces 5-10 phrases with sources for body to weave in |
| lede-agent | 1.5 (after format) | `agents/lede-agent.md` | Writes the lede + nut graf (first 100 words) — sets up the entire piece, optimized for dwell time and (if applicable) featured snippet |
| body-agent | 1.5 (after format) | `agents/body-agent.md` | Writes the full body from the brief's outline — section-by-section, weaving citations from Source Map and internal links |
| cta-agent | 1.5 (after format) | `agents/cta-agent.md` | Designs intent-appropriate CTAs (in-content + end CTA + sidebar) with placement logic |
| seo-compliance-agent | 2 (sequential) | `agents/seo-compliance-agent.md` | Validates schema markup, meta description, title length, internal-link structure, alt text, keyword density, SERP feature targeting |
| title-variant-agent | 2 (sequential) | `agents/title-variant-agent.md` | Generates 3-5 title + meta description variants for SEO/CTR testing |
| critic-agent | 2 (final) | `agents/critic-agent.md` | Long-form quality gate — lede strength, proof density, scannability, narrative arc, citation hygiene |

### Shared References (read by multiple agents)

- `references/long-form-format-specs.md` — Per-format specs (pillar, case study, byline, PR, newsletter, listing): word count ranges, structure expectations, schema, distribution requirements
- `references/citation-style-guide.md` — External citation patterns, internal link logic, source hygiene, attribution norms
- `references/seo-checklist.md` — Schema by intent, meta description patterns, alt text, technical SEO

---

## Routing Logic

### Route A: Single Piece

**When:** One blog post, one case study, one byline, one PR, one newsletter feature — not part of a multi-piece cluster.

```
1. Pre-dispatch: Gather context (Step 0) — load brief from content-research-long.md OR build inline
2. LAYER 1 — Dispatch IN PARALLEL:
   - format-agent (resolves format, pulls format specs)
   - voc-extraction-agent (pulls audience phrases)
3. LAYER 1.5 — Dispatch IN PARALLEL (after format-agent returns):
   - lede-agent (receives format specs + VoC + brief)
   - body-agent (receives format specs + VoC + brief outline)
   - cta-agent (receives format specs + VoC + brief intent)
4. MERGE: Assemble lede + body + CTA into unified asset following format spec
5. LAYER 2 — Dispatch SEQUENTIALLY:
   - seo-compliance-agent (validates schema, meta, internal links, keyword density)
   - title-variant-agent (3-5 title + meta description variants)
6. Dispatch: critic-agent (final long-form quality gate)
7. If FAIL → re-dispatch named agent(s) with feedback (max 2 cycles)
8. Deliver artifact + meta artifact
```

### Route B: Pillar + Cluster

**When:** A full topic cluster from a `content-research-long` Route E brief — pillar piece + 3-7 cluster pieces.

```
1. Pre-dispatch: Load Route E brief from content-research-long.md
2. Confirm cluster sequencing recommendation with user (or accept default)
3. For each piece in sequence (cluster pieces first to build internal-link foundation, then pillar, then remaining clusters):
   - Run Route A end-to-end
   - Update internal-link map after each piece (later pieces link to earlier ones)
4. Final pass: cross-link audit (every cluster links UP to pillar; pillar links DOWN to all clusters; siblings cross-link)
5. Deliver cluster artifact set + cross-link map + distribution sequencing recommendation
```

### Route C: Press Release / Byline

**When:** PR or byline article with embargo, attribution, and outlet-specific style requirements.

```
1. Pre-dispatch: Confirm outlet (for byline), embargo date (for PR), and approval chain
2. format-agent applies PR/byline template (dateline, lede, body, boilerplate, contact for PR; outlet style guide for byline)
3. body-agent uses outlet-specific style (AP for PR, outlet's published style guide for byline)
4. seo-compliance-agent skipped or modified (PR/byline often won't carry our schema)
5. Critic verifies attribution, embargo metadata, outlet alignment
6. Deliver asset + media kit recommendations (for PR) OR pitch email (for byline)
```

### Route D: Newsletter Feature

**When:** Long-form for our own newsletter or as a guest feature in someone else's newsletter.

```
1. Pre-dispatch: Confirm newsletter (ours vs. third-party), word-count constraint, format constraints
2. format-agent applies newsletter spec (no schema, simpler structure, often more voice-driven)
3. body-agent prioritizes voice + narrative arc over SEO depth
4. CTA-agent emphasizes subscribe / reply / share over external action
5. Critic verifies engagement-friendly structure (scannable, voice-consistent, share-worthy quote pulled out)
6. Deliver asset + share-quote recommendations
```

### Route E: Called by Another Skill

**When:** Invoked by `imc-plan`, `attribution`, or workflow orchestrator for inline long-form work.

```
1. Read context from calling skill's artifacts
2. Dispatch relevant agents based on caller needs (typically Route A subset)
3. Dispatch: critic-agent
4. Return content to calling skill
```

---

## Dispatch Protocol

### Step 0: Context Gathering

Check for upstream artifacts in this priority order:

1. **`.agents/mkt/content-research-long.md`** — long-form brief from research (preferred)
2. **`.agents/mkt/imc-plan.md`** — channel strategy and angles
3. **`research/icp-research.md`** — audience profile
4. **`research/product-context.md`** — product context
5. **`brand/BRAND.md`** + **`brand/DESIGN.md`** — voice, tone, positioning
6. **`.agents/mkt/content-research.md`** *(optional)* — short-form research may have related audience signals

If no brief exists: interview for the minimum viable context:
1. **What's the target keyword or topic?** — Primary keyword + intent
2. **What format?** — Blog post / pillar / case study / byline / PR / newsletter / listing
3. **Who's the audience?** — ICP role + sophistication
4. **What's the goal?** — Search ranking / earned media / subscriptions / sales / demand gen
5. **Outlet (if byline/PR) or distribution channel** — Specific destination
6. **Word-count guidance** — From SERP analysis if available, otherwise format default

### Step 1: Route Selection

Based on the user's request and brief:

- Single piece → Route A
- Topic cluster from Route E brief → Route B
- PR or byline → Route C
- Newsletter feature → Route D
- Called by another skill → Route E

### Single-Agent Fallback

If the task is narrow (e.g., "just write the lede for this brief"), dispatch only the relevant agent. Skip the full pipeline. Return the single agent's output directly.

---

## Layer 1 Dispatch — Parallel Context Agents

```
context = {
  brief: [from content-research-long.md or built inline],
  format: [pillar / case study / byline / PR / newsletter / listing],
  audience: [ICP role + sophistication from brief or icp-research],
  product_context: [from product-context.md],
  voice_specs: [from BRAND.md + DESIGN.md],
  outline: [from brief — H2s + key sub-points],
  source_map: [from brief — external citations + expert quotes + distribution],
  internal_links: [from brief — internal-link targets],
  goal: [search ranking / earned media / subscriptions / sales],
  outlet: [if byline/PR] | null,
  embargo: [if PR — date + time + timezone] | null
}
```

**Dispatch in parallel:**
- `format-agent` — resolves format and pulls format-specific specs
- `voc-extraction-agent` — pulls 5-10 audience phrases with sources

### Layer 1.5 Dispatch — Parallel Writers

After `format-agent` returns format specs:

**Dispatch in parallel:**
- `lede-agent` — writes lede + nut graf (first 100 words)
- `body-agent` — writes body section-by-section from outline
- `cta-agent` — designs CTAs with placement

### Merge Step

Assemble lede + body + CTA into the format-specific template (long-form-format-specs.md). Verify:
- Lede flows into body's first H2 without abrupt transition
- Body sections weave VoC phrases naturally
- Citations from Source Map appear at appropriate H2s (not all clumped at the end)
- Internal links land in contextually relevant H2s
- CTAs placed at intent-appropriate moments (not at top of TOFU informational)

---

## Layer 2 Dispatch — Sequential Refiners

### Step 1: SEO Compliance Agent

```
dispatch seo-compliance-agent:
  upstream: [merged asset]
  references: [references/seo-checklist.md]
```

Validates: schema markup correctness, meta description (≤155 chars + primary keyword + CTA-shape), title (≤60 chars + primary keyword), internal-link structure, alt text on images, keyword density (target keyword appears in title + lede + ≥1 H2 + body 3-7x naturally), SERP feature targeting (answer-first paragraph for snippet, FAQPage schema for PAA), canonical URL.

### Step 2: Title Variant Agent

```
dispatch title-variant-agent:
  upstream: [SEO-compliant asset]
  references: [references/long-form-format-specs.md]
```

Generates 3-5 title + meta description variants for SEO/CTR testing. Variants vary: emotion (curiosity vs. clarity), specificity (numbered vs. open), framing (positive vs. contrarian), keyword position (front vs. back).

### Step 3: Critic Agent

```
dispatch critic-agent:
  upstream: [final asset + variants]
  references: [references/long-form-format-specs.md, references/citation-style-guide.md]
```

Long-form quality gate. Returns PASS or FAIL.

---

## Critic Gate — Max 2 Cycles

```
cycle = 0
while cycle < 2:
  verdict = critic-agent.evaluate(artifact)
  if verdict == PASS:
    break
  else:
    for each failure:
      re-dispatch named agent with feedback
    merge fixes into artifact
    cycle += 1

if cycle == 2 and verdict == FAIL:
  deliver artifact with critic's remaining notes as "[REVIEWER NOTE]" annotations
  warn user: "Artifact delivered with quality notes — some items could not be resolved in 2 cycles."
```

**On rewrite:** Only re-dispatch agents the critic names. Do not re-run the entire pipeline.

---

## Artifact Template

```markdown
---
skill: content-long
slug: [slug]
format: [pillar / case study / byline / press release / newsletter / listing]
target_keyword: [primary keyword]
intent: [informational / commercial / transactional / navigational + sub-intent]
word_count: [actual count]
date: {{today}}
status: draft
---

# [Final Title]

**Meta description:** [≤155 chars, primary keyword in first 60 chars, CTA-shaped]

**Target keyword:** [primary] | **Intent:** [type] | **Format:** [type]

---

## TL;DR
[40-80 word summary — the answer to the implicit question, before the user reads anything else]

## [H2 #1 — typically definition or framing]

[Lede paragraph — 40-60 words, optimized for featured snippet if targeted]

[Nut graf — explains why this piece matters, what reader will get, sets expectation]

[Body of section, with embedded citations: "According to [Authority Name]'s 2025 research ([URL])..." and internal links: "[anchor text](internal URL)"]

## [H2 #2]

[Section with body, citations, and internal links woven in]

## [H2 #3]

...

## [H2 — counter-argument, if applicable]

[Address the counter-argument from brief's deep-listening directly. State the conventional wisdom, then your differentiated take with evidence.]

## [H2 — synthesis / next steps / FAQ]

[Closing section. If FAQ: structured FAQ with questions phrased exactly as PAA. Schema: FAQPage.]

---

## CTA (if intent-appropriate)
[Primary CTA — action verb + clear value]

[Secondary CTA — for users not ready for primary, e.g., newsletter signup, related read]
```

The companion meta artifact (`[slug].meta.md`):

```markdown
---
slug: [slug]
date: {{today}}
---

# [slug] — Meta Artifact

## Title Variants (for A/B test)
1. [Variant 1] — [hypothesis: tests X]
2. [Variant 2] — [hypothesis: tests Y]
3. [Variant 3] — [hypothesis: tests Z]

## Meta Description Variants
1. [Variant 1, ≤155 chars]
2. [Variant 2, ≤155 chars]
3. [Variant 3, ≤155 chars]

## Schema Markup
```json
{
  "@context": "https://schema.org",
  "@type": "Article",
  ...
}
```

## SEO Compliance Report
- Title length: [#] chars
- Meta description length: [#] chars
- Primary keyword density: [%]
- Internal links: [#] (target: ≥3)
- External citations: [#] (target: ≥3)
- Schema types: [list]
- SERP feature target: [featured snippet / AI Overview citation / PAA inclusion]

## Distribution Checklist
- [ ] UTM URLs generated for all distribution links
- [ ] Newsletter feature pitched to: [from brief Source Map]
- [ ] LinkedIn share queued for: [author/executive] — share copy attached
- [ ] Reddit / community: [subreddit + posting plan]
- [ ] Podcast pitch sent to: [show + host]
- [ ] Authority outreach: [Person → ask: cite, share, quote]
- [ ] Internal-link map updated (next pillar/cluster pieces should link here)
- [ ] GSC monitoring queries added: [primary + long-tails]

## Tracking
- Earned-link target: [N within X months]
- Newsletter mentions target: [N within X months]
- Organic ranking target: [position] for [primary keyword] within [N] months
```

---

## Worked Example

**User:** "Write the pillar piece for our code review topic cluster — brief is in `.agents/mkt/content-research-long.md`."

**Route B (Pillar + Cluster).** Brief specifies: target keyword "code review best practices", intent informational, top-5 median 4500 words, outline of 8 H2s, cite Tornhill + Greiler + Stanford, address counter-argument "we adopted code review and shipped slower."

**L1 parallel:**
- format-agent resolved as pillar guide → applied pillar specs (4000-6000 words, FAQPage + Article schema, internal-link to all 5 clusters when published, image pack with original visuals).
- voc-extraction-agent pulled 7 phrases from brief's deep-listening: "review tax", "PR bottleneck", "team learning loop", "tools don't fix process", "shipped slower", "review fatigue", "feature factory."

**L1.5 parallel writers:**
- lede-agent wrote 60-word lede + 80-word nut graf, opening with stat from Greiler's Microsoft research, framing the counter-argument as the unifying tension.
- body-agent wrote 8 H2s totaling 4800 words. Wove Tornhill citation into H2 #2 (definition), Greiler into H2 #4 (metrics), Stanford paper into H2 #6 (counter-argument). Internal-link placeholders for 5 future cluster pieces.
- cta-agent placed soft mid-content CTA (newsletter signup with code-review checklist), end CTA (related cluster pieces "to be published" placeholder), sidebar CTA (download original benchmark data).

**Merge:** assembled with FAQPage section at end built from brief's PAA list (8 questions, ~80 words each).

**L2 sequential:**
- seo-compliance-agent validated schema (Article + FAQPage + HowTo for procedural H2 #3), meta description 142 chars, title 58 chars, primary keyword in title + lede + 2 H2s + 6x in body, alt text on 4 images.
- title-variant-agent generated 3 variants:
  1. "The 2026 Code Review Playbook for Engineering Teams" (clarity)
  2. "We Reviewed 2 Million Code Reviews. Here's What Works." (curiosity + data)
  3. "Code Review in 2026: 12 Practices That Top Engineering Teams Use" (specificity + numbered)

**Critic:** PASS. "Lede earns the click. Counter-argument H2 is the strongest section. Cite-and-distribute plan for Tornhill outreach is solid."

Then ran each cluster piece (1-5) via Route A in sequence, updating internal links as each published.

---

## Anti-Patterns

**Word-count padding** — Hitting 5000 words by repeating the same point in different ways. Length should match outline substance, not target a number.
**INSTEAD:** Outline-driven word allocation. If outline justifies 3500 words, the piece is 3500 words. Padding fails the critic.

**Citation theater** — "According to industry experts" without naming anyone. Or "Studies show" with no study cited.
**INSTEAD:** Every claim that requires evidence cites a specific source from the brief's Source Map. If no source exists, the claim is removed or flagged for research.

**Generic listicles for competitive queries** — "Top 10 Code Review Tools" written by a DR 30 site against DR 80+ competitors will not rank.
**INSTEAD:** Brief should have called this out (out-of-reach difficulty); pivot to long-tail flank or counter-argument angle.

**Outlines and placeholders in delivered copy** — "[Expand on benefits]" or "Discuss the trade-offs" left in the asset.
**INSTEAD:** Critic enforces no-placeholder rule. Every section is fully written. If the agent can't write it, the brief is incomplete and gets flagged.

**Buried lede** — The actual answer is in H2 #5; the first 500 words are throat-clearing.
**INSTEAD:** Lede + nut graf land within first 100 words. The reader knows what they're getting before scrolling.

**TOFU piece with hard sales CTA** — "Start your free trial today!" at the top of a 101-style explainer. Wrong intent for the funnel stage.
**INSTEAD:** CTA-agent matches CTA intensity to funnel stage. TOFU = soft (newsletter, related read). MOFU = medium (calculator, comparison). BOFU = direct (demo, trial).

**Schema mismatch** — Using HowTo schema on a comparison post, or no schema at all.
**INSTEAD:** SEO-compliance-agent verifies schema matches outline shape and intent. FAQPage for FAQ sections, HowTo for procedural, Comparison for vs-pieces, Review for case studies.

**Counter-argument ignored** — Brief surfaced an objection from deep-listening, asset doesn't address it.
**INSTEAD:** Critic enforces ≥1 counter-argument H2 when brief lists one. Differentiation is the point.

**Distribution-blind delivery** — "Here's the post, publish it" without distribution checklist.
**INSTEAD:** Companion meta artifact includes distribution checklist drawn from brief's Source Map (newsletters, podcasts, authorities for outreach).

**Voice drift across long-form** — Tone shifts between sections because different agents wrote them. Reads like a Frankenstein piece.
**INSTEAD:** All writer-agents (lede, body, cta) read voice_specs from BRAND.md before writing. Critic checks voice consistency.

**Stale brief** — Writing from a 6-month-old SERP analysis when the SERP has shifted.
**INSTEAD:** Step 0 checks brief age. >30 days for SERP data triggers re-run recommendation for content-research-long.

---

## Required Artifacts

None — works with brief OR inline interview. Strongly preferred: `.agents/mkt/content-research-long.md`.

### Optional Artifacts

| Artifact | Source | Benefit |
|----------|--------|---------|
| `content-research-long.md` | content-research-long | Full brief: keyword, intent, outline, sources, distribution — eliminates inline interview |
| `imc-plan.md` | imc-plan | Channel strategy and angle context |
| `icp-research.md` | icp-research | Audience profile for sophistication calibration |
| `product-context.md` | icp-research | Product context for examples and positioning |
| `BRAND.md` | brand-system | Voice and tone specs |
| `content-research.md` | content-research (short-form) | Adjacent audience signals if running both short and long campaigns |

---

## References

- [references/long-form-format-specs.md](references/long-form-format-specs.md) — Per-format specs (pillar, case study, byline, PR, newsletter, listing): word count, structure, schema, distribution
- [references/citation-style-guide.md](references/citation-style-guide.md) — External citation patterns, internal link logic, source hygiene
- [references/seo-checklist.md](references/seo-checklist.md) — Schema by intent, meta description patterns, alt text, technical SEO
