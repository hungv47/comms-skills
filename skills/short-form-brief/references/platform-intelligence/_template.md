---
type: platform-intelligence
platform: <linkedin | tiktok | reels | shorts | x | youtube>
schema_version: 1
last_verified: <YYYY-MM-DD>
verifier: <hungv47 | agent-name>
sources:
  - title: <source title>
    url: <url>
    accessed: <YYYY-MM-DD>
    tier: <primary | secondary | tertiary>   # primary = platform docs/exec statements; secondary = practitioner reports with named cohort + N; tertiary = uncited author OR commenter signal without disclosed cohort/N (treat as heuristic, not benchmark — calibrate against your own data before adopting any threshold sourced this way)
status: draft | reviewed | stale
---

# Platform Intelligence — <Platform>

Practitioner-grade reference consumed by `short-form-brief` (and downstream surface-specific copy skills) to ground hooks, format compliance, algorithm fit, and anti-pattern checks. **Not generic marketing advice.** Every claim cites a primary platform doc, a named-cohort practitioner study, or an in-house pattern-log entry.

When this doc's `last_verified` exceeds 90 days, the consuming critic flags `DONE_WITH_CONCERNS` with "platform signal may be stale — verify before publishing."

---

## 1. Hook Taxonomy

Minimum **3** archetypes specific to this platform. Each archetype must include:

- **Definition** — one sentence
- **Identifying signal** — concrete patterns a human or LLM can detect
- **Verbatim examples** — ≥2 real public examples per archetype with creator handle + post URL/date when retrievable; mark `[anonymized]` only when source explicitly required
- **Engagement-signal rationale** — *why* this archetype fits this platform's algorithm + audience (cite source from `sources` block)
- **Best for** — niche / brand_mode / content type fit

Archetypes catalogued here may overlap with the six base archetypes in `../hook-archetypes.md` (Credential flash, Pattern interrupt, Question hook, Pre-reveal tease, Contrarian claim, Data point), but **must add platform-specific framing or surface platform-native variants** — do not just rename the base set.

### Archetype 1 — <Name>

- **Definition:** ...
- **Identifying signal:** ...
- **Verbatim example A:** "<exact opening line/visual cue>" — @handle, <date>, <url> — engagement: <metric if known>
- **Verbatim example B:** "<exact opening line/visual cue>" — @handle, <date>, <url> — engagement: <metric if known>
- **Engagement-signal rationale:** ... [source: <id from sources block>]
- **Best for:** ...

### Archetype 2 — <Name>

(repeat structure)

### Archetype 3 — <Name>

(repeat structure)

---

## 2. Format Constraints

Hard specs an agent or critic can enforce. Prefer numeric over prose.

| Constraint | Value | Citation |
|---|---|---|
| Duration sweet spot | <e.g., 21–34s> | <source id> |
| Duration hard cap | <e.g., 10 min on TikTok> | <source id> |
| Aspect ratio | <9:16 vertical, 1:1, etc.> | <source id> |
| Resolution recommended | <e.g., 1080×1920> | <source id> |
| Caption character limit | <number> | <source id> |
| Caption truncation point | <e.g., 125 chars before "...more"> | <source id> |
| Safe zones (top / bottom) | <px or % from edges> | <source id> |
| Burned-in caption requirement | <yes/no + why> | <source id> |
| Hashtag norm | <count + placement convention> | <source id> |
| Cover/thumbnail | <required / recommended / ignored> | <source id> |
| Audio handling | <original / trending / silent-friendly default> | <source id> |

Add platform-specific rows when relevant (e.g., LinkedIn's "first-3-line preview", TikTok's "Stitch/Duet eligibility", Shorts' "shelf vs. feed").

---

## 3. Algorithm Signals (Ranked by Impact)

Ordered list — strongest ranking signal first. For each:

- **Signal name** + concrete metric the algorithm reads
- **Why it matters** — one sentence, cite source
- **Operator lever** — what the brief can spec to move this signal
- **Source tier** — primary (platform doc / exec statement) or secondary (practitioner cohort study, named N)

Example shape (LinkedIn):

> 1. **Dwell time** — total seconds the viewer spent on the post before scrolling. *Why:* LinkedIn's 2024 ranking docs cite dwell time as the top engagement-quality signal for video. *Lever:* spec a 3s hook + a 7-12s "earn the watch" reveal so the dwell threshold is cleared. *Tier:* primary.

Cap at the top **5–7** signals; more is noise.

---

## 4. Anti-Patterns

What the algorithm penalizes or what audiences punish. Each entry:

- **Pattern** — specific behavior or content trait
- **Penalty observed** — distribution drop, downrank, shadow throttle, audience drop-off — with citation if public
- **Detection rule** — how a critic agent can spot this in a brief before publish
- **Source** — primary if platform-stated; secondary if practitioner-observed

Examples to seed thinking:

- TikTok: visible Reels watermark
- Reels: trending audio without original visual treatment (post-Originality Score)
- Shorts: missing loop-friendly final frame
- LinkedIn: naked sales-pitch CTA
- X: external-link-first replies (downranked vs. native-first)

Be specific. "Don't be salesy" is not an anti-pattern — it's a fortune cookie.

---

## 5. Hook Window + Retention Curve

- **First-second goal:** <what the hook must accomplish by 0:01>
- **Critical drop-off point:** <0:03? 0:07? 0:10?> + citation
- **Retention checkpoint(s):** <e.g., 50% retention at 0:15 = strong signal>
- **Loop / replay behavior:** <does this platform reward loops? swipe-back?>

If retention data isn't public for this platform, state that explicitly and cite the best practitioner estimate available.

---

## 6. CTA Placement Norms

Where CTAs land best on this platform — overlay, end-card, caption first line, comment-pinned, bio link. Cite practitioner data or platform guidance.

| CTA placement | When it works | When it fails | Source |
|---|---|---|---|
| <Overlay 0:18-0:22> | <context> | <context> | <id> |
| <End card> | <context> | <context> | <id> |
| <Caption first line> | <context> | <context> | <id> |
| <Comment-pinned> | <context> | <context> | <id> |

---

## 7. Open Questions / Known Unknowns

What this doc *does not* answer well — gaps the verifier flagged. Each entry is a one-liner.

- E.g., "Shorts' shelf-vs-feed traffic split: no public data; estimates vary 30–60%."
- E.g., "LinkedIn dwell-time threshold for 'qualified view': unstated by platform; practitioner consensus 6s but no cited cohort."

Naming the unknowns is mandatory. A doc with zero open questions is either complete (rare) or hiding gaps.

---

## 8. Changelog

| Date | Change | By |
|---|---|---|
| <YYYY-MM-DD> | Initial draft | <verifier> |

---

## Authoring rules (delete from per-platform doc; keep here in template)

1. **No fortune cookies.** "Be authentic" is banned. Every claim must be falsifiable.
2. **Cite or don't write.** A claim without a `sources` entry doesn't ship. Tier sources honestly.
3. **Verbatim, not paraphrased.** Hook examples are exact opening lines / visual cues, not summaries.
4. **Numeric > prose.** "21–34s sweet spot" beats "moderate length."
5. **Platform-native framing.** A "Question hook" on LinkedIn behaves differently than on TikTok — surface that, don't recycle.
6. **Date everything.** `last_verified` + per-source `accessed` dates. Algorithm signals decay; the date is how downstream skills know to reverify.
7. **Open questions are required.** Section 7 is non-negotiable. If you have nothing to put there, you didn't research hard enough.
