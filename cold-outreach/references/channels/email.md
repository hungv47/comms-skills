# Channel: Email

Craft rules for cold email. Consumed by composer, voice-auditor, critic.

## Constraints

| Constraint | Rule |
|-----------|------|
| Subject length | 2-4 words, lowercase, no punctuation tricks |
| Body length | 4-6 sentences total (120 words max is a soft ceiling) |
| Paragraphs | 2-3 short paragraphs. Never one block. |
| Links | 0 or 1. Never 2+. Never unsubscribe-style footer. |
| Images | None. Plain text only. |
| HTML | None. Plain text only. |
| Signature | One line: `Thanks,\n[first name]`. Optional second line: one calendar link OR one URL, not both. |
| Emojis | None. |
| Fonts/colors | None. Default inbox font. |

## Subject Lines

**Goal:** Get opened. Not get sold. Not get click-baited.

**Target characteristics:**
- Short (2-4 words)
- Lowercase (mostly — proper nouns can stay capitalized)
- Internal-looking, as if from a colleague
- Reference a noun from the trigger when possible
- No emojis, no punctuation tricks, no ALL CAPS

**Patterns that work:**
- Topic noun: "reply rates" / "onboarding times" / "q3 forecast" / "attribution model"
- Internal question: "quick q" / "quick question" / "sanity check"
- Name + topic: "sarah — attribution" / "mike — onboarding" (use sparingly)
- Referral: "brian suggested I reach out" (if true)

**Patterns that kill:**
- Prospect's first name alone ("Sarah," "Mike,") — spam signal
- "Following up" / "Touching base" / "Just checking in" — vendor pattern
- Fake "Re:" or "Fwd:" — short-term lift, long-term trust destruction
- Emojis anywhere
- Exclamation marks ("Important!!")
- ALL CAPS words
- URLs in subject line
- Click-bait ("You won't believe...")
- Numbers without context ("10x your pipeline")

**Subject-body match.** The subject should not promise more than the body delivers. "Reply rates" → body must talk about reply rates. If they mismatch, unsubscribes rise.

## Body Structure

### Opening Sentence

Never:
- "I hope this email finds you well."
- "My name is X and I work at Y."
- "I came across your LinkedIn profile."
- "I wanted to reach out because..."

Always: specific observation OR direct question. The first sentence after the salutation carries the weight.

### Body Paragraphs

Paragraph 1 (1-2 sentences): observation + problem bridge.
Paragraph 2 (1-3 sentences): proof + logic.
Paragraph 3 (1 sentence): CTA.

Line breaks between paragraphs. Monochrome wall of text tanks read-through on mobile (where 60%+ of cold emails are opened first).

### Sentence Discipline

- Average sentence 10-18 words. Not all the same length.
- Contractions required. "I'm," "you're," "we've."
- Active voice. "We helped Ramp..." not "Ramp was helped by us..."
- No filler: "just," "really," "very," "basically," "actually," "honestly" — strip
- No hedges: "maybe," "perhaps," "I think" — use unless strategically necessary

### Sign-off

One line only. Casual peer register.

| Good | Bad |
|------|-----|
| `Thanks,` | `Best regards,` |
| `Cheers,` | `Sincerely,` |
| (empty line, name only) | `Looking forward to hearing from you,` |
| `— [name]` | `Kind regards,` |

No "P.S." unless it's carrying a specific, non-pitchy detail (a second proof point, a small helpful link, a compliment about something specific they posted).

## Mobile-First Formatting

60%+ of cold emails open on mobile first. Design for that:

- No indentation (displays broken on mobile)
- Short paragraphs (walls fail on small screens)
- Calendar links (if any) at the end, not mid-body
- Sign-off visible in preview pane

## Spam Hygiene

Avoid triggers:
- All-caps words
- Multiple exclamation marks
- Currency symbols in subject line ($, $$$$)
- URL shorteners (bit.ly, tinyurl) — use clean destination URLs
- Large images (none at all in cold)
- Attachments (zero for cold outreach)
- Trigger words in subject: "FREE," "URGENT," "GUARANTEE"

## Breakup Email (final touch)

When sending the breakup (touch 4 or 5):

```
[Name] — closing the loop on this thread.

If [specific trigger that would re-open] lands on your radar, happy to dig back in. Otherwise, I'll step out of your inbox.

Thanks,
[sender]
```

Rules:
- One paragraph, maybe two.
- Do not include any new proof, pitch, or resource.
- Offer ONE specific future re-trigger.
- Sign off warmly. No bitterness or passive aggression.

## What Good Email Looks Like (services-sell, signal=5)

```
Subject: attribution drift

Hi Sarah,

Your post about SDR attribution being a black box — the "we track activity not outcomes" line stuck. That gap usually means ~40% of closed-won is getting credited to the wrong channel, and ops stops trusting the dashboard.

Helped Ramp's ops team rebuild their model last quarter — they cut "unknown source" from 38% to 6% without a replatform.

Worth a look?

Thanks,
Mike
```

Why it works:
- Subject: 2 words, lowercase, noun-based, matches body.
- First sentence: specific quote from her post. Remove test fails.
- Second sentence: inferred problem tied to the observation.
- Third sentence: named proof + specific number.
- CTA: tier-1, one-line-reply.
- Sign-off: one word.
- Length: 4 sentences body. Mobile-friendly.
