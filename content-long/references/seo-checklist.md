# SEO Checklist

Technical SEO checklist for long-form content — schema by intent, meta description patterns, alt text, technical SEO fundamentals.

Used primarily by `seo-compliance-agent` to validate the merged asset before delivery.

---

## On-Page SEO Fundamentals

### Title Tag

- [ ] ≤60 chars (or fits ~580px display width)
- [ ] Primary keyword in first 60 chars (ideally front-loaded)
- [ ] Reads as standalone (without site name, makes sense)
- [ ] Unique on the site (no two pages share the same title)
- [ ] No keyword stuffing (don't repeat target keyword)

### Meta Description

- [ ] ≤155 chars (mobile may truncate at ~120)
- [ ] Primary keyword in first 60 chars
- [ ] Action-shaped (verb + value)
- [ ] Unique per page
- [ ] Compels click without misleading

### URL Slug

- [ ] Lowercase, hyphens (not underscores), no stop words
- [ ] Keyword-based, ≤5 words ideally
- [ ] Stable (don't change after publish without 301 redirect)
- [ ] No dates if evergreen (avoid "/2025/" in URL unless year-specific)

Example:
✅ `/code-review-best-practices/`
❌ `/2025/01/15/the-ultimate-guide-to-code-review-best-practices-for-engineering-teams/`

### H1

- [ ] Exactly one H1 per page (typically the title)
- [ ] Contains primary keyword
- [ ] Distinct from title tag (often same; can vary if useful)

### H2 / H3 Hierarchy

- [ ] H2s structure the body
- [ ] H3s nest under H2s where outline calls
- [ ] No skipped levels (H2 → H4 with no H3)
- [ ] Primary keyword in ≥1 H2
- [ ] Secondary keywords distributed across H2s/H3s
- [ ] PAA questions used verbatim as H2/H3 (where targeted)

### Keyword Density

For 2500-5000 word piece, target keyword:
- [ ] In title
- [ ] In meta description
- [ ] In H1
- [ ] In lede (first 100 words)
- [ ] In ≥1 H2
- [ ] In body 3-7 times naturally
- [ ] In ≥1 image alt text
- [ ] In URL slug
- [ ] In first and last paragraph (ideally)

Density of 0.3-1.5% is natural; 2%+ approaches stuffing.

---

## Schema Markup by Intent

### Article (always include for blog/pillar/case study/byline)

```json
{
  "@context": "https://schema.org",
  "@type": "Article",
  "headline": "[title]",
  "description": "[meta description]",
  "image": "[OG image URL]",
  "datePublished": "[ISO 8601]",
  "dateModified": "[ISO 8601]",
  "author": {
    "@type": "Person",
    "name": "[author name]",
    "url": "[author profile URL]"
  },
  "publisher": {
    "@type": "Organization",
    "name": "[publisher name]",
    "logo": {
      "@type": "ImageObject",
      "url": "[logo URL]"
    }
  }
}
```

### FAQPage (when piece has FAQ section)

```json
{
  "@context": "https://schema.org",
  "@type": "FAQPage",
  "mainEntity": [
    {
      "@type": "Question",
      "name": "[exact PAA question]",
      "acceptedAnswer": {
        "@type": "Answer",
        "text": "[40-80 word answer]"
      }
    }
    // ... more Q&A
  ]
}
```

### HowTo (when piece has procedural section)

```json
{
  "@context": "https://schema.org",
  "@type": "HowTo",
  "name": "[how-to title]",
  "step": [
    {
      "@type": "HowToStep",
      "name": "[step name]",
      "text": "[step instructions]"
    }
    // ... more steps
  ]
}
```

### NewsArticle (for press releases)

```json
{
  "@context": "https://schema.org",
  "@type": "NewsArticle",
  "headline": "[headline]",
  "datePublished": "[ISO 8601]",
  "author": "[author or company]",
  "publisher": { ... },
  "dateline": "[CITY, STATE — DATE]"
}
```

### Review / CaseStudy (for case studies)

```json
{
  "@context": "https://schema.org",
  "@type": "Review",
  "itemReviewed": {
    "@type": "Product",
    "name": "[product name]"
  },
  "author": {
    "@type": "Organization",
    "name": "[customer company]"
  },
  "reviewBody": "[case study summary]"
}
```

### BreadcrumbList (always for site-hosted content)

```json
{
  "@context": "https://schema.org",
  "@type": "BreadcrumbList",
  "itemListElement": [
    {
      "@type": "ListItem",
      "position": 1,
      "name": "Home",
      "item": "[home URL]"
    }
    // ... more breadcrumbs
  ]
}
```

---

## Schema Combinations

| Format + Intent | Schema Combination |
|---|---|
| Pillar guide (informational) | Article + FAQPage + BreadcrumbList |
| Pillar guide (informational + procedural) | Article + FAQPage + HowTo + BreadcrumbList |
| Pillar guide (commercial best-of) | Article + ItemList + Review + BreadcrumbList |
| Pillar guide (vs comparison) | Article + Comparison-style + BreadcrumbList |
| Standard blog post | Article + BreadcrumbList (+ FAQPage if FAQ section) |
| Case study | Article + Review (or CaseStudy) + Organization + BreadcrumbList |
| Byline (3rd party) | Outlet handles — typically Article |
| Press release | NewsArticle + Organization |
| Newsletter (own domain) | Article + BreadcrumbList |
| App store listing | SoftwareApplication (platform-handled) |

---

## SERP Feature Targeting Checks

### Featured Snippet

For paragraph snippet:
- [ ] H2 phrased exactly (or near-exactly) as the target query
- [ ] Answer paragraph 40-60 words immediately following
- [ ] Answer is the FIRST paragraph after the H2 (not buried)
- [ ] Schema Article supports the page

For list snippet:
- [ ] H2 phrased as the query
- [ ] Ordered/unordered list of 4-8 items immediately following
- [ ] Each list item is concise (1-2 lines)

For table snippet:
- [ ] H2 phrased as the query
- [ ] HTML table with `<th>` headers immediately following
- [ ] At least 2 columns and 3 rows

### AI Overview Citation

For AI Overview eligibility:
- [ ] Article + FAQPage schema present
- [ ] Original data, cited research, or unique insight
- [ ] Authority signals (named expert quotes, cited researchers)
- [ ] Specific examples (not generalities)
- [ ] Recent date references (freshness)
- [ ] Clear "answer" sections (not buried in narrative)
- [ ] Author has identifiable expertise (author bio with credentials)

### People Also Ask (PAA) Inclusion

For each target PAA:
- [ ] H2 or H3 phrased exactly as PAA question (or near-exact)
- [ ] Direct answer in 40-80 words immediately following
- [ ] FAQPage schema includes this Q&A pair

---

## Image Optimization

- [ ] Every image has descriptive alt text (not "image of X")
- [ ] At least 1 image's alt text includes target keyword
- [ ] Alt text is unique per image (no copy-paste)
- [ ] Image filenames use keywords (e.g., `code-review-checklist.png` not `IMG_4521.png`)
- [ ] Image file size ≤200KB where possible
- [ ] Modern format (WebP or AVIF) where supported
- [ ] Lazy-loading attribute on below-fold images (`loading="lazy"`)
- [ ] Width and height attributes specified (CLS prevention)
- [ ] Original images preferred over stock (flag any stock images)

---

## Internal Link Optimization

- [ ] All anchor texts use keywords (no "click here" / "learn more" / "this article")
- [ ] Anchor text matches the linked page's target keyword
- [ ] Links land in contextually relevant body sections (not dumped in conclusion)
- [ ] Total internal links: 2-4 per 1000 words for pillar; 1-3 per 1000 words for standard blog
- [ ] All brief-specified internal links present
- [ ] No broken internal links (verify URL exists)
- [ ] No orphan-link clusters (all links contextually justified)

---

## External Link Optimization

- [ ] All external citations include URL + author + publication
- [ ] All citations are real, verifiable sources (no fabrications)
- [ ] External links use `rel="noopener"` (security)
- [ ] Use `rel="nofollow"` for paid placements / sponsored mentions / untrusted UGC
- [ ] Use `rel="ugc"` for user-generated content links
- [ ] No more than 5-10 external links per 1000 words (varies by piece)

---

## Technical SEO

### Canonical URL

- [ ] Canonical tag points to the page's own URL (unless syndicated)
- [ ] Syndicated copies (cross-posts to LinkedIn, Medium, Substack) canonical back to original

### Open Graph (OG) Tags

- [ ] `og:title` — matches title or meta-description
- [ ] `og:description` — matches meta description
- [ ] `og:image` — recommended 1200×630 px
- [ ] `og:type` — "article" for long-form content
- [ ] `og:url` — canonical URL

### Twitter Card

- [ ] `twitter:card` — "summary_large_image"
- [ ] `twitter:title` — matches title
- [ ] `twitter:description` — matches meta description
- [ ] `twitter:image` — same as OG image
- [ ] `twitter:site` — site's Twitter handle (optional)

### Structured Data Validation

- [ ] Schema validates in Google's Rich Results Test
- [ ] No schema warnings or errors
- [ ] Schema matches visible content (no schema-content mismatch)

### Core Web Vitals (page-level, often platform-handled)

- [ ] LCP (Largest Contentful Paint) <2.5s
- [ ] CLS (Cumulative Layout Shift) <0.1 (use width/height attrs on images)
- [ ] INP (Interaction to Next Paint) <200ms

### Mobile

- [ ] Mobile-friendly (responsive layout)
- [ ] Tap targets ≥48×48 px
- [ ] Font ≥16px for body
- [ ] No horizontal scrolling

---

## Common SEO Failures

| Failure | Fix |
|---|---|
| Title >60 chars | Trim, front-load keyword |
| Meta description missing | Generate from lede + value-add |
| H1 missing or duplicated | Ensure exactly one H1, with primary keyword |
| Image without alt text | Add descriptive alt; ≥1 with target keyword |
| Internal anchor "click here" | Replace with keyword anchor |
| Citation without URL | Find URL or remove citation |
| Generic "studies show" | Name the study + URL |
| Schema missing for FAQ section | Add FAQPage schema |
| Featured snippet H2 wording mismatch | Phrase H2 exactly as query |
| No OG image | Add 1200×630 image to OG tags |
| URL slug too long | Shorten to ≤5 words, keyword-based |
| Date in URL on evergreen | Remove date from slug |
| Schema-content mismatch | Sync schema with visible content |
