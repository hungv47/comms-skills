# Marketing Skills — Changelog

Format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/). Versioning is [SemVer](https://semver.org/spec/v2.0.0.html) — major.minor.patch.

This file tracks stack-level releases. SKILL.md files describe current behavior; this file documents what changed and when.

---

## [2.0.0] - 2026-05-16

**Agent Skills 2.0 — fresh start.** The marketing-skills stack reset to 2.0.0 as part of the umbrella Agent Skills 2.0 release. Released as a pre-release tag on the `refactor/v2.0` branch. The `main` branch holds the legacy v1.x line for users who do not opt into the 2.0 trunk.

### Skills (14)

- `orchestrate-marketing` — router that reads brand/research state and proposes the next skill with rationale + cost + duration
- `brand-system` — brand identity (BRAND.md + DESIGN.md + ASSETS.md)
- `copywriting` — persuasive copy with V/F/U rubric scoring + Competitor Swap Test
- `ad-copy` — Meta paid-ad copy (retargeting + cold-traffic)
- `cold-outreach` — email / LinkedIn / Twitter / iMessage / proposals
- `social-copy` — platform-native social copy (tiktok / reels / shorts / x / linkedin)
- `short-form-brief` — production-ready short-form video briefs (live-action + motion-graphic)
- `lp-brief` — campaign-grade landing-page or redesign brief
- `lp-eval` — post-launch landing-page evaluation (loop-native)
- `campaign-plan` — cross-channel campaign briefs + calendars
- `design-brief` — per-asset graphic-design briefs (social, thumbnails, banners, OG, hero)
- `seo` — search visibility (technical / AI / programmatic / competitor / aso modes)
- `humanize` — strip AI patterns, inject brand voice, compress
- `vn-tone` — Vietnamese register polish (báo chí / semi-casual / bro / pop-marketing)

### Pipeline

```
brand-system → campaign-plan → lp-brief / short-form-brief / ad-copy / cold-outreach / social-copy / seo
                                  ↓ (per-asset slot)
                               design-brief
                                  ↓ (post-launch)
                               lp-eval (inside eval-loop)
```

Horizontal: `copywriting`, `humanize`, `vn-tone` — invoked at any stage.

### Starting point

Run `icp-research` (from research-skills) first to create `research/product-context.md`, the canonical cross-stack record consumed by 13+ downstream skills.
