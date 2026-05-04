#!/bin/bash

# Headline Generator
# Generates headline variations using proven formulas

echo "=== Landing Page Headline Generator ==="
echo ""

read -p "Enter desired outcome (e.g., 'lose 20 pounds'): " OUTCOME
read -p "Enter common objection (e.g., 'giving up favorite foods'): " OBJECTION
read -p "Enter your solution (e.g., 'meal plan'): " SOLUTION
read -p "Enter timeframe (e.g., '30 days'): " TIMEFRAME
read -p "Enter specific number/stat (e.g., '47%', '10,000'): " NUMBER
read -p "Enter pain point (e.g., 'spending hours cooking'): " PAIN_POINT

echo ""
echo "=== Generated Headlines ==="
echo ""
echo "OUTCOME + OBJECTION REMOVAL:"
echo "  - How to $OUTCOME without $OBJECTION"
echo "  - $OUTCOME without $OBJECTION (here's how)"
echo "  - Finally $OUTCOME—and you don't have to $OBJECTION"
echo ""
echo "NUMBERED BENEFIT:"
echo "  - The $NUMBER $SOLUTION that $OUTCOME (even if $OBJECTION)"
echo "  - $NUMBER ways to $OUTCOME in $TIMEFRAME"
echo "  - The $TIMEFRAME system for $OUTCOME"
echo ""
echo "WARNING/CONSEQUENCE:"
echo "  - Warning: $PAIN_POINT could be costing you $OUTCOME"
echo "  - Stop $PAIN_POINT. Start $OUTCOME."
echo "  - $PAIN_POINT? Here's why (and the fix)"
echo ""
echo "FINALLY SOLUTION:"
echo "  - Finally, a $SOLUTION that $OUTCOME in $TIMEFRAME"
echo "  - The $SOLUTION that actually works for $OUTCOME"
echo "  - Done with $PAIN_POINT? Try this instead."
echo ""
echo "SIMPLE METHOD:"
echo "  - The easy way to $OUTCOME without $PAIN_POINT"
echo "  - The lazy person's guide to $OUTCOME"
echo "  - $OUTCOME in $TIMEFRAME (the simple way)"
echo ""
echo "CURIOSITY/INTRIGUE:"
echo "  - What $NUMBER people know about $OUTCOME that you don't"
echo "  - The $OUTCOME secret they don't want you to know"
echo "  - Why everything you know about $OUTCOME is wrong"
echo ""
echo "SOCIAL PROOF:"
echo "  - How $NUMBER people $OUTCOME in $TIMEFRAME"
echo "  - Join $NUMBER others who $OUTCOME"
echo "  - The $SOLUTION that $NUMBER people swear by"
echo ""
echo "=== 4-U Score Reminder ==="
echo "Check each headline for:"
echo "  [ ] Useful - Does it promise clear value?"
echo "  [ ] Unique - Does it stand out from competitors?"
echo "  [ ] Urgent - Is there a reason to act now?"
echo "  [ ] Ultra-specific - Does it include numbers/outcomes?"
echo ""
echo "Pick your top 3 and A/B test!"
