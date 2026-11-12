---
name: feature-qa
description: Coordinate feature QA from Gherkin scenario collection through staging verification, exploratory testing, usability review, and a QA report.
---

# 기능 QA 통합

1. 대상 기능·변경 범위와 근거 자료, 스테이징 URL을 파악한다. 출력 위치를 지정하지 않았다면 OS 임시 디렉터리에 고유한 `feature-qa-*` 실행 폴더를 만든다. 실행 정보가 부족해도 가능한 시나리오 수집은 진행한다.
2. [generate-qa-scenarios](../generate-qa-scenarios/SKILL.md)를 읽고 `.feature`를 작성한다. 적합한 기존 케이스는 재사용·보완한다.
3. 같은 실행 폴더와 파일·근거·우선 위험·미정 사항을 넘겨 [run-staging-qa](../run-staging-qa/SKILL.md)에 따라 검증·탐색·사용성 검토를 이어간다. 전체 시간 제한은 작성·실행·정리에 나눠 사용한다.

시나리오 작성 후에는 실행 요청을 다시 기다리지 않고 QA로 이어간다. 부족한 정보·권한이 필요한 부분만 확인하고 가능한 작업은 계속한다. 최종 응답에 `.feature`와 리포트 링크, 주요 발견과 남은 미검증 위험을 함께 제공한다.
