---
type: platform-intelligence
platform: shorts
schema_version: 1
last_verified: 2026-05-07
verifier: opus-research-agent-2026-05-07
sources:
  - id: yt-help-3min
    title: "Understand three-minute YouTube Shorts — YouTube Help"
    url: https://support.google.com/youtube/answer/15424877?hl=en
    accessed: 2026-05-07
    tier: primary
  - id: 9to5g-3min
    title: "YouTube Shorts will soon be up to 3 minutes long"
    url: https://9to5google.com/2024/10/03/youtube-shorts-3-minutes/
    accessed: 2026-05-07
    tier: secondary
  - id: sej-3min
    title: "YouTube Extends Shorts To 3 Minutes, Adds New Features"
    url: https://www.searchenginejournal.com/youtube-extends-shorts-to-3-minutes-adds-new-features/529177/
    accessed: 2026-05-07
    tier: secondary
  - id: shortimize-algo
    title: "How Does YouTube Shorts Algorithm Work In 2025?"
    url: https://www.shortimize.com/blog/how-does-youtube-shorts-algorithm-work
    accessed: 2026-05-07
    tier: secondary
  - id: paddy-3p3b
    title: "We studied 3.3 Billion views to decode the YouTube Shorts algorithm — Paddy Galloway"
    url: https://www.linkedin.com/posts/paddy-galloway-459b8913a_we-studied-33-billion-views-to-decode-the-activity-7053697597592498176-PAkf
    accessed: 2026-05-07
    tier: secondary
  - id: vidiq-loops
    title: "How to Double Your YouTube Watch Time by Looping Shorts (vidIQ)"
    url: https://vidiq.com/blog/post/double-youtube-watch-time-looping-shorts/
    accessed: 2026-05-07
    tier: secondary
  - id: virvid-loop
    title: "Looping Structure: The Hidden Retention Trick in Viral Shorts"
    url: https://virvid.ai/blog/looping-structure-shorts-retention-2026
    accessed: 2026-05-07
    tier: secondary
  - id: conbersa-shelf
    title: "What Is the YouTube Shorts Shelf?"
    url: https://www.conbersa.ai/learn/what-is-youtube-shorts-shelf
    accessed: 2026-05-07
    tier: secondary
  - id: sel-related-links
    title: "YouTube enables linking between Shorts and long-form videos"
    url: https://searchengineland.com/youtube-enables-linking-shorts-long-form-videos-430655
    accessed: 2026-05-07
    tier: secondary
  - id: vidiq-related
    title: "YouTube Unveils 'Related Links' to Connect Shorts and Long-Form Videos"
    url: https://vidiq.com/blog/post/youtube-related-links-connect-shorts-long-videos/
    accessed: 2026-05-07
    tier: secondary
  - id: blog-google-clickbait
    title: "Strengthening enforcement against egregious clickbait on YouTube — Google Blog"
    url: https://blog.google/intl/en-in/products/platforms/strengthening-enforcement-against-egregious-clickbait-on-youtube/
    accessed: 2026-05-07
    tier: primary
  - id: joyspace-watermark
    title: "How to Remove TikTok Watermark for YouTube Shorts (Avoid Penalties 2026)"
    url: https://joyspace.ai/stop-reposting-tiktoks-watermark-detection
    accessed: 2026-05-07
    tier: secondary
  - id: vidiq-reused
    title: "YouTube Reused Content Policy: What AI Creators Need to Know — vidIQ"
    url: https://vidiq.com/blog/post/youtube-reused-content-policy-guide/
    accessed: 2026-05-07
    tier: primary
  - id: opus-retention
    title: "The Ideal YouTube Shorts Length & Format for Retention (Data-Backed) — OpusClip"
    url: https://www.opus.pro/blog/ideal-youtube-shorts-length-format-retention
    accessed: 2026-05-07
    tier: secondary
  - id: unkoa-ypp
    title: "YouTube Shorts Monetization Requirements 2026 (Both YPP Tiers) — Unkoa"
    url: https://www.unkoa.com/youtube-shorts-monetization-requirements/
    accessed: 2026-05-07
    tier: secondary
  - id: vidiq-shorts-mon
    title: "YouTube Shorts Monetization in 2026 — vidIQ"
    url: https://vidiq.com/blog/post/youtube-shorts-monetization/
    accessed: 2026-05-07
    tier: secondary
  - id: hashtagtools-tags
    title: "YouTube Shorts Hashtags: Title or Description? (2026)"
    url: https://hashtagtools.io/blog/youtube-shorts-hashtags-title-vs-description-2026
    accessed: 2026-05-07
    tier: secondary
  - id: buffer-analytics
    title: "The Creator's Guide to YouTube Shorts Analytics — Buffer"
    url: https://buffer.com/resources/the-creators-guide-to-youtube-shorts-analytics/
    accessed: 2026-05-07
    tier: secondary
  - id: tubefilter-mrbeast
    title: "MrBeast's Paris Baguette Shorts becomes YouTube's most-liked video — Tubefilter"
    url: https://www.tubefilter.com/2025/02/20/mrbeast-paris-baguette-shorts-most-liked-youtube-video/
    accessed: 2026-05-07
    tier: secondary
  - id: dailydot-mrbeast-shorts
    title: "MrBeast's YouTube Shorts Now Have More Views Than His Videos — Daily Dot"
    url: https://www.dailydot.com/news/mrbeast-youtube-shorts-views/
    accessed: 2026-05-07
    tier: secondary
status: draft
---

# Platform Intelligence — YouTube Shorts

Practitioner-grade reference consumed by `short-form-brief` (and downstream surface-specific copy skills) to ground hooks, format compliance, algorithm fit, and anti-pattern checks for **YouTube Shorts**. Shorts behaves differently from TikTok/Reels because it sits inside YouTube's long-form ecosystem: every Short is also a YouTube video, every channel has a long-form rail and a Shorts shelf, and the algorithm distributes Shorts across at least three discovery surfaces (Shorts feed, Shorts shelf on Home/Search/channel page, Suggested) — not one.

When this doc's `last_verified` exceeds 90 days, the consuming critic flags `DONE_WITH_CONCERNS` with "platform signal may be stale — verify before publishing."

---

## 1. Hook Taxonomy

Shorts inherits the base-6 hook archetypes (Credential flash, Pattern interrupt, Question hook, Pre-reveal tease, Contrarian claim, Data point) but its position inside YouTube's long-form ecosystem creates platform-native variants the brief must spec for. The four below are Shorts-specific — they describe what the *opening* must accomplish given that (a) the viewer is in a swipe-decision feed with a 1–2s budget, (b) the Short may also be surfaced via the Shorts shelf where a thumbnail and title are visible *before* playback, and (c) Shorts function as a top-of-funnel feeder to the channel's long-form rail.

### Archetype 1 — Channel-flywheel hook

- **Definition:** A Short whose opening explicitly previews or fragments a long-form video on the same channel, with the long-form linked via Related Links/description so engaged Shorts viewers route into the long-form rail.
- **Identifying signal:** First 2s names a deliverable that cannot fit in 60s ("Here's the 3-minute version — full breakdown linked"), or visually fragments a long-form scene ("This is from my 22-minute deep-dive"); a "Related Links" pill appears at the bottom of the Shorts player linking to the long-form. [source: sel-related-links, vidiq-related]
- **Verbatim example A:** "I spent 24 hours in the world's most expensive hotel room — full video on my channel" — the channel-flywheel pattern that MrBeast's main channel uses to push Shorts traffic into long-form (MrBeast Shorts have >1B views per top short and now exceed long-form views on the main channel) — @MrBeast, https://www.youtube.com/@MrBeast/shorts — engagement: top Shorts in the 1B+ view range. [source: dailydot-mrbeast-shorts, tubefilter-mrbeast]
- **Verbatim example B:** "The Region Beta Paradox" (2-sentence concept tease with "watch the full 18-min essay" pattern) — @aliabdaal, https://www.youtube.com/@aliabdaal/shorts — engagement: ~1.7M views, 137k likes. [source: shortimize-algo]
- **Engagement-signal rationale:** Shorts subscribers count toward the same channel total used for YPP eligibility (Tier 1 = 500 subs + 3M Shorts views/90d; Tier 2 = 1k subs + 3M Shorts views/90d or 4k watch hours), and long-form watch time monetizes at materially higher RPM than Shorts feed (Shorts ~$0.06/1k views per Galloway's 3.3B-view study). The flywheel hook converts low-RPM Shorts impressions into high-RPM long-form watch hours and into subscribers — both of which compound. [source: paddy-3p3b, unkoa-ypp, vidiq-shorts-mon]
- **Best for:** Established channels with a long-form library; education/expertise niches; founder-mode where the goal is audience compound, not standalone Short virality.

### Archetype 2 — Loop-bait Short

- **Definition:** A Short engineered so the final frame visually or narratively connects to the first frame, producing accidental re-watches that count as additional views (since March 31, 2025, each loop = another counted view).
- **Identifying signal:** Final ~0.5–1s frame visually mirrors first frame; ending sentence completes only when looped to the start; total duration 7–15s (loop math compounds when watch length is short); no end-card or CTA card that breaks the loop. [source: vidiq-loops, virvid-loop]
- **Verbatim example A:** Satisfying-process Shorts where the last visual frame (e.g., "the door closes") re-cues the opening ("a door opens"); the format is endemic to the @ASMRSCAN, @5MinuteCrafts, and oddly-satisfying niches — pattern documented across 100k+ Shorts in vidIQ's loop-structure analysis. [source: vidiq-loops]
- **Verbatim example B:** Short ending: "...and that's how you do it. Wait, did you catch the part where—" (cuts to silence; loop restarts and viewer rewatches to "catch" the missed beat) — pattern from looping-structure case studies. [source: virvid-loop]
- **Engagement-signal rationale:** As of March 31, 2025, each loop counts as another view, and "even a 10% replay rate can meaningfully boost distribution"; looped Shorts can register >100% retention in YouTube analytics because segments get rewatched within a single session. This is the only short-form platform where the "incomplete ending" pattern compounds *measurably* in distribution — not just engagement signal. [source: vidiq-loops, virvid-loop]
- **Best for:** Visual / process / ASMR / satisfying / micro-narrative niches; product demos with a clear "before → after → before" arc; brand-mode where view-count is the KPI more than CTR-out.

### Archetype 3 — Shelf-style preview hook

- **Definition:** A Short whose first frame is composed and titled to function as a thumbnail-plus-headline pair on the Shorts shelf (Home, Search, channel-page carousel) — because the shelf renders a static thumbnail + the first ~30 chars of title before any swipe-in.
- **Identifying signal:** First-frame visual has thumbnail-grade composition (high-contrast face, bold text overlay, single focal subject) rather than feed-style "drop into action"; title is written headline-first ("The $1 productivity trick that 10x'd my output") not stream-of-consciousness; viewer arrives via shelf with a *click decision already made* before playback. [source: conbersa-shelf]
- **Verbatim example A:** Productivity creator opens with a 3-word burned-in caption and a face-on-frame shot — "Stop. Doing. This." — title "The 5-second rule that ended my procrastination" — composed for the shelf-card render where face + bold caption survive thumbnail compression. Pattern documented across @aliabdaal Shorts. [source: shortimize-algo]
- **Verbatim example B:** "Most people get this 100% wrong" (text overlay on opening frame) — pattern recurs in finance/career niche shelf Shorts where title and frame-1 are designed as a unit to function on the home shelf carousel. [source: conbersa-shelf]
- **Engagement-signal rationale:** The Shorts feed handles the majority of Shorts views, but the shelf (Home / Search / channel page) introduces Shorts to viewers who would never enter the dedicated Shorts feed — these viewers make a *thumbnail-and-title click decision* before the video plays, so the first frame and title must function the way a long-form thumbnail does. Shelf-acquired subscribers are reportedly higher-retention than feed subscribers (practitioner observation, not platform-confirmed). The exact feed-vs-shelf traffic split is practitioner-estimated at 70–90% — see §7. [source: conbersa-shelf, buffer-analytics]
- **Best for:** Channels that already get Home/Suggested impressions; education/explainer niches; any short where the click decision is happening *before* playback (not during the 1–2s swipe window).

### Archetype 4 — Title-and-thumbnail-hybrid hook

- **Definition:** A Short where the opening 1–2s burns in oversized text that *is* the thumbnail when the Short surfaces on the home shelf and *is* the hook when it plays in feed — the first frame does double duty.
- **Identifying signal:** First-frame text is ≥48px in 1080×1920, contains the thesis verbatim (not a label or ornament), uses a single high-contrast color block for text background, and the speaker either delivers the same line aloud or stays visually subordinate to the text for the full first second. [source: opus-retention]
- **Verbatim example A:** "I tried this for 30 days" (text occupies ~40% of frame, slammed against face) — the burned-in-headline hook recurs across @MrBeast, @aliabdaal, and most challenge/experiment Shorts. [source: tubefilter-mrbeast]
- **Verbatim example B:** "Did you know that using this simple technique can double your productivity?" (Ali Abdaal opening pattern with text-over-face composition) — @aliabdaal Shorts. [source: shortimize-algo]
- **Engagement-signal rationale:** Shorts with an immediate hook in the first 2s retain 19% more viewers than slow-start variants (OpusClip cohort), and 50–60% of total drop-offs happen in the first 3s. A first-frame that *is* the headline hits both the swipe-decision moment in feed AND the thumbnail-rendering moment on shelf without splitting effort. [source: opus-retention]
- **Best for:** Hooks built around a single thesis or claim; educational/expertise creators; any time the same Short needs to perform across feed, shelf, and embed/share contexts.

---

## 2. Format Constraints

| Constraint | Value | Citation |
|---|---|---|
| Duration hard cap (current) | **3 minutes (180s)** for videos uploaded on/after Oct 15, 2024 (Dec 8, 2025 for Official Artist Channels). Vertical/square + ≤180s = classified as Short. | yt-help-3min, 9to5g-3min |
| Duration hard cap (legacy) | 60s for uploads before Oct 15, 2024 | 9to5g-3min, sej-3min |
| Duration sweet spot | **15–30s for retention-led**; **40–60s for absolute-view-count** (Shorts in 50–60s range earned ~22× more views than <10s clips per OpusClip cohort; Galloway's 3.3B-view study found algorithm "favors longer videos (40s+) that hold viewer duration well") | opus-retention, paddy-3p3b |
| Aspect ratio | 9:16 vertical or 1:1 square (anything wider = classified as long-form, not Short) | yt-help-3min |
| Resolution recommended | 1080×1920 (vertical) | yt-help-3min |
| Title character limit | **100 characters** (hard cap); first ~70 visible on shelf cards | hashtagtools-tags |
| Description character limit | **5,000 characters** total; only first **~100–125** visible above the fold in Shorts player | hashtagtools-tags |
| Hashtag count limit | Max **15 hashtags** per video (post — YouTube ignores all hashtags if >15) | hashtagtools-tags |
| Hashtag norm | **3–5 hashtags in description, not title**; first 3 description hashtags auto-render as clickable links above title (saves the 100-char title budget); `#shorts` is widely-recommended-but-not-required (YouTube auto-detects vertical+short videos as Shorts; the tag is a redundancy hedge) | hashtagtools-tags |
| Cover/thumbnail | Effectively functions on the **Shorts shelf** (Home/Search/channel page) — first frame doubles as thumbnail by default; custom thumbnails supported but the shelf renders frame-1 if uploaded thumbnail is rejected as misleading | conbersa-shelf, blog-google-clickbait |
| Audio handling | YouTube's in-app audio library + remix-from-existing-Short; for Shorts >60s, Content ID-claimed music is a hard block — claimed music in any Short over 1 minute = video blocked globally and ineligible for monetization | yt-help-3min |
| Music duration cap (in 3-min Shorts) | Most licensed songs usable for **up to 90s** within a 3-min Short; some tracks limited to 60s or 30s | yt-help-3min |
| Burned-in caption | **Strongly recommended** — sound-off viewing common; first-frame text doubles as shelf thumbnail | opus-retention, conbersa-shelf |
| Safe zones | Avoid bottom ~25% of frame (UI overlay: like/dislike/comment/share + Related Links pill) and top ~10% (handle + title) | sel-related-links |
| Subscriber math | Public + private subscribers from Shorts count toward channel total used for YPP eligibility (Tier 1: 500 subs + 3M Shorts views/90d OR 3k watch hours/yr; Tier 2: 1k subs + 3M Shorts views/90d OR 4k watch hours/yr). Shorts watch time does NOT count toward the 4k-hour long-form requirement. | unkoa-ypp |
| Made-for-kids implications | Shorts marked "Made for Kids" disable comments, personalized ads, end-screens/cards, Stories, Super Chat, save-to-playlist, and notifications — kills most monetization and CTA paths. Set audience honestly per channel. | yt-help-3min |
| Linked long-form ("Related Links") | Available to verified channels — persistent link near bottom of Shorts player to a creator-specified long-form video | sel-related-links, vidiq-related |

---

## 3. Algorithm Signals (Ranked by Impact)

YouTube's Creator Liaison framework (Rene Ritchie, plus Senior Director of Growth & Discovery Todd Beaupré) consistently positions Shorts ranking around two pillars: **the swipe-decision** (does the viewer stop?) and **post-swipe satisfaction** (do they finish, react, and return?). Below ranks the operationally-actionable signals.

1. **Viewed-vs-Swiped (VVSA) — the swipe-decision metric.** Concrete metric: of all impressions delivered to the feed, what % stopped vs. swiped past in the first 1–2s. *Why:* this is the ranking signal YouTube's Creator Liaison most consistently surfaces; Galloway's 3.3B-view study found Shorts with <60% VVSA rarely performed; top Shorts hit 70–90%. *Lever:* burned-in first-frame headline + visual motion in frame-1; treat frame-1 like a thumbnail. *Tier:* secondary (creator-cohort study; the *signal name* is platform-stated, the *thresholds* are practitioner-derived). [source: paddy-3p3b, shortimize-algo]

2. **Average view duration / completion rate.** Concrete metric: % of total length the average viewer watches; top Shorts hit 80–90% completion on <60s videos. *Why:* highest-weight post-swipe signal — a viewer who stopped scrolling but bounced at 3s is a worse signal than a viewer who finished. *Lever:* duration discipline (15–30s for retention-led; 40–60s only when content sustains it); cut every dead second. *Tier:* secondary cohort + primary (YouTube documentation on watch time as core ranking signal). [source: shortimize-algo, opus-retention]

3. **Replay rate / loop count.** Concrete metric: how often viewers re-watch the Short within a session; **as of March 31, 2025 each loop counts as an additional view**. *Why:* replays signal exceptional engagement and now compound view-count math directly. Even ~10% replay rate "can meaningfully boost distribution." *Lever:* loop-bait ending (visual or narrative loop), 7–15s duration target where loop math compounds, no hard end-card that breaks the loop. *Tier:* primary (platform changed counting methodology) + secondary (threshold). [source: vidiq-loops, virvid-loop]

4. **Likes, comments, shares (engagement velocity).** Concrete metric: per-impression rate of each action; shares carry highest weight as virality signal. *Why:* secondary post-swipe satisfaction signal; comments + shares specifically signal "this was worth a reaction" which the algorithm extrapolates to "this will satisfy other viewers." *Lever:* explicit prompt at end ("comment your answer", "share with someone who needs this"); pinned-comment kickoff to seed thread. *Tier:* secondary. [source: shortimize-algo]

5. **Personalization match (viewer-history fit).** Concrete metric: how closely the Short's topic/visual/audio fingerprint matches the individual viewer's prior watch history. *Why:* per Beaupré/Ritchie, "the algorithm pulls videos for viewers" — Shorts distribution is per-viewer matching, not push-broadcast. A Short with an 80% completion rate from a tightly-matched audience can outperform a Short with 60% from a broad audience. *Lever:* topical clarity in frame-1 (the algorithm needs to classify the Short fast), niche-specific phrasing over generic, consistent channel topical signal. *Tier:* primary (Creator Liaison statements). [source: shortimize-algo]

6. **Click-through to channel / Related Links / long-form follow-through.** Concrete metric: % of viewers who click handle, Related Link pill, or end-card; counts as positive distribution signal because it implies value beyond the single watch. *Why:* the Shorts shelf vs. feed split means a Short that *only* performs in-feed and never converts to channel/long-form interest is throttled relative to Shorts that bridge into the channel ecosystem. *Lever:* spec a Related Link to a tightly-relevant long-form; verbal CTA at second-to-last beat ("full breakdown on my channel"). *Tier:* secondary. [source: sel-related-links, conbersa-shelf]

7. **Subscriber conversion.** Concrete metric: subscribers gained per 1,000 views (Galloway's 3.3B-view study found ~16.9 subs per 10,000 views as average). *Why:* a Short that converts viewers into subscribers signals durable value — the algorithm rewards Shorts that grow channels, not just generate one-shot views. *Lever:* channel-flywheel hook framing; identity-anchored opening ("if you build software, this changes things"); end-card subscribe prompt as a backstop, not the lead. *Tier:* secondary. [source: paddy-3p3b]

---

## 4. Anti-Patterns

- **TikTok watermark (or visible artifacts of removal).** *Penalty:* YouTube's frame-scanning detects TikTok logos and the blur/jitter/crop artifacts left after removal; flagged Shorts get restricted to existing subscribers and removed from the Shorts feed (the main discovery surface). YouTube also fingerprints TikTok's compression profile — re-uploading a downloaded TikTok file matches a hash database even with the logo cropped out. *Detection rule:* search the brief for "repurposed from TikTok" / "downloaded from TikTok" / "Reels watermark" — if production_mode = repurpose-cross-platform, hard-fail unless source is the original master file. *Source:* secondary. [joyspace-watermark, vidiq-reused]

- **Reused content without transformation (YouTube Reused Content policy).** *Penalty:* Channels that primarily reupload other creators' content or self-content with minimal transformation can lose YPP monetization entirely. *Detection rule:* if the Short is a long-form clip with no platform-native treatment (no vertical reframe, no captions added, no audio re-cut, no overlay), flag for transformation pass. *Source:* primary. [vidiq-reused]

- **Egregious clickbait (title/thumbnail vs. content mismatch).** *Penalty:* As of late 2024, YouTube began **removing** (not just deprioritizing) videos where titles or thumbnails make promises the video doesn't deliver — initially rolled out in India with global expansion. Examples flagged: "The President Resigned!" on a video with no resignation; "Top Political News" thumbnail on a video with no news content. Initial enforcement is removal without strikes; behavior is expected to escalate. *Detection rule:* the title must answer a question or claim that the *first 60% of the Short* actually delivers — not "subscribe to find out". *Source:* primary. [blog-google-clickbait]

- **Slow-start / no first-frame hook.** *Penalty:* 50–60% of total drop-offs happen in the first 3s; below-50% VVSA → algorithm classifies the Short as skippable and stops distributing. *Detection rule:* check that storyboard frame 0:00–0:02 contains either burned-in headline text OR a high-motion/high-contrast visual OR a verbal claim — not a logo intro, not a "hey guys", not silent setup. *Source:* secondary (creator-cohort). [opus-retention, shortimize-algo]

- **Too-long-for-the-content Short.** *Penalty:* Shorts that pad past their natural length tank completion rate. A 30s Short at 85% completion outperforms a 60s Short at 50% completion even though the 60s version delivered more total watch time. The algorithm penalizes the lower retention more than it rewards the longer absolute watch time. *Detection rule:* if the storyboard has filler beats added to "fill out" duration, cut. Aim for the duration the content actually justifies (15–30s for tight thesis; 40–60s only when content sustains it). *Source:* secondary. [opus-retention]

- **Content ID-claimed music in Shorts >60s.** *Penalty:* Hard-blocked globally — the Short will not play and will not be eligible for monetization. *Detection rule:* if duration target >60s, audio must be original or from YouTube's Shorts audio library (not a Content ID-claimed commercial track). *Source:* primary. [yt-help-3min]

- **Made-for-Kids designation when audience is mixed/adult.** *Penalty:* Disables comments, personalized ads, end-screens/cards, Super Chat, notifications — kills most monetization and most CTA paths. *Detection rule:* if the Short uses Related Links, end-cards, or pinned-comment CTAs, audience cannot be Made-for-Kids. *Source:* primary. [yt-help-3min]

- **Loop-breaking end-card on a loop-bait Short.** *Penalty:* The "subscribe-bell" end-card animation breaks the visual loop and prevents the auto-replay that Loop-bait depends on, kneecapping the very signal the format was designed to produce. *Detection rule:* if hook archetype = Loop-bait, the final 0.5s must be a frame-1 mirror — no end-card, no card animation, no subscribe overlay. *Source:* secondary. [vidiq-loops, virvid-loop]

---

## 5. Hook Window + Retention Curve

- **First-second goal (0:00–0:01):** Stop the swipe. Frame-1 must contain at least one of: burned-in headline text (≥48px on 1080×1920), high-contrast face-on subject, dynamic motion, or a verbal claim — NOT a logo, channel intro, or "hey guys". The decision the viewer makes here is binary: stop or swipe. [source: opus-retention, paddy-3p3b]
- **Swipe-decision window (0:00–0:02):** Galloway's framing: "treat your intro like a thumbnail." Sub-50% VVSA in this window = algorithm classifies as skippable; 70%+ = distribution scales. [source: paddy-3p3b]
- **Critical drop-off cliff (0:00–0:03):** **50–60% of total drop-offs happen in the first 3 seconds**. A retention curve with a 30%+ cliff at the 3s mark is diagnostic of a failed hook. [source: opus-retention]
- **Retention checkpoints:**
  - **>70% past 3s** = strong intro retention (target).
  - **80–90% completion** on Shorts <60s = top-performer band.
  - **<50% completion** = algorithmic throttle.
  - **>100% retention** is achievable (and now visibly desirable) on loop-bait Shorts because each loop counts as an additional view. [source: opus-retention, vidiq-loops]
- **Loop / replay behavior:** Since March 31, 2025, **each replay/loop counts as another view**. Even a 10% replay rate meaningfully boosts distribution. Loop-bait Shorts in the 7–15s range compound view counts most aggressively; >100% retention is the explicit signal Loop-bait targets. [source: vidiq-loops, virvid-loop]
- **Drop-off structure on healthy Shorts:** Flat-with-gentle-decline is the target curve. A clean staircase or single sharp cliff means a specific moment failed (pacing slowed, topic shifted without transition, visual interest dropped). Bumps upward late in the Short = replay segments — that's the loop-bait signature. [source: opus-retention, virvid-loop]

---

## 6. CTA Placement Norms

| CTA placement | When it works | When it fails | Source |
|---|---|---|---|
| **Related Link pill (long-form linked)** | Channel-flywheel hook with a real, tightly-relevant long-form on the same channel; verified channel only; CTA verbalized at second-to-last beat ("full version on my channel") so the pill registers | Linked long-form is unrelated; pill exists but never verbally cued; channel not verified | sel-related-links, vidiq-related |
| **Pinned comment** | Loop-bait or feed-mode Shorts where the CTA would interrupt the visual flow; works for "drop your answer", resource links, follow-up; survives sound-off | Audience is too cold to leave the platform (low CTR); pinned comment too long (truncates in feed view) | shortimize-algo |
| **End-card overlay (final 1–3s)** | Channel-flywheel and Title-and-thumbnail-hybrid Shorts where the loop is not the goal; "subscribe for the full version" pattern | Loop-bait Shorts (breaks the loop and kills replay-rate signal); Made-for-Kids Shorts (cards disabled) | vidiq-loops, yt-help-3min |
| **Verbal in-line CTA (mid-Short)** | Channel-flywheel hook where the verbal "the full breakdown is linked" rides at 60–80% mark, before drop-off accelerates | Hard-sell CTAs at 0:01 (kills VVSA and completion); generic "smash like and subscribe" without a reason-to-act | shortimize-algo |
| **Description first line / "More" expansion** | Reinforcement only — the description is invisible until expanded; useful for hashtags, long-form link, Related Link backstop, sponsor disclosure | Treating description as a primary CTA surface — viewers don't expand by default | hashtagtools-tags |
| **Burned-in CTA text overlay** | The Shelf-style preview hook where the Short doubles as a shelf card; CTA is the headline ("Tap for the 5-second rule") | Cluttered first-frame (competes with hook headline); UI safe-zone violation (bottom 25% covered by YouTube UI) | conbersa-shelf, opus-retention |

**Default order to pick from in a brief:** Related Link pill (for channel-flywheel) → pinned comment (for loop-bait or feed-only Shorts) → end-card (when loop is not the goal) → verbal mid-Short CTA (always, layered).

---

## 7. Open Questions / Known Unknowns

- **Shelf-vs-feed traffic split is not publicly disclosed at granularity.** Practitioner consensus is that the Shorts feed accounts for **70–90%** of views on most Shorts, with the shelf (Home/Search/channel page) taking the remainder, but YouTube does not publish a platform-level distribution and per-creator splits vary widely with channel maturity. Briefs should not assume a fixed shelf weight. [buffer-analytics]
- **Subscriber quality from Shorts vs. long-form.** Practitioner observation (Sprout Social's creator data, vidIQ commentary) holds that subscribers gained via the shelf — who saw the Short *in context* with the channel's long-form rail — retain materially better than feed-only subscribers, but no public cohort study quantifies the gap. Treat "Shorts subscribers ≈ long-form subscribers" as unproven for retention purposes. [conbersa-shelf]
- **Exact VVSA threshold the algorithm uses to throttle vs. promote.** Galloway's cohort places the floor at "<60% rarely performs" and top performers at "70–90%", and Shortimize/cohort studies cite a "70% swipe-away = stop showing" rule, but YouTube has not stated a numeric threshold. Treat 70% as a working target, not a documented gate.
- **Algorithm treatment of 60–180s Shorts (post-Oct 2024).** It is unclear whether the algorithm now distributes 60–180s Shorts the same as <60s Shorts, or whether longer Shorts get pushed to a different rail (Shorts feed vs. long-form Suggested) when retention is low. Galloway's pre-2024 study found 40s+ favored *if retention holds*; the 3-min era is too recent for a stable cohort. Spec briefs at 15–60s when in doubt.
- **Whether Shorts watch time will *ever* count toward the 4k-hour YPP long-form requirement.** Currently it does not — and the Tier 1/Tier 2 split exists specifically because Shorts has its own monetization track. Treat as stable for now; verify each refresh.
- **How the Oct 2024 Egregious-Clickbait enforcement scales globally.** Initially rolled out in India; YouTube has stated global expansion but timing/per-market enforcement intensity is opaque. Briefs should assume the rule applies *now* in production markets, not "eventually."

---

## 8. Changelog

| Date | Change | By |
|---|---|---|
| 2026-05-07 | Initial draft. Covers post-Oct 2024 3-minute Shorts era, March 2025 loop-counts-as-view methodology change, late-2024 egregious-clickbait enforcement, Related Links UI, Tier-1/Tier-2 YPP Shorts monetization split. Hook taxonomy: channel-flywheel, loop-bait, shelf-style preview, title-and-thumbnail-hybrid. | opus-research-agent-2026-05-07 |
