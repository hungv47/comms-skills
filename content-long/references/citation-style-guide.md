# Citation Style Guide

How to weave external citations and internal links into long-form content — patterns, hygiene rules, attribution norms.

---

## Why Citation Hygiene Matters

For long-form content, citations do four jobs:

1. **Lend authority** — citing recognized experts and original research borrows their credibility
2. **Earn links** — when you cite well, the cited authorities often share/link back
3. **Satisfy AI Overview / featured snippet** — Google's algorithms favor content with structured authority signals
4. **Earn reader trust** — claims with sources beat unsourced assertions every time

Generic "studies show" or "experts say" without naming the study/expert is a failure.

---

## External Citation Patterns

Use varied patterns to avoid monotony. Don't cite the same author in three consecutive paragraphs.

### Inline Attribution

Pattern: "[claim], according to [Author Name]'s [year/work]"

Example:
> Code reviews that take longer than 4 hours have a 60% higher defect-leak rate, according to Greiler's 2024 Microsoft Research paper.

When to use: data points, research findings, definitive claims.

### Quote with Attribution

Pattern: "'[exact quote],' wrote/said/noted [Author], [Affiliation/Work]."

Example:
> "The single biggest factor in code-review effectiveness is reviewer attention," wrote Adam Tornhill in *Code as a Crime Scene*.

When to use: when the exact phrasing matters or carries weight, and when you have permission/fair-use justification.

### Parenthetical Attribution

Pattern: "[claim] ([Source], [year])"

Example:
> Multi-repo context awareness reduces missed bugs by ~40% (Smartbear research, 2025).

When to use: secondary supporting claims, when inline attribution would interrupt flow.

### Footnote-Style (academic-leaning)

Pattern: "[claim][^1]"

```markdown
...as established by Greiler et al.[^1]

[^1]: Greiler, M. et al. (2024). "Modern Code Review at Microsoft." Microsoft Research.
```

When to use: bylines for academic / research-leaning outlets, formal whitepapers. Rare in standard marketing long-form.

### Implicit Attribution (Hyperlink-only)

Pattern: "[claim with embedded hyperlink to source]"

Example:
> Recent research from [Microsoft](URL) shows that...

When to use: less formal pieces, newsletters, when source name is less important than the link.

**Caution:** Implicit attribution is weaker for AI Overview citation. Prefer named attribution for SEO-targeted long-form.

---

## Citation Density

| Format | Citations per 1000 words |
|---|---|
| Pillar guide | 1.5-2.5 (3-12 total in 2500-5000 word piece) |
| Standard blog post | 1.0-2.0 (1-5 total in 1200-2500 word piece) |
| Case study | 0.5-1.0 (mostly internal — protagonist's own data) |
| Byline | 1.5-3.0 (outlets favor well-cited bylines) |
| Press release | 0.5-1.0 (typically just a quote + boilerplate) |
| Newsletter | 0.5-1.5 (lighter, more voice-driven) |

Above the upper range = over-cited (reads as research summary, not original work).
Below the lower range = under-cited (reads as opinion, low authority).

---

## Citation Distribution

Spread citations across H2s, not clumped:

**Good distribution:**
- H2 #1 (definition): 1 citation (canonical authority)
- H2 #2 (problem): 2 citations (data + expert quote)
- H2 #3 (approach): 1 citation
- H2 #4 (counter-argument): 2 citations (one supporting, one for the differentiated view)
- H2 #5 (conclusion): 1 citation (forward-looking statement from a futurist or analyst)

**Bad distribution:**
- H2 #1: 0 citations
- H2 #2: 0 citations
- H2 #3: 0 citations
- H2 #4: 7 citations dumped at the end ← red flag

---

## Source Quality Tiers

| Tier | Source Type | Examples | When to Use |
|---|---|---|---|
| **Tier 1** | Original research, peer-reviewed papers, industry-canonical books | Stanford SE research, Greiler's Microsoft papers, Tornhill's *Code as a Crime Scene* | Always preferred — strongest authority signal |
| **Tier 2** | Industry-standard reports, established analysts | Stripe Atlas, Stack Overflow Survey, GitHub Octoverse, Gartner/Forrester | Strong — widely-cited reports lend cross-cutting credibility |
| **Tier 3** | Recognized practitioner writing | Pragmatic Engineer (Orosz), Stratechery, Lenny's Newsletter, established industry blogs | Good — practitioner authority + audience overlap |
| **Tier 4** | Established media (sector-specific) | TheNewStack, InfoQ, TechCrunch, sector trades | Acceptable — situational, often for current events |
| **Tier 5** | Vendor-published research | SaaS company "state of X" reports | Use with care — flag the vendor; cross-cite Tier 1-3 to validate |
| **Tier 6** | Wikipedia, generic listicles | — | Avoid as primary citation; find the underlying source instead |

**Rule:** Prefer Tier 1-3 for authoritative claims. Tier 4-5 for current-events context. Never cite Tier 6 as primary.

---

## Avoiding Common Citation Failures

### "Studies Show" Failure

❌ "Studies show that code review improves quality."
✅ "Microsoft Research's 2024 study of 6,200 code reviews found that reviewed PRs had 23% fewer post-merge defects than unreviewed PRs."

### "Experts Agree" Failure

❌ "Industry experts agree that AI code review is the future."
✅ "Adam Tornhill, author of *Code as a Crime Scene*, predicts AI code review will become standard by 2027 (Pragmatic Engineer interview, March 2025)."

### Vendor-Stat Without Context Failure

❌ "Code review reduces defects by 80% (Codacy)."
✅ "Codacy's 2024 customer benchmark shows defect reduction of up to 80% (vendor-reported); independent research suggests 20-40% is more typical (Greiler, Microsoft Research, 2024)."

### Date-Less Citation Failure

❌ "According to research from Stanford..."
✅ "According to Stanford's 2023 software-engineering research..."

### URL-Less Citation Failure

❌ "As Tornhill wrote in his book..."
✅ "As Tornhill wrote in *Code as a Crime Scene* (Pragmatic Bookshelf, 2018)..." [with hyperlink to publisher or book page]

### Fabricated Citation Failure (most serious)

❌ "Stanford's 2025 paper on code review..." (paper doesn't exist)
✅ Cite real, verifiable sources only. Fabricated citations destroy credibility and may constitute fraud.

**Critic-agent enforces no-fabrication rule. Every citation must trace to a real, accessible source.**

---

## Internal Link Patterns

### Anchor Text

✅ Use the secondary keyword the linked page targets:
> "...measured by [PR cycle time](URL/pr-cycle-time-guide)..."

❌ Don't use generic anchors:
> "...as we discussed [here](URL)..."
> "...[click here](URL) for more..."
> "...[learn more](URL) about this..."

### Link Placement

✅ Place internal links in contextually relevant sentences:
> "When evaluating tools, [run a 30-day pilot](URL/pilot-framework) to capture real performance data."

❌ Don't dump internal links in the conclusion:
> "Related reading: [link 1] [link 2] [link 3] [link 4]" (fine as a *related-reading* section but not a substitute for contextual links in body)

### Link Density

| Format | Internal Links per 1000 words |
|---|---|
| Pillar guide | 2-4 (5-12 total) |
| Standard blog post | 1-3 (2-7 total) |
| Case study | 1-2 (related case studies) |
| Byline (3rd party) | 0 (typically only author bio link) |
| Press release | 0-1 (typically only boilerplate "About" link) |
| Newsletter | 1-2 (related issues) |

### Brief-Specified vs. Body-Agent-Added

- All brief-specified internal links MUST be placed.
- Body-agent may add additional internal links if contextually relevant.
- seo-compliance-agent verifies all brief-specified links are present.

---

## Attribution Norms by Format

| Format | Attribution Standard |
|---|---|
| Pillar guide | Inline + parenthetical mix; varied patterns; ≥3 external citations |
| Case study | Inline attribution to protagonist (named individuals quoted with permission); minimal external citation |
| Byline | Outlet's style guide overrides; check before submission |
| Press release | AP style; quotes attributed to spokesperson with title; boilerplate at end |
| Newsletter | More casual; hyperlinks acceptable as implicit attribution; named sources for key claims |
| App store / G2 listing | Minimal external attribution; primarily product-fact and use-case |

---

## Quote Permissions

Direct quotes from named individuals require:
- **Public-facing source** (published article, podcast transcript, conference talk, public social post) — fair-use citation acceptable with attribution + URL
- **Permission** if the quote is from a private interview, email, or unpublished source — secure written permission

For case studies featuring customer quotes:
- Always secure written quote approval from the named individual
- Even paraphrases should be approved if attributed to a person

---

## Linking Etiquette (the karma side)

When you cite someone:
- Notify them after publish ("we cited your work in our new pillar — [URL]")
- Tag them on social when sharing
- Many cited authorities will share back if your piece does their work justice — this is how citation earns links

This is part of `cta-agent`'s and the brief's distribution plan, not body-agent's job. But the citation choices in the body enable this distribution.
