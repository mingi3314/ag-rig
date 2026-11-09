---
name: submit-pr
description: Create a GitHub pull request with a Korean title and a description that makes the purpose and approach easy to review.
---

# Submit PR

Use `gh` to create the pull request.

- Follow the repository's existing commit-title convention. If no clear convention exists, refer to previous merged PRs.
- Write the PR title and body in Korean.
- Find and follow the repository's pull request template (`.github/PULL_REQUEST_TEMPLATE.md`) if one exists.

## PR Description

Help a reviewer outside the conversation quickly understand why the change is needed, how it addresses the problem, and why the approach fits the requirements.

Apply the plain-language principles of ISO 24495-1:2023: give reviewers the information they need, make it easy to find and understand, and help them use it to assess the change.

- Start with the concrete situation and its consequence, then connect the change to the resulting behavior. Supply the premises a reviewer needs before introducing internal names or mechanisms.
- Explain the decisive reasons for the approach. When a meaningful choice exists, include the relevant constraints, alternatives, and tradeoffs needed to judge it. Ground the rationale in the actual code and evidence; avoid unsupported claims that an approach is best or exhaustive comparisons that do not affect the decision.
- Use a small data example, execution flow, or code snippet when it makes the problem or change easier to grasp. A compact before/after example often establishes shared context quickly. Keep only the details needed to show the behavior, and reuse the same example through the explanation. Omit examples that add no understanding.
- Scale detail to the change. A simple change may need only a few sentences and validation. More complex changes may need additional context, but each detail should help assess purpose, behavior, or a consequential design choice. Fit this reasoning into the repository template without imposing a fixed explanation structure or length.
- Summarize checks actually performed and any material verification limits.

Before publishing, reread the description as a reviewer who has not seen the chat. Check that the purpose and direction are apparent on a quick read, the reasoning has enough context to assess, and repetition or implementation narration does not bury the main point. Preserve important assumptions and evidence when shortening the text.
