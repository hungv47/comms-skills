# AI SEO (AEO) Reference

Platform-specific optimization details and citation-optimized content templates.

---

## Research-Backed Optimization Methods

**Source:** Princeton GEO Study (KDD 2024) — tested 9 optimization methods across multiple AI platforms and measured visibility boost.

| Method | Visibility Boost | Notes |
|--------|-----------------|-------|
| Cite sources | +40% | Highest single impact. AI systems trust content that references other sources. |
| Add statistics | +37% | Specific numbers with sources outperform vague claims. |
| Add quotations | +30% | Expert quotes signal authority and original reporting. |
| Improve fluency | +25% | Clear, well-structured writing. |
| Authoritative tone | +20% | Confident, expert voice. |
| Technical terminology | +15% | Domain-specific language signals depth. |
| Easy-to-understand | +10% | Accessible explanations (complementary to technical). |
| Unique words | +5% | Distinctive vocabulary. |
| Keyword stuffing | **-10%** | Actively reduces AI visibility. Opposite of traditional SEO intuition. |

**Content-Answer Fit** (ZipTie study): 55% of ChatGPT citation likelihood comes from matching ChatGPT's own response format. Domain authority accounts for only 12%, on-page structure 14%. Implication: study how each AI platform formats its answers, then structure your content to match that format.

**Key takeaway:** The highest-leverage AEO actions are (1) cite sources in your content, (2) include specific statistics, (3) include expert quotes. These three are the highest-impact individual methods (+40%, +37%, +30% respectively). Apply all three — the combined effect is significant even if not strictly additive. Keyword stuffing actively hurts.

---

## Platform-Specific Optimization

### Google AI Overviews

**Data source:** Traditional Google Search index + structured data + Knowledge Graph

**What gets cited:**
- Content already ranking well in traditional search
- Pages with FAQ and How-To schema markup
- Content with strong E-E-A-T signals
- Featured snippet content (often pulled directly into AI Overviews)

**Priority actions:**
1. Implement structured data (FAQ, How-To, Article schema)
2. Optimize for featured snippets (direct answers at top of content)
3. Maintain strong traditional SEO fundamentals
4. Complete Google Business Profile
5. Build entity associations in Knowledge Graph

**Note:** Google AI Overviews appear in ~45% of searches and can reduce clicks by up to 58%. Being cited in the AI Overview is increasingly important for maintaining traffic.

### ChatGPT (with browsing)

**Data source:** Bing index + GPTBot crawl + training data

**What gets cited:**
- Third-party reviews and mentions (heavily weighted)
- Original research and proprietary data
- Well-structured comparison content
- Content from high-authority domains

**Priority actions:**
1. Allow GPTBot in robots.txt
2. Build third-party mentions (review sites, industry publications)
3. Publish original data that can't be found elsewhere
4. Ensure consistent entity information across the web

**Key insight:** ChatGPT heavily weights third-party sources. Your G2 profile may matter more than your own website for ChatGPT citations.

### Perplexity

**Data source:** PerplexityBot (own crawler) + Bing + multiple search APIs

**What gets cited:**
- Content with inline source citations (Perplexity loves content that itself cites sources)
- Structured comparison tables
- Direct answer passages (40-60 words)
- Recent content (aggressive freshness preference)

**Priority actions:**
1. Allow PerplexityBot in robots.txt
2. Cite sources within your content
3. Use comparison tables extensively
4. Write clear 40-60 word answer blocks under H2 headings
5. Keep content fresh — update dates and data regularly

**Key insight:** Perplexity always shows its sources. Getting cited creates a visible, clickable attribution.

### Claude

**Data source:** Training data + ClaudeBot crawl

**What gets cited:**
- Expert-attributed content with clear credentials
- Nuanced, balanced analysis (not marketing fluff)
- Content that acknowledges tradeoffs and limitations
- Original research and data

**Priority actions:**
1. Allow ClaudeBot in robots.txt
2. Publish expert-authored content with clear attribution
3. Create balanced analysis acknowledging limitations
4. Provide original data and unique insights

**Key insight:** Claude prefers balanced, honest content. Acknowledging tradeoffs may perform better than pure sales copy.

### Gemini

**Data source:** Google index + Knowledge Graph + Google Business Profile

**Priority actions:**
1. Optimize Google Business Profile completely
2. Build Knowledge Graph presence
3. Publish on YouTube (Gemini has preferential access)
4. Implement Organization and Product schema

---

## Citation-Optimized Content Templates

### FAQ Content (citation goldmine)

```markdown
## [Exact question the audience asks — use their language]

[40-60 word direct answer. Lead with the answer, not context.
Include a specific number, date, or fact. Cite a source.]

According to [source], [supporting evidence].
```

**Rules:**
- Use exact audience questions (from ICP research)
- Answer in the first sentence — don't build up to it
- Each answer: 40-60 words
- Always cite a source or provide original data
- Implement FAQ schema markup

### Comparison Article

```markdown
# [Product A] vs [Product B]: [Specific Use Case] ([Year])

[40-60 word summary answering "which is better?" with a direct
recommendation and the key differentiator.]

## Quick Comparison

| Feature | [Product A] | [Product B] |
|---------|-------------|-------------|
| Best for | [specific use case] | [specific use case] |
| Price | [specific price] | [specific price] |
| [Key feature 1] | [detail] | [detail] |

## Our Recommendation

[Direct answer: who should use which, and why. 40-60 words.]
```

### Original Research

```markdown
# [Year] [Topic] Report: [Key Finding in Headline]

## Key Findings

- [Finding 1]: [Specific number] — [one sentence context]
- [Finding 2]: [Specific number] — [one sentence context]

## Methodology

- Sample: [N respondents/data points]
- Period: [date range]
- Method: [survey/analysis/benchmark]
```

### How-To Guide

```markdown
# How to [Specific Outcome] in [Steps/Timeframe]

[40-60 word summary with specific metric or result.]

## Step 1: [Action Verb] [Object]

[What to do, why, how to verify.]

## Common Mistakes

1. **[Mistake]** — [consequence]. Instead: [correct approach].
```

---

## AI Visibility Monitoring

### Monthly Audit Queries

Test these across ChatGPT, Perplexity, Google AI Overviews, Claude:
1. "What is [your product]?"
2. "Best [your category] tools"
3. "[Your product] vs [top competitor]"
4. "[Your category] for [your ICP use case]"
5. "How to [problem your product solves]"

### Monitoring Tools

| Tool | What It Tracks | URL |
|------|---------------|-----|
| Otterly AI | AI search visibility across platforms | otterly.ai |
| Peec AI | AI citation tracking | peec.ai |
| ZipTie | Brand monitoring in AI answers | ziptie.dev |

### Tracking Template

| Query | Platform | Mentioned? | Cited? | Accurate? | Date Checked |
|-------|----------|-----------|--------|-----------|-------------|
| [query] | ChatGPT | Y/N | Y/N | Y/N | [date] |
| [query] | Perplexity | Y/N | Y/N | Y/N | [date] |

---

## Machine-Readable Discovery Files

AI agents increasingly browse on behalf of users — comparing products, evaluating options, making purchase recommendations. These files make your site legible to AI agents doing research.

### llms.txt

A `/llms.txt` file at your domain root tells AI crawlers what your site does, what's important, and where to find key content. Think of it as `robots.txt` for understanding, not crawling.

```text
# [Company Name]

> [One-sentence description of what the company does]

## Key Pages

- [Homepage](https://example.com): [What visitors find here]
- [Pricing](https://example.com/pricing): [Plans and pricing]
- [Docs](https://example.com/docs): [API/product documentation]
- [Blog](https://example.com/blog): [Thought leadership and updates]

## Product

- Category: [e.g., "Project Management Software"]
- Best for: [specific ICP use case]
- Pricing model: [freemium/subscription/usage-based]
- Key differentiator: [one sentence]
```

**When to recommend:** Always for AI mode audits. Low effort, high signal for AI agent discovery.

### pricing.md

A `/pricing.md` file provides structured pricing data that AI agents can parse when comparing products. This is becoming a standard for AI-mediated buying journeys.

```markdown
# [Product] Pricing

## Plans

| Plan | Price | Best for | Key features |
|------|-------|----------|-------------|
| Free | $0/mo | [use case] | [features] |
| Pro | $X/mo | [use case] | [everything in Free + features] |
| Enterprise | Custom | [use case] | [everything in Pro + features] |

## FAQ

**Is there a free trial?** [answer]
**What payment methods?** [answer]
**Annual discount?** [answer]
```

**When to recommend:** For any product/SaaS site running AI mode. AI agents doing purchase research will parse this over scraping a complex pricing page.

### robots.txt AI Bot Allowlist (consolidated)

Ensure these bots are allowed in `robots.txt`:

```
# AI Search Bots — allow for AEO visibility
User-agent: GPTBot
Allow: /

User-agent: ChatGPT-User
Allow: /

User-agent: PerplexityBot
Allow: /

User-agent: ClaudeBot
Allow: /

User-agent: Google-Extended
Allow: /

User-agent: Applebot-Extended
Allow: /

User-agent: Bytespider
Allow: /

User-agent: cohere-ai
Allow: /
```

**Notes:**
- Many sites block these by default. The AI mode audit should check `robots.txt` for blocks and recommend unblocking as a priority action.
- **Bytespider** (ByteDance/TikTok) is aggressive — recommend allowing only if the client targets Chinese markets or TikTok discovery. Otherwise, block.
