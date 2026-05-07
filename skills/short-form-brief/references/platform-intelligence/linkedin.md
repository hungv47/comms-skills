---
type: platform-intelligence
platform: linkedin
schema_version: 1
last_verified: 2026-05-07
verifier: opus-research-agent-2026-05-07
sources:
  - id: src-li-eng-dwell
    title: "Leveraging Dwell Time to Improve Member Experiences on the LinkedIn Feed (LinkedIn Engineering Blog)"
    url: https://www.linkedin.com/blog/engineering/feed/leveraging-dwell-time-to-improve-member-experiences-on-the-linkedin-feed
    accessed: 2026-05-07
    tier: primary
  - id: src-li-help-pages
    title: "Video specifications for LinkedIn Pages and Career Pages (LinkedIn Help)"
    url: https://www.linkedin.com/help/linkedin/answer/a1311816
    accessed: 2026-05-07
    tier: primary
  - id: src-li-help-ads
    title: "Video ads advertising specifications (LinkedIn Help)"
    url: https://www.linkedin.com/help/linkedin/answer/a424737
    accessed: 2026-05-07
    tier: primary
  - id: src-li-ads-guide
    title: "LinkedIn Marketing Solutions — Video Ads Specifications"
    url: https://business.linkedin.com/marketing-solutions/success/ads-guide/video-ads
    accessed: 2026-05-07
    tier: primary
  - id: src-vdb-2025
    title: "Algorithm Insights Report 2025 — Richard van der Blom / Just Connecting (1.8M post analysis, 123 pages)"
    url: https://www.linkedin.com/posts/richardvanderblom_chapter-1-algorithm-insights-report-2025-activity-7322514599126130688-Q895
    accessed: 2026-05-07
    tier: secondary
  - id: src-authoredup-algo
    title: "How the LinkedIn Algorithm Works in 2025 [Data-Backed Facts] — AuthoredUp (994,894 post sample)"
    url: https://authoredup.com/blog/linkedin-algorithm
    accessed: 2026-05-07
    tier: secondary
  - id: src-authoredup-video
    title: "LinkedIn Video Posts: How to Create, Format & Optimize for More Views (2026) — AuthoredUp (3M+ post sample, Mar 2025–Feb 2026)"
    url: https://authoredup.com/blog/linkedin-video-posts
    accessed: 2026-05-07
    tier: secondary
  - id: src-authoredup-best
    title: "Best Performing Content on LinkedIn in 2026: What the Data Says — AuthoredUp"
    url: https://authoredup.com/blog/best-performing-content-on-linkedin
    accessed: 2026-05-07
    tier: secondary
  - id: src-authoredup-hooks
    title: "30 Best LinkedIn Hook Examples to Boost Engagement — AuthoredUp"
    url: https://authoredup.com/blog/linkedin-hook-examples
    accessed: 2026-05-07
    tier: secondary
  - id: src-authoredup-viral
    title: "11 Viral LinkedIn Post Examples And Why They Went Viral — AuthoredUp"
    url: https://authoredup.com/blog/viral-linkedin-posts-examples
    accessed: 2026-05-07
    tier: secondary
  - id: src-socialinsider
    title: "LinkedIn Organic Benchmarks 2026 — Socialinsider"
    url: https://www.socialinsider.io/social-media-benchmarks/linkedin
    accessed: 2026-05-07
    tier: secondary
  - id: src-acosta-post
    title: "Lara Acosta — public LinkedIn post (1,595 likes / 694 comments)"
    url: https://www.linkedin.com/posts/laraacostar_linkedin-writing-tip-i-use-to-create-viral-activity-7155174875018522624-HTSq
    accessed: 2026-05-07
    tier: secondary
  - id: src-smt-q1-2026
    title: "LinkedIn Reports Significant Increases in Post Comments and Video Posts (Microsoft Q1 2026 earnings) — Social Media Today"
    url: https://www.socialmediatoday.com/news/linkedin-reports-increase-in-post-comments-video-posts-microsoft-q1-2026/804353/
    accessed: 2026-05-07
    tier: primary
  - id: src-growleads
    title: "LinkedIn Algorithm 2026: Text vs Video Strategy Exposed — GrowLeads"
    url: https://growleads.io/blog/linkedin-algorithm-2026-text-vs-video-reach/
    accessed: 2026-05-07
    tier: secondary
status: draft
---

# Platform Intelligence — LinkedIn (Native Video)

Practitioner-grade reference consumed by `short-form-brief` (and downstream surface-specific copy skills) to ground hooks, format compliance, algorithm fit, and anti-pattern checks for LinkedIn native video posts. **Not generic marketing advice.** Every claim cites a primary platform doc, a named-cohort practitioner study, or an in-house pattern-log entry.

When this doc's `last_verified` exceeds 90 days, the consuming critic flags `DONE_WITH_CONCERNS` with "platform signal may be stale — verify before publishing."

Scope: native video uploaded directly to LinkedIn (personal profile or Company Page). Excludes: live broadcasts, LinkedIn Learning, Sales Navigator video messaging, paid Video Ads (covered separately under "Video Ads" rows in §2 where they diverge from organic).

---

## 1. Hook Taxonomy

LinkedIn video hooks operate under a constraint no other short-form platform shares: the **caption first line carries equal hook weight to the visual hook**, because the post body sits *above* the autoplay video in the feed and is the first thing the eye lands on. This produces archetypes that don't map cleanly onto TikTok/Reels.

Six base archetypes are defined in `../hook-archetypes.md` (Credential flash, Pattern interrupt, Question, Pre-reveal tease, Contrarian claim, Data point). The three below are LinkedIn-native variants that meaningfully reframe those bases for the feed-with-truncated-caption surface.

### Archetype 1 — Caption-first credential drop (text-leads-video)

- **Definition:** The caption first line states a credential or outcome so strong it earns the click on "...more"; the video then *delivers* the story behind it. Visual hook is secondary.
- **Identifying signal:** First-line of post body is ≤210 characters, contains a specific number or named outcome, and the video opens with the speaker mid-context (no "Hi everyone" preamble — the caption did the framing).
- **Verbatim example A:** "I'm not big on vanity metrics, but this one felt good. I started this..." — @sahilbloom, 2023-07-30, [post](https://www.linkedin.com/posts/sahilbloom_im-not-big-on-vanity-metrics-but-this-one-activity-7091064945840111616-YPIn) — engagement: 156+ comments visible.
- **Verbatim example B:** "LinkedIn writing tip I use to create 'viral' content: (And it's not writing better hooks)" — @laraacostar, 2024-01-23, [post](https://www.linkedin.com/posts/laraacostar_linkedin-writing-tip-i-use-to-create-viral-activity-7155174875018522624-HTSq) — engagement: 1,595 likes / 694 comments. [src-acosta-post]
- **Engagement-signal rationale:** Caption first lines that earn the "...more" click drive dwell time before the video starts playing — and dwell time is LinkedIn's stated primary engagement-quality signal [src-li-eng-dwell]. AuthoredUp's 3M-post sample finds posts with ≥20-sentence captions hit 1.13× median reach vs. 0.73× for captions under 5 sentences [src-authoredup-video].
- **Best for:** founder personal brand, B2B thought leadership, recruiter content, niches where credibility is the buying lever.

### Archetype 2 — Vulnerability lede (status-inversion hook)

- **Definition:** First spoken line / first caption line admits a failure, a confusion, or a status drop — which is rare on LinkedIn's default "polished professional" surface and creates an immediate pattern interrupt for a feed otherwise saturated with brag posts.
- **Identifying signal:** First-person ("I", "my") + a negative or counter-status word (lost, fired, failed, wrong, embarrassed, confused) within the first 8 words of caption OR within the first 2 seconds of spoken audio.
- **Verbatim example A:** "Losing my job was the best thing that ever happened to me." — practitioner-archive example cited as LinkedIn viral hook by AuthoredUp [src-authoredup-hooks].
- **Verbatim example B:** "On Monday, I sat down to write my week of posts… but my inspiration, energy, and motivation was ZERO." — practitioner-archive viral example [src-authoredup-viral].
- **Engagement-signal rationale:** LinkedIn's default professional register makes vulnerability a measurable pattern interrupt — viewers stop to verify the claim, which lifts the 3-second autoplay completion rate and feeds dwell time. Just Connecting / van der Blom's 2025 report attributes ~50% of organic-reach decline to a shift away from "vanity reactions" toward meaningful comments, and vulnerability hooks reliably surface comment threads [src-vdb-2025].
- **Best for:** founder mode, career-pivot content, lessons-learned posts, post-failure case studies. Avoid in company-mode brand voice — reads as performative.

### Archetype 3 — Process-tease frame ("Here's how I…" / "Watch this in 60s")

- **Definition:** Caption + opening visual together promise a defined deliverable inside a defined runtime ("How I cut churn 22% in 90 days — 60-second walkthrough"), which converts the post from "talking head" to "watchable explainer." Length is *promised*, not just performed.
- **Identifying signal:** Caption first line contains (a) a numeric outcome, (b) a time frame ("in 90 days", "in 60s"), and (c) a process verb ("how I", "the way we", "step by step"). Video opens with on-screen text restating the deliverable.
- **Verbatim example A:** "How I" framing — Lara Acosta's documented advice: "Use 'How I' instead of 'How to'" because it adds personal proof and stops the scroll on a self-improvement-saturated feed [src-authoredup-hooks].
- **Verbatim example B:** Hook template family: "I made one change to my outbound strategy and doubled my reply rate" — practitioner template cited by AuthoredUp as a top-performing video caption hook [src-authoredup-video].
- **Engagement-signal rationale:** Promised-runtime hooks reduce *perceived* time cost, which is the friction LinkedIn's autoplay specifically tests — viewers commit to a 60-second watch when the caption sets that expectation, lifting both retention and the 50% checkpoint that AuthoredUp flags as the algorithm's mid-video health signal [src-authoredup-video]. Promised-outcome hooks also generate higher save rates; saves drive ~5× the reach of likes [src-authoredup-algo].
- **Best for:** SaaS demos, agency case studies, recruiting "day in the life" videos, BD/sales tactical breakdowns.

### Archetype 4 — Contrarian-to-LinkedIn-orthodoxy hook

- **Definition:** First line directly attacks a piece of common LinkedIn advice ("Stop posting daily", "Hooks don't matter", "Networking is overrated"), forcing viewers to either defend or update.
- **Identifying signal:** Imperative + anti-platform-orthodoxy claim in first 10 words; OR "Everyone says X. They're wrong." structure. Video proceeds to argue the contrarian case with one counter-example.
- **Verbatim example A:** "LinkedIn gurus will tell you to focus on the hook. But all my…" — @laraacostar, [post](https://www.linkedin.com/posts/laraacostar_linkedin-gurus-will-tell-you-to-focus-on-activity-7150101427363708928-MNxu) — engagement: 989+ comments visible.
- **Verbatim example B:** "(And it's not writing better hooks)" — Lara Acosta's parenthetical rehook on the same post family, denying the conventional answer to set up the real one [src-acosta-post].
- **Engagement-signal rationale:** Contrarian hooks generate "indirect comments" — comments that dispute or refine the claim — which van der Blom's 2025 cohort and AuthoredUp both rank as the most algorithmically-rewarded comment type. AuthoredUp reports posts with indirect comments see up to **2.4× more reach** than baseline [src-authoredup-algo]. Contrarian-to-orthodoxy hooks specifically engineer for that comment shape.
- **Best for:** creator economy, marketing/ops/RevOps niches, B2B founder voice. Avoid for risk-averse enterprise brands and regulated industries — invites brand-damaging dispute.

---

## 2. Format Constraints

Hard specs an agent or critic can enforce. Numeric over prose.

| Constraint | Value | Citation |
|---|---|---|
| Duration sweet spot (organic) | 30–90 seconds for talking heads; videos >3 min get 21% more reach + 17% more engagement than format-average per Socialinsider 2026 cohort | src-authoredup-video, src-socialinsider |
| Duration hard cap (Pages, organic) | 10 minutes | src-li-help-pages |
| Duration hard cap (mobile upload) | 10 minutes | src-li-help-pages |
| Duration hard cap (desktop upload) | 15 minutes (some practitioner sources); LinkedIn Help formal cap is 10 minutes | src-li-help-pages |
| Duration min | 3 seconds | src-li-help-pages |
| Duration sweet spot (Video Ads) | 15–30 seconds qualifies for all placements; <15s for top performers | src-li-help-ads |
| Aspect ratio (recommended for feed) | 1:1 (1080×1080) or 4:5 (1080×1350) — vertical/square outperforms 16:9 in mobile feed | src-li-help-ads |
| Aspect ratio range supported | 1:2.4 to 2.4:1 | src-li-help-pages |
| Resolution range | 256×144 to 4096×2304 | src-li-help-pages |
| Resolution recommended | 1080p (1080×1080 / 1080×1350 / 1920×1080 / 1080×1920) | src-li-help-ads |
| File size (organic Pages) | 75 KB – 5 GB | src-li-help-pages |
| File size (Video Ads) | 75 KB – 500 MB | src-li-help-ads |
| File format | MP4, WebM, MKV, WMV2/3, ASF, FLV, MPEG-1/4, VP8/9 (Pages); MP4 only (Video Ads) | src-li-help-pages, src-li-help-ads |
| Frame rate | 10–60 FPS (organic); <30 FPS (Video Ads) | src-li-help-pages, src-li-help-ads |
| Caption (post body) hard limit | 3,000 characters | src-li-help-ads |
| Caption truncation point ("...more") | **210 characters** on desktop feed; varies 140–210 across sources, 210 is the most-cited 2025–2026 figure. Critic should treat **first 210 chars as the visible hook surface.** | src-authoredup-algo, src-growleads |
| Headline char limit (Video Ads) | 70 characters recommended (200 hard) — truncates on most devices past 70 | src-li-help-ads |
| Burned-in caption requirement | Effectively required: ~80% of LinkedIn video is watched on mute (LinkedIn autoplays muted by default; industry-standard mute-viewing stat) | src-authoredup-video |
| Hashtag norm | 3–5 in post body; >3 hashtags shows slight reach drag in AuthoredUp cohort, but impact is "negligible" overall | src-authoredup-algo |
| Cover/thumbnail | Custom thumbnail recommended; LinkedIn auto-pulls a frame if not set. No formal "cover ratio" — uses the video's first frame at chosen aspect | src-li-help-pages |
| Audio handling | Auto-mute on autoplay; sound only on user-initiated play. Burned subtitles required to convey message in mute preview | src-authoredup-video |
| Autoplay preview length | ~3 seconds before "Continue watching" prompt or scroll-past | src-authoredup-video |
| .SRT caption upload | Supported; LinkedIn renders as native captions toggleable by viewer | src-li-help-pages |
| External link in post body | Reduces median reach **18.8%** (van der Blom 1.3M-post 2025 sample); AuthoredUp/cohort range 25–40%; some 2026 cohort data found multi-link posts outperformed (attributed to confound: link-heavy posts often higher quality). Treat single external link as a 18–35% reach tax. | src-vdb-2025, src-growleads |
| Post-comment link | Standard workaround; no measured penalty when link is in first comment instead of post body | src-vdb-2025 |
| First-3-line preview | Mobile feed shows ~3 lines (~140–210 chars) before "...more" — same surface as truncation cap | src-authoredup-algo |

---

## 3. Algorithm Signals (Ranked by Impact)

Capped at top 7. Ranked by impact based on cross-referenced primary + named-cohort sources.

1. **Dwell time** — total seconds the viewer spent on the post before scrolling. *Why:* LinkedIn Engineering's 2024 post explicitly names dwell time as a top quality signal and details how they replaced the static `Tskip` threshold with adaptive percentile-based normalization specifically to avoid biasing toward long-video formats [src-li-eng-dwell]. *Lever:* spec a caption first line ≤210 chars that earns the "...more" click (caption read time = pre-video dwell), plus a 0–3s visual hook so the autoplay preview clears the dwell threshold. *Tier:* primary.

2. **Indirect comments / comment quality** — comments that engage with the post idea (vs. tagged-friend or "great post!" replies). *Why:* AuthoredUp reports posts with indirect comments see up to 2.4× reach vs. baseline; comments are weighted ~2× likes in LinkedIn's initial test phase [src-authoredup-algo]. Van der Blom's 2025 cohort attributes ~50% of recent organic-reach decline to LinkedIn deprioritizing "vanity reactions" in favor of meaningful comments [src-vdb-2025]. *Lever:* end the video with a specific debate-able prompt; spec a contrarian or vulnerability hook (Archetype 2 or 4) that produces dispute or expansion comments rather than agreement. *Tier:* secondary (cohort-derived; LinkedIn has not published the weighting publicly).

3. **First-60-minute engagement velocity (Initial Classification)** — likes, comments, dwell within the first hour. *Why:* AuthoredUp documents a 0–60min "Initial Classification" phase that gates whether the post enters Extended Distribution; 1–2 hours is the "Engagement Testing" window that determines reach ceiling [src-authoredup-algo]. *Lever:* publish at the time the creator's audience is online; avoid scheduling tools that historically signaled lower trust (no longer a hard penalty per van der Blom 2025); seed with a comment from the author within minutes of publishing. *Tier:* secondary.

4. **Saves** — viewer hits the save bookmark. *Why:* AuthoredUp reports saves drive ~5× more reach than likes and a 130% higher follow probability for saved content [src-authoredup-algo]. *Lever:* spec the video deliverable as save-worthy reference material — frameworks, checklists, before/after comparisons. Process-tease hooks (Archetype 3) over-index on saves vs. vulnerability hooks. *Tier:* secondary.

5. **Native vs. external-link signal** — does the post keep users on platform. *Why:* Van der Blom's 1.3M-post 2025 sample finds one external link in the post body reduces median reach 18.8% [src-vdb-2025]; cohort range across studies is 18–40% [src-growleads]. LinkedIn's 360Brew LLM-based ranking system, rolled out 2025–2026, doubles down on platform-retention signals [src-smt-q1-2026]. *Lever:* publish video natively (never as a YouTube link); put any external CTA link in the first comment, not the post body. *Tier:* primary (LinkedIn has publicly stated native preference) + secondary (penalty magnitude is cohort-derived).

6. **Topic / authority signal (creator graph relevance)** — LinkedIn matches video to viewers based on creator's topic history and viewer's professional graph. *Why:* Van der Blom's 2025 report and LinkedIn's stated 2026 algorithm direction both emphasize "topic relevance" and "authority signals" over raw engagement counts; the 360Brew LLM ranks based on professional-fit semantic match [src-vdb-2025, src-smt-q1-2026]. *Lever:* keep videos clustered around 2–3 topic pillars; spec keyword-rich on-screen text and caption phrasing that matches the creator's established niche vocabulary. *Tier:* primary (LinkedIn product comms) + secondary (van der Blom cohort).

7. **Caption depth (sentence count)** — long, structured captions correlate with reach uplift. *Why:* AuthoredUp's 3M-post sample: 20+ sentence captions hit 1.13× median reach vs. 0.73× for <5-sentence captions [src-authoredup-video]. Hypothesized mechanism: longer captions extend pre-video dwell time, feeding signal #1. *Lever:* ship the video with a 15–25 sentence caption that tells the same story in text — many viewers consume the caption *instead of* the video and still count as engaged dwell. *Tier:* secondary.

---

## 4. Anti-Patterns

Specific patterns the algorithm penalizes or audiences punish on LinkedIn video. Each entry includes a detection rule a critic agent can apply.

- **Pattern:** External link in post body (YouTube/blog/landing page).
  **Penalty observed:** 18–40% median reach reduction (van der Blom 2025: 18.8%; cohort range 25–40%) [src-vdb-2025, src-growleads].
  **Detection rule:** Caption contains `http(s)://` or recognizable domain pattern outside `linkedin.com`.
  **Source:** primary (LinkedIn-stated native preference) + secondary (penalty magnitude).

- **Pattern:** YouTube-link share posing as native video.
  **Penalty observed:** Treated as external link; loses autoplay preview entirely; reach degraded vs. native upload [src-growleads].
  **Detection rule:** Brief specifies "share YouTube link" or "embed video URL" without native upload step.
  **Source:** primary.

- **Pattern:** No burned-in subtitles / no .SRT.
  **Penalty observed:** ~80% of LinkedIn video is watched on mute due to autoplay-muted default; without subtitles, the message doesn't land in the 3s preview, killing dwell-time signal [src-authoredup-video].
  **Detection rule:** Brief omits "burned subtitles" OR "uploaded .SRT" in production spec.
  **Source:** secondary (industry consensus).

- **Pattern:** "Hi everyone, today I want to talk about…" preamble in first 3 seconds.
  **Penalty observed:** Audience drop-off at 0:03 — viewers scroll past before the preview ends. AuthoredUp: "If most viewers drop off in the first 10 seconds, your hook isn't working" [src-authoredup-video].
  **Detection rule:** First spoken line is a greeting or self-introduction; first 2 seconds contain no claim, number, or specific outcome.
  **Source:** secondary.

- **Pattern:** Caption first line is generic ("Excited to share this video about…").
  **Penalty observed:** Fails to earn the "...more" click → reduced pre-video dwell → algorithm reads as low-quality.
  **Detection rule:** First 210 chars of caption contain none of: a specific number, a named outcome, a question, a credential statement, a contrarian claim. (Critic should fail any caption that opens with "I'm excited to" / "Today I'm sharing" / "Check out my new video" patterns.)
  **Source:** secondary.

- **Pattern:** Hashtag stuffing (>5 hashtags).
  **Penalty observed:** Negligible-to-mild reach drag per AuthoredUp; not a hard penalty but consumes valuable first-210-char surface [src-authoredup-algo].
  **Detection rule:** >5 hashtags in caption, or hashtags placed in the first 210 characters.
  **Source:** secondary.

- **Pattern:** Tagging unrelated high-follower accounts.
  **Penalty observed:** Reach reduction when tagged accounts don't engage; LinkedIn 2025 tightened anti-spam handling around irrelevant tagging [src-vdb-2025].
  **Detection rule:** Brief specifies "@-tag X creators" without relationship/relevance justification.
  **Source:** secondary.

- **Pattern:** Naked sales-pitch CTA inside the video ("DM me to book a call" with no proof or specificity).
  **Penalty observed:** Audience punishment via low save/comment rate, not algorithmic — but second-order signal degrades reach over the 0–60min Initial Classification window.
  **Detection rule:** CTA is a generic ask without a deliverable, named offer, or specific next action.
  **Source:** secondary.

- **Pattern:** Re-uploaded TikTok with visible TikTok watermark.
  **Penalty observed:** No formal LinkedIn statement, but practitioner consensus is significant reach drag — the watermark signals off-platform-origin which 360Brew's platform-retention objective deprioritizes [src-smt-q1-2026].
  **Detection rule:** Brief specifies cross-posting from TikTok without watermark removal step.
  **Source:** secondary.

- **Pattern:** Video >10 minutes uploaded via mobile (silent failure).
  **Penalty observed:** Upload rejected outright [src-li-help-pages].
  **Detection rule:** Duration spec >10:00 paired with mobile-upload production path.
  **Source:** primary.

---

## 5. Hook Window + Retention Curve

- **First-second goal (0–1s):** Visual must convey *what kind of video this is* — face-cam vs. screen-share vs. b-roll story — and the burned subtitle must show the first 3–5 words of a specific claim. AuthoredUp: "short clips under 90 seconds with a face visible in the first four seconds do better than everything else" [src-authoredup-video].

- **Autoplay preview window (0–3s):** LinkedIn autoplays the video silent for ~3 seconds before showing a "Continue watching" prompt or letting the user scroll past [src-authoredup-video]. The 3s preview is the hard gate — if dwell time falls below the percentile threshold LinkedIn uses to classify "skipped" [src-li-eng-dwell], the post is downranked.

- **Critical drop-off point:** 0:10. AuthoredUp: "If most viewers drop off in the first 10 seconds, your hook isn't working" [src-authoredup-video]. Practitioner consensus: post-3s gate, 0:10 is the next inflection — viewers either commit to the watch or peel off here.

- **Mid-video health checkpoint:** 50% retention. LinkedIn surfaces dropoff data at 25/50/75/100% in creator analytics. AuthoredUp: "if they drop at 50%, your video is too long or loses focus mid-way" [src-authoredup-video]. Treat 50% retention as the lever for whether the next video should be cut shorter.

- **Loop / replay behavior:** LinkedIn does *not* loop video by default (unlike TikTok/Reels); a single play-through is the default unit. Replay does count toward dwell time but is rare. Brief should not optimize for loop-friendly final frames.

- **Dwell time threshold debate:** LinkedIn explicitly abandoned its static `Tskip` threshold in favor of an adaptive, percentile-based dwell-time normalization that compares each post against "a specific percentage (x%) of its counterparts" [src-li-eng-dwell]. Practitioner sources cite 6s as a folk threshold for "qualified view"; LinkedIn has not confirmed this number publicly. **Treat dwell as relative-rank, not absolute-seconds.** A 6s dwell on a long-form post is a skip; a 4s dwell on a short clip might be a strong signal.

---

## 6. CTA Placement Norms

The link-in-post vs. link-in-comment debate is the longest-running operator-level dispute on LinkedIn. The cohort data is mixed but converges on: **don't put the only link in the post body if reach is the primary goal.**

| CTA placement | When it works | When it fails | Source |
|---|---|---|---|
| Link in first comment (creator-pinned) | Default for organic reach optimization. Caption references "link in comments" overtly. Works because the post body stays link-free, avoiding the 18–40% link reach tax. | When the comment isn't pinned, mobile users miss it (comments collapse below the fold). | src-vdb-2025, src-growleads |
| Link in post body (in caption) | Works for paid Video Ads (no organic algorithm penalty applies). Works for posts where conversion >> reach (e.g., job-board posts where reach beyond audience is wasted). | Default-fail for organic content optimizing reach: 18.8% median reach drop per van der Blom 1.3M-post sample. | src-vdb-2025 |
| Verbal CTA at end of video (no link) | Works when the CTA is "comment with X" or "follow for the next part" — drives the indirect-comment + follow signals the algorithm rewards. | Fails for direct conversion goals (no measurable click path); only suitable for top-funnel awareness. | src-authoredup-algo |
| On-screen text CTA at 0:50–1:00 | Works as a complement to verbal CTA; reinforces the action when audio is muted (~80% of viewers). | Fails when burned in too early (≤0:15) — competes with the hook for attention and lowers retention. | src-authoredup-video |
| Bio / Featured section link | Works as evergreen anchor for high-intent traffic. LinkedIn's "Featured" section links survive every algorithm update and don't compete with post-level reach. | Fails as a post-specific CTA — viewers won't navigate to profile from feed; only the mid-funnel re-visiters click bio links. | src-authoredup-algo |
| "DM me" CTA | Works for high-trust/high-ticket B2B with established personal brand (post engages, viewer self-selects, conversation starts). | Fails when used as default-CTA on every post — reads as transactional, lowers comment quality, and is the prototypical "naked sales pitch" anti-pattern. | src-vdb-2025 |

---

## 7. Open Questions / Known Unknowns

- **Dwell-time threshold for "qualified view" on LinkedIn:** unstated by platform; LinkedIn explicitly uses adaptive percentiles, not a fixed seconds value [src-li-eng-dwell]. Practitioner folk-figure of 6s is unsourced. Cohort study with measured dwell-to-reach correlation by video length is missing.
- **Caption truncation char count:** sources cite 140 characters (older), 210 characters (most 2025–2026), and "first 3 lines" (mobile-relative). LinkedIn has not published an official figure. The 210 number is dominant in current cohort sources but was not directly confirmed by LinkedIn in any document found.
- **External-link reach penalty magnitude:** range 18–40% across cohorts (van der Blom 2025: 18.8%; AuthoredUp/GrowLeads: 25–40%). Q1 2026 analysis found multi-link posts outperformed link-free posts (likely confound: link-heavy posts skew higher quality), suggesting the penalty is moderating or topic-conditional. Net direction is clear (negative); magnitude is not.
- **360Brew LLM ranking weights:** LinkedIn announced LLM-based ranking via 360Brew through 2025–2026 [src-smt-q1-2026], but no detailed signal weights or features are public. All §3 weights are pre-360Brew cohort observations and may decay faster than typical platform-doc claims.
- **Video reach decline mechanism:** AuthoredUp 2026 cohort: video reach −36% YoY, engagement −26% [src-authoredup-video]. LinkedIn-stated: video uploads +45%, video viewership +36% YoY — the same data viewed from supply vs. demand sides. Open question: is per-video reach down because supply outpaced demand, or because LinkedIn rebalanced format weighting toward documents (1.45×) and polls (1.64×) [src-authoredup-algo]? This determines whether videos should slow production or compete harder.
- **Mobile vs. desktop watch-time split:** Just Connecting cited 72% mobile share but no per-format breakdown. Whether desktop viewers (sound-on, larger screen) clear the dwell threshold differently than mobile viewers (sound-off, autoplay) is not separately measured in any public cohort.
- **Subtitle compliance auto-detection:** No public data on whether LinkedIn algorithmically detects burned-in subtitles vs. uploaded .SRT files and weights them differently. Practitioner consensus is to do both; the marginal value of one over the other is unmeasured.
- **Verbatim hook examples for video specifically:** Most cited "viral LinkedIn hook" archives are text-post hooks. Public archives of *video-post* opening lines with engagement metrics are thin — most §1 examples are caption-first lines from posts that included video, not transcribed first lines from the video itself. A future verifier should pull 10+ verbatim spoken-first-line examples with timestamps from public posts.

---

## 8. Changelog

| Date | Change | By |
|---|---|---|
| 2026-05-07 | Initial draft. 4 hook archetypes, 7-signal algorithm rank, format spec table, 10 anti-patterns, 6-row CTA placement matrix, 7 open questions. Sources: 4 primary (LinkedIn Engineering blog, LinkedIn Help × 2, LinkedIn Marketing Solutions ads guide, Microsoft Q1 2026 earnings via SMT), 9 secondary (van der Blom 2025 cohort, AuthoredUp × 4, Socialinsider 2026 benchmarks, GrowLeads, Acosta verbatim post). | opus-research-agent-2026-05-07 |
