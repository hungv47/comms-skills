# Detector-Resistance Reference

> Humanize must survive classifier-style AI detectors, not just remove obvious LLM phrases. Pangram-style detectors are trained on semantic and structural signals; synonym swapping is not enough.

## What Changes

Traditional humanizers optimize surface texture:

- replace AI vocabulary,
- vary sentence length,
- remove obvious phrases,
- add contractions.

Classifier-style detectors can still catch that because the underlying document keeps the same uniform argument flow, overly balanced structure, generic specificity, and polished consistency.

Detector-resistant humanization changes the document at four levels:

1. **Structure:** rearrange the argument when the original flow is template-shaped.
2. **Semantics:** replace generic claims with context-specific evidence, caveats, and lived observations.
3. **Rhythm:** create real variation, including short fragments, longer qualified sentences, and occasional imperfect transitions.
4. **Register:** allow controlled human inconsistency where it matches the author, channel, and stakes.

## Pangram-Aware Gate

If a real detector integration is available, the orchestrator may run it after critic PASS.

Expected environment:

- `PANGRAM_API_KEY` or equivalent detector credential.
- A detector CLI/script configured by the operator.
- A threshold defined by the operator or the content policy.

If no credential or detector script exists, do not fabricate a score. Run the proxy checklist below and mark detector status as `proxy_pass` or `proxy_fail`. Use `not_run` only when detector mode is disabled.

## Proxy Checklist

Use this when an external detector cannot run.

| Signal | Pass | Fail |
|---|---|---|
| **Argument shape** | The flow has a human reason for its order; not every section follows claim -> explanation -> example -> transition. | The piece keeps a symmetrical template after editing. |
| **Specificity source** | Specifics come from the original, brand context, cited examples, or clearly marked placeholders. | Specifics feel bolted on or invented. |
| **Register variance** | Formality shifts naturally by section and channel. | Every paragraph is uniformly polished. |
| **Semantic compression** | Filler is removed while ideas become sharper. | The same generic idea survives in fewer words. |
| **Human imperfection** | Minor asymmetry, directness, or bluntness appears where a real editor would leave it. | The output is immaculate, balanced, and generic. |

## Regression Fixture Pattern

For recurring content types, keep a small local fixture set:

- original AI-ish input,
- expected protected tokens,
- expected minimum compression range,
- expected detector/proxy result,
- final approved output.

The goal is not to game a detector. The goal is to prevent regressions where humanize drifts back into synonym-swapping, over-polishing, or deleting specificity.

## Multi-Pass Escalation

Use only when the critic or detector proxy still sees AI residue:

1. **Generate:** start from original text and preserve all facts.
2. **Strip:** remove known AI patterns.
3. **Restructure:** reorder template-shaped argument flow.
4. **Revoice:** add author/channel-specific rhythm and experience markers.
5. **Compress:** cut filler after structure and voice are stable.
6. **Verify:** critic, protected-token regression, and detector/proxy gate.

Do not loop indefinitely. After two failed verification cycles, return `DONE_WITH_CONCERNS` with the detector/proxy findings.
