---
name: evaluate-review-feedback
description: Critically evaluate existing PR or code-review feedback before acting on it. Verify the claimed mechanism, production reachability, contract impact, operational risk, and change-induced complexity; recommend accepting, simplifying, documenting, deferring, escalating upstream, or rejecting the feedback. Use when deciding whether review comments are valid, correctly prioritized, or worth implementing, including requests for an adversarial or production-minded second opinion.
---

# Evaluate Review Feedback

Evaluate the review claim and its proposed remedy with equal skepticism. Optimize for production value, not theoretical completeness.

## Workflow

1. Pin the exact code revision and supported versions. Distinguish explicit public contracts, test-backed behavior, and reviewer expectations; do not treat them as equivalent.
2. Split each comment into its claimed mechanism, prerequisites, impact, and requested remedy.
3. Verify mechanism and production reachability separately. Prefer exact-version upstream source and a real dependency reproduction when they matter; treat mocks as control-flow evidence only.
4. Assess the unmodified risk from reachability, incident-conditioned likelihood, impact, blast radius, detectability, and recovery difficulty. State assumptions instead of inventing probabilities.
5. Compare remedies, including no change, a smaller fix, contract clarification, and an upstream solution. Judge net value as risk reduced minus regression risk and maintenance cost; do not privilege the reviewer's proposed remedy. Account for new states, concurrency or cancellation paths, compatibility, and tests.
6. Separate factual validity, priority, and recommended action. Explain the decisive evidence and remaining uncertainty.

Use these outcomes when useful:

- `ACCEPT`: implement substantially as requested.
- `ACCEPT_SIMPLIFIED`: address the issue with a smaller change.
- `CONTRACT_ONLY`: clarify or weaken the contract rather than add code.
- `DEFER_NEEDS_EVIDENCE`: require stronger reachability or operational evidence.
- `UPSTREAM`: avoid local complexity until the dependency provides the needed primitive.
- `REJECT`: the claim or its prerequisites do not hold.

Do not dismiss rare but catastrophic or silent failures merely for low frequency. Do not promote a theoretical possibility without a reachable production path. Prefer the least complex remedy that materially reduces expected loss.

Default to analysis only. Do not modify code, post or resolve GitHub comments, or submit a review unless the user explicitly requests that action. Use the relevant GitHub skill for PR metadata, thread state, and writes.
