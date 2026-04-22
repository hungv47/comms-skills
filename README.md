# Marketing Skills

Brand identity, content creation, campaign planning, optimization, localization polish, outbound, and performance attribution. 10 skills.

## Install

Installs via the [`skills` CLI](https://skills.sh). Requires Node.js 18+. Auto-detects Claude Code, Cursor, Codex, Windsurf, Gemini CLI, or VS Code.

```bash
# Install the full marketing stack
npx skills add hungv47/marketing-skills

# Cherry-pick a single skill (any skill in the stack — these are just examples)
npx skills add hungv47/marketing-skills --skill copywriting
npx skills add hungv47/marketing-skills --skill seo
npx skills add hungv47/marketing-skills --skill humanize

# List available skills without installing
npx skills add hungv47/marketing-skills --list

# Target a specific editor
npx skills add hungv47/marketing-skills --agent claude-code

# Install globally (available in every project)
npx skills add hungv47/marketing-skills -g
```

See the [root README](https://github.com/hungv47/agent-skills#install) for the full install reference.

## Pipeline

<picture>
  <img src="./assets/pipeline.svg" alt="Marketing pipeline: brand-system → imc-plan → content-create → attribution, plus horizontal copywriting, lp-optimization, seo, humanize, vn-tone" width="100%">
</picture>

## Skills

### `brand-system` — build a visual identity

Creates brand identity systems — color palettes, typography, design tokens, logo guidelines, voice definition, and component specs.

**Use when:**
- You're launching a product and need a cohesive visual identity before any marketing
- You want design tokens that ensure consistency across all touchpoints
- You need brand voice guidelines that content creators can follow

**Not for:** writing marketing copy (use `content-create`) or mapping user flows (use `user-flow`)

**Produces:** `brand/BRAND.md` + `brand/DESIGN.md`

---

### `imc-plan` — plan the campaign

Creates integrated marketing plans — channel strategy, positioning, content calendar, budget allocation, and go-to-market timelines.

**Use when:**
- You're planning a product launch and need to decide where, when, and how much to spend
- You want a structured content calendar with channel-specific tactics
- You need to allocate budget across PLG and SLG channels

**Not for:** writing actual content (use `content-create`) or setting numeric targets (use `funnel-planner`)

**Produces:** `.agents/mkt/imc-plan.md`

---

### `content-create` — draft marketing content

Drafts social posts, ads, emails, newsletters, blog posts, case studies, video scripts, and launch announcements in platform-native formats with A/B variants.

**Use when:**
- You need a specific content asset — a LinkedIn carousel, email sequence, blog post, or video script
- You want content drafted in the correct format for the target platform
- You need A/B variants for testing

**Not for:** editing existing text (use `humanize`) or persuasive headlines and CTAs (use `copywriting`)

**Produces:** `.agents/mkt/content/[slug].md`

---

### `copywriting` — write persuasive copy

Headlines, hooks, CTAs, taglines, and full-page section copy with rubric scoring, annotations, and ranked alternatives.

**Use when:**
- You need a headline that stops scrolling or a CTA that converts
- You have existing copy that needs to be sharper, more specific, or more persuasive
- You want copy evaluated with a rubric and scored alternatives

**Not for:** full content assets like blog posts or emails (use `content-create`) or AI pattern removal (use `humanize`)

**Produces:** `.agents/mkt/content/[slug].copy.md`

---

### `lp-optimization` — improve landing page conversion

Audits hero section, CTAs, social proof, objection handling, and page flow. Produces specific copy and structure change recommendations.

**Use when:**
- Your landing page isn't converting and you need a diagnostic
- You want a prioritized list of changes ranked by expected conversion impact
- You're preparing for a paid traffic campaign and want the page ready

**Not for:** A/B testing variants (use `experiment`) or full site SEO audits (use `seo`)

**Produces:** `.agents/mkt/lp-optimization.md`

---

### `seo` — grow organic visibility

Technical audit, keyword research, AI/AEO optimization, programmatic SEO, competitor analysis, and app store optimization (ASO).

**Use when:**
- You want more organic traffic from search engines or AI answer engines
- You need a technical SEO audit of your site
- You want to build programmatic SEO pages at scale
- You need app store optimization for iOS or Android

**Not for:** landing page conversion (use `lp-optimization`) or writing content (use `content-create`)

**Produces:** `.agents/mkt/seo-[mode].md`

---

### `attribution` — measure what's working

Maps marketing activities to business outcomes, evaluates channel ROI, identifies gaps in measurement, and recommends where to double down or cut spend.

**Use when:**
- You're spending on marketing and need to know what's actually driving results
- You want a KPI-to-initiative-to-content mapping for accountability
- You need to identify measurement gaps before scaling spend

**Not for:** setting new KPIs (use `funnel-planner`) or creating new content (use `content-create`)

**Produces:** `.agents/mkt/attribution.md`

---

### `humanize` — make AI text read human

Strips AI patterns, injects brand voice, and compresses existing text. Targets 15%+ word reduction with zero idea loss.

**Use when:**
- You have AI-generated content that sounds robotic or generic
- You want to inject a specific brand voice into existing text
- You need to compress text for density without losing meaning

**Not for:** writing new content from scratch (use `content-create`) or crafting new copy (use `copywriting`)

**Produces:** `.agents/mkt/content/[slug].humanized.md`

---

### `cold-outreach` — write cold outbound messages

Writes and evaluates cold outreach across email, LinkedIn (DM + connection note), Twitter/X (reply + DM), and platform proposals (Upwork, Fiverr, similar). Signal-based personalization, channel-specific craft, 5-dimension rubric scoring, automatic humanize terminal pass. Supports first-touch compose and inbound-reply handling.

**Use when:**
- You're writing a cold email, cold DM, or proposal and want it to read like a sharp human, not a template
- You need a reply to an inbound response (not-interested / no-budget / send-info / curious / qualified / later / hostile / ambiguous)
- You're doing services-sell, saas-sell, partnership-sell, or community-sell outbound

**Not for:** sourcing or list-building (start at "here's who I'm reaching"), campaign orchestration across many prospects (compose touches individually with prior-touches context), fundraise/hiring outreach (different norms), lifecycle/nurture emails (use `content-create`).

**Produces:** `.agents/mkt/cold-outreach/[slug].md` + `[slug].rationale.md` + `[slug].critic-score.md`

---

### `vn-tone` — polish translated Vietnamese into native register

Post-translation polish for Vietnamese text. Detects translation giveaways (pronoun drift, missing sentence-final particles, literal idiom calques, passive-voice calques, corporate translationese, typography) and rewrites into one of four target registers: **báo chí** (news/formal), **semi-casual** (tech community/blogger), **bro** (Otofun or Voz forum casual), or **pop-marketing** (consumer marketing/lifestyle).

Uses a live-scraped corpus from VnExpress, Chinhphu.vn, Tinhte, Spiderum, Otofun, Voz, and Kenh14 as the register reference.

**Use when:**
- You have Vietnamese text that was translated from English (by AI, MT, or a non-native writer) and reads robotic
- You have native Vietnamese copy that needs register alignment (e.g., corporate voice that should be bro-community)
- You're localizing marketing copy and need the final polish before publication
- Your brand serves a Vietnamese audience and generic MT output won't land

**Not for:** translating from English to Vietnamese (use your preferred MT first, then this), writing new Vietnamese from scratch (use `copywriting`), or stripping AI patterns in English (use `humanize` first, then translate, then `vn-tone`).

**Produces:** `.agents/mkt/content/[slug].vn-tone.md`

---

## Cross-Stack

- `brand-system`, `imc-plan`, `content-create`, `copywriting`, `lp-optimization`, `seo`, `cold-outreach` read `research/product-context.md` from [research-skills](https://github.com/hungv47/research-skills)
- `cold-outreach` additionally reads `research/icp-research.md` for target persona pain language
- `imc-plan` and `attribution` read `.agents/solution-design.md` and `.agents/targets.md` from research-skills

## License

MIT
