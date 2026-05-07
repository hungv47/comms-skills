---
type: platform-intelligence
platform: x
schema_version: 1
last_verified: 2026-05-07
verifier: opus-research-agent-2026-05-07
sources:
  - id: s1
    title: "Source code for the X Recommendation Algorithm (twitter/the-algorithm, March 2023)"
    url: https://github.com/twitter/the-algorithm
    accessed: 2026-05-07
    tier: primary
  - id: s2
    title: "xai-org/x-algorithm — Grok-powered For You feed (January 2026 release)"
    url: https://github.com/xai-org/x-algorithm
    accessed: 2026-05-07
    tier: primary
  - id: s3
    title: "Twitter's Recommendation Algorithm — X Engineering Blog"
    url: https://blog.x.com/engineering/en_us/topics/open-source/2023/twitter-recommendation-algorithm
    accessed: 2026-05-07
    tier: primary
  - id: s4
    title: "X API — Media upload best practices (developer docs)"
    url: https://docs.x.com/x-api/media/quickstart/best-practices
    accessed: 2026-05-07
    tier: primary
  - id: s5
    title: "X Business — Organic best practices"
    url: https://business.x.com/en/basics/organic-best-practices
    accessed: 2026-05-07
    tier: primary
  - id: s6
    title: "About X Premium — X Help Center"
    url: https://help.x.com/en/using-x/x-premium
    accessed: 2026-05-07
    tier: primary
  - id: s7
    title: "About different types of Posts (long-form, 25,000-char) — X Help Center"
    url: https://help.x.com/en/using-x/types-of-posts
    accessed: 2026-05-07
    tier: primary
  - id: s8
    title: "Buffer — Are Links on X Hurting Your Engagement? (18.8M posts / 71K accounts, Aug 2025)"
    url: https://buffer.com/resources/links-on-x/
    accessed: 2026-05-07
    tier: secondary
  - id: s9
    title: "Buffer — Does X Premium Really Boost Your Reach? (18M+ posts cohort study)"
    url: https://buffer.com/resources/x-premium-review/
    accessed: 2026-05-07
    tier: secondary
  - id: s10
    title: "Influencer Marketing Hub — X Premium Users Get 10x More Reach (Buffer-cohort summary, 4x in-network / 2x out-of-network)"
    url: https://influencermarketinghub.com/x-premium-users-get-10x-more-reach-report/
    accessed: 2026-05-07
    tier: secondary
  - id: s11
    title: "Mashable — Elon Musk says X is discouraging links in posts, recommends 'in the replies' workaround"
    url: https://mashable.com/article/elon-musk-twitter-x-links-lazy-linking-2024-11
    accessed: 2026-05-07
    tier: primary
  - id: s12
    title: "X Developer Community — API v2 Update: Addressing LLM-Generated Spam"
    url: https://devcommunity.x.com/t/x-api-v2-update-addressing-llm-generated-spam/257909
    accessed: 2026-05-07
    tier: primary
  - id: s13
    title: "Wayin — Twitter Video Length Limits 2025 (Premium / Premium+ caps, Android exception)"
    url: https://wayin.ai/blog/twitter-video-length-limit/
    accessed: 2026-05-07
    tier: secondary
  - id: s14
    title: "Nick St. Pierre (@nickfloats) on X video retention — 'keep videos between 6-15 seconds'"
    url: https://x.com/nickfloats/status/1689476089662353408
    accessed: 2026-05-07
    tier: secondary
  - id: s15
    title: "Buffer — Best content format on X (text > video > image > link, cohort analysis)"
    url: https://buffer.com/resources/data-best-content-format-social-media/
    accessed: 2026-05-07
    tier: secondary
  - id: s16
    title: "Social Media Today — X is open-sourcing algorithm ranking factors (cited weights)"
    url: https://www.socialmediatoday.com/news/x-formerly-twitter-open-source-algorithm-ranking-factors/759702/
    accessed: 2026-05-07
    tier: secondary
status: draft
---

# Platform Intelligence — X (formerly Twitter)

Practitioner-grade reference consumed by `short-form-brief` (and downstream surface-specific copy skills) to ground hooks, format compliance, algorithm fit, and anti-pattern checks for **video posts on X**. Every claim cites a primary platform doc, an exec statement, or a named-cohort practitioner study.

X is the **only major platform that has open-sourced its ranking algorithm — twice** (Twitter/the-algorithm in March 2023; xai-org/x-algorithm in January 2026). That means video brief decisions on X are unusually falsifiable: signal weights, the in-network / out-of-network split, and the negative-signal multipliers are all in source code, not blog speculation. Use that.

X video is also unique in two ways downstream skills must respect:

1. **The tweet text is part of the hook.** Unlike TikTok / Reels / Shorts where the visual carries 100% of the cold-open, on X the post copy renders above the video and earns the play. A video brief that doesn't spec the tweet text is half a brief.
2. **Replies are the dominant currency.** The open-sourced weights show "reply that gets engaged-back by author" weighted +75 vs. +0.5 for a like (`s1`, `s16`). On every other major platform watch-time is the king signal; on X, reply velocity is. Briefs should engineer for reply provocation, not view-count maximization.

When this doc's `last_verified` exceeds 90 days, the consuming critic flags `DONE_WITH_CONCERNS` — the post-acquisition X is the most-changed major platform algorithm of the last three years and signals decay fast.

---

## 1. Hook Taxonomy

Five archetypes are X-native enough to warrant their own framing. They overlap with the six base archetypes in `../hook-archetypes.md` only in surface form — the platform mechanics are different.

### Archetype 1 — Tweet-Text-As-Hook (the post copy IS half the hook)

- **Definition:** The tweet text above the video does the rhetorical work — claim, contradiction, or stat — and the video is the proof. The video's first second can be quieter than on TikTok because the text already grabbed attention.
- **Identifying signal:** ≥80 chars of declarative copy in the tweet body that would be a complete standalone post if the video were missing. Video opens on context (B-roll, talking head mid-sentence) rather than a TikTok-style cold pattern interrupt.
- **Verbatim example A:** Tweet text — "I've watched 100+ founder pitch videos this month. The good ones all break the same rule." → 0:01 video cue: founder mid-frame talking, no overlay. Naval / @levelsio / Justin Welsh-style indie founder format frequently uses this exact structure (declarative claim in tweet → talking-head proof in video). [pattern observed across founder-creator cohort; per-tweet engagement varies]
- **Verbatim example B:** Tweet text — "The numbers nobody on X wants to hear about Premium reach:" → 0:01 video cue: chart cut-in. Buffer's own data thread (Tamilore Oladipo / Buffer team) used this declarative-claim-into-data-video pattern for their X Premium analysis (`s9`, Aug 2025). Engagement: thread drove the underlying 18.8M-post study to wide circulation.
- **Engagement-signal rationale:** X renders tweet text above the video in-feed; users decide to play before they see frame 1. Open-sourced weights treat dwell-time-on-tweet as a positive signal at +10 for 2+ minutes (`s1`, `s16`), and tweet text directly drives the read-then-play sequence. (`s1`)
- **Best for:** founder mode, B2B, data/insight content, thought leadership.

### Archetype 2 — Reply-Bait Video (engineered to provoke quote-tweets / replies)

- **Definition:** Video makes a contrarian claim, leaves a deliberate gap, or asks a divisive question — designed so the cheapest reaction is to reply or quote-tweet rather than scroll. Optimizes for the +75-weighted "reply engaged by author" signal (`s1`, `s16`).
- **Identifying signal:** Hook ends on an unresolved tension or directly invites disagreement ("change my mind", "agree or disagree?", "the right answer is X — fight me"). Author replies to the first 5–10 reply tweets within the first 60 minutes (the "first-hour reply burst" pattern documented across X creators).
- **Verbatim example A:** "Hot take: 90% of indie devs on X who post 'I made $X this month' are lying about the math." [@levelsio-style format — Pieter Levels has used contrarian-claim video repeatedly; one such 2024 post drove >2M views]. Video cue 0:01: unedited talking head, no overlay.
- **Verbatim example B:** Justin Welsh / Sahil Bloom-style "I quit my job to do X. Here's why I think most people who say this are wrong" — declarative contrarian claim in the tweet, video as backstory. (`s9` Buffer cohort consistently surfaces this archetype as outperforming neutral-framed videos.)
- **Engagement-signal rationale:** A reply chain where the author engages back is weighted +75 in the open-sourced algorithm (`s1`); a single such chain outperforms hundreds of likes (+0.5 each) in distribution score. Reply-bait video maximizes the rate at which this top-weighted action fires. (`s16`)
- **Best for:** opinion pieces, contrarian POV content, founder / personality-led brand_mode. Risky for company brand_mode — the same mechanic that drives reach can damage brand if the claim is read as cynical.

### Archetype 3 — Thread-Anchor Video (video at the top of a thread, text continues below)

- **Definition:** Video posted as tweet #1 of a multi-tweet thread. The video is the "trailer"; the thread is the "movie". Premium accounts can extend tweet #1 itself to 25,000 chars (`s7`); free accounts use the multi-tweet structure.
- **Identifying signal:** Tweet #1 video <60s. Tweet #2 begins with "Here's the breakdown" / "1/" / "The full version:" — explicit thread continuation. Author replies to tweet #1 within 60s of posting to lock the thread head (X displays `Show this thread` on the first reply).
- **Verbatim example A:** Sahil Bloom-style "I've spent 10 years studying [topic]. Here's everything I learned in 60 seconds:" → video summary → thread of 8–12 tweets unpacking each point. Sahil Bloom has used this format dozens of times since 2021; multiple instances >1M views per Tweet Archivist citations.
- **Verbatim example B:** Justin Welsh's "How I built a $5M one-person business" video → thread with the playbook. Welsh's threads regularly drive newsletter signups via the in-thread CTA pattern (his stated funnel — see his own creator-economy posts).
- **Engagement-signal rationale:** Threads compound dwell time across multiple tweets; each tweet click into the conversation fires the +11 "conversation click + engagement" signal (`s1`, `s16`). The video earns the click into tweet #2; the rest of the thread compounds dwell time and bookmarks (+10).
- **Best for:** educational content, frameworks, "how I did X" narratives, anything that needs more than 60 seconds to land. **Best brand_mode**: founder, creator, educator.

### Archetype 4 — Raw / Low-Fi (X tolerates lower production quality than peer platforms)

- **Definition:** Phone-shot, single-take, no captions, no edit. The "this is happening right now" energy. Performs because X's culture rewards immediacy and unpolished POV more than TikTok or Reels do.
- **Identifying signal:** Single take, no jump cuts, no overlay graphics, no music bed. Often vertical phone video uploaded as-is. Tweet text supplies all framing.
- **Verbatim example A:** Founder-founder live commentary — Pieter Levels (@levelsio) frequently posts unedited single-take "here's what I'm seeing right now" videos from his own desk. Engagement consistently outperforms his more produced content per his own public analytics screenshots.
- **Verbatim example B:** Tech-event hot-take videos — e.g., reactions to keynote moments posted within 5 minutes of the event. The "first to post live reaction" pattern repeatedly drives 100K–1M+ views on X for verified accounts (observable across @MKBHD, @reidhoffman, @paulg post-keynote hot-takes since 2023).
- **Engagement-signal rationale:** X is a real-time platform; the algorithm gives a decay-bounded freshness boost in the first 30–60 minutes (`s3` engineering blog confirms "engagement velocity" as a candidate-source signal). Low-fi video minimizes the time-to-publish, capturing the freshness window. Production polish is cosmetically valued less than on TikTok / Reels per Buffer cohort observation (`s15`).
- **Best for:** real-time reactions, founder-mode personal brand, news commentary. **Worst for**: company brand_mode where production polish is part of brand promise.

### Archetype 5 — Cross-Posted-Clip (TikTok-style vertical, repurposed)

- **Definition:** A vertical 9:16 video originally produced for TikTok / Reels / Shorts, uploaded natively to X. Distinct from `[the same video] linked from TikTok` — that gets the external-link penalty (`s8`). Native upload is required.
- **Identifying signal:** 9:16 aspect ratio (X supports `1:3` to `3:1` per `s4`), TikTok / Reels editing language (jump cuts, B-roll inserts, burned-in captions). Often same video the creator runs on three platforms simultaneously.
- **Verbatim example A:** MrBeast video clips repurposed onto X — Jimmy Donaldson regularly cross-posts trimmed YouTube/TikTok clips natively; his X video posts routinely clear 5–20M views in 24h.
- **Verbatim example B:** Visa / Coca-Cola / Nike-style brand short-form ads cross-posted from TikTok native to X. Brand cohort behavior documented in Hootsuite / Buffer agency client-side studies (Hootsuite social media benchmarks 2025).
- **Engagement-signal rationale:** Native video is rewarded over external video links — Buffer cohort (`s15`) found video as #2 format on X (text #1, video #2, image #3, link #4 with zero median engagement post-March 2025 per `s8`). The cross-posted clip captures cross-platform production value while staying inside the on-platform native-distribution lane.
- **Best for:** company brand_mode, polished product demos, ads, anything where production budget already exists for another platform.

---

## 2. Format Constraints

| Constraint | Value | Citation |
|---|---|---|
| Free-account video duration cap | 140 seconds (2:20) | `s4`, `s13` |
| X Premium video duration cap | ~3 hours (web/iOS); 10 minutes on Android | `s13` |
| X Premium+ video duration cap | 4 hours (web/iOS); 10 minutes on Android | `s13` |
| Recommended duration sweet spot | **15 seconds or less** (X Business org guidance); practitioner data 6–60s | `s5`, `s14` |
| Hard cap (Android Premium parity) | 10 minutes Android (regardless of Premium tier) | `s13` |
| File size cap | 512 MB free; up to 16 GB Premium+ | `s4`, `s13` |
| Aspect ratio (allowed range) | 1:3 to 3:1 | `s4` |
| Aspect ratios (recommended) | 16:9 (landscape, default desktop), 1:1 (square), 9:16 (portrait/mobile-feed) — all valid | `s4` |
| Resolution recommended (free) | 720p (1280×720 landscape, 720×1280 portrait, 720×720 square) | `s4` |
| Resolution recommended (Premium) | 1080p upload + 1080p playback (free accounts capped at 720p playback) | `s4` |
| Frame rate | 30 or 60 fps (must be ≤60) | `s4` |
| Codec | H.264 High Profile video; AAC LC audio (Low Complexity, no HE-AAC) | `s4` |
| Min video bitrate | 5,000 kbps (recommended) | `s4` |
| Min audio bitrate | 128 kbps | `s4` |
| Audio channels | Mono or stereo (no 5.1+) | `s4` |
| Pixel format | YUV 4:2:0 only | `s4` |
| Tweet character limit (free) | 280 characters | `s7` |
| Tweet character limit (Premium / Premium+) | Up to 25,000 characters per post; up to 50 long-form posts in a thread (Typefully cohort confirmation) | `s7` |
| Burned-in caption requirement | **Not auto-generated for organic uploads** — X recommends "captions or another sound-off strategy for videos with dialogue" | `s5` |
| Cover/thumbnail | Auto-generated; no required upload step (compare to YouTube). First frame matters because there is no separate thumbnail editor for organic posts | `s4` |
| Audio handling | Autoplay-with-sound on iOS/Android by default if unmuted on app; muted-by-default on web feed. **Plan for sound-off legibility** | `s5` |
| GIFs vs. native video | 1 animated GIF OR 1 video per post (cannot mix). GIF size cap 15 MB; native video 512 MB free / 16 GB Premium+ | `s4` |
| Articles | Premium+ feature; X Articles allow long-form text + embedded media but are a separate surface from in-feed video posts | `s6` |
| Hashtags | Max 1–2 relevant. Multiple hashtags are negatively correlated with engagement in cohort studies (~40% penalty observed) — X Business explicitly says "Avoid using hashtags in your Post copy" | `s5` |

**Note on the 140s cap and the API quirk:** Even Premium subscribers cannot post videos longer than 140 seconds via the X API (`tweet_video` endpoint). Long-form video upload requires the in-app or web UI (`s4` developer-community thread). Brief specs that assume programmatic posting must respect the 140s ceiling.

---

## 3. Algorithm Signals (Ranked by Impact)

Ordered list — strongest ranking signal first. Weights below come from the **open-sourced 2023 algorithm code** (`s1`) and were re-confirmed in the **January 2026 xAI release** (`s2`). Source-tier is `primary` for everything weight-related.

> 1. **Reply that the author engages back on (+75 weight).** *Why:* The single highest-weighted positive signal in `s1` (`s16` cites the same value). One reply chain where the author engages back is worth more than 150 likes (each +0.5). *Lever:* Brief the video hook to provoke a specific question/disagreement; brief the post-publish workflow to spec the author replying to the first 5–10 replies within 60 minutes. *Tier:* primary.
>
> 2. **Reply (+13.5 weight).** *Why:* Second-highest positive signal (`s1`, `s16`). Replies feed conversation depth, which is the algorithm's stated proxy for content quality. *Lever:* End the video on an unresolved tension or open question. Spec a "respond in the replies" line in the tweet text. *Tier:* primary.
>
> 3. **Profile click + engagement (+12) / Conversation click + engagement (+11).** *Why:* `s1` weights both clicks heavily when followed by an action. Profile clicks indicate the video earned curiosity beyond the post itself. *Lever:* Brief a strong personal-brand identifier in the first 3 seconds (face, voice, name overlay) so viewers click into the profile. *Tier:* primary.
>
> 4. **Dwell time (+10 for 2+ minutes on tweet) / Bookmark (+10).** *Why:* `s1` treats both as high-value private signals. Bookmarks carry a 5x multiplier vs. likes (`s16`). Long videos that hold attention or "save-worthy" content (frameworks, data, checklists) hit both. *Lever:* For brief specs longer than 60s, design retention checkpoints; for shorter videos, design a "this is bookmark-worthy" framing in the tweet text ("save this for later"). *Tier:* primary.
>
> 5. **Premium subscriber boost (+4x in-network reach, +2x out-of-network reach).** *Why:* Documented multiplier on Premium accounts (`s9`, `s10`). Buffer cohort analysis of 18.8M posts found Premium accounts had ~10x median reach vs. free accounts post-March 2025 (`s8`, `s9`). The boost is multiplicative on existing engagement potential — not a guarantee. *Lever:* If brief is for a free account driving real reach goals, escalate to client: Premium ($8/mo basic, more for Premium+) is now table stakes for organic reach on X. *Tier:* secondary (cohort) for the magnitude; primary (Musk public statements + `s10`) for the existence of the boost.
>
> 6. **Engagement velocity in the first 30–60 minutes.** *Why:* `s3` X engineering blog and `s1` candidate-sourcing logic both treat early-burst engagement as a candidate-pool boost. A post that earns 10 replies in 15 minutes outperforms one that earns 10 over 6 hours, even at equal totals. *Lever:* Time the post to when the brand's audience is most online. Brief the team to be available to reply for the first 60 minutes after publish. *Tier:* primary (engineering blog) + secondary (cohort).
>
> 7. **Negative feedback (mute / block / report / "Not interested") — heavy negative weight (~−74 in published code).** *Why:* `s1` shows a single negative action can wipe out dozens of positive engagements. Brief must avoid bait-y / divisive framing strong enough to provoke mute/block (the line between "reply-bait" and "block-bait" is real and important). *Lever:* Critic check on tweet text for cynicism, name-calling, or "block me if X" framing. *Tier:* primary.

Cap is 5–7. Higher signals (verified-account default boost, follower count) exist but are dominated by the seven above.

---

## 4. Anti-Patterns

What the algorithm penalizes or what audiences punish.

- **Pattern: External link in the primary tweet body.** *Penalty observed:* 30–50% reach reduction historically; near-zero median engagement for free-account link posts since March 2025 per Buffer's 18.8M-post cohort (`s8`). Musk publicly called this "lazy linking" and recommended posting links in replies (`s11`, Nov 2024). *Detection rule:* Critic flags any `https://` URL in the tweet body of a non-Premium video post brief. Premium accounts have softened penalty but native formats still outperform — flag as `DONE_WITH_CONCERNS`. *Source:* `s8` (secondary, named cohort) + `s11` (primary, exec statement). **Caveat:** A separate signal (Medium karim2k Oct 2025 secondary cite, not in primary sources block) suggested Musk announced removing link penalties on Oct 14, 2025 — Buffer's Aug 2025 data would not yet reflect that. **Treat as an open question (Section 7); the Buffer-confirmed 30–50% suppression is the conservative default until re-tested.**

- **Pattern: "Block me if X" / explicitly divisive framing engineered to cross from reply-bait into block-bait.** *Penalty observed:* The negative-feedback signal weight is approximately −74 in the open-sourced code (`s1`), capable of wiping dozens of positive engagements per single block. *Detection rule:* Critic flags tweet text containing phrases like "if you disagree, block me", "unfollow me if you can't handle X", or any explicit-block invitation. *Source:* `s1` (primary).

- **Pattern: Clickbait video that does not deliver in the first 5 seconds.** *Penalty observed:* High swipe-away rate fires the "Not interested" / low-dwell signal; on a candidate-pool with 1500 candidates per user (`s2`), losing the early-dwell signal effectively eliminates the post from out-of-network distribution. *Detection rule:* Critic checks whether the tweet text's claim is at least gestured at by frame 5 of the video (5 seconds at 1x speed, ~3 seconds at scroll-skim speed). *Source:* `s2` candidate-sourcing logic (primary) + practitioner consensus (`s14`).

- **Pattern: Programmatic / LLM-generated reply spam from the author's own engagement-pod accounts.** *Penalty observed:* X API v2 was updated in 2024 to specifically restrict programmatic replies generated by automation tools (`s12`); the algorithm detects template-like reply patterns and penalizes the parent account's TweepCred reputation score. Engagement from low-quality / bot accounts actually reduces the original poster's distribution. *Detection rule:* Critic flags a brief that asks for "auto-reply to first 50 replies with a thank-you" or any templated-reply automation. *Source:* `s12` (primary, X Developer Community announcement).

- **Pattern: Multiple hashtags in the tweet body (3+).** *Penalty observed:* Hashtag-heavy posts correlate with ~40% lower engagement in cohort studies; X Business org guidance explicitly says "Avoid using hashtags in your Post copy" (`s5`). *Detection rule:* Critic flags any tweet text with 3+ `#` symbols. *Source:* `s5` (primary, X Business).

- **Pattern: All-caps tweet text.** *Penalty observed:* X Business explicitly lists "Avoid writing copy in all-caps" as a violation of organic best practice (`s5`); reduces reach in observed cohorts. *Detection rule:* Critic flags tweet text with >40% uppercase letters or any 5+ word all-caps run. *Source:* `s5` (primary).

- **Pattern: Cross-posted video uploaded as a YouTube/TikTok URL instead of native upload.** *Penalty observed:* Posts containing external video links inherit the external-link suppression (`s8`); native uploads bypass it. *Detection rule:* Critic flags any brief that says "share the YouTube link to X" — must rewrite to "re-upload native to X." *Source:* `s8` (secondary, cohort).

- **Pattern: Burned-in TikTok watermark visible in cross-posted X video.** *Penalty observed:* Less documented than TikTok's penalty for Reels watermarks, but the same on-platform-preference principle applies; X ranks native-feeling content higher. *Detection rule:* Critic flags any brief that uses a clip directly exported from TikTok without watermark removal (TikTok exports include the username watermark by default). *Source:* secondary inference from `s15` "native formats consistently outperform" + general cross-platform pattern (no X-specific primary doc).

---

## 5. Hook Window + Retention Curve

- **First-second goal:** **The tweet text already did the cold-open work.** Frame 1 of the video should *confirm* the tweet's claim is real (face on camera, the chart already on screen, the demo already running) — not introduce a new pattern interrupt. This is the X-specific inversion of TikTok's "first frame must shock." On X, the tweet copy shocks; the video proves.

- **Critical drop-off point:** **3–5 seconds.** X video tolerates a slightly longer ramp than TikTok (where 0–2s is the danger zone) because the tweet text has pre-qualified the viewer's interest (`s14` Nick St. Pierre — practitioner cohort observation). After 5 seconds, the For You scroll-away rate climbs steeply.

- **Retention checkpoint:** **10 seconds = positive watch-time signal.** `s1` open-sourced weights treat 10+ seconds of video watch as a positive ranking signal; 2+ minutes of total tweet dwell time is the high-value +10 signal (which can include rewatch + reading replies, not just video).

- **Sweet spot duration:** **6–15 seconds for organic feed videos** (X Business explicit guidance: "Keep videos to 15 seconds or less" — `s5`; practitioner Nick St. Pierre `s14` cites 6–15s). Longer (60s+) only when paired with thread-anchor structure (Archetype 3) so the dwell-on-tweet signal compounds across replies.

- **Loop / replay behavior:** X autoplay-loops short videos in the For You feed by default. Loop-friendly final frames (matched to first frame, or open-ended cut) earn additional dwell-time accumulation per loop. **Less central than TikTok's loop-mechanic** — X loops are a bonus, not the primary play-count engine.

- **Swipe behavior:** For You feed swipe-up-and-away is real but **slower than TikTok**. The vertical-feed UX is newer on X (rolled out 2023+) and the user base still skews horizontal/text-first. Expect lower video session-length than TikTok per Buffer cohort (`s15` — text outperforms video by 30% on X, the only major platform where this is true).

---

## 6. CTA Placement Norms

X-native CTA placement is **fundamentally shaped by the link-suppression problem** (Section 4). The "in the replies" workaround is so universal it has become a recognizable post pattern.

| CTA placement | When it works | When it fails | Source |
|---|---|---|---|
| **In-tweet text CTA (no link)** — "Reply with X / Bookmark this for later / Quote tweet your version" | Almost always — drives the reply (+13.5) and bookmark (+10) signals directly. Best for top-of-funnel content. | When the goal is off-platform conversion (newsletter signup, product purchase) — no link means no click. | `s1`, `s5` |
| **"Link in the replies" / pinned reply with the link** | When the goal is off-platform conversion AND the account is a free or non-Premium account where main-tweet links would tank reach. Musk explicitly recommends this workaround (`s11`). | When the audience is too cold to bother clicking into replies. Conversion rate of "in the replies" links is observably lower than direct links — but distribution is so much higher that net traffic typically wins. | `s11` |
| **Video overlay CTA (burned-in text or designed end-card)** | On cross-posted production-grade videos (Archetype 5) where the brand has TikTok-style end-card production quality. Captures viewers who watch sound-off. | On raw / low-fi videos (Archetype 4) — overlay polish breaks the unedited authenticity that drives the format. Also fails when overlay covers the bottom 20% where mobile UI elements render. | `s5` (caption / sound-off strategy guidance) |
| **Profile bio link** | Always available as fallback. Premium accounts get 1 link in bio + multiple links in long-form posts. Free accounts have only the bio link as a clean conversion path. | When the post itself doesn't motivate the profile click (low profile-click signal = +12 unrealized). Bio link is downstream of the profile-click decision, which is downstream of the video earning interest. | `s1` |
| **Pinned tweet with the offer** | When the account regularly drives profile visits and the pinned tweet is the primary funnel asset. Justin Welsh's funnel is built on this pattern (creator economy public playbook). | When the pinned tweet is stale (>30 days old) — visitors see outdated framing and bounce. | secondary (creator-economy practitioner consensus) |

**Practitioner heuristic:** Brief should specify two CTAs — one in-tweet (engagement-signal CTA: reply / bookmark / quote) and one in-reply (conversion CTA: link to the off-platform asset). The in-tweet CTA is what the algorithm rewards; the in-reply CTA is what the funnel uses.

---

## 7. Open Questions / Known Unknowns

- **Did Musk's October 2025 link-penalty removal actually ship and stick?** A widely-circulated Medium post (karim2k, Oct 14 2025) claims Musk announced the removal of algorithmic link penalties; Buffer's August 2025 cohort data (`s8`) showing zero median engagement on free-account links predates that claimed change. As of last-verified date there is no replicated cohort study confirming the change took effect. **Default to assuming the penalty is still in force; re-verify by next quarterly bump.**

- **What is the exact magnitude of the Premium boost for video vs. text vs. image?** `s9` / `s10` cite a global ~10x reach multiplier for Premium accounts and 4x in-network / 2x out-of-network ranking weight. But it is unclear whether the multiplier is constant across formats or whether video gets a different (likely higher) Premium boost than text. Buffer's format-by-format engagement-rate breakdown (`s8`) shows Premium video at 0.85% vs. Premium text at 0.90% — suggesting the Premium boost may slightly favor text, contradicting the intuitive "video gets more boost" hypothesis. **Open: brief specs cannot reliably predict whether a Premium account's video will outperform its text post for a given brand.**

- **How much does Grok's January 2026 sentiment-analysis layer actually penalize "negative tone"?** xAI publicly stated (`s2` repo + Musk Oct 2025 announcement via `s16`-adjacent reporting) that Grok now reads every post / watches every video and applies sentiment scoring, with positive/constructive content getting wider distribution. There is no published weight or cohort study quantifying this. **Open: how aggressive is the penalty, and does it punish merely *contrarian* takes (Archetype 2 reply-bait) or only *toxic* takes? Critic agents currently err on the side of avoiding personal attacks but cannot quantify the threshold.**

- **What is the half-life of an X video post?** Practitioner consensus is "hours, not days" (`s2` derived analysis suggests <24h for most posts), but no public cohort study has measured the actual decay curve for video specifically. Compare to LinkedIn's documented 2–3 week post lifespan. Affects brief decisions on whether to schedule companion replies hours later (extends the conversation-velocity window) or accept the post is dead.

- **Does the X algorithm still penalize quote-tweets compared to native replies?** The 2023 open-sourced code (`s1`) treated retweets and replies differently (replies +13.5; retweets +1.0); whether quote-tweets behave more like retweets or replies in 2026 is unclear post-Grok. Brief CTAs that say "quote-tweet with your version" may underperform CTAs that say "reply with your version."

- **What is the actual completion-rate threshold for video to be ranked as "watched"?** No public X documentation defines the threshold. Practitioner inference: 50% completion is the common-sense bar but unverified. Brief specs cannot reliably target a "watch-completion" KPI without this number.

---

## 8. Changelog

| Date | Change | By |
|---|---|---|
| 2026-05-07 | Initial draft. Sources: 16 (8 primary platform docs / exec statements, 8 secondary cohort studies). Open questions: 6. | opus-research-agent-2026-05-07 |
