---
name: context-free-engineering-writing
description: Draft or revise PR descriptions, ADRs, design documents, implementation plans, review responses, and other engineering artifacts for readers who did not participate in the preceding conversation. Do not use for casual conversation, ordinary code comments, or documents explicitly intended to rely on linked prior context.
---

# Context-Free Engineering Writing

Create engineering writing that its intended readers can understand without access to the private conversation that produced it.

Apply the plain-language principles of ISO 24495-1:2023: provide the information intended readers need, organize it for easy retrieval, and make it understandable and usable for their purpose.

“Context-free” means independent of preceding conversation context. It does not mean explaining every repository convention, avoiding technical language, or writing for a complete beginner.

## Conversation context

Treat the preceding conversation as private working context, not as context automatically available to the reader.

Notice claims, decisions, exclusions, and shorthand whose meaning depends on that conversation. Restore only the premises materially necessary for the intended reader to understand the artifact.

Do not expose the conversation itself, reproduce every considered alternative, or add background that does not serve the artifact’s purpose.

## Intended reader

Infer the artifact’s intended readers and calibrate the explanation to their likely domain and repository knowledge. Follow any audience the user explicitly identifies.

Do not assume readers participated in the design discussion. Also do not treat experienced project reviewers as beginners or explain familiar concepts without a reason.

When the audience is unclear, write for a technically capable teammate who knows the repository but is unfamiliar with the specific domain or decision.

## Explanation order

Establish the concrete situation and its consequence before relying on an unfamiliar mechanism or abstraction. Give readers the premises when they need them, rather than merely including those premises somewhere in the artifact.

For changes with several interacting parts, establish the problem and resulting behavior before introducing supporting mechanisms and exceptional cases. A small, consistent example can make those relationships easier to follow; use one when it helps the intended reader.

Keep qualifications that affect the main claim close to that claim. Defer supporting detail only when doing so preserves accuracy and leaves readers enough information to assess the change. This is a principle for ordering explanations, not a required document structure.

## Technical language

Preserve technical precision and use domain terminology when it helps the intended reader.

Do not use terminology as a substitute for the concrete meaning it compresses. When a term hides an important premise, failure mode, or scope boundary, make that meaning understandable in the surrounding text.

Do not mechanically remove jargon, add glossaries, expand every acronym, or make the artifact longer merely to appear accessible.

## Sentence readability

Make actions and consequences directly readable. Prefer concrete subjects and verbs when abstract nouns make readers reconstruct who does what. Unpack compressed phrases when the relationships they hide matter to understanding the change.

Let each sentence establish a situation, action, or consequence that the next can build on. Split sentences when conditions, mechanisms, reasons, and exceptions compete for attention. Keep useful causal connections explicit; shorter sentences are not an end in themselves.

Use consistent names for the same actor, state, or result. Do not vary terminology merely to avoid repetition, or replace precise distinctions with a single convenient label. Introduce a technical name alongside its concrete meaning when the reader needs that connection.

## Cold-reader review

Before delivering or publishing the artifact, reread it as if the preceding conversation were unavailable. Perform this review internally unless the user asks to see it.

Revise anything that materially depends on missing conversation context, including:

- conclusions whose premises exist only in the conversation;
- exclusions justified only as unnecessary, too complex, or not worth the cost;
- references such as “as discussed,” “the current approach,” or “this risk” without a clear referent;
- technical terms standing in for an unexplained situation;
- assumptions about environment, usage, constraints, or reader knowledge that affect the conclusion.

Also check whether the reader can follow the explanation without mentally rewriting it:

- Can they understand the problem and resulting behavior before working through unfamiliar implementation details?
- Does a passage require them to hold several unexplained concepts in mind?
- Can they identify who does what, under which conditions, and with what result from the sentences as written?
- Are causal links and recurring terms clear, and do simplifications preserve the scope and certainty of the claims?

Preserve the user’s chosen structure, tone, and level of detail when they are specified. Otherwise choose the structure, length, and style that best fit the artifact. Do not add sections, follow a fixed template, or rewrite an existing artifact wholesale merely to demonstrate compliance with this skill.
