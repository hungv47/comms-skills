#!/bin/bash

# Landing Page Audit Checklist Generator
# Generates a markdown checklist for auditing landing pages

OUTPUT_FILE="${1:-lp-audit-$(date +%Y%m%d).md}"

cat > "$OUTPUT_FILE" << 'EOF'
# Landing Page Audit

**Date:** $(date +%Y-%m-%d)
**URL:** [Enter URL here]
**Auditor:** [Your name]

---

## 3-Second Test

- [ ] Value proposition clear within 3 seconds
- [ ] Primary CTA visible without scrolling
- [ ] Trust signal visible above fold
- [ ] Visual hierarchy guides the eye

**Notes:**


---

## Headline Analysis (4-U Formula)

- [ ] **Useful**: Communicates clear value/benefit
- [ ] **Unique**: Differentiates from competitors
- [ ] **Urgent**: Creates reason to act now
- [ ] **Ultra-specific**: Includes numbers/outcomes

**Current Headline:**


**Suggested Improvements:**


---

## Copy & Messaging

- [ ] Uses customer language (not corporate speak)
- [ ] Benefits before features
- [ ] PAS structure (Problem → Agitate → Solve)
- [ ] Grade 6 reading level (11-word sentences)
- [ ] Active voice throughout
- [ ] First-person CTAs ("Get MY...")

**Copy Issues Found:**


---

## Social Proof Audit

- [ ] Testimonials have specific results
- [ ] Real names and photos used
- [ ] Placed near decision points
- [ ] Recent/dated testimonials
- [ ] Case studies with before/after

**Social Proof Score (1-10):**

**Improvements Needed:**


---

## Trust Signals

- [ ] Security badges visible
- [ ] Money-back guarantee stated
- [ ] Privacy policy linked
- [ ] Contact info visible
- [ ] Clustered near CTA/forms

**Missing Trust Signals:**


---

## Form Analysis

- [ ] 5 fields or fewer
- [ ] Essential fields only
- [ ] Clear labels
- [ ] Error handling visible
- [ ] Progress indicator (if multi-step)

**Current Field Count:**

**Fields to Remove:**


---

## CTA Analysis

- [ ] First-person language ("Get My...")
- [ ] Action-oriented verb
- [ ] Visible without scrolling
- [ ] Contrasting color
- [ ] Adequate white space around it
- [ ] Multiple CTAs for long pages

**Current CTA Text:**

**Suggested CTA:**


---

## Message Match

- [ ] Headline matches ad/email copy
- [ ] Visual consistency with source
- [ ] Offer matches what was promised
- [ ] Consistent tone throughout

**Traffic Source:**

**Message Match Issues:**


---

## Mobile Experience

- [ ] Loads under 3 seconds
- [ ] CTA in thumb zone
- [ ] Touch targets 44x44px minimum
- [ ] Text readable without zooming
- [ ] Forms mobile-optimized

**Mobile Issues:**


---

## Technical Performance

- [ ] Page loads under 3 seconds
- [ ] Analytics tracking verified
- [ ] Conversion tracking working
- [ ] All links functional
- [ ] No console errors

**Performance Score (PageSpeed):**


---

## Urgency & Scarcity

- [ ] Uses authentic urgency only
- [ ] No fake countdown timers
- [ ] Deadline/limit explained
- [ ] FOMO without manipulation

**Current Urgency Tactics:**

**Authentic Alternatives:**


---

## Priority Fixes

### Critical (Fix Immediately)
1.
2.
3.

### High Priority (This Week)
1.
2.
3.

### Medium Priority (This Month)
1.
2.
3.

---

## A/B Test Recommendations

### Test 1: Headlines
**Control:**
**Variant:**
**Hypothesis:**

### Test 2: CTA
**Control:**
**Variant:**
**Hypothesis:**

### Test 3: Social Proof
**Control:**
**Variant:**
**Hypothesis:**

---

## Overall Score

| Category | Score (1-10) |
|----------|--------------|
| Headline | |
| Copy | |
| Social Proof | |
| Trust | |
| UX/Design | |
| Mobile | |
| Performance | |
| **TOTAL** | **/70** |

---

## Summary

**Biggest Opportunity:**


**Estimated Impact of Fixes:**


**Recommended Next Steps:**
1.
2.
3.
EOF

echo "Audit checklist created: $OUTPUT_FILE"
