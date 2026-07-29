---
name: pr-review
description: PR review, branch review, code review, or diff audit skill for Codex. Use when asked to review a pull request or branch against a base branch. Coordinates read-only specialist subagents for correctness, maintainability barriers, security, tests, architecture, performance, concurrency, codebase consistency, code quality, and repo-specific rules. Do not use for implementation or autofix unless the user explicitly asks for fixes.
---

# PR Review

## Purpose

Use this skill to perform a high-signal review of a pull request, branch diff, or proposed code change. The goal is to find actionable risks introduced by the change: correctness defects and maintainability barriers that make changed code hard for another teammate to understand, safely modify, test, or own. Do not produce a broad style critique.

Default posture: read-only review. Do not edit files, push commits, run destructive commands, or post GitHub comments unless the user explicitly asks.

Treat these instructions as guardrails, not a checklist. Use judgment based on the diff, repository, and user request; avoid narrowing the review just because a concern is not named here. Treat reviewer confusion as a useful signal, but publish it only when it points to concrete maintenance or defect risk.

## Inputs and defaults

Infer missing inputs when safe:

- Base branch: prefer the PR base if available; otherwise try `origin/main`, `main`, `origin/master`, then `master`.
- Head branch: current `HEAD`.
- Review depth:
  - small or obvious diff: single-pass review is acceptable.
  - medium, risky, multi-service, security-sensitive, migration, concurrency, or broad diff: spawn specialist subagents.
- Output destination: final response only unless the user asks to post to GitHub.

Ask a clarifying question only when the base branch or review scope is impossible to infer and a wrong choice would materially change the review.

## Routing policy

Use the cheapest sufficient review plan.

### Skip or summary-only

Use summary-only review for:

- generated files only
- vendored code only
- lockfile-only changes without dependency policy impact
- formatting-only changes
- documentation-only changes, unless the user asks for docs quality review

### Single-agent review

Use the parent agent without extra subagents when:

- the diff is small and localized
- the risk is low
- there are no security, data, auth, migration, concurrency, or cross-service changes

### Multi-subagent review

Spawn specialist subagents when independent review lenses are likely to improve coverage, especially for broad, risky, cross-boundary, security-sensitive, test-sensitive, consistency-sensitive, or hard-to-understand diffs.

Keep fan-out bounded by default. Do not create recursive fan-out.

## Subagent plan

When using subagents, explicitly spawn bounded read-only subagents and wait for all results before synthesizing.

Prefer custom agents if installed:

- `pr_explorer`
- `pr_correctness_reviewer`
- `pr_security_reviewer`
- `pr_tests_reviewer`
- `pr_architecture_reviewer`
- `pr_consistency_reviewer`
- `pr_code_quality_reviewer`

If custom agents are not installed, spawn generic subagents with equivalent instructions.

Select reviewers by the diff's risk profile. Include only reviewers whose perspective can materially improve the review, and let the Explorer's map influence the final reviewer mix when the scope is unclear.

### 1. Explorer

Task:

- map changed files to runtime behavior
- identify relevant entry points, callers, data flow, config, and tests
- find relevant repo guidance and ownership context
- avoid judging severity unless evidence is concrete

Return:

```json
{
  "scope_summary": "...",
  "affected_paths": ["..."],
  "entry_points": ["..."],
  "relevant_tests": ["..."],
  "risk_areas": ["..."]
}
```

### 2. Correctness reviewer

Task:

- find behavior regressions, edge cases, error handling gaps, compatibility breaks, and rollout/rollback risks
- focus only on issues introduced or materially worsened by the diff

### 3. Security reviewer

Task:

- look for concrete security and privacy risks around trust boundaries, sensitive data, unsafe execution, permissions, dependencies, and untrusted input
- avoid speculative findings without an execution path

### 4. Tests reviewer

Task:

- assess whether changed behavior and important risks are covered by appropriate tests
- flag deleted, skipped, weakened, flaky, or misleading tests when they matter to the PR
- do not demand tests for purely mechanical changes unless risk justifies it

### 5. Architecture, performance, and concurrency reviewer

Task:

- look for material maintainability, layering, API contract, performance, caching, resource lifetime, concurrency, idempotency, and background job risks
- assess whether new boundaries and ownership are clear enough for shared maintenance
- focus on concrete risk, not preference

### 6. Consistency reviewer

Task:

- assess whether the PR fits established codebase patterns and local conventions
- flag divergence only when it creates maintenance risk, incompatible parallel patterns, future-change friction, or likely review churn for teammates
- consider whether the change violates expectations that nearby-code readers rely on to understand responsibility, side effects, or contracts
- cite the existing local pattern that the PR should align with
- do not treat personal style preferences as findings

### 7. Code quality reviewer

Task:

- look for unnecessary complexity, brittle logic, unclear contracts, duplication, dead code, and abstractions that obscure important invariants
- assess whether changed names, call sites, and structure let a teammate predict responsibility, side effects, scope, and abstraction level without the original author's context
- treat hard-to-name or hard-to-follow code as possible evidence of mixed responsibilities; prefer responsibility separation over rename-only advice when that is the real issue
- focus on issues that plausibly increase future defect risk or make the changed behavior hard to review, test, or maintain
- do not publish polish-only comments unless the user explicitly asks for nits

Each reviewer returns findings in the shared schema below.

## Shared finding schema

Every finding must be JSON-compatible and must include:

```json
{
  "severity": "P0|P1|P2|Nit",
  "confidence": 0.0,
  "title": "short imperative or risk title",
  "file": "path/from/repo/root",
  "line_start": 1,
  "line_end": 1,
  "introduced_by_pr": true,
  "category": "correctness|security|tests|architecture|performance|concurrency|consistency|code-quality|repo-rule",
  "evidence": "specific reason this is a real issue",
  "failure_mode": "what breaks, leaks, or regresses",
  "suggested_fix": "minimal fix direction"
}
```

Severity calibration:

- `P0`: critical vulnerability, data loss, severe outage, or irreversible production break.
- `P1`: likely serious bug, security issue, data leak, auth/tenant bypass, migration break, or high-impact regression.
- `P2`: real issue with moderate impact or narrower triggering conditions.
- `Nit`: low-risk maintainability or clarity issue. Do not emit nits unless the user asks or the nit hides a real defect.

Confidence calibration:

- `0.90+`: directly evidenced by diff and code path.
- `0.75-0.89`: likely issue with clear reasoning but incomplete runtime proof.
- `<0.75`: do not publish as a finding; mention only in internal synthesis or `needs manual check` if useful.

Publication threshold:

- exact location
- concrete failure mode
- evidence from the diff or adjacent code
- for maintainability findings, a concrete way the change could mislead a teammate, hide an invariant or side effect, block safe modification, or increase future defect risk
- confidence >= 0.75
- issue introduced or materially worsened by the PR

Noise suppression:

- avoid style-only comments
- avoid naming or readability comments unless they hide responsibility, side effects, contracts, invariants, or ownership enough to create plausible maintenance or defect risk
- avoid replacing already-clear local names with personal preference names
- avoid framework-general advice with no local failure path
- avoid requests for tests when existing coverage is sufficient
- avoid pre-existing issues outside the PR scope
- avoid findings already guaranteed by lint/typecheck/CI, unless they are security- or release-critical

## Verification and synthesis

The parent agent must verify all subagent findings before presenting them.

Reject or downgrade any finding that fails one of these checks:

- exact file and line range exist in the current diff or immediately adjacent context
- issue is introduced or materially worsened by the PR
- evidence shows a concrete failure path, not generic concern
- maintainability concern explains how a teammate would be blocked, misled, or likely to introduce a future defect
- issue is not already fully caught by existing lint/typecheck/CI unless the user needs it highlighted
- suggested fix is proportionate and local
- duplicate findings are merged

When multiple agents identify the same issue, merge them into one finding and raise confidence only if they provide independent evidence.

## Output format

Unless the user requests another language, write the final review in Korean. Keep schema/category enum values in English.

Return a concise review in this structure:

```markdown
## 발견 사항

### P1 - <제목>

- Location: `path/to/file.ext:Lx-Ly`
- Category: correctness|security|tests|architecture|performance|concurrency|consistency|code-quality|repo-rule
- 신뢰도: 0.xx
- 근거: <왜 실제 문제인지>
- 실패 모드: <무엇이 깨지거나 회귀되는지>
- 제안 수정: <최소 수정 방향>

## 리뷰 요약

- Base: `<base>`
- Head: `<head>`
- 리뷰한 파일 수: `<n>`
- 리뷰 모드: `single-agent|multi-subagent`
- 판정: `no blocking findings|findings require attention|manual review still required`

## 참고 사항

- <중요한 관찰만 포함. 없으면 생략.>

## 서브에이전트 커버리지

- Explorer: <확인한 범위>
- Correctness: <사용한 경우 확인한 범위>
- Security: <사용한 경우 확인한 범위>
- Tests: <사용한 경우 확인한 범위>
- Architecture/performance/concurrency: <사용한 경우 확인한 범위>
- Consistency: <사용한 경우 확인한 범위>
- Code quality: <사용한 경우 확인한 범위>
```

If there are no findings, say so directly and list the highest-risk areas checked. Do not invent issues to fill the template.

## GitHub posting rules

Do not post comments to GitHub unless the user explicitly asks.

If asked to post:

- inline comments only for `P0` and `P1`
- summary comment may include `P2`
- omit `Nit` unless specifically requested
- avoid duplicate comments on the same line/risk
- include exact file and line information

## Prohibited behavior

Do not:

- modify code during review unless explicitly asked to fix
- run destructive commands
- expose secrets or print sensitive values
- evaluate model output as shell commands
- make style-only comments as blocking findings
- report pre-existing unrelated issues as PR defects
- claim tests passed unless they were actually run
- claim a vulnerability exists without a plausible path

## Re-review mode

When reviewing an updated PR after prior feedback:

- focus first on whether previous P0/P1/P2 findings were fixed
- check whether the fix introduced new regressions
- suppress old nits unless they are still materially relevant
- state what changed since the previous review if detectable
