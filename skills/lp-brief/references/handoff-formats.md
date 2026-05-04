# Hand-Off Formats — Per-Tool Prompt Patterns

> Catalog of hand-off prompt patterns for the 4 supported targets. Each pattern names: structure, length, what to lift verbatim, what to compress, common failure modes.
>
> **Use:** when handoff-agent runs, look up the target's pattern here. Compose the prompt block to match.

---

## Claude Design (`claude-design`)

**Tool:** Anthropic's design assistant at claude.ai/design (or Claude with computer-use for design tools)

**Format:** Natural-language prompt, ~120–180 lines

**Structure:**

```
[1. Page identity + hypothesis — 3–5 lines]

[2. Brand block — palette tokens, type tokens, surface, motion tokens. Verbatim from brand_digest.]

[3. Architecture summary — section list with one-line purpose each. Reference brief.md for full ASCII.]

[4. Per-section blocks — for each section:
   - Section name + purpose
   - Recommended copy (headline / subhead / CTA) — verbatim
   - Asset reference with file path
   - Layout notes (column structure, type tokens used)
   - Trust signal positioning
]

[5. DO NOT block — sacred elements + voice forbidden vocabulary. Verbatim.]

[6. Output expectation — single layout, multiple variants, code, etc.]
```

**Lift verbatim:**
- Sacred elements
- Voice forbidden vocabulary + preferred phrases
- All recommended copy slots
- Asset file paths

**Compress:**
- Hypothesis (claim + 1-line bet, not full 3Q)
- Architecture (ref brief.md for full ASCII; summary list inline)
- Audit findings (1–2 lines on what's being closed)

**Common failures:**
- Prompt too long (>250 lines) → Claude Design loses focus
- Sacred elements paraphrased → drift in output
- Copy presented as "ideas" instead of "use this verbatim" → Claude Design rewrites

**Example skeleton:**

\`\`\`
Build a landing page for /pricing targeting engineering managers at 10–50 person teams.

Hypothesis: Right-size proof leads — segmenting proof by team size lifts conversion ≥15% on small-team traffic.

BRAND
- Palette: #004700 primary, #B7FF6E accent, #F5F4EE warm-neutral background
- Type: Geist Sans display (--font-geist-sans), Inter body (--font-inter)
- Surface: matte (no glass, no frost, no transparent overlays)
- Motion: ease-out, duration-md (240ms) for fade-up; static for decision moments

ARCHITECTURE (5 sections)
1. Hero — first-impression gate
2. Segmented social proof — three columns by team size
3. Features — 4 rows, benefit-led
4. Objection — "is this overkill for small teams?" addressed directly
5. CTA block — primary action moment

SECTION 1 — HERO
Headline (verbatim): "See the price your team actually pays — in 8 seconds"
Subhead (verbatim): "Quotes by team size. No 'contact sales' detours."
Primary CTA (verbatim): "Get my team's price"
Asset: growth/pricing/hero.webp — calibrated still-life of pricing receipt
Layout: Headline 64px Geist Sans, subhead 20px Inter, CTA primary button (#004700 bg)
Trust signal in viewport: 6-logo customer grid below CTA

[... per section ...]

DO NOT
- Use glass, frost, or transparent overlay surfaces (anti-glass sacred)
- Modify or paraphrase the tagline
- Use these words anywhere: leverage, unlock, seamlessly, robust, cutting-edge
- Use "Submit" / "Click Here" / "Learn More" CTAs (use first-person action verbs)
- Include a 3rd primary CTA (one primary; one secondary; zero tertiary)

OUTPUT
Single desktop + mobile layout per section. Use the design system tokens above.
\`\`\`

---

## Pencil MCP (`pencil`)

**Tool:** Pencil MCP (`mcp__pencil__*` tools — works on .pen files, encrypted)

**Format:** High-level brief, ~60–100 lines. Pencil generates the `batch_design` operations itself.

**Structure:**

```
[1. Document goal — what kind of .pen file (LP / single section / asset)]

[2. Section list with layout intent per section]

[3. Tokens — palette + type, named or hex]

[4. Copy blocks — verbatim per slot]

[5. Asset references — file paths]

[6. Sacred / forbidden — compact bullet list]
```

**Lift verbatim:**
- Sacred elements (compact list)
- Copy per slot
- Asset paths

**Compress:**
- Architecture rationale (Pencil doesn't need the why)
- Per-CP citation rationale
- 4-U scoring detail

**Common failures:**
- Including operation syntax (`I("parent", {...})`) — let Pencil generate, not the brief
- Over-specifying layout — Pencil's strength is layout decisions
- Missing tokens — Pencil falls back to defaults

---

## Figma (`figma`)

**Tool:** Figma file build, often consumed by a designer post-spec

**Format:** Structured spec, ~200–400 lines (designer reads frame-by-frame)

**Structure:**

```
[1. Project — page slug, file naming convention]

[2. Page setup — frame sizes (desktop 1440, tablet 1024, mobile 390), grid system]

[3. Tokens — palette tokens with hex + variable name, type tokens with size/weight/line-height/letter-spacing]

[4. Component library references — button variants, card variants, input variants. Reference Auto Layout settings.]

[5. Per-frame blocks (one per section):
   - Frame name + purpose
   - Layout grid (cols, gutter, padding)
   - Typography tokens used
   - Color tokens used
   - Component instances + variants
   - Copy verbatim
   - Asset placement (file path or instance reference)
]

[6. Variants — desktop / tablet / mobile differences per frame]

[7. Sacred + voice — non-negotiable callout]
```

**Lift verbatim:**
- All copy slots
- Sacred elements
- Voice forbidden vocab
- Token names + values

**Compress:**
- Hypothesis (1-line in cover frame)
- Audit context (1 paragraph max)
- 4-U / PAS / CP rationales (designer doesn't need them; they're in brief.md if asked)

**Common failures:**
- Inventing token names not in DESIGN.md → designer creates ad-hoc tokens
- Skipping mobile variants → designer guesses
- Component variants not specified → designer picks defaults that may violate sacred

---

## Human Designer (`designer`)

**Tool:** A human designer working in their preferred tool (Figma, Sketch, Adobe XD, code-first)

**Format:** Narrative + structured spec, ~150–300 lines

**Structure:**

```
[1. The why — hypothesis, audience, what we're betting (~5 lines, narrative)]

[2. The audit context (Route B only) — what's broken, what we're fixing (~3 lines)]

[3. Brand non-negotiables — sacred elements, voice rules, surface language (verbatim)]

[4. Architecture — section list with purpose; ASCII diagram or link to brief.md]

[5. Per-section spec — copy verbatim, layout intent, asset references, type/color tokens]

[6. Reference inspiration (optional) — links to brand/inspiration/ or content-research]

[7. Pre-flight checklist for the designer — sacred respected, voice clean, copy verbatim, asset paths used]
```

**Lift verbatim:**
- Sacred elements
- Voice rules
- Copy slots
- Asset paths

**Compress:**
- 3Q rubric detail (designer cares about the bet, not the framework)
- CP rationale (cite IDs only — they can read brief.md if curious)

**Common failures:**
- Burying sacred elements at end → designer misses them
- Hypothesis without why → designer optimizes wrong dimension
- No reference imagery → designer's taste fills the gap (may not match brand)

---

## Choosing the Format

If `target_handoff` is a single value, use that pattern. If it's a list, write one block per target.

**Default selection logic** (when user doesn't specify):
- Project uses Claude / Anthropic tools heavily → `claude-design` first
- Project uses Pencil for design → `pencil`
- Designer is a human in Figma → `figma` + `designer` (both — Figma for spec, designer for narrative)
- Solo founder, no designer, code-first → `claude-design` only

**Multiple targets** is normal. Brief at `.agents/mkt/lp-brief/[slug]/` may include:
- `brief.md` — main artifact
- `handoff-claude-design.md` — Claude Design block
- `handoff-figma.md` — Figma spec
- `handoff-designer.md` — narrative for designer
- `asset-slots/*.md` — per-asset generative prompts

## Cross-Format Rules

- **Sacred elements always verbatim, always near the end.** Reader should hit them last; they're the constraints they take into execution.
- **Voice forbidden vocab always verbatim.** No "avoid corporate-sounding language" — give the actual list.
- **Copy slots always presented as "use this verbatim" not "consider this".** The candidates were rubric-scored upstream; the recommended is the recommended.
- **Asset references always include file paths.** "Hero image" tells nothing; `growth/pricing/hero.webp` is actionable.
- **Quality gates always concrete.** "Looks good" is not a gate. "Headline matches brief verbatim" is.

## Anti-Patterns

- **One block for all targets** — fails all of them. Pick one per block.
- **Pasting brief.md verbatim** — defeats compression. Format-specific compression is the value-add.
- **Inventing format conventions** — if the target tool has docs, follow them. Reference: target's official docs > this catalog > intuition.
- **Skipping sacred / voice for brevity** — these are the most important parts. If you cut anything, cut the rationale, not the rules.
