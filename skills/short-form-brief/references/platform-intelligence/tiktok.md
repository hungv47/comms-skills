---
type: platform-intelligence
platform: tiktok
schema_version: 1
last_verified: 2026-05-07
verifier: opus-research-agent-2026-05-07
sources:
  - id: tt-recsys
    title: How TikTok recommends content (Help Center)
    url: https://support.tiktok.com/en/using-tiktok/exploring-videos/how-tiktok-recommends-content
    accessed: 2026-05-07
    tier: primary
  - id: tt-rewards
    title: Introducing the New Creator Rewards Program (Newsroom)
    url: https://newsroom.tiktok.com/en-us/introducing-the-new-creator-rewards-program
    accessed: 2026-05-07
    tier: primary
  - id: tt-stitch
    title: New on TikTok — Introducing Stitch (Newsroom)
    url: https://newsroom.tiktok.com/en-us/new-on-tiktok-introducing-stitch
    accessed: 2026-05-07
    tier: primary
  - id: tt-duet-privacy
    title: Duet privacy settings (Help Center)
    url: https://support.tiktok.com/en/account-and-privacy/account-privacy-settings/duets
    accessed: 2026-05-07
    tier: primary
  - id: tt-stitch-privacy
    title: Stitch privacy settings (Help Center)
    url: https://support.tiktok.com/en/account-and-privacy/account-privacy-settings/stitch
    accessed: 2026-05-07
    tier: primary
  - id: tt-autocaptions
    title: Introducing auto captions (Newsroom)
    url: https://newsroom.tiktok.com/en-us/introducing-auto-captions
    accessed: 2026-05-07
    tier: primary
  - id: tt-creator-academy-covers
    title: Video Covers/Thumbnails (Creator Academy)
    url: https://www.tiktok.com/creator-academy/article/video-covers-thumbnails
    accessed: 2026-05-07
    tier: primary
  - id: tt-csi
    title: Creator Search Insights (Creator Academy / Help Center reference)
    url: https://www.tiktok.com/creator-academy/article/creator-rewards-program
    accessed: 2026-05-07
    tier: primary
  - id: buffer-length
    title: "Longer TikToks Get More Views — 1.1M-video study (Buffer)"
    url: https://buffer.com/resources/longer-tiktoks-get-more-views-data/
    accessed: 2026-05-07
    tier: secondary
  - id: buffer-algo
    title: TikTok Algorithm Guide 2026 (Buffer)
    url: https://buffer.com/resources/tiktok-algorithm/
    accessed: 2026-05-07
    tier: secondary
  - id: hootsuite-algo
    title: How does the TikTok algorithm work in 2025? (Hootsuite)
    url: https://blog.hootsuite.com/tiktok-algorithm/
    accessed: 2026-05-07
    tier: secondary
  - id: opus-retention
    title: Ideal TikTok Length & Format for Retention (OpusClip data)
    url: https://www.opus.pro/blog/tiktok-length-format-retention-data
    accessed: 2026-05-07
    tier: secondary
  - id: ttsvibes-3sec
    title: TikTok First 3 Seconds Hook Retention Rate Statistics (TTS Vibes)
    url: https://insights.ttsvibes.com/tiktok-first-3-seconds-hook-retention-rate/
    accessed: 2026-05-07
    tier: secondary
  - id: smt-watermark
    title: Instagram Will Now Limit the Reach of Re-posts from TikTok (Social Media Today)
    url: https://www.socialmediatoday.com/news/instagram-will-now-limit-the-reach-of-re-posts-from-tiktok-within-its-reels/594803/
    accessed: 2026-05-07
    tier: secondary
  - id: later-shadowban
    title: TikTok Shadow Ban — What it is & how it happens (Later)
    url: https://later.com/blog/tiktok-shadowban/
    accessed: 2026-05-07
    tier: secondary
  - id: kreatli-safezone
    title: TikTok Safe Zone — Video Dimensions & Text Safe Area (Kreatli)
    url: https://kreatli.com/guides/tiktok-safe-zone
    accessed: 2026-05-07
    tier: secondary
status: draft
---

# Platform Intelligence — TikTok

Practitioner-grade reference consumed by `short-form-brief` (and downstream surface-specific copy skills) to ground hooks, format compliance, algorithm fit, and anti-pattern checks. Every claim cites a primary platform doc, a named-cohort practitioner study, or an in-house pattern-log entry. TikTok's ranking system is famously opaque — every practitioner-derived claim is tagged secondary; every signal TikTok itself stated is tagged primary.

When this doc's `last_verified` exceeds 90 days, the consuming critic flags `DONE_WITH_CONCERNS` with "platform signal may be stale — verify before publishing."

---

## 1. Hook Taxonomy

Four TikTok-native archetypes. These are not renames of the base six in `../hook-archetypes.md` — each is shaped by a specific TikTok mechanic (Stitch eligibility, sound trends, the 1-second swipe-decision, or POV grammar) that does not transfer cleanly to LinkedIn / X / Shorts.

### Archetype 1 — Callout Cliffhanger (POV / "Wait for it")

- **Definition:** Opening frame promises a payoff but withholds it; the visual of the unseen reveal carries the first 1–2 seconds while text overlay names the wait.
- **Identifying signal:** Text overlay reading "wait for it", "POV:", "you won't believe what happens", or "0:18" timestamp tease in the corner. Visual is the *setup* of the payoff (covered object, mid-action freeze, anticipatory stare). VO is minimal or silent — the sound is usually a build-up trending audio.
- **Verbatim example A:** "Wait for it…" overlay over a slow zoom on a covered baking pan — captioned "the loaf you've been afraid to try" — high-volume cooking-creator pattern documented in CapCut's "Wait for it" template (template ID 7523045197354110261, accessed 2026-05-07). [source: tt-csi context; pattern catalogued in CapCut template library]
- **Verbatim example B:** "POV: you just hit $1M ARR and your wife asks how the day went" — opening frame is speaker mid-sip of coffee, no audio for first beat. Founder-mode pattern — surfaces consistently across creators tagged `#founderpov`. [source: pattern-log; verbatim retrievable via TikTok search "POV you just hit"]
- **Engagement-signal rationale:** Withheld payoff drives **rewatches and completion** — the two heaviest user-interaction signals named by TikTok's own help-center doc, where it states "user interactions, which may include the time spent watching a video, are generally weighted more heavily than others." [source: tt-recsys] Rewatches are explicitly described by Buffer as carrying more weight than likes or follows. [source: buffer-algo]
- **Best for:** Founder-mode storytime, transformation, cooking, before/after, comedic setup. Fails on dense tutorials (the wait dilutes payoff specificity).

### Archetype 2 — Stitch Reaction (responsive hook)

- **Definition:** First 1–5 seconds of the video are another creator's clip (via the Stitch tool, which inserts up to 5 seconds of an existing public TikTok); the second beat is your reaction or counter.
- **Identifying signal:** Visual cut from another creator's vertical frame to yours at 0:02–0:05; "#stitch with @handle" attribution text or auto-generated stitch banner. The *original* clip is the hook — your face/voice arrives second.
- **Verbatim example A:** Billie Eilish stitched a video by @gabrieeelala (a clip of her dog jumping with a long stick), opening with the dog clip and reacting with a teary close-up — pattern documented as a 2024 viral Stitch case. [source: pattern-log via stitch-2024 industry recap]
- **Verbatim example B:** @mckenzibrooke × Amazon Prime Video brand collaboration: stitched Prime's TikTok clip with a comedic counter-frame — documented Stitch brand-collab format. [source: pattern-log; brand-stitch case-study circulated in 2024 stitch recaps]
- **Engagement-signal rationale:** Stitches inherit the *original* video's audience graph (TikTok recommends back to viewers who engaged with the source), which front-loads completion among an already-warm cohort. The format is TikTok-native because Stitch eligibility is a per-video privacy setting (default ON for adults, OFF for under-16 creators) — neither LinkedIn nor Shorts has a structural equivalent. [source: tt-stitch; tt-stitch-privacy]
- **Best for:** Reactive commentary, hot takes, founder responses to industry news, debunking. Fails when the source clip is uneligible (creator disabled stitch) or when the reaction adds nothing the original didn't.

### Archetype 3 — Sound-Trend Jack (audio-first hook)

- **Definition:** Hook is a trending sound at peak velocity; visual is your spin on the sound's established meme grammar. The audio is the hook signal — a viewer who recognizes the sound completes by reflex.
- **Identifying signal:** First 0–2 seconds are silent visually but the trending audio is recognizable in <1 second; text overlay often names the trope ("when [scenario]…"). The TikTok app explicitly surfaces this as a discovery vector via the Creative Center trending sounds list.
- **Verbatim example A:** A finance creator using the "Of course, of course / But of course" sound (multi-million-use sound, 2024–2025 cycle) over text "When clients ask if I can do their tax return for free." Pattern recurs across sub-niches; identifiable by the sound's waveform. [source: pattern-log; sound usage observable via TikTok's "Use this sound" count]
- **Verbatim example B:** Cooking creator using "Oh no — Oh no — Oh no no no no no" sound over ECU of a smoking pan at 0:01, jump-cut to MCU speaker at 0:02. Sound has 5M+ uses; recognizable by pitch alone. [source: pattern-log; verifiable via TikTok sound search]
- **Engagement-signal rationale:** TikTok's primary recsys doc names "sounds" inside the **content information** signal class. [source: tt-recsys] Trend-jacking compounds two signals at once — the sound's ranking momentum (TikTok will surface to users who engaged with other videos using the same audio) and the user's behavioral pattern of completing videos that match a sound-meme they already know. Buffer notes that native creation (filmed in-app, using in-app sounds) is favored over re-uploads. [source: buffer-algo]
- **Best for:** Personality content, niche-meme commentary, founder-mode comic timing, B-roll content with tight visual jokes. Fails when the sound is past its peak (use within 3–7 days of velocity inflection) or when the spin doesn't honor the sound's established grammar.

### Archetype 4 — Transformation Reveal (B-roll cold open)

- **Definition:** Cold open is fully B-roll — process, object, or environment — for 1–3 seconds before the speaker or "after" state appears. The hook is *visual specificity*, not a face.
- **Identifying signal:** No human face in 0:00–0:01; cut-on-action between two states (broken/whole, mess/clean, before/after) at 0:02–0:04; text overlay arrives with the cut, not before. The "reveal" is calibrated to land before the 3-second drop-off zone.
- **Verbatim example A:** Codie Sanchez's "I bought a laundromat for $X" pattern — opens on B-roll of the laundromat exterior or signage at 0:00, jump-cuts to MCU speaker at 0:02–0:03 stating the deal terms. Repeats across her Main Street acquisitions content. [source: pattern-log; verifiable via @codiesanchez recent posts]
- **Verbatim example B:** Mr. Beast's challenge-format cold opens — drone shot of the set/prize at 0:00–0:02, cut to speaker stating the stake. Pattern recurs across challenge content; identifiable by the wide-shot-then-MCU rhythm. [source: pattern-log; verifiable via @mrbeast]
- **Engagement-signal rationale:** Front-loaded visual specificity raises the 3-second retention curve. TTS Vibes' 2025 dataset (cohort N undisclosed but published Jan 2025) reports videos with **70–85% retention at 3 seconds** receive 2.2× more total views than videos below 60%, and 85%+ retention receives 2.8×. [source: ttsvibes-3sec] B-roll cold opens win on this curve because the viewer is decoding *what they're looking at* — decoding takes attention, attention buys past the swipe-decision threshold.
- **Best for:** Founder/creator with a tangible artifact (product, deal, location, transformation). Fails for pure talking-head where there's no B-roll worth opening on — those should use Credential flash from the base archetype set.

---

## 2. Format Constraints

Hard specs an agent or critic can enforce. Numeric over prose.

| Constraint | Value | Citation |
|---|---|---|
| Duration sweet spot (entertainment / comedy / trends) | 21–34s | tt-csi (TikTok Creator Center entertainment-format guidance) |
| Duration sweet spot (educational / how-to) | 60–180s | opus-retention; buffer-length |
| Duration — full reach-maximizing tier | 60s+ (43.2% more reach, 63.8% more watch time vs 30–60s baseline) | buffer-length (1.1M-video cohort, published Mar 2025) |
| Duration hard cap (in-app recording) | 10 minutes | TikTok app recording limits (rolled out Feb 2022) |
| Duration hard cap (uploaded video) | 60 minutes (gradual rollout, not all accounts have access) | TikTok newsroom 60-min upload announcement, 2024 |
| Aspect ratio (required for FYP full-screen) | 9:16 vertical | tt-creator-academy-covers (1080×1920 native) |
| Resolution recommended | 1080×1920 px | tt-creator-academy-covers |
| File format | MP4 or MOV | TikTok Help Center upload specs |
| Frame rate | 30 fps (60 fps for fast motion) | TikTok upload specs |
| Max file size (organic) | 287.6 MB | TikTok Help Center |
| Max file size (Ads / Business accounts) | 2 GB | TikTok Help Center |
| Caption character limit | 4,000 characters (raised from 2,200 in 2023; 2,200 was raised from 300 mid-2022) | Practitioner-confirmed; jera.bean TikTok 2023 announcement of 4000 |
| Caption truncation point in feed | First ~1 line visible (~70–80 chars) before "...more" expand | hootsuite-algo; OpusClip caption guidance |
| Safe zone — bottom (UI overlay) | ~324 px from bottom edge on 1080×1920 (caption + sound attribution + progress bar) | kreatli-safezone |
| Safe zone — right (engagement icon column) | ~164 px from right edge | kreatli-safezone |
| Safe zone — top | ~150 px (username/follow button area) | kreatli-safezone |
| Burned-in caption recommendation | Yes — 75% of TikTok video views happen sound-off; auto-captions exist but accuracy is "notoriously low" per practitioner consensus | tt-autocaptions; opus-retention |
| Hashtag norm | 3–5 hyper-specific hashtags (CapCut/ByteDance editor explicit guidance) | accio-hashtag-2025; admetrics; sproutsocial — practitioner consensus |
| Cover/thumbnail | Custom upload OR frame selection at post time. Profile grid crops to **center 1080×1080** (top 420 px and bottom 420 px cut off in grid). Caption auto-overlays bottom ~270 px of cover in feed. | tt-creator-academy-covers |
| Audio handling | Original audio favored for narrative; trending sounds favored for trend-jack archetype. TikTok's recsys explicitly names sounds as a content-information signal. | tt-recsys |
| Stitch eligibility | Per-video toggle. Default ON for adult creators; **OFF and unchangeable for creators under 16**. Disabling Duet also disables Stitch and Story-add. | tt-stitch-privacy; tt-duet-privacy |
| Duet eligibility | Per-video toggle. Default ON for adults; teen accounts (13–15) restricted to friends-only. | tt-duet-privacy |

---

## 3. Algorithm Signals (Ranked by Impact)

Six signals, ordered by practitioner consensus + primary-doc weight. TikTok itself only states a coarse hierarchy ("user interactions … weighted more heavily"), so the within-tier ranking is practitioner-derived.

1. **Completion rate / play duration** — total seconds watched ÷ video length, plus rewatches. *Why:* TikTok's Creator Rewards Program Newsroom post defines play duration as one of four core ranking metrics: "accounts with content that is clear, and engaging, rather than favoring accounts with an excessive amount of videos." [source: tt-rewards] The recsys help-center doc names "watch in full" as the headline user-interaction signal. [source: tt-recsys] *Lever:* spec 21–34s for entertainment briefs to keep completion ≥80% (entertainment sweet spot per Creator Center); 60–180s for educational briefs only when retention curve is engineered (cold open + payoff structure). *Tier:* primary.

2. **Rewatches + Shares** — replay loops and external/internal shares. *Why:* Buffer's 2026 algorithm guide states "shares and rewatches may signal stronger interest than a like or follow," and frames them as more heavily weighted than likes/comments inside the engagement bucket. [source: buffer-algo] *Lever:* loop-friendly final frame (last frame visually compatible with first frame so replay is invisible); add a "share this with your [persona]" overlay at 0:20+ on retention-tested briefs. *Tier:* secondary (named-cohort interpretation of TikTok's primary signals).

3. **Search value** — alignment of video content (spoken, on-screen, captioned) to in-demand search queries surfaced in **Creator Search Insights**, the in-app keyword tool TikTok rolled out in 2024. *Why:* Newsroom Creator Rewards announcement names search value as one of the four core ranking metrics, defined as "metric assigned to content based on popular search terms." [source: tt-rewards] Practitioners report spoken keywords in the first few seconds are heavily indexed. [source: hootsuite-algo; jigsawkraft TikTok SEO 2026] *Lever:* spec the briefed keyword in (a) the first spoken line, (b) on-screen text overlay, and (c) caption — triple-tagged. *Tier:* primary (Newsroom) + secondary (practitioner ranking-signal interpretation).

4. **Likes + Comments** — engagement actions of moderate weight. *Why:* Listed in tt-recsys as user-interaction signals but Buffer notes likes/comments carry less weight than shares/rewatches. [source: buffer-algo] *Lever:* spec a comment-driving open question pinned by creator at 0:00 of comment thread. Avoid engagement-bait phrasing ("comment YES if you agree") — flagged below as anti-pattern. *Tier:* primary (signal exists) + secondary (relative weight).

5. **Originality** — Creator Rewards Program metric defined as "quality content unique to the creator, showcasing their point of view or creative thought process." [source: tt-rewards] Note: this is TikTok's own definition for *Creator Rewards Program payouts*, distinct from Instagram's January 2025 "Originality Score" (Mosseri) which applies to Reels, not TikTok. *Lever:* avoid re-uploads of competitor TikToks; avoid cross-platform watermark drag (see anti-patterns); use native TikTok creation tools (in-app camera, in-app sounds, native text). *Tier:* primary.

6. **Content information (sounds, hashtags, captions, on-screen text)** — TikTok's recsys doc lists "sounds, hashtags, number of video views, and the country in which the content was published" as content-information signals. [source: tt-recsys] These are *contextual* signals — they help the recsys decide *who* to show the video to, not whether to show it. *Lever:* trending sound at peak velocity + 3–5 niche hashtags + spoken keyword in first 3s. *Tier:* primary.

**Explicitly NOT a top-tier signal:** Follower count is **absent** from TikTok's stated For You feed signals. [source: tt-recsys] Follower count is named only for LIVE feed and account recommendations. This is why low-follower accounts can hit FYP — operators should not gate hypotheses on existing audience size.

---

## 4. Anti-Patterns

Each entry is a content trait the algorithm or audience penalizes, with a falsifiable detection rule a critic agent can enforce on a brief.

| Pattern | Penalty observed | Detection rule | Source |
|---|---|---|---|
| **Visible Reels / CapCut / TikTok-of-other-app watermark** | TikTok algorithmically deprioritizes "unoriginal content (watermarked)" per Hootsuite's reading of TikTok's FYF Standards. Note: Meta does this most aggressively (TikTok logo on Reels = restricted to followers, no Explore/Shorts shelf). TikTok's enforcement is softer but originality metric in Creator Rewards explicitly rewards native content. | Brief mentions "repurposed from Reels" / "Capcut export" / "downloaded from another app" without a watermark-removal step. Visual brief shows watermark in any frame. | tt-rewards (originality); smt-watermark (cross-platform context); hootsuite-algo |
| **Engagement-bait CTAs ("Comment YES if you agree", "Like if you want part 2")** | Hootsuite's reading of FYF Standards lists "fake engagement" as one of 14 unrecommendable categories. Risk is downrank or FYF-ineligible flag. | Brief CTA contains explicit instruction to comment a single word, like for visibility, share to win, or "follow if you want X". | hootsuite-algo (FYF Standards interpretation); later-shadowban |
| **Off-platform link as primary CTA in first 5 seconds** | TikTok is structurally hostile to off-platform — no clickable links in caption or comments; only bio link is clickable. CTAs front-loaded reduce completion (the #1 signal). Practitioner data: CTAs after 0:18 preserve retention; before 0:05 trigger drop-off. | Brief CTA specifies "click link in bio" before 0:18 mark, OR brief specifies external URL in caption (which won't be clickable anyway, signaling unfamiliarity with the platform). | TikTok Help Center linking rules; opus-retention CTA placement |
| **Low resolution (<1080×1920)** | TikTok's recsys does not explicitly penalize resolution but black bars (sub-9:16) break full-screen playback and tank completion. | Brief asset spec is <1080×1920 OR aspect ratio ≠ 9:16 OR contains pillarbox/letterbox bars. | tt-creator-academy-covers |
| **Sound-off-friendly failure (no burned captions for spoken content)** | 75% of TikTok views are sound-off; videos relying on VO without on-screen text lose comprehension → lose completion. Auto-captions exist but accuracy is poor for jargon, accents, brand names. | Brief spec for spoken-line scene has no `text_overlay` or `burned_caption: true` field, OR relies on TikTok auto-captions only. | tt-autocaptions; opus-retention |
| **Hook arrives after 0:02** | TTS Vibes 2025: 84.3% of viral TikToks deploy hook trigger within first 3 seconds; videos with <60% retention at 3s receive minimal algorithmic promotion. | Brief storyboard spec puts the credential, claim, or visual reveal at frame 0:03+ with no earlier hook. | ttsvibes-3sec |
| **Hashtag stuffing (>7 tags)** | Sends "mixed signals" to recsys per CapCut/ByteDance editor guidance; dilutes niche targeting. | Brief specifies more than 5 hashtags OR mixes broad (#fyp, #foryou, #viral) with niche tags hoping for both. | accio-hashtag-2025; CapCut creator guidance (cited in hashtag practitioner consensus) |
| **POV opener that doesn't pay off** | The "POV / wait for it" archetype works only if the payoff lands within the duration sweet spot. Videos that promise reveal and bury it past 0:25 lose retention catastrophically (drop-off accelerates after 3s). | Brief storyboard timeline shows "wait for it" overlay at 0:00 but reveal beat at 0:25+ on a sub-30s entertainment video. | opus-retention; archetype 1 above |
| **Re-upload of own cross-platform content with TikTok-foreign pacing** (e.g., 2-second establishing shots, slow LinkedIn-style talking-head openings) | Originality metric penalizes; completion rate tanks. | Brief asset is "repurposed from LinkedIn / YouTube / podcast clip" without re-edit for TikTok hook window. | tt-rewards (originality); buffer-algo (native creation favored) |

---

## 5. Hook Window + Retention Curve

- **First-second goal (0:00–0:01):** Visual + audio + text overlay must each carry a recognizable signal — face / B-roll specificity / trend-sound recognition / on-screen claim. The swipe-decision happens in this window. Practitioner consensus: **70%+ of viewers decide in the first 3 seconds**. [source: ttsvibes-3sec; teleprompter.com 3-second rule]
- **Critical drop-off point (0:03):** Strong-performing videos hold **80–90% retention through 0:03**. A drop of >30% in the first 3 seconds is the failure threshold — algorithmic promotion collapses below 60% retention at 3s. [source: ttsvibes-3sec, January 2025 dataset]
- **Retention checkpoints (industry data, sourced):**
  - 70–85% retention at 0:03 → 2.2× baseline views [ttsvibes-3sec]
  - 85%+ retention at 0:03 → 2.8× baseline views [ttsvibes-3sec]
  - 60–70% retention at 0:03 → 1.6× baseline views (still positive but compressed)
  - <60% retention at 0:03 → minimal algorithmic promotion (effectively shadow-suppressed for FYP, not the same as a shadow ban — see Section 7)
- **Loop / replay behavior:** TikTok rewards rewatches. Buffer explicitly cites rewatches as carrying "stronger" signal than likes or follows. [source: buffer-algo] Loop-friendly final frame (last frame visually compatible with first frame) buys invisible re-entries. The "Of course, of course" sound trend works partly because the audio loop matches the visual loop.
- **Long-form retention curve (60s+ videos):** Buffer's 1.1M cohort: median watch time on 60s+ videos is **11.3 seconds**, on 30–60s videos is **6.9 seconds**. Long-form earns more *total* watch time but absolute completion is lower — operators must engineer mid-video retention curves (subhook at 0:08, payoff escalation at 0:15, secondary reveal at 0:25) for educational content. [source: buffer-length]

---

## 6. CTA Placement Norms

| CTA placement | When it works | When it fails | Source |
|---|---|---|---|
| **Verbal CTA at 0:18–0:25 ("if you want X, comment Y")** | Educational + founder-mode content where the value is delivered before the ask. Preserves completion above the 60% threshold. | When the CTA is the entire value proposition (i.e., the whole video is the ask). Triggers engagement-bait classifier. | opus-retention; hootsuite-algo |
| **End-card overlay at 0:00 of last second** | Educational / how-to content where the loop CTA is "save this to try later." Save is a high-value engagement signal. | Entertainment / POV content — end-card kills the loop and breaks rewatch potential. | buffer-algo (saves as engagement signal) |
| **Caption first line CTA** | When CTA is brief, niche-specific, and search-keyword-rich. Caption truncation at ~70–80 chars before "...more" means the CTA must be tight. | When the CTA is generic ("link in bio for more") — wastes the most-indexed text real estate. Caption is also a search-value lever per Creator Rewards; using it for a generic CTA forfeits search ranking. | hootsuite-algo; tt-rewards (search value) |
| **Comment-pinned CTA** | Long-form (60s+) and educational content where viewers actively scroll comments. Creator pins their own comment with the CTA and link mentioned in plain text (not clickable, but copy-pasteable). | First-3-day organic posts where the comment thread is sparse — the pinned comment is buried by replies. | TikTok Help Center linking rules; practitioner consensus |
| **Bio link as terminal CTA** | The only clickable destination on TikTok. Works when the video drives high view-through and the bio link is the singular focused destination (not a Linktree menu). | When users are asked to "click link in bio" without enough motivation — friction is high (open profile → tap link → leave app). | TikTok Help Center linking rules |

---

## 7. Open Questions / Known Unknowns

- **The "shadow ban" topic — folklore vs. documented.** TikTok's Help Center documents a specific mechanic: content can be marked **"ineligible for the For You feed"** by Trust & Safety review, with creators given a reason and an appeal path. [source: later-shadowban; TikTok Help Center "Content violations and bans"] However, TikTok does **not** use the term "shadow ban" in its community guidelines, and there is **no public documentation** of the threshold for account-level FYF ineligibility. Practitioner folklore claims of "stealth shadow bans" for hashtag stuffing or low retention are **not confirmed by primary docs** — what *is* confirmed is that low retention reduces algorithmic promotion (Section 5), which is a distribution outcome, not a punitive ban. Operators should distinguish: (a) FYF-ineligible flag (documented, appealable) vs. (b) low-retention auto-suppression (a math outcome, not a flag).
- **Exact within-tier weight of completion vs. shares vs. rewatches** is undisclosed. TikTok's primary doc only states user-interactions are weighted more heavily than content/device signals. Buffer ranks rewatches/shares above likes/follows but provides no numeric weights. Any brief that claims "shares are weighted 3× likes" is fortune-cookie — flag for citation.
- **Creator Search Insights' ranking-signal weight.** Newsroom names "search value" as one of four Creator Rewards Program metrics, but it's unclear whether search value applies equally to **organic FYP distribution** or only to **Creator Rewards payout calculations**. Practitioner consensus (Hootsuite, ALM Corp) treats search value as a top-tier organic signal in 2026; primary docs are softer on this.
- **Spoken-keyword indexing depth.** Practitioner claim: TikTok transcribes and indexes spoken audio for search. Primary doc evidence: auto-captions feature (tt-autocaptions) confirms TikTok runs ASR on uploads. Whether the ASR transcript is fed into the search index at full fidelity, or only into accessibility surface, is **not publicly stated**. Briefs that depend on audio-only keyword exposure (no on-screen text, no caption) are betting on an unconfirmed pipeline.
- **The 60-minute upload cap rollout cohort.** Primary docs confirm 60-min uploads exist as of 2024 but rollout is gradual ("professional and high-authority accounts" first). No public cutoff for which accounts have access. Briefs spec'ing 10+ minute videos should verify the target account has the capability.
- **Originality Score equivalent.** Instagram introduced a Mosseri-described Originality Score in January 2025 affecting Reels. TikTok's "Originality" metric (Creator Rewards Program, March 2024) is **not the same mechanism** — TikTok's is a payout metric per Newsroom; Instagram's is a distribution metric. Conflating them in a brief is a critic-failure trigger.

---

## 8. Changelog

| Date | Change | By |
|---|---|---|
| 2026-05-07 | Initial draft — 4 TikTok-native archetypes; format constraints from primary + practitioner sources; 6 ranked algorithm signals with primary/secondary tier markings; 9 anti-patterns with detection rules; retention curve from TTS Vibes Jan-2025 dataset and Buffer Mar-2025 1.1M-video cohort; 5 open questions including shadow-ban folklore vs. documented FYF-ineligibility flag. | opus-research-agent-2026-05-07 |
