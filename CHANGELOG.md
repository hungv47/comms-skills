# Marketing Skills — Changelog

Format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/). Versioning is [SemVer](https://semver.org/spec/v2.0.0.html) — major.minor.patch.

This file tracks stack-level releases. SKILL.md files describe current behavior; this file documents what changed and when.

---

## [4.2.1] - 2026-05-11

Discipline patch on the v4.2.0 `/ad-copy` scaffold. Independent review caught three rubric/contract issues plus a humanize-integration gap that would have surfaced on first real invocation. None are source-fidelity violations.

### Rubric fixes
- **Specificity band wording aligned to the Floor.** In v4.2.0 the 7-8 band and 5-6 band both said "2 verifiable specifics per variant" — same numeric condition with no deterministic rule for the critic to pick between them. (Sibling skill `cold-outreach` caught the same pattern in its v4.1.1 patch; v4.2.0 reproduced it.) 7-8 now requires ≥3 specifics with one feeling bolted on; 5-6 requires exactly 2 with both integrating naturally. Applied identically in `references/rubric.md` and `agents/critic.md`.
- **Per-variant floor is binding.** `agents/critic.md` Scoring Discipline previously included "PASS_WITH_CONCERNS if 2 of 3 variants pass and the third is recoverable" — a sycophancy escape hatch that contradicted the per-variant per-dim floor rule the rest of the rubric enforced. Removed. Overall Verdict is FAIL if any variant fails a per-dim floor, regardless of aggregate average.

### Pre-Dispatch fixes
- **Hard-block trigger widened.** v4.2.0 only fired the cold-traffic + 3-day-trial soft warn on a literal "3-day trial" string match. A user typing "7-day free trial" (which one of the worked examples actually uses) would bypass the warn entirely. The Apple 24h signal window is structural — it affects all short free trials, not only 3-day. Hard-block now fires on `(offer contains "free trial" OR trial duration ≤ 14 days)`, matching the broader `anti-patterns.md` §4c scope.

### Humanize integration fix
- **Terminal pass content-type token now registered.** v4.2.0 passed `content-type: "ad-creative"` to humanize, but humanize's Content Type Calibration table has no `ad-creative` row — the call would fall to a default and bypass the 0-10% compression cap that critic just enforced. The closest match is `short-outbound` (Light strip / Full voice / 0-10% compression / protected_tokens enabled — exact semantic fit). `ad-copy` now passes `short-outbound`, and humanize's table at `humanize/SKILL.md` lines 187 + 194 explicitly registers ad-copy as another caller of that content-type alongside cold-outreach.

### Discipline fixes
- **Example 4 arithmetic.** Variant B scorecard summed to 15 (2+7+2+3+0+1) but printed 14; aggregate 14.3, not 14.0. Corrected scorecard and Calibration Discriminant table.
- **Emoji threshold alignment.** `references/format-spec.md` said "0-1 emoji in headline; 2+ excessive" while `references/anti-patterns.md` §5d said "3+ in headline; 5+ in primary text excessive". format-checker reads format-spec; voice-auditor reads anti-patterns — same draft would flag inconsistently. Aligned to anti-patterns' more lenient threshold (3+ headline, 5+ primary text).
- **Strategist verification phrasing.** SKILL.md Layer 1 Strategy Dispatch previously said "Extract `angle_archetype` per variant..." but strategist returns markdown prose with no machine-parseable keys. Rewrote as a checklist that the orchestrator can apply by reading the Variant Assignments section.

### What did NOT change
- All v4.2.0 behavioral content is preserved — 5-agent dispatch, 6-dimension rubric, hero + 2 variants per audience-temperature, Meta-only scope, automatic humanize terminal pass per variant.
- Source-fidelity verification on v4.2.0 was clean throughout — every numeric figure traces to a substantiated reference, no fabricated claims, no stitched-quote violations. None of the 7 fixes touch source attribution; they're all internal-consistency repairs.
- Two simplifications surfaced by the review (consolidating the Pattern-Interruption rule's 5-place definition into a single source of truth; folding Pattern-Interruption out of the critic and into a pre-critic structural gate to reduce to 5 dims matching siblings) are real architectural questions worth revisiting in v0.2 but not applied here — they're refinements, not bugs.

### Independent review report
`.agents/skill-artifacts/meta/records/2026-05-11-fresh-eyes-ad-copy.md` (local-only artifact).

### Files changed
~15 net lines across 6 files:
- `skills/ad-copy/SKILL.md`
- `skills/ad-copy/agents/critic.md`
- `skills/ad-copy/references/rubric.md`
- `skills/ad-copy/references/examples.md`
- `skills/ad-copy/references/format-spec.md`
- `skills/humanize/SKILL.md`

---

## [4.2.0] - 2026-05-11

New skill: **`/ad-copy`** — Meta paid-ad copywriting for retargeting and cold-traffic audiences. Phase 1.2 of the marketing-stack content build. Produces a hero plus two distinct variants per invocation, gated by audience-temperature framing, Meta char caps, policy compliance, and a 6-dimension critic rubric.

### Added
- **`skills/ad-copy/SKILL.md`** — orchestrator (5-agent dispatch). Single audience-temperature per invocation (`retargeting` or `cold`); run twice for campaigns spanning both. Hero plus two variants, each with a distinct angle archetype and a distinct anchor proof. Automatic `humanize` terminal pass per variant with a specificity regression check.
- **`skills/ad-copy/agents/`** — five agents:
  - `strategist.md` — picks angle archetype, audience-temperature framing (warm-objection map vs cold-objection map), CTA verb, and the anchor-proof slot per variant. Surfaces a ceiling warning when `creative_format=repurposed-ugc`.
  - `composer.md` — drafts hero + Variant A + Variant B (primary text + headline + description per variant) within Meta's char caps. Enforces visible-window economy (hook + anchor must land in the first ~125 characters of primary text).
  - `format-checker.md` — hard-gate. Bounces on any Meta char-cap violation (3,000 / 40 / 30), any policy banned phrase, or any measured claim that doesn't trace to `available_proof[]`. Does not rewrite.
  - `voice-auditor.md` — peer-voice audit. Strips vendor-speak, AI tells, em-dashes, "just"/"quick" hedges, rhetorical-question openers, generic claim soup. Same auto-fail discipline as `cold-outreach`'s voice-auditor, scoped to ad copy.
  - `critic.md` — scores hero + A + B across 6 dimensions independently, then aggregates. Pass: aggregate ≥ 42/60 with every per-variant per-dim ≥ 6.
- **`skills/ad-copy/references/`** — five reference files:
  - `rubric.md` (v0.1) — 6-dimension bands: Hook scroll-stop, Component-char compliance, CTA-LP match, Pattern-interruption density, Policy + claim compliance, Specificity (Floor ≥ 2 verifiable specifics per variant).
  - `policy-floor.md` — Meta banned-phrase rules (health / finance / political / protected-class / engagement bait / click bait / misleading buttons) + substantiation hedging templates.
  - `anti-patterns.md` — vendor-speak banned list, AI-tell structural fails, ad-specific fabrication tells, ceiling-warning triggers, variant-distinctness anti-patterns.
  - `format-spec.md` — Meta component char caps (hard + soft) with visible-window economics per placement.
  - `examples.md` — four worked examples (strong-retargeting / weak-retargeting / strong-cold / weak-cold) with per-variant per-dim scorecards. Discriminant gap 33-40 points between strong and weak.
- **`skills/ad-copy/references/ad-intelligence/`** — three per-surface practitioner references (previously pre-staged in 4.0.4 / 4.0.5; now consumed by the skill):
  - `meta-retargeting.md` — warm-audience system (3 custom audiences, warm-vs-cold objection map, budget pacing) [George Clem 2026]
  - `meta-cold-traffic.md` — subscription-app cold playbook (2-campaign structure, trial-start optimization, 3-layer attribution, cross-vertical matrix) [Cali Apps]
  - `creative-cadence.md` — volume / kill speed / 80/20 budget / dedicated vs repurposed-UGC ceiling [Simplr + Cali + uncited operator vault]

### Wiring
- **`.claude-plugin/plugin.json`** — `ad-copy` added to the `skills` array (slot 14); description updated; `ad-copy` added to keywords; version 4.2.0.
- **`skills/orchestrate-marketing/SKILL.md`** — intent buckets table gains a `paid-ads` row matching trigger phrases like "Meta ads", "Facebook ads", "Instagram ads", "retargeting ads", "primary text", "ad headline", "ad creative copy". Routing rules add a `paid-ads → ad-copy` rule between `social-post` and `outbound`, hard-gated on `research/icp-research.md` and asking which audience-temperature.
- **`skills/orchestrate-marketing/references/workflow-graph.md`** — pipeline diagram now includes `ad-copy (per audience-temp — Meta only at v1)`. Per-skill catalog gains an `ad-copy` entry. Routing rules numbered through `l. vn-polish`.
- **`CLAUDE.md`** — skill count updated 12 → 13. Pre-Dispatch protocol summary now notes `ad-copy` as the second-most-elaborate cold-start (7 questions plus audience-temp and creative-format hard-blocks). Multi-Agent Skills list gains an `ad-copy` row.
- **`README.md`** — skill count updated; pipeline diagram now includes `ad-copy`; per-skill section added between `vn-tone` and `cold-outreach`; Cross-Stack section notes `ad-copy` also consumes `research/icp-research.md`.

### Scope at v1
- **In:** Meta paid-ads (Facebook + Instagram), retargeting + cold-traffic audience temperatures, dedicated and repurposed-UGC creative formats with ceiling warning surfaced on the latter, single audience-temperature per artifact, hero + 2 variants per invocation.
- **Out:** Google RSA (15 headlines per ad), LinkedIn ads, TikTok Ads, Reddit ads — references not pre-staged at v1; reserved for future expansion when source material lands. Audience setup / pixel setup / budget pacing remain operator-driven in Ads Manager. Landing-page copy uses `copywriting` or `lp-brief`. Cold-outreach DMs use `cold-outreach`.

### Calibration
- Synthetic-illustrative discriminant test on rubric v0.1 produced strong totals of 54-55/60 and weak totals of 13-22/60 across both audience-temperatures. Discriminant gap 33-40 points (target: ≥15). All per-dim auto-fail conditions fired as designed. Calibration record at `.agents/skill-artifacts/mkt/ad-copy/2026-05-11-calibration-record.md` (local-only).
- Rubric v0.1 is provisional. Mandatory revision triggers after first 5 real-world invocations OR if Meta announces a substantiation-rule change.

### Notes
- Phase 1.2 architecture is locked at Option A (separate skills, not a `--surface` flag on `copywriting`) per the 2026-05-08 divergence test.
- Three ad-intelligence references previously pre-staged at v4.0.4 / v4.0.5 are now load-bearing for this skill. Their re-verification triggers (footer of each ref) fire at first real invocation — Meta's ad system shifts on quarter cadences, so refs should be re-verified before running a real campaign.
- Independent review (`/fresh-eyes`) is recommended before the first production invocation given this is the largest behavioral addition to the marketing stack since `social-copy` shipped in v4.0.0.

---

## [4.1.6] - 2026-05-11

`orchestrate-marketing` Step 1 starts from concrete disk state instead of asking the model to derive it. When you run `/orchestrate-marketing`, the skill now sees the actual artifact counts by domain, which top-level canonical folders exist (`research/`, `brand/`, `architecture/`), and the last 5 commits — all rendered inline before the manifest read kicks in.

### Changed
- **`skills/orchestrate-marketing/SKILL.md` §Step 1** — disk-snapshot block lifted from `orchestrate-meta`. Three `! \`<cmd>\`` interpolations (artifact-count-by-domain / canonical-folder check / git-log -5) substitute their output at slash-command invocation time, before the manifest read. The orchestrator starts from a deterministic snapshot instead of speculating about what's on disk.

### Notes
- Additive context. No behavioral change to routing, recommendations, or output schema. Existing invocations work unchanged.
- The block only renders when the skill is invoked as a slash command. If `SKILL.md` is read via the Read tool inside another skill, the bang-backtick lines pass through as literal syntax — by design.

---

## [4.1.5] - 2026-05-11

Discipline patch on the v4.1.4 channel-tightening pass. Independent review caught one source-fidelity violation (the exact stitched-blockquote pattern patched in v4.0.3 / v4.0.5 / v4.1.1) plus two wiring gaps that left the new `imessage | sms` channel discoverable in the artifact spec but invisible to the user-facing input contract.

### Source-fidelity fix
- **`channels/imessage.md` Teaser Preview blockquote — split into two sequential quotes.** The Saraev source has the two iMessage teaser rules as separate bullets (one about the ~90-char preview + ≥135 char minimum, one about cliffhanger placement at the truncation boundary). v4.1.4 stitched them into a single prose blockquote under one source attribution — the same auto-fail pattern caught by prior anti-fab patches. Now rendered as two separate blockquotes, each individually attributed.
- **`channels/imessage.md` Links row — source quote restored.** Saraev line 142 explicitly says "Same applies (lower-priority) to LinkedIn and SMS" about the cold-email no-links rule. v4.1.4 paraphrased the reasoning without quoting source; the row now carries the verbatim Saraev quote alongside the derived application.

### Discoverability fix
- **`SKILL.md` §Inputs Required — channel enum widened.** v4.1.4 updated the artifact frontmatter spec (line 139) to include `imessage | sms` but missed line 102, the human-facing Inputs Required block that's the first place a user learns which channels the skill accepts. Both lines now match.

### Wiring fix
- **`composer.md` and `reply-composer.md` — channel→file mapping documented.** The composer's auto-read pattern is `references/channels/{channel}.md`. With `channel: sms`, that resolves to a non-existent `sms.md` (the file is `imessage.md` and covers both messaging types). The mapping was implicit for `linkedin-dm`→`linkedin.md` and `twitter-dm`→`twitter.md` already; a one-liner in both composer files now documents the grouped-channel convention explicitly, including the iMessage/SMS case.

### What did NOT change
- All v4.1.4 behavioral content is preserved — the LinkedIn / X DM Teaser Preview Constraint sub-sections, the new `imessage.md` file's overall structure, the composer + voice-auditor + strategist row additions, the channel enum widening in frontmatter, and the SKILL.md description update.
- No new content beyond fixing the issues called out by the review. Net ~6 lines edited across 4 files.

### Independent review report
Report at `.agents/skill-artifacts/meta/records/2026-05-11-fresh-eyes-channel-tightening.md` (local-only artifact).

---

## [4.1.4] - 2026-05-11

Tightens `cold-outreach` with per-channel teaser-preview rules from the Saraev source and adds first-class support for iMessage / SMS as a cold-outreach channel. Drafts targeting any of these channels now respect the visible-preview window before recipients open the thread.

### What's new
- **LinkedIn connection notes — visible-preview window codified.** `references/channels/linkedin.md` gains a Teaser Preview Constraint subsection: LinkedIn surfaces only the first ~50-55 characters in the inbox before the recipient clicks in. A long-firstname salutation (`Hi [Long-Firstname] — `) can burn 20+ of the 55-char preview before the trigger lands. The existing ≤300-char hard limit is the layered limit on the full note; the new rule guards the *visible* slice.
- **X / Twitter DM — visible-preview window codified.** `references/channels/twitter.md` gains a Teaser Preview Constraint (DM) subsection: X DM inboxes preview only the first ~40-55 characters before requiring a click. Public replies don't have this constraint (they render inline), so the rule bites specifically on DM. Reinforces the existing "no salutation" DM convention.
- **New channel — iMessage / SMS.** `references/channels/imessage.md` covers what the Saraev source gives us: a ~90-character preview that often shows the whole message in the lock-screen notification, so drafts need to be ≥135 characters to force the open, with a cliffhanger landing right at the truncation boundary. Also: blue-bubble (iMessage) carries a trust premium over green-bubble (SMS) for high-income iPhone-native targets. Coverage is intentionally thin — a single practitioner source — and the file is flagged that way.
- **`channel` field now accepts `imessage` and `sms`.** Artifact frontmatter enum widened from `email | linkedin-dm | linkedin-connection | twitter-reply | twitter-dm | upwork-proposal | other-platform` → adds `imessage | sms`. Backward-compatible (existing channel values unchanged).

### Wiring (so the new channel actually carries through the pipeline, not just sit in references)
- **composer.md** — new row in the channel constraints table for `imessage / sms`: ≥135 chars, ~90-char cliffhanger, no links, prefer blue bubble. The existing `twitter-dm` row gains a teaser hook addendum (first ~40-55 chars carry the hook).
- **voice-auditor.md** — new row in the channel-register table for `imessage / sms`: casual peer, text-to-a-friend register. Corporate phrasing reads instantly fake on a phone.
- **strategist.md** — framework selection rows for `email / linkedin-dm` now also cover `imessage / sms` for parity (same framework choices apply; only the form factor differs). The Saraev Four-Step row extends here too — the channel is a natural fit for touch-1 outbound to strangers.
- **SKILL.md** — `references/channels/imessage.md` registered in the Shared References block, channel enum extended in the artifact frontmatter spec, top-level skill description updated to mention iMessage/SMS so the skill matches when someone asks for iMessage outreach help.

### What did NOT change
- All existing channel files (email, LinkedIn, Twitter/X, platform proposals) behave identically. The LinkedIn and Twitter edits are additive — the new Teaser Preview Constraint sub-sections sit alongside existing rules without modifying them.
- Saraev Four-Step framework itself unchanged. The new channel inherits the existing framework selection; no new framework was added.
- Per-channel character limits beyond the teaser-preview rule (LinkedIn 300-char hard cap, Twitter 280, etc.) all unchanged.

### Source
Nick Saraev's 2026 cold outreach course (§Channel-specific platform rules — LinkedIn, X, iMessage/SMS). Strict scope per source — only the three teaser-window rules + iMessage/SMS bubble-color signal were ported. Other Saraev material (subject-line tactics, follow-up cadence, iteration cadence) was already absorbed in v4.1.0; this release closes the channel-tightening tail.

---

## [4.1.3] - 2026-05-11

One-line discipline patch on the `campaign-plan/references/distribution-models/clipping-and-live.md` ref shipped in 4.1.2. Independent review caught one row of operational guidance that wasn't carrying the inferred-tag the rest of the doc uses.

### Source fidelity fix
- **§6 habitat-to-channel table — B2B enterprise row now tagged inferred.** The row claiming "B2B enterprise buyer in a regulated category → No (clipping bounty networks are not currently structured for compliance-sensitive distribution)" is a reasonable allocation call, but Oren John's source essay frames clipping in consumer-market terms (male 21–30, Gen Alpha / younger Gen Z). The B2B-enterprise row is a generalization from that consumer framing, not source-attributed. It now carries `[inferred — generalization from source's male-21-30 consumer framing; not source-attributed]` matching the convention already used by §3 vetting checklist, §3 rate-range guidance, and §5 pre-production clip-density test.

### What did NOT change
- All source-attributed content (blockquotes from Oren's essay, named platforms Whop+Zagged, named operators TJR+FearBuck+Brez Scales+Air piece+David Protein, the verbatim compelling-source test). All source-verified clean by the independent review.
- The clip-density characterization sub-section in `research-skills@3.0.2` cleared review with no findings — no companion patch.
- All other §6 rows (Gen Alpha + younger Gen Z, tech-worker + vibe-coding / TBPN-on-X, live-streaming H-density Lurker pattern, all-L-density No-allocation guidance) — these are source-grounded or are direct implications of channel-strategy.md's existing habitat-density rules.

---

## [4.1.2] - 2026-05-11

Adds a new reference doc to `campaign-plan` covering the paid-CPM clipping ecosystem (Whop/Zagged bounty model) and the Jubilee debate format as a source-engineered-for-clipping pattern. Channel-agent consults it conditionally when the target demographic skews male 21–30 or habitat data flags live-streaming density. No behavioral change to any existing skill.

### What's new
- **`campaign-plan/references/distribution-models/clipping-and-live.md`** — covers the Normie-to-Fringe awareness ladder, the three operational modes of clipping (in-house team / paid-CPM bounty network / curator cross-post), the Whop+Zagged+TJR-army-of-clippers cohort, the Jubilee format with three named instances (Brez Scales 1M views/day, Air's three-generations-of-marketers piece, the David Protein crisis-comms hypothetical), and the compelling-source test (boring source × paid CPM = expensive nothing). Includes a habitat-to-channel mapping table for when to allocate to clipping vs. stay on the default 9-channel map.
- Sourced from Oren John, *How streaming and clipping work, and why brands should care* (2026-03-17). Verbatim quotes blockquoted; vetting checklist and rate-range guidance tagged `[inferred from creator-economy norms; not source-attributed]` per the stack anti-fabrication convention.

### Wiring
- `campaign-plan/SKILL.md` Shared References lists the new doc.
- `campaign-plan/SKILL.md` Multi-Agent Dispatch Map gates channel-agent to consult it conditionally on demo / habitat triggers.
- `campaign-plan/agents/channel-agent.md` input contract updated.

### Why it's its own primitive (not a UGC sub-tactic)
- Bounty economics (Whop/Zagged pay CPM per view; the clip account is the unit of inventory).
- Distributed-network reach (hundreds of clippers per personality; millions to hundreds-of-millions of views/day).
- Decoupled source and distribution (one source → N clip accounts → M derivative clips).

These properties make clipping behaviorally closer to *paid acquisition with creator-as-format-supplier* than to *organic social posting* — hence the separate doc rather than another row inside `channel-strategy.md`.

---

## [4.1.1] - 2026-05-11

Four fixes to the `cold-outreach` Saraev framework that landed in 4.1.0. Independent review caught one strategist routing bug and one source-fidelity issue.

### Behavioral fix worth knowing about
- **Strategist Framework Selection Logic now reaches Saraev for services-sell touches with signal 1-2.** The table previously listed the Saraev row below the generic `1-2 / any → Question → Value → Ask` row, and row-matching is top-down — services-sell touches with signal 1-2 were never reaching Saraev. Now the Saraev row sits above the generic Q→V→A row, so the narrower (services-sell) match wins. A precedence note also documents the "narrower row above broader" convention for future additions.

### Source fidelity fix
- **`anti-patterns.md` Pattern 2 (Variable mishaps) separates verbatim from inferred.** The previous list mixed two source-verbatim examples ("Hi Nick Daily Updates", "Hi Nick Automates, congrats on 35K subs") with one inferred example ("Hi Pacific Creative Group LLC team") under a single "Verbatim examples from source" header. The inferred example is now in a separate "Inferred from source's casualization rule" block. The verbatim entries also restore the source-original bracket annotation and lowercase ("Hi [Nick automates]") rather than the post-cleanup form.

### Documentation fixes (no behavioral change)
- **`critic.md` Specificity dimension** now explicitly states that the Floor (≥2 verifiable specifics) overrides the rubric bands. A draft scored at the 7-8 or 5-6 band today has exactly 1 verifiable specific — the Floor auto-fails it. Band wording is retained for diagnostic continuity with prior reviews; practically a 7-8 score is awarded only when both halves carry weight AND the integration is partial.
- **`saraev-four-step.md` source-claim caveat** trimmed from a sentence to a phrase ("Source-claimed lift: 3x top-of-funnel at ~10% margin cost, net 2.7x"). The "do not pass as stack endorsement" disclaimer is already covered by the top-of-file caveat — duplicate caveat removed.

### What did NOT change
- The Saraev framework reference itself, the offer-formula equation, the seven Cialdini levers, the verbatim $15M template, the email iteration section, the Specificity Floor auto-fail rule — all stand. This is a discipline patch, not a substance patch.

---

## [4.1.0] - 2026-05-11

`cold-outreach` gains an opinionated four-step framework reference from Nick Saraev's 2026 cold-email course, plus a Specificity Floor in the critic that tightens what counts as a passable cold message. Touch 1 to a stranger now has a sharper structural option than the generic Q→V→A fallback.

### Behavioral change worth knowing about

- **Critic now enforces a Specificity Floor: ≥2 verifiable specifics in the body.** A "verifiable specific" is a named entity (Ramp, Linear, a specific post the prospect wrote), a named number with context (`9 days → 4 days`, `$3M last month`, `20 booked meetings in 90 days`), or a named research source. Drafts with one strong specific and three generic-flavor sentences ("great work in SaaS space", "leading B2B SaaS companies") will now fail where they previously passed. Generic-flavor language doesn't count toward the floor. The reason: drafts that "feel specific" without being verifiable were sliding through the old rubric — the floor closes that gap.

### New framework reference

- **`cold-outreach/references/frameworks/saraev-four-step.md`** — Saraev's four-step outbound framework (personalization → who-am-I → offer → CTA) with each step's purpose, length budget, and worked tactics. Includes the seven Cialdini-mapped levers (reciprocity, commitment, social proof, authority, liking, scarcity, unity), the offer-formula equation (`ROI × Trust ÷ Friction`), and the verbatim $15M template attributed to Saraev's source claim (figure not stack-verified — cited as Saraev's example, not endorsed).
- **`strategist.md` Framework Selection Logic** gains a new row for `signal-strength 1-3 / email-or-linkedin-dm / services-sell` → **Saraev Four-Step**. Sharper than the Q→V→A fallback when the message is touch 1 to a stranger with zero pre-existing trust.

### New anti-patterns

- **`anti-patterns.md` §"AI-Generated Personalization Tells (Saraev)"** documents five specific tells that mark personalization as AI-written or scraper-driven:
  - **Compound-praise specificity ("BeaverCorp tell")** — "love how passionate you are about process optimization and aligning corporations with diversity outcomes at BeaverCorp"
  - **Variable mishaps** — scrapers pulling YouTube channel names as first-name fields ("Hi Nick Daily Updates", "Hi Pacific Creative Group LLC team")
  - **Bolded / quoted / bracketed variables** — template-engine leaks ("Hi **{{FirstName}}**", "Hi [Sarah]")
  - **False-specificity dressed as specificity** — "Saw you're doing great work in the SaaS space" reads specific but isn't verifiable; the remove-the-opener test passes (rest of the email reads identically without it)
  - **AI-coined rhetorical-question hooks** — "What if I told you there's a way to 10x your pipeline..." (auto-fail per `critic.md` §Peer Voice structural auto-fail #9)

### Email channel additions

- **`channels/email.md` §Subject + Preheader Truncation** — Gmail/Outlook show subject + first ~80-100 chars as the preview line (combined ~150 chars). Body length ≥150 chars total so the preheader isn't filled with date metadata; bury the hook at the truncation boundary to force the click.
- **`channels/email.md` §Iteration** (new section) — codifies the 500-1,000-send statistical-significance floor per variant, Saraev's Sunday 20-30 min iteration cadence (~50 cycles/year vs. ad-hoc iteration that dies after week one), the reply-rate progression band (2.0-3.0% week 1 → 4.5-6.0% week 4-6 with iteration; 8-15% top-decile), and the 2-then-3 follow-up sequence sizing rule.

### Coordination notes

- Voice-auditor's downstream rules are unchanged — Saraev's framework lives upstream of voice-auditor. The "Sent from my iPhone" tag and intentional-typo-at-end-of-long-emails stylistic devices pass through voice-auditor cleanly (it kills phrases, not stylistic choices).
- Source figures from Saraev (`$15M+`, `$300K/mo profit`) are cited as source claims, not stack endorsements. The framework's structural value is independent of the revenue numbers.

### Source

Nick Saraev's 2026 cold-email course condensed at the contributor's idea vault. Practitioner-grade source with cited tactics and verbatim teardowns; numeric author-claims (`$15M+`) flagged inline as source claims.

---

## [4.0.6] - 2026-05-11

Ten new AI-tell patterns added to the `humanize` reference. Catches the post-2024 LLM voice that the original 37-pattern catalog was written before — `load-bearing`, `it's giving`, anaphora cascades, "X has entered the chat," "what if I told you," "X is having a moment," `quietly`/`silently` rebrand intensifiers, "X, but Y" headlines, "X is the new Y," and the *agentic / agentful / model-native / vibe-coded / vibe shift / the year of agents* jargon cluster.

If you ran content through `humanize` last quarter and it still felt subtly AI-flavored, this is why — the original catalog was tuned to 2023-era output and didn't have names for the constructions LLMs lean on now. Updating `humanize` is the entire fix; no skill API changes.

### Added
- **10 new patterns** in `skills/humanize/references/ai-patterns.md` (catalog grows from 37 → 47):
  - **Hard Tells (6, on-sight flags):** Load-Bearing X (#38), "It's Giving X" (#39), Anaphora Cascade (#40), "X Has Entered the Chat" (#41), "What If I Told You" (#42), "X Is Having a Moment" (#43).
  - **Soft Tells (4, flag in cluster):** "Quietly" / "Silently" as Rebrand Intensifier (#44), "X, but Y" Headline Form (#45), "X Is the New Y" (#46), Agentic-Era Jargon Cluster (#47).
  - Each new pattern is routed into its natural category (Language Quirks / Filler Patterns / Structural Tics) rather than spawning a new category — keeps the taxonomy intact.
  - Each pattern carries severity, mechanism, illustrative example, and a specific fix. The fix for #38 includes the delete-test (if the argument doesn't collapse without the load-bearing word, the word wasn't load-bearing). The fix for #43 / #46 requires citing actual displacement signal (share-of-time, share-of-spend) or deleting the trend claim entirely.
- **6 vocabulary additions** to the high-frequency AI vocabulary list: `agentic`, `agentful`, `load-bearing`, `model-native`, `vibe shift`, `vibe-coded`. Single instances are fine; 3+ in one paragraph still triggers the existing vocabulary cluster flag.
- **8 new items in Speed Scan** (final-audit checklist grows from 19 → 27 items): one item per new on-sight phrase pattern plus the anaphora-cascade and agentic-jargon cluster checks. Still within the rapid-audit budget.

### Changed
- **`pattern-scanner-agent.md` diagnosis table** updated so each category row lists the new pattern numbers — Language Quirks now reads `(6-10, 38, 44, 47)`, Filler Patterns reads `(21-25, 39, 41, 42, 43, 46)`, Structural Tics reads `(26-30, 37, 40, 45)`. The scanner agent runs every numbered pattern; the table is only the reporting structure.
- **`strip-agent.md` absolute-prohibition list** extended to include the four phrase-level Hard Tells that always delete on sight: "it's giving X", "X has entered the chat", "what if I told you", "X is having a moment" without a cited signal. These join em dashes, negative parallelism, rhetorical question hooks, colons in prose, and staccato taglines as zero-tolerance patterns.
- **Quick Scan checklist** in `ai-patterns.md` extended with the 10 new patterns under the correct severity buckets.

### Notes
- The pattern catalog is now at 47. The over-prescribing watch-point sits around ~50 patterns; further additions need empirical justification before shipping.
- Examples in the new pattern entries are illustrative (synthetic AI-flavored prose), consistent with the existing 37 patterns. The anti-fabrication rule applies to sourced verbatim quotes (e.g., the Paolo Scales reference docs), not to generic pattern-detection examples.
- **Agent-file consistency.** The four agents that share an Absolute-Prohibitions surface (`pattern-scanner-agent.md`, `strip-agent.md`, `critic-agent.md`) all now list the same 13-item zero-tolerance set: the original 9 (em dashes, negative parallelism, rhetorical question hooks, colons in prose, "actually" emphasis, filler context, emojis, unsourced 47/73, staccato taglines) plus the 4 new phrase-level Hard Tells (#39, #41, #42, #43). Drift between scanner / strip / critic on this list would mean a pattern fails one stage and passes another.

---

## [4.0.5] - 2026-05-10

Source-attribution and tier-vocabulary fixes to the v4.0.4 ad-intelligence reference docs. No behavioral changes to any active skill — the ad-copy seedbank is still pre-staged.

### Fixed
- **Stitched-bullet quote pattern across 4 locations** — `meta-cold-traffic.md` §1, §3, §4 and `creative-cadence.md` §6. Each was rendered as a single prose blockquote with sentence punctuation, but the underlying source used bullet structure. Each fragment was individually verbatim, but the rendered quote-as-displayed did not appear as continuous prose in the named source. The stack's verbatim-quote rule says every blockquote must actually appear in its named source, so this failed the test for a reader cross-checking the citation. **Resolution:** the 4 stitched quotes are now split into sequential bullet quotes preserving the source's bullet structure. `meta-cold-traffic.md` §7 Sources gains a new "Source-attribution convention" subsection codifying the rule.
- **`creative-cadence.md` frontmatter `simplr-comment` tier mislabel** — declared `tier: secondary`, but the template's `secondary` definition requires "named cohort + N", which a tweet commenter without a disclosed audience doesn't meet. The doc's own §8 reconciliation table already honestly labeled the same source as "low — commenter, no cohort, no scale disclosure" — direct contradiction with the frontmatter. Frontmatter is the machine-readable signal that future tier-aware tools key off. **Resolution:** frontmatter changed to `tier: tertiary` to match the doc's own internal labeling.
- **`platform-intelligence/_template.md` tier vocabulary extension** — v4.0.4's `creative-cadence.md` introduced `tier: tertiary` without updating the template, which enumerated only `<primary | secondary>`. Future tier-keyed code (validation, manifest sync, critic-agent gates) wouldn't recognize `tertiary`. **Resolution:** template tier enumeration extended to `<primary | secondary | tertiary>` with a definition for tertiary ("uncited author or commenter signal without disclosed cohort/N — treat as heuristic, not benchmark; calibrate against your own data before adopting any threshold sourced this way"). The 6 existing platform-intelligence files were left at their current `secondary` classification — they were approved through their own review cycles; re-tiering them is a separate review.

### Notes
- Source-fidelity sweep verified every numeric threshold (`$1k–$2.5k` cold CAC, `$20–50/day` starter, `$100–200/day` mature, `24–72h` timing, `1.5%` CTR/48h, `80/20` split, `$10–15K` vs `$40K/day`, `$2M→$5.7M`, `$30/year`, `~30%` retention, `~1.3x`, `50+` variants/month, `100+/week`) appears verbatim in its named source. Every named entity (Clem/Paid House/Cali/Zach/Simplr/Tribe/AppsFlyer) is real and correctly attributed. The substantive fixes were entirely about quote-rendering discipline and tier-vocabulary alignment — no fabricated metrics, no invented attributions.

---

## [4.0.4] - 2026-05-10

Pre-staged reference docs for a future `ad-copy` skill. The skill itself isn't built yet — no SKILL.md, no plugin-manifest entry, no behavioral change to any active skill. These are reference docs sitting in `skills/ad-copy/references/ad-intelligence/` waiting for the skill to scaffold around them.

### Added
- **`skills/ad-copy/references/ad-intelligence/meta-retargeting.md`** — warm-audience retargeting system: 3 custom audiences (IG engagers 180d / IG followers / FB page engagers from cold-traffic interactions), warm-vs-cold objection map (warm = fit/credibility/timing, not awareness/positioning), creative posture differentiation, frequency-driven budget pacing (`$20–50/day` starter, `$100–200/day` mature), 4-step Meta Ads Manager setup, compounding-effect rationale, and 7 named failure modes. Source: George Clem (Paid House, $200k+/mo agency). Numeric examples (`$2k cold / $500 retargeting / 4x`) are labeled illustrative, not benchmarks.
- **`skills/ad-copy/references/ad-intelligence/meta-cold-traffic.md`** — subscription-app cold-traffic playbook: pre-conditions for paid (organic warmth + first-year profitability + founder hands-on learning), 2-campaign structure (Scale CBO + Testing), broad targeting + algo-via-creative (post-Andromeda), conversion-event choice (trial-start, not purchase, given the Apple-privacy 24h signal window), 3-layer attribution (custom product pages + MMP + incrementality testing), 6 anti-patterns, and a cross-vertical applicability matrix covering apps vs DTC vs B2B SaaS. Source: Cali (`$2M/mo` influencer-only → `$5.7M/mo` with paid layer; in-house ads run by Zach after the agency hit a `$5K/day` cap).
- **`skills/ad-copy/references/ad-intelligence/creative-cadence.md`** — paid-ad creative cadence discipline: variant volume (master brief → many angles), kill-speed thresholds (`1.5%` CTR/48h auto-pause; "3 days not 3 weeks"), winner-vs-test budget split (`80/20` directional), dedicated-vs-repurposed creative spend differential (`$10–15K/day` repurposed vs `$40K/day` dedicated), affiliate-creator production model (Tribe + WhatsApp), 6 failure modes, and source-confidence reconciliation across 3 sources with explicit per-claim attribution. Sources: Simplr Intelligence commenter, uncited operator-vault thresholds, Cali creative-strategy section.
- **`skills/ad-copy/README.md`** — directory-level note flagging `ad-copy/` as a pre-staged seedbank (intentionally absent from the plugin's `skills` array since there's no SKILL.md to register). Protects against future cleanup-artifacts runs flagging the folder as orphan.

### Notes
- Each reference doc carries explicit source-confidence labels and re-verification triggers in its frontmatter and footer. When the `ad-copy` skill scaffolds, the references should be re-verified before consumption — Meta's ad system shifts on quarter cadences.
- Anti-fabrication discipline carried over from v4.0.3: every numeric threshold is attributed to a specific source ID, illustrative examples are explicitly labeled as such, and no invented metrics are presented in verbatim format.

---

## [4.0.3] - 2026-05-10

Removes fabricated examples from `copywriting/references/emotional-triggers.md` and wires the new copywriting references into the agent bodies that 4.0.2 missed. If you installed 4.0.2, update — the emotional-triggers reference had invented quotes presented as verbatim Paolo Scales source material.

### Fixed
- **3 fabricated illustrative examples in `copywriting/references/emotional-triggers.md`.** Trigger 5 (Curiosity Gap) "Strong gap" comparison table contained 2 invented rows ("the cold email template that opened a $150k deal in 8 minutes" and "the 3-second hook structure that took my app from 0 to #1 in 3 days") that did not appear in the Paolo Scales source. Trigger 5 "compound hooks" bullet list contained a fabricated third bullet ("the silent reason your sales calls don't close (it's not the offer)") presented in the same italicized verbatim-quote format as 2 legitimate Paolo quotes. Trigger 6 (Aspiration) skepticism-vs-aspiration table contained a fabricated 2nd row with invented `$5M business` / `$90k → $11k MRR` figures. **Resolution:** fabricated rows replaced with explicit illustrative-paraphrase placeholders that name the structural ingredients (e.g., "specific framework + specific outcome + specific timeframe") and instruct the reader to instantiate from real data, with an anti-fabrication warning ("invented results are detectable and burn the account permanently"). The comparison-table teaching pattern is preserved; the false-attribution risk is removed.
- **`copywriting/agents/hook-agent.md` + `copywriting/agents/psychology-agent.md` body wiring.** v4.0.2 added `emotional-triggers.md`, `belief-disruption.md`, and `lead-magnet-stack.md` to SKILL.md's Layer 1 + Layer 2 dispatch matrices, but the agent bodies had no instruction on how to integrate the new references into the existing Headline Formula Catalog (`hook-agent`) or Sweep 6: Heightened Emotion (`psychology-agent`). Dispatch was passing the path, but the agents would have landed cold. **Resolution:** `hook-agent.md` gains an "Engagement-Driven Hook References" sub-section (peer to Headline Formula Catalog) that lists when to invoke each new reference — TOF / lead-magnet / persuasion-heavy hooks only, not tactical product/nav/label copy. `psychology-agent.md` Sweep 6 gains an "Engagement-driven sub-pass — when to invoke" addition with the same triage. Both agents' input-contract `references` fields updated.

### Notes
- `belief-disruption.md` and `lead-magnet-stack.md` cleared review with no findings — fabrication issues were concentrated in one file.
- `research-skills` is not affected by this patch — its companion 3.0.1 release cleared its own review with no findings.

---

## [4.0.2] - 2026-05-10

Three new reference docs and a new critic dimension for `copywriting`, plus a format-fit test for `short-form-brief`'s critic. Sourced from external practitioner content (Paolo Scales viral-LinkedIn breakdown and Roman Khaves UGC playbook).

### Added
- **`copywriting/references/emotional-triggers.md`** — 6-lever framework (identity validation / status signaling / tribal belonging / productive discomfort / curiosity gap / aspiration+believability) with worked examples per lever, stack rules, an authenticity filter, and anti-patterns. Loaded by `hook-agent` (TOF/lead-magnet hooks), `psychology-agent` (Layer 2 emotion pass), and `critic-agent` (trigger-density gate).
- **`copywriting/references/belief-disruption.md`** — TOF ragebait 5-step structure (state common belief → create doubt → introduce alternative frame → show implication → optional path forward) for problem-unaware audiences. 3 worked examples with step-by-step decomposition. Pairing rules with the 6-trigger stack.
- **`copywriting/references/lead-magnet-stack.md`** — 5-element lead-magnet post (curiosity hook → identity validation → tribal belonging → investment signaling → aspiration+CTA) and 4-layer FOMO sequence (social proof → transformation → exclusivity → urgency) for high-friction CTAs. Worked full-post example. Stack-when matrix.

### Changed
- **`copywriting/agents/critic-agent.md`** — added an **emotional-trigger density** dimension. 0-2 triggers = WEAK (FAIL — fold in another lever); 3-4 = STRONG (target zone); 5-6 = GURU-ENERGY RISK (FAIL — cut to 3-4). Applies to TOF / lead-magnet / persuasion-heavy copy only; N/A for tactical product / nav / label copy. Score on craft, not trigger-count alone — V/F/U upstream gate must pass first. Routing for trigger-density and authenticity-filter failures added to the Rewrite Routing table.
- **`copywriting/SKILL.md`** — Layer 1 dispatch matrix now lists the 3 new reference files against `hook-agent`, `cta-agent`, and `social-proof-agent`. Layer 2 dispatch matrix lists `emotional-triggers.md` + `belief-disruption.md` against `psychology-agent`, and `emotional-triggers.md` against `critic-agent`. Shared References section enumerates the 3 new docs with which agents consume each.
- **`short-form-brief/agents/critic-agent.md`** — added a **format-fit test** to the Brand-Fit Critic (Roman Khaves' 2 failure modes: viral-but-no-convert vs converts-but-no-views). The critic now answers "is the product the punchline of the format, or pasted on top?" with quoted shot-or-beat evidence. Routing table gains `format-fit pasted-on` → `hook-agent + storyboard-agent` (re-architect product reveal as payoff) and `format-fit heavy-integration` → `format-agent + storyboard-agent` (loosen integration).

### Notes
- The matching synthesis-heuristic addition to `short-form-research/pattern-extractor-agent.md` ships in `research-skills@3.0.1` — separate stack, separate plugin manifest.
- Additive content + one strengthened critic dimension. No contract changes for downstream consumers, no behavioral change to skill outputs that already passed v4.0.1's gates.

---

## [4.0.1] - 2026-05-09

Critical fix on top of 4.0.0: the new `social-copy` skill was on disk but missing from the plugin manifest, so anyone who installed 4.0.0 didn't actually get it. If you ran `/plugin install marketing-skills@4.0.0` and don't see `/social-copy`, update to 4.0.1.

### Fixed
- **`plugin.json` `skills` array was missing `social-copy`** — installed copies of `marketing-skills@4.0.0` would not have surfaced the new skill. Added `./skills/social-copy/` to the array. **This is the load-bearing fix in this patch.**
- **`orchestrate-marketing/SKILL.md` body H1 still said `# Start Marketing`** — the 4.0.0 rename missed the body title. Fixed to `# Orchestrate Marketing`.
- **`orchestrate-marketing/references/workflow-graph.md` did not list `social-copy`** — the orchestrator could not route users to the new skill. Added social-copy to the pipeline diagram, the per-skill catalog, and the routing rules (h. social-post → social-copy with soft-gate on short-form-brief OR brand). Also corrected stale `.agents/mkt/...` paths under short-form-brief to the new `.agents/skill-artifacts/` taxonomy.
- **CHANGELOG accuracy correction.** v4.0.0 claimed TikTok Findings 1-4 were closed in the platform-intel verbatim-example cleanup; actually only Finding 1 was. Findings 2 (Billie Eilish stitch), 3 (@mckenzibrooke × Prime Video brand stitch), and 4 (Codie Sanchez laundromat) are now relabeled `[pattern-observed; URL not pinned]` to match the rest of the cleanup pattern. No fabricated URLs were introduced.
- **Missing changelog audit-trail rows** in `tiktok.md`, `reels.md`, and `x.md` — only `shorts.md` had a 2026-05-08 row. Added matching entries describing which findings each file closed.
- **`social-copy/SKILL.md`** did not state the spec-locked default "single-market per artifact (matches short-form-brief)". Added the constraint inline alongside the polish-chain section.
- **`marketing-skills/CLAUDE.md` skill counts ("11 skills")** and "Skills using this pattern" enumeration not updated for `social-copy`. Counts now read 12; `social-copy` added with its 3-agent dispatch description; Recent Changes entry added.
- **`plugin.json` description** updated: "11 skills" → "12 skills" and named `social-copy` in the blurb. Added `social-copy` keyword.

---

## [4.0.0] - 2026-05-08

### BREAKING
- **`start-marketing` is renamed to `orchestrate-marketing`.** The skill scans existing artifacts and continues mid-pipeline; the orchestration role now reads explicitly in the slash command. No backward-compat alias.
- Update any `/start-marketing` invocations in your workflows to `/orchestrate-marketing`.

### Added
- **New skill: `social-copy`.** Generates platform-native social copy (A/B hook variants, body, CTA, format spec) for TikTok, Reels, YouTube Shorts, X, and LinkedIn. Three-agent pipeline (copywriter → format-checker with max-1 hard-cap revision loop → critic) with a 5-dimension critic rubric: hook scroll-stop strength, char/word limit compliance, CTA placement vs algorithm truncation, pattern-interruption density, format compliance (0-10 each, pass ≥35/50). Reads `short-form-brief/references/platform-intelligence/[platform].md` for per-surface Hook Taxonomy, Format Constraints, and Algorithm Signals. Single-platform per invocation; YouTube long-form is deliberately excluded (different rubric). Polish chain default `none`; can route through `humanize` or `vn-tone`.
- **`social-copy/references/rubric.md` v0.1** — falsifiable thresholds for each of the 5 dimensions with a discrimination test protocol baked in (weak brief must score <25, strong brief must score ≥35; rubric breakage is flagged when both pass or both fail).
- **`social-copy/references/examples.md`** — 10 worked examples (1 strong + 1 weak per platform) with full per-dimension critic verdicts. Discrimination spread on ship: strong totals 44–48 / 50; weak totals 11–23 / 50.
- **`social-copy/references/anti-patterns.md`** — 10 detection rules (generic hook openers, algorithm-blind CTAs, format mismatch, char-limit-blind copy, brand-voice ignored, pattern-interrupt monotony, pasted-from-blog body, engagement-bait CTA, external link in post body, hook-body disconnect) calibrated per platform.
- **Platform-intelligence verbatim-example and source-attribution cleanup.** 11 deferred findings from the original platform-intelligence framework ship resolved across `tiktok.md`, `reels.md`, `shorts.md`, and `x.md`. Verbatim hook examples without locatable specific-post URLs are relabeled `[pattern-observed; URL not pinned]` (no fabricated URLs). Source mis-attributions corrected (the ManyChat doc is no longer cited as Stephanie Kase; the Buffer blog scope is clarified as the underlying study, not the X post; the X-API doc is footnoted to clarify dual API/organic applicability). Shorts March 2025 "loop = view" methodology preserved with practitioner-source caveat. All 6 platform-intel docs + `_template.md` `last_verified` bumped to 2026-05-08.

### Notes
- Marketing-skills surface area: 12 → 13 skills.
- Forward-looking: `email-copy` and `ad-copy` will ship as separate standalone skills with their own per-surface reference catalogs, not as `--surface` flags on `copywriting`.

---

## [3.4.3] - 2026-05-08

CLAUDE.md doc cleanup — align stack-level documentation with the new `.agents/skill-artifacts/` taxonomy shipped in v3.4.2 and across the umbrella as marketplace 1.5.0.

### Changed

- `marketing-skills/CLAUDE.md` Artifacts and Cross-Stack sections — every `.agents/mkt/...`, `.agents/prioritize.md`, `.agents/targets.md` reference migrated to the new lifecycle taxonomy (`.agents/skill-artifacts/mkt/...`, `.agents/skill-artifacts/meta/sketches/prioritize-*.md`, `.agents/skill-artifacts/meta/records/targets-*.md`).
- Cross-stack `short-form-research` reference relocated from `mkt/` to `research/` to match where the producer skill writes after its own T33 migration.
- "Pipeline outputs write to `.agents/mkt/`" → "Pipeline outputs write to `.agents/skill-artifacts/mkt/`."
- Manifest Spec section + short-form-brief description updated to the new path.

### Notes

Doc-only patch — no SKILL.md or skill-behavior changes. Per-stack CLAUDE.md was left out of the v3.4.2 T33 pass to keep that pass strictly about skill output declarations; this patch closes the doc-vs-code drift.

---

## [3.4.2] - 2026-05-08

T33 path migration — every skill SKILL.md updated to the new `.agents/skill-artifacts/` lifecycle taxonomy (see `agent-skills/CLAUDE.md` §"Artifact Placement"). Mechanical churn only — no behavior changes.

### Changed

- All 12 SKILL.md files (`brand-system`, `campaign-plan`, `cold-outreach`, `copywriting`, `design-brief`, `humanize`, `lp-brief`, `lp-optimization`, `seo`, `short-form-brief`, `start-marketing`, `vn-tone`) — frontmatter `description`, `routing.produces`, `routing.consumes`, and inline body references updated:
  - `.agents/mkt/...` → `.agents/skill-artifacts/mkt/...`
  - `.agents/prioritize.md` → `.agents/skill-artifacts/meta/sketches/prioritize-*.md`
  - `.agents/targets.md` → `.agents/skill-artifacts/meta/records/targets-*.md`
  - Cross-stack: short-form-brief's reference to `short-form-research` updated to `.agents/skill-artifacts/research/short-form-research.md` (was incorrectly pinned under `mkt/`).
- All 12 SKILL.md files now declare `routing.lifecycle:` — `canonical` for `brand-system` (top-level `brand/` paths unchanged), `pipeline` for the rest.

### Notes

Non-behavioral release. Operator-driven migration to clean two-tier `.agents/` structure; old paths were not breaking but accumulated drift. No skill output changed format. No CHANGELOG entry warranted for downstream skill consumers — the path change is purely substrate-level and the manifest catches up automatically.

---

## [3.4.1] - 2026-05-08

Fresh-eyes mechanical fixes to the v3.3.0 platform-intelligence reference docs. No behavioral changes.

### Fixed

- `short-form-brief/references/platform-intelligence/linkedin.md` — Reclassified the Microsoft Q1 2026 earnings recap (Social Media Today) from `primary` to `secondary` (third-party recap; underlying earnings statements are primary). Split the conflated "Duration sweet spot (organic)" row into two rows so the 30–90s talking-head guidance and the 3+ min retention-lift figure each carry their own citation.
- `short-form-brief/references/platform-intelligence/reels.md` — Reclassified the ManyChat DM-trigger source from `primary` to `secondary` (third-party automation-tool docs documenting an integration mechanism; Mosseri's endorsement is primary, ManyChat's docs are not). Removed the unsourced "Meta's 2024 internal data cited 50% reach lift for Collab posts" claim and replaced with hedged practitioner-consensus phrasing; added a §7 open-question entry to track the citation gap. Hedged the 2,200-char caption limit and ~125-char truncation citations (`S6` was claimed but the underlying URL pin is not in the sources block); added a second §7 open-question entry.
- `short-form-brief/references/platform-intelligence/shorts.md` — Removed the unsupported numeric claim "70–90% of total Shorts views via the Shorts feed traffic source"; rephrased to "the Shorts feed handles the majority of Shorts views" with the 70–90% split flagged as practitioner-estimated and pinned to §7.
- `short-form-brief/references/platform-intelligence/tiktok.md` — Hedged the 4,000-char caption-limit citation (`jera.bean TikTok 2023 announcement` was an inline reference not registered in the frontmatter sources block) to practitioner-derived; added §7 open-question. Hedged the 3–5 hashtag-norm and >7 stuffing-penalty rows (orphan source IDs `accio-hashtag-2025`, `admetrics`, `sproutsocial` not pinned in frontmatter); added §7 open-question entry to register them on a re-research pass.
- `short-form-brief/references/platform-intelligence/youtube.md` — Reclassified the Ritchie + Beaupré algorithm-and-television-strategy recap (Richard Harrington's blog) from `primary` to `secondary` (the presenters are YouTube employees, but the source itself is a third-party blog).

### Notes

These are the 9 mechanical fresh-eyes corrections to the v3.3.0 platform-intelligence ship: tier mis-classifications corrected (3 sources), a fabricated "internal data" claim removed, an orphan source-ID chain hedged, a conflated citation row split, and §7 open-questions seeded so the next re-research pass can close the citation gaps cleanly. No content claim was strengthened — the fix direction is consistently from over-confident attribution to honest hedging plus a registered re-research item.

---

## [3.4.0] - 2026-05-07

`lp-brief` always-emit Implementation Prompt for coding agents + critic-rubric awareness + `pending-media-skill` route.

### Added

- `lp-brief` now writes `handoff-implementation.md` as a paste-ready prompt for any frontier coding agent (Claude Code, Cursor, Codex, etc.) on every brief run, regardless of `target_handoff`. Stack auto-detected from repo (frameworks → that stack; no framework → pure HTML/CSS/Vanilla JS, single index.html). Motion stack from `brand/DESIGN.md` (silent → GSAP+ScrollTrigger+Lenis default). Includes verbatim Asset Placeholder Rule so coding agents never invent stock-photo URLs — missing slot files render as solid-color placeholder blocks with slot-id overlay until a media-briefing skill catches up. New gold-standard format section in `references/handoff-formats.md` modeled on Awwwards-grade single-shot prompts.
- `lp-brief/agents/asset-slot-agent.md` adds `pending-media-skill` route value for slot types not yet covered by an existing media-briefing skill (motion, 3D, video, audio-reactive). Slots flagged this way spec dimensions/format/fallback fully; the implementation prompt renders placeholders until skills like `motion-brief` / `3d-brief` / `video-brief` ship.
- `lp-brief/agents/brand-voice-critic-agent.md` G8b — new gate scoring Implementation Prompt compliance: Asset Placeholder Rule lifted verbatim, "Invent or substitute asset URLs" ban present in DO NOT block, closing-rule presence, and (BUG FIX) callouts for tricky CSS mechanics (clip-path, mix-blend-mode + transform stacking, sticky-inside-overflow). Both critics' input contracts now reference the implementation prompt companion.

### Changed

- `lp-brief` artifact template: `target_handoff` now optional (specialty targets only — implementation prompt is universal default). `pencil` restored to enum (was missing). Array form documented. Hand-Off (Specialty Targets) section explicitly omitted when `target_handoff: null`.
- Brief stays inside the 250–500 line envelope by referencing `handoff-implementation.md` as a companion file, not inlining the 200–350-line prompt body. Prevents auto-FAIL on brand-voice critic G6 (envelope gate).

### Notes

User-driven: improve lp-brief output so coding agents (Cursor / Codex / Claude Code) can implement landing pages from a single paste-ready prompt, with media handled as placeholders deferring to `design-brief` and future media-briefing skills. Independent fresh-eyes review caught and fixed an envelope conflict, a dropped enum value (`pencil`), and a critic blind spot before merge.

---

## [3.3.0] - 2026-05-07

Platform-intelligence references for `short-form-brief` (Phase 0.5).

### Added

- `short-form-brief/references/platform-intelligence/` — 6 per-platform reference docs (LinkedIn, TikTok, Reels, Shorts, X, YouTube long-form) plus a canonical `_template.md`. Each doc covers: ≥3 platform-native hook archetypes with verbatim public-post examples + URLs + engagement metrics, format constraints (numeric over prose), 5–7 ranked algorithm signals with operator levers, anti-patterns with detection rules, hook window + retention curve, CTA placement matrix, and explicit open-questions section. Frontmatter `last_verified: 2026-05-07`. When `last_verified` exceeds 90 days, downstream critics flag `DONE_WITH_CONCERNS` ("platform signal may be stale"). 8–20 cited sources per doc, mix of primary platform docs/exec statements and named-cohort practitioner studies (Richard van der Blom, AuthoredUp, Buffer, Later, Mosseri/Ritchie/Beaupré statements, the open-sourced X algorithm). Replaces the previously-scoped standalone `algo-intel` skill — practitioner-grade reference content, not a new skill.

### Notes

This release lands the practitioner-grade answer to the "algo-master" ask (per stack roadmap). YouTube long-form ships pre-built so it's available when long-form briefs become a Phase 2 candidate. Drafts are `status: draft` until first real-use validation; the `last_verified` 90-day staleness gate is enforced by consuming critics.

---

## [3.2.0] - 2026-05-07

Manifest-aware state detection in `start-marketing`.

### Changed

- `start-marketing` SKILL.md — Step 1 (State Detection) now reads `.agents/manifest.json` first with a status-aware lookup table (`done`, `done_with_concerns`, `blocked`/`needs_context`, `stale`, `frontmatter_present: false`). Per-artifact staleness flows from the manifest's `stale_after_days` field rather than the previous 180-day brand-artifact rule. The manifest's `experience` block surfaces Pre-Dispatch coverage (entries count for `brand.md`, `audience.md`, `goals.md`). Per-path filesystem scan demoted to fallback for fresh projects. Anti-pattern entry added: "Don't ignore the manifest." Added `side-effects: [manifest-sync]` to the skill's routing block.
- `CLAUDE.md` — added "Manifest Spec" section pointing producer skills (brand-system, copywriting, campaign-plan, lp-brief, lp-optimization, seo, cold-outreach, design-brief, humanize, vn-tone, short-form-brief) at the canonical contract in `meta-skills/references/manifest-spec.md` and the frontmatter obligations.

### Notes

This release lands the manifest-spec contract on the consumer side. Per-skill frontmatter retrofit (brand-system, copywriting, etc.) follows in a later release — the spec's graceful fallback (`frontmatter_present: false`) keeps existing artifacts working until producers are migrated.

---

## [3.1.0] - 2026-05-06

Stack orchestrator added; declaration drift fixed.

### Added

- `start-marketing` — Stack orchestrator. Reads `research/`, `brand/`, `.agents/mkt/`, and `.agents/experience/*.md`, parses the user's free-form ask (or asks one bundled scoping question if empty), and proposes the next 1–3 skills in the marketing pipeline (`brand-system` → `campaign-plan` → content layer (`copywriting` / `lp-brief` / `seo` / `cold-outreach` / `short-form-brief`) → polish (`humanize` / `vn-tone`)) with rationale + cost + duration. Honors the brand-foundation gate — defers to `brand-system` (or upstream `icp-research`) when prerequisites are missing. Never auto-invokes — always prints the `/skill-name` for the user to type. Persists a breadcrumb to `.agents/experience/marketing-workflow.md`. Standard budget, ~$0.10–0.30 per run. Pipeline catalog lives in `references/workflow-graph.md`.

### Fixed

- `short-form-brief` was present on disk since v3.0.0 but missing from `.claude-plugin/plugin.json` `skills[]` — declaration restored. Skill now installs correctly via the Claude Code plugin marketplace path.

### Changed

- Plugin `keywords` extended with `short-form` to surface the video-brief capability in marketplace search.

---

## [1.0.0] - 2026-05-05

Initial public release. Brand identity, persuasive copy, campaign planning, landing-page architecture, design briefs, search visibility, humanization, localization polish, and outbound.

### Added

**Skills (10)**

- `brand-system` — Builds brand identity as three artifacts: `brand/BRAND.md` (story, voice, positioning, archetype), `brand/DESIGN.md` (AI-readable design system with palettes, tokens, components, motion), `brand/ASSETS.md` (per-platform production inventory with auto-scanned checkboxes). Carries the canonical 13-platform target catalog inside Pre-Dispatch. 8 agents; Quick Brand (Route A, BRAND.md only) or Full (Route B, all three artifacts).
- `copywriting` — Horizontal copy craft for any surface: landing pages, emails, social posts, headlines, CTAs, taglines, subject lines. Pre-writing framework drives every agent. Produces inline OR `.agents/mkt/content/[slug].copy.md`. 9 agents (hook, body, CTA, social-proof, variant, voice, psychology, zero-risk, critic).
- `campaign-plan` — Coordinates ICP research into integrated marketing communication: 3-5 messaging pillars, 3D angles per pillar, 9-channel evaluation with habitat-informed selection, timeline, ORB launch sequencing. Produces `.agents/mkt/campaign-plan.md`. 6 agents.
- `humanize` — Strips 37 AI writing patterns + injects voice + compresses 15-30%. 5-dimension critic. Produces `.agents/mkt/content/[slug].humanized.md`. 6 agents (Layer 1 parallel: pattern-scanner + voice-extractor; Layer 2 sequential: strip → soul-injection → compression → critic).
- `vn-tone` — Post-translation Vietnamese register polish across 4 registers (báo chí, semi-casual, bro, pop-marketing) backed by a live-scraped corpus reference. Detects 28 EN→VN translation artifacts. 3 agents (diagnostic → polisher → critic).
- `lp-optimization` — Landing-page conversion audit with 4 modes (full audit, AI/agent engine optimization, programmatic, ASO). Message-match verification against traffic source. Produces `.agents/mkt/lp-optimization.md`. 7 agents.
- `lp-brief` — Campaign-grade redesign brief: hypothesis, surface rhythm, section spec, asset slots, hand-off prompts. Internalizes lp-optimization conversion principles via cite-by-line reference (CP-01 → CP-13). **Hard-gated on `brand/BRAND.md` + `brand/DESIGN.md`**. 9 agents with 3 Approval Gates. Tier-1 only (primary + secondary conversion pages).
- `seo` — 4 modes: technical audit, AI/agent engine optimization, programmatic page generation, competitor comparison content, ASO. Mode-based routing dispatches different agents. Produces `.agents/mkt/seo-[mode].md`. 11 agents across modes.
- `cold-outreach` — Touch-based outbound (services-sell / saas-sell / partnership-sell / community-sell). Mode + Channel + Target + Trigger + Outcome + Bridge + Proof — most-elaborate Pre-Dispatch in the stack with Missing-Input Hard Blocks (mode/channel/target/proof cannot be substituted). Compose route + Reply route. 8 agents; terminal humanize with specificity regression check.
- `design-brief` — Per-asset graphic-design brief for downstream renderers (Claude Design / Pencil MCP / Figma / human designer). 4 downstream routes (image-gen / vector-tool / designer-handoff / template-pack) drive Layer 2 agent selection. **Hard-gated on `brand/BRAND.md` + `brand/DESIGN.md`**. 7 agents with 2 Approval Gates.

**Pipeline contract**

```
brand-system (visual identity foundation)
  ↓
campaign-plan (channel strategy + calendar)
  ↓
  ├─ lp-brief (per landing page) → design-brief (per asset slot)
  ├─ seo (per mode)
  └─ cold-outreach (per touch)

Audit existing pages: lp-optimization → (if redesign warranted) lp-brief

Horizontal: copywriting, humanize, vn-tone — invoked at any stage.
```

**Architectural patterns**

- **Pre-Dispatch protocol** — every skill follows the canonical spec at `meta-skills/references/pre-dispatch-protocol.md`. Cold Start / Warm Start flows; answers persist to `.agents/experience/{product,audience,brand,business,goals}.md`. Hard-gated skills (`design-brief`, `lp-brief`) gate before cold-start questioning.
- **Status protocol** — every skill emits `DONE / DONE_WITH_CONCERNS / BLOCKED / NEEDS_CONTEXT`; artifact frontmatter mirrors.
- **Multi-agent orchestration** — Layer 1 (parallel) → Layer 2 (sequential) → Critic gate (PASS/FAIL, max 2 rewrite cycles). `cold-outreach` adds a terminal humanize with specificity regression check.
- **Reusable agent template** — `copywriting/agents/_template.md` defines the standard structure for agent instruction files across the stack.

**Cross-stack**

- `research/product-context.md` (icp-research) read by brand-system, copywriting, campaign-plan, lp-brief, lp-optimization, design-brief, humanize, vn-tone, seo, cold-outreach.
- `research/icp-research.md` (icp-research) read by brand-system, copywriting, campaign-plan, lp-brief, lp-optimization, design-brief, seo, cold-outreach.
- `.agents/prioritize.md` + `.agents/targets.md` (research-skills) optionally read by campaign-plan, lp-brief for strategic alignment.
