# Anti-Patterns: AI Tells, Template Smell, Reply Killers

Consumed by voice-auditor and critic. The banlist.

## AI Telltale Phrases (auto-strip or auto-fail)

These phrases mark a message as AI-generated or template-filled within 3 seconds of reading. Delete them on sight.

### Opening phrases (always banned in touch 1)

- "I hope this email finds you well."
- "I hope you're doing well."
- "I hope all is well."
- "I trust this email finds you in good health."
- "I came across your [LinkedIn profile / company / website]."
- "I wanted to reach out because..."
- "My name is [X] and I work at [Y]."
- "I am writing to introduce..."
- "I am reaching out regarding..."
- "I wanted to take a moment to..."
- "I'd like to introduce myself..."

**Why banned:** Zero-value openers. The FIRST sentence is where you lose or earn attention. These tell the reader "template" immediately.

### Vendor-speak vocabulary

| Word/phrase | Replacement or action |
|-------------|----------------------|
| "leverage" | "use" |
| "synergy" / "synergies" | delete the sentence |
| "best-in-class" | delete or specific adjective |
| "world-class" | delete |
| "cutting-edge" | delete |
| "innovative" | delete or specific descriptor |
| "state-of-the-art" | delete |
| "solution" (meaning product) | "tool" or specific noun |
| "robust" | delete or specific adjective |
| "seamless" / "seamlessly" | delete |
| "empower" | specific verb |
| "circle back" | "follow up" |
| "touch base" | "check in" or cut |
| "deep dive" | "look at" / "dig into" |
| "value-add" | specific benefit |
| "low-hanging fruit" | specific thing |
| "move the needle" | specific metric |
| "at scale" | cut unless quantified |
| "mission-critical" | delete |
| "game-changer" / "game-changing" | delete |
| "bandwidth" (meaning availability) | "time" or "room" |
| "take this offline" | "handle via DM" or delete |
| "ping" (as verb for contact) | acceptable — conversational |
| "quick win" | specific outcome |
| "double down" | cut or specific action |
| "power-packed" | delete |
| "turnkey" | "ready-to-go" or delete |
| "industry-leading" | delete |
| "results-driven" | delete |
| "thought leader" / "thought leadership" | delete |

### Hedges (strip aggressively)

- "just" — 95% of uses are filler. "I just wanted to..." → "I wanted to..."
- "really" — delete
- "very" — delete
- "somewhat" / "kind of" / "sort of" — delete
- "basically" — delete
- "actually" — delete (unless contrasting)
- "quickly" (in "quickly check in") — delete
- "simply" — delete
- "literally" — delete
- "honestly" — delete
- "frankly" — delete

### Closing phrases (banned)

- "Looking forward to hearing from you."
- "I look forward to connecting."
- "Please let me know if you have any questions."
- "Feel free to reach out if..."
- "Don't hesitate to..."
- "I'd love to hear your thoughts."
- "Best regards,"
- "Sincerely,"
- "Kind regards,"
- "Warm regards,"

**Replacement sign-offs:** "Thanks," / "Cheers," / "— [name]" / empty line + name only.

### Meta-phrases (banned)

- "I'll keep this short."
- "I know you're busy, so..."
- "Just checking in." (as a whole email, or as an opener)
- "Bumping this up in your inbox."
- "Following up on my previous email."
- "In case you missed my last one..."

## Template Smell (patterns that signal "this was sent to 500 people")

- **{{FirstName}} pattern in context**: "Hi Sarah, I know Sarah's work at [company] is impressive." Artifact of template-merge.
- **Industry-generic openers**: "Companies like yours" / "Leaders in [industry]" / "Professionals in [field]"
- **Compliment stacking**: "Impressive growth! Amazing team! Great product!"
- **Claim-dump paragraphs**: 3-4 claims in a row, no specifics
- **Logo-dump in body**: "We've worked with [logo], [logo], [logo], [logo]..."
- **Statistic without source**: "93% of companies report..." — unverifiable
- **"Custom-built for you" phrases when it wasn't**: "I crafted this just for you, [Name]."

## AI-Generated Personalization Tells (framework)

Specific patterns that mark personalization as AI-written or scraper-driven. Pulled from practitioner's 2026 cold-email course teardowns. Cross-references `frameworks/saraev-four-step.md` §Step 1.

### Pattern 1: Compound-praise specificity ("BeaverCorp tell")

**Verbatim AI-generated example from Pattern basis: internal research synthesis.

> "Hey Stacy, love how passionate you are about process optimization and aligning corporations with diversity outcomes at BeaverCorp."

**Why it tells:** No human writes "love how passionate you are about [thing A] and [thing B] at [company]." Reads as: AI scraped a LinkedIn bio, generated a flattering paragraph, and stitched it together. The "and" + 2-noun-cluster + "at [company]" is the AI's signature comma-separated rhythm.

**Detection signals:**
- Praise + compound noun + "at [company]" structure
- 2+ abstract nouns in the first sentence ("process optimization," "diversity outcomes," "operational excellence")
- "Love how passionate you are about…" / "Truly impressed by your work on…" / "Inspired by your dedication to…"

**Fix:** Rewrite to one short observation OR use a framework-style cold-read ("love your channel man — very no-BS, helped me get started in [generic field]").

### Pattern 2: Variable mishaps (scraper-pulled wrong field)

**Pattern examples from Pattern basis: internal research synthesis.

- "Hi Nick Daily Updates" — scraper pulled YouTube channel name as first-name field
- "Hi [Nick automates], congrats on 35K subs" — same failure mode (source-original bracket annotation + lowercase preserved; reflects how the raw YouTube handle would land in the salutation pre-cleanup)

**Inferred from source's casualization rule** (not in source verbatim — extrapolated from framework's "casualize company name: Leftclick Inc. → Leftclick; Pacific Creative Group LLC → PCG"):

- A scraper using an unfiltered company-name column produces salutations like "Hi Pacific Creative Group LLC team" instead of the casualized "Hi PCG team."

**Why it tells:** Real people don't address messages to channel names or LLC entities. Pattern-matches as: bulk-scraped, no human pre-send review.

**Fix:** When pulling first-name field from a YouTube/X/LinkedIn handle, **take only the first word.** "Nick Daily Updates" → "Nick." Apply framework's casualization rule to company-name fields before injection into salutations.

### Pattern 3: Bolded / quoted / bracketed variables ("template leak")

**Pattern examples from Pattern basis: internal research synthesis.

- "Hi **{{FirstName}}**" — template merge engine didn't run
- "Hi [Sarah]" — bracket leak from the personalization template
- "Hi \"Mike\"" — quotes around a variable that shouldn't be quoted

**Why it tells:** Real people never type their salutation in bold, brackets, or quotes. These artifacts mean the template engine misfired or the operator copy-pasted from a draft tool.

**Fix:** Pre-send QA: read the first sentence with eyes (not just spell-check). Any formatting around the first name = re-run the merge.

### Pattern 4: False-specificity dressed as specificity

**Pattern:** the message contains a "specific" detail that isn't actually verifiable or unique to the prospect.

**Examples:**
- "Saw you're doing great work in the SaaS space" — "SaaS space" is generic; "great work" is praise without referent
- "Loved your recent insights" — what insights? when?
- "Your team's commitment to excellence is impressive" — every team has commitment to excellence

**Why it tells:** Specificity-flavored language with no concrete noun. The reader's brain auto-completes "generic praise"; the personalization fails the remove-the-opener test (the rest of the email reads identically without it).

**Fix:** Replace with either (a) a real signal — a quoted line, a named launch, a specific number from their funding round — or (b) a cold-read that doesn't pretend to be specific ("love your channel, no BS, helped me get started in [generic field]"). The cold-read is honest about being a cold-read; false-specificity isn't.

### Pattern 5: AI-coined hooks ("instant tell")

**Verbatim AI-generated example from Pattern basis: internal research synthesis.

> "What if I told you there's a way to 10x your pipeline without changing your stack?"

**Why it tells:** "What if I told you…" / "Imagine if your team could…" / "Ever wondered…" — rhetorical-question hooks are AI's favorite open. Auto-fail per `critic.md` §Peer Voice structural auto-fail #9.

**Fix:** Lead with the observation directly, not the rhetorical wrapper around it.

---

## Reply Killers (specific sentence patterns that tank reply rates)

| Pattern | Why it kills | Fix |
|---------|--------------|-----|
| 2 CTAs in one email | Reader has to evaluate both; picks neither | Pick one |
| 3+ links | Dilutes action; reads as spam | 0 or 1 link |
| Paragraph walls | internal | Break into 2-3 short paragraphs |
| First sentence starts with "I" or "We" | Sender-first framing | Rewrite reader-first |
| 8+ sentence body | Too long for cold | Cut to 4-6 |
| No sign-off or overly formal sign-off | Register mismatch | "Thanks,\n[name]" |
| Calendar link in touch 1 | High-friction; vendor signal | Save for tier-4 CTA |
| Fake Re: or Fwd: in subject | Short-term lift, long-term trust destruction | Real subject line |
| Prospect's first name alone in subject | Spam pattern | Use topic noun |
| 3+ exclamation marks | AI/template signal | Cut |
| ALL CAPS words in body | AI/template signal | Normal case |
| Emojis in cold outreach body | Usually off-register | Almost never use |

## Structural Anti-Patterns

- **Hook, pivot, hook, pivot** — changing direction mid-email confuses the reader. Pick one thread.
- **Buried CTA** — CTA in paragraph 2, then another paragraph, then sign-off. Move CTA to the last content sentence.
- **Multiple asks with "or"** — "Would you like A, or B, or C?" — decision fatigue.
- **Email-then-DM-then-InMail same day** — looks automated. Space channels 2-3 days minimum.
- **Thread-hijacking** — replying to an old thread about something unrelated. Different topic = different email.

## When to Bend the Rules

These rules are defaults, not laws. Bend them when:

- **"Just" is the right word semantically**, not a hedge — "Just to confirm, the migration is this Thursday?" (confirmation, not softening)
- **A banned phrase is quoted from the prospect** — if they said "I hope you're doing well" in their reply, echoing it is fine
- **Emojis are native to the user's voice AND the channel allows them** — community-sell on Twitter often uses one emoji naturally
- **A "longer" email is the right length** — if you're responding to a detailed question, 8 sentences can be correct

**But:** if you're bending a rule, write down why in the change log. If you can't articulate a reason, the rule should hold.
