# Tool Routing Decision Tree

How design-create picks between Route P (generative AI prompt), PE (Pencil direct), PA (Paper direct), and F (Figma handoff). Used in Step 0 by the orchestrator.

---

## Decision tree

```
1. Is the asset a brand-guideline artboard or extension of existing brand-system Paper output?
   YES → Route PA
   NO → continue

2. Is the asset print or OOH (≥300dpi, CMYK, billboard, business card, A4 flyer)?
   YES → Route F (human designer in Figma)
   NO → continue

3. Is the asset typographic / vector / multi-format / template-based?
   - Text-led carousel (typography is the lead element)
   - Vector logo or mark variant
   - Branded social template with tight typographic spec
   - Multi-size variant pack (1080x1080 + 1080x1920 + 1200x630 same campaign)
   - Spot icon or decorative vector
   YES → Route PE (Pencil)
   NO → continue

4. Is the asset photo / illustration / abstract / video / audio?
   - Photographic hero / OG image
   - Hero illustration (custom)
   - Ad creative with photographic background
   - Video (use Veo)
   - Audio (use Suno for video soundtrack)
   YES → Route P (generative AI prompt)

5. Hybrid (e.g., generative photo + post-processed text overlay)?
   - Generate photo via Route P
   - Overlay text via Route PE (Pencil)
   - Combine in deliverable
```

---

## Asset-type → default route table

| Asset type | Default | Alt | Notes |
|-----------|---------|-----|-------|
| OG image (blog hero / social share) | P | F (if hand-craft) | Generative + text overlay typical |
| Instagram feed post (typographic) | PE | — | Pencil for tight type |
| Instagram feed post (image-led) | P | PE+overlay | Generate image, overlay any type |
| Instagram carousel (typographic) | PE | — | Multi-slide, type-led |
| Instagram carousel (image-led) | P (per slide) + PE (assembly) | F | Generate slide images, assemble |
| Instagram Story | P or PE | depends on content | |
| Instagram Reel cover | P | — | Photo-based |
| LinkedIn single image | P or PE | — | Depends on content |
| LinkedIn carousel (PDF) | PE | F | Vector type-led typical |
| X / Twitter image | P or PE | — | |
| TikTok cover | P | PE | Photo-led typical |
| YouTube thumbnail | P + PE overlay | — | Generate background, overlay bold type |
| Email hero | P or PE | — | Watch file size |
| Display ad (banner) — text-heavy | PE | F | |
| Display ad (banner) — visual-led | P + PE overlay | F | |
| Hero illustration (custom) | P | F (if hand-illustrated) | |
| Logo variant | PE | PA | Pencil for free vector; Paper if extending brand-system artboards |
| Brand artboard | PA | — | Paper conventions |
| Print collateral (business card, flyer) | F | — | Print-grade requires designer |
| OOH / billboard | F | — | Print-grade + production |
| App store screenshot | PE | F | Tight type + screenshot composite |
| Spot icon / decoration | PE | — | Vector |
| Animated banner / loop | P (Veo) | F | Video gen |
| Brand audio (video soundtrack) | P (Suno) | — | |

---

## Route override conditions

User can force a route:
- `--route=P` / `--route=PE` / `--route=PA` / `--route=F`

Honor the override but warn if the asset-type default differs (e.g., user requests Route P for a logo variant — flag that vector mark is better in Pencil).

---

## When the default is wrong

Sometimes the default is a poor fit. Watch for:

### Photographic concept on Route PE

Pencil is vector. If the brief calls for photographic mood, re-route to P (generative) and overlay any vector elements in Pencil after.

### Vector-precise concept on Route P

Generative AI cannot hit exact pixel placement of vector elements. If the brief specifies "logo at exact 60×60px in the bottom-right with 60px margin," that's a Pencil overlay step, not a generative prompt.

### Print spec on Route P or PE

300dpi CMYK is the bar. Generative tools output 72dpi sRGB. Pencil exports at vector but color-profile management is fragile for print. Route F (Figma + designer) is the right tool.

### Brand-system artboard on Route PE

Paper has the conventions for brand artboards (flex-only, inline-only, hex-only). If extending the existing artboard family, use Route PA. Pencil's flexibility is wrong for this strict pattern.

---

## Hybrid workflows

Most assets are hybrid. Common patterns:

### Pattern 1: Generative background + Pencil overlay

1. Route P: prompt-craft-agent produces Midjourney/Imagen prompt for the background image.
2. User generates externally, downloads PNG.
3. Route PE: pencil-render-agent imports the PNG into Pencil, overlays type and logo per brief.
4. Export final.

### Pattern 2: Multi-format assembly

1. Concept → 1 brief, multiple format variants (e.g., 1200x630 + 1080x1920 + 1080x1080).
2. For photo-led: Route P generates one master photo; Pencil resizes/repositions per format.
3. For type-led: Route PE renders all formats in one Pencil document (each frame = one format).

### Pattern 3: Print ad with generative imagery

1. Route P: generate the photographic component (at high resolution if possible — Veo, Imagen 3 give larger sizes).
2. Route F: handoff to designer with the generated image as input + Figma spec.
3. Designer composes final at 300dpi CMYK in Figma.

---

## Route implications for cost

| Route | Estimated cost | Time |
|-------|---------------|------|
| P (Midjourney) | $0.10–0.50 per generation × 3-6 attempts | 5–15 min user time |
| P (Imagen 3) | $0.04 per image × 3-6 | 5–15 min |
| P (DALL·E 3) | $0.040–$0.080 per image × 3-6 | 5–15 min |
| P (Claude Design) | Bundled in Claude subscription | 10–30 min iterative |
| P (Veo) | Higher per generation | Variable |
| PE (Pencil) | Compute time only | 5–20 min |
| PA (Paper) | Compute time only | 5–20 min |
| F (Figma + designer) | Designer rate × 1–4 hrs | Hours to days |

When cost matters and concept fits multiple routes, prefer in this order: PE > PA > P (Imagen) > P (other) > F.

---

## Out of Scope (v1)

These asset classes are NOT supported by design-create v1. Return **NEEDS_CONTEXT** with the right destination — do not silently dispatch a generic prompt.

| Asset class | Why out of scope | Where to go instead |
|---|---|---|
| Code-driven generative art (p5.js, three.js, canvas, WebGL hero) | Skill is brief→render. Code generation belongs in product-skills. | `impeccable:overdrive` (animated frontend) for now; future v1.x route |
| Lottie / After Effects animation | Source-of-truth is `.aep` / `.json` from a designer. design-create can produce an asset *brief* but not the AE source. | Route F (Figma + designer + Lottie export pipeline) |
| 3D model / glTF / blender source | Asset pipeline is modeler-driven. | External 3D pipeline; brief can spec the model but not produce one |
| Standalone audio (podcast cover audio, music bed without video) | Suno is listed as Route P sub-tool but only for video accompaniment in v1. | Document as v1.1 Route P expansion. For now, NEEDS_CONTEXT. |
| Full motion-design package (multi-scene video edit) | One Veo prompt = one shot. Multi-shot edits need a video editor. | Brief + per-shot Route P, then external NLE assembly |

If a user request matches one of these, return:

> NEEDS_CONTEXT: design-create v1 doesn't cover [class]. Recommended path: [pointer]. To proceed within scope, narrow the request to [single shot / single asset / single layer].
