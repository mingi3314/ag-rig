---
name: use-logfire
description: Query Logfire traces, spans, and logs with logfire-cli when given a Logfire URL or asked to inspect execution records. Also return trace links for verification. Not for SDK setup.
---

# Use Logfire

Use `logfire-cli` for queries and trace links. Read region, organization, project, trace/span IDs, and time bounds from the supplied URL; pass `--region` and `--org` when needed to override the current context.

```sh
logfire-cli mcp context
logfire-cli mcp projects --output json
logfire-cli mcp query schema
logfire-cli mcp query run --project <project> --start <ISO8601> --end <ISO8601> --output json '<SQL>'
logfire-cli mcp link trace <trace-id> --project <project>
```

- SQL runs through `mcp query run`, not `mcp query sql`. Use schema/help for unfamiliar fields and options; bound scan times with `--start`/`--end` and result rows with SQL `LIMIT`.
- Query rows are under `.data.structuredContent.rows`. Check whether `attributes` is an object or JSON string before parsing.
- A parent span may contain only metadata; inspect child agent spans for messages and tool calls.
- CLI login and the application's telemetry destination/content settings are separate. For requested test runs, use existing app instrumentation and return a trace/span link.
