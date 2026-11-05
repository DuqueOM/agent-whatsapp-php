# Roadmap

How this project is planned and tracked. **Milestones** (M0–M9) set the order
of work; a **Kanban board** controls the flow inside them. Every card is one
small, testable change that maps to a requirement in [`SPEC.md`](SPEC.md)
(F1–F10) or to the infrastructure needed to meet it.

Status: **M0 – Setup** · Last board update: 2026-10-16

---

## 1. How the board works

### Columns

| Column | A card is here when… |
|---|---|
| **Backlog** | It is identified but not yet ready to start. |
| **Ready** | It meets the Definition of Ready (below). Top of the column is next. |
| **In progress** | Someone is working on it right now. |
| **Review** | Work is finished; it is being verified against the Definition of Done. |
| **Done** | It meets the Definition of Done and is committed. |

### WIP limits

| Column | Limit | Why |
|---|---|---|
| In progress | **1 per owner** (`dev`, `ai`) | One developer and one AI pair. Finishing beats starting. |
| Review | **2** | Unreviewed work is unfinished work. When Review is full, nobody starts new work: review first. |

### Pull policy

- Pull the top card from **Ready** only when its owner has nothing in
  **In progress**.
- Finish a milestone (exit criteria met) before pulling cards from the next
  one. Exception: setup and research cards with no dependency on open work.
- A card stuck for more than 30 minutes is marked `⛔ blocked: <reason>`
  and gets help before more time is spent on it. If the cause was not obvious,
  it is recorded so it does not cost time twice.

### Card format

`ID · Title` with a **Spec** reference, an **Owner** and a **Type**.

**Owner** sets code ownership. The project is built with an AI pair
(Claude Code) under a human-owned-core policy:

- `dev`: core logic, implemented by the developer. Webhook security,
  persistence, the tool loop, handoff rules, the system prompt and the eval
  cases. The AI pair writes the failing tests first and reviews the result; it
  does not write the implementation.
- `ai`: scaffolding generated with the AI pair: infrastructure,
  configuration, test suites, fixtures and simulators. It is produced in small,
  reviewable steps, and no line is merged before the developer reviews it.

**Type**: `feat` · `test` · `infra` · `docs` · `research` · `ops` ·
`decision`.

### Definition of Ready

- [ ] The expected behavior is written down, including edge cases.
- [ ] For `dev` code cards: the tests exist and fail for the right reason.
- [ ] Dependencies (credentials, earlier cards) are in place.

### Definition of Done

- [ ] All tests pass inside the container (`composer test`).
- [ ] Static checks pass (`composer check`: PSR-12 style and PHPStan level 6,
      with no new ignores or baseline).
- [ ] Conventions hold: `declare(strict_types=1)`, prepared statements only.
- [ ] No secrets, real phone numbers or customer text in code, logs or git.
- [ ] One small commit for this card, with a message written by its owner.
- [ ] Commands and docs touched by the change are updated.
- [ ] Reviewed: the developer has read every changed line, generated code
      included. Nothing unreviewed is merged.

### Flow metrics

Each card in **Done** records `pulled → done` dates. Lead time per card and
throughput per week are reviewed at the end of each milestone to adjust the
next forecast.

---

## 2. Board

> Single source of truth for card status. Move IDs between columns; card
> details live in section 4.

| Backlog | Ready | In progress | Review | Done |
|---|---|---|---|---|
| M2-01 … M2-03 | M0-02 Store name | — | M1-01 Containers | M0-06 Repo & secret guardrails (10-14 → 10-14) |
| M3-01 … M3-02 | M0-04 LLM account | | M1-02 Toolchain | |
| M4-01 … M4-08 | M0-01 Spec | | | |
| M5-01 … M5-04 | M0-07 WhatsApp notes | | | |
| M6-01 … M6-07 | M0-03 Meta app | | | |
| M7-01 … M7-05 | M0-05 Local `.env` | | | |
| M8-01 … M8-05 | M0-08 … M0-09 Notes | | | |
| M9-01 … M9-06 | M1-03 … M1-06 | | | |
| M1-07 CI (optional) | | | | |

---

## 3. Milestones

| # | Milestone | Spec | Effort | Target window | Exit criteria |
|---|---|---|---|---|---|
| M0 | Setup | — | 1 d | Oct 14–15 | Credentials in local `.env` only; reference notes reviewed. |
| M1 | Skeleton | NFR | 1–2 d | Oct 15–17 | Clean clone boots and tests pass with documented commands. |
| M2 | Webhook verification | F1 | 1 d | Oct 19–20 | Meta marks the webhook as verified. |
| M3 | Signature | F2 | 1 d | Oct 20–21 | 6 signature tests pass; unsigned POST gets 401. |
| M4 | Receive & persist | F3, F4 | 3–4 d | Oct 21–24 | Repository tests pass on MySQL; a duplicate webhook leaves one row. |
| M5 | First echo | F8 | 1 d | Oct 26–27 | A message from my phone gets an echo back. |
| M6 | LLM with tools | F5, F6, F9, F10 | 4–5 d | Oct 27–Nov 3 | My order → status; another number's order → "not found". |
| M7 | Human handoff | F7 | 2–3 d | Nov 3–6 | Asking for an agent: bot replies once, then stays silent until released. |
| M8 | Prompt & evals | F5 | 3 d | Nov 6–11 | Pass rate published; every prompt change has a motivating case. |
| M9 | Close-out | all | 2 d | Nov 11–17 | Acceptance criteria in `SPEC.md` met from a clean clone. |

Effort is focused part-time days. Target windows are forecasts, revised with
the flow metrics at the end of each milestone.

---

## 4. Milestone details

### M0 · Setup

Goal: accounts, credentials and reference notes in place, with nothing secret
in git.

| ID | Card | Spec | Owner | Type |
|---|---|---|---|---|
| M0-01 | Write `docs/SPEC.md`: requirements F1–F10, non-functional requirements, caps, out of scope, acceptance criteria | all | dev | docs |
| M0-02 | Fictional store: name and what it sells | F5, F6 | dev | decision |
| M0-03 | Meta for Developers app: WhatsApp product, test number, own phone as allowed recipient | — | dev | ops |
| M0-04 | LLM provider account: API key created, monthly spend limit set | NFR | dev | ops |
| M0-05 | Fill local `.env`: phone number ID, access token, App Secret, verify token, LLM key | — | dev | ops |
| M0-06 | Public repo, `.gitignore` from the first commit, local secret scan (pre-commit), GitHub push protection | NFR | ai | infra |
| M0-07 | Reference notes (assistant skill): WhatsApp Cloud API (verification, signature, payloads, sending, 24-hour window, retries, traps). Each fact with its official URL and date | F1–F4 | ai | research |
| M0-08 | Reference notes (assistant skill): LLM tool calling in the OpenAI-compatible Chat Completions format (request, `tool_calls`, `finish_reason`, loop cap, timeouts, retries, usage and cost), the provider's compatibility limits, and a one-call smoke test against the real API | F5, F9 | ai | research |
| M0-09 | Reference notes (assistant skill): system prompt structure, eval case format, runner, what to measure | F5 | ai | research |

Notes M0-07 to M0-09 are drafted with the AI pair, each fact with its official
source and date; the developer verifies every fact before committing.

### M1 · Skeleton

Goal: a reproducible environment where tests run in one command.

| ID | Card | Spec | Owner | Type |
|---|---|---|---|---|
| M1-01 | Containers: PHP 8.3 + MySQL 8.4 (utf8mb4, test database, healthcheck); both published on localhost only, app port configurable | NFR | ai | infra |
| M1-02 | Toolchain: Composer with PSR-4 autoload, Guzzle, PHPUnit (unit + integration suites), PHP_CodeSniffer (PSR-12), PHPStan (level 6), versioned pre-commit hook (secrets, style, static analysis) | NFR | ai | infra |
| M1-03 | Front controller `public/index.php` and router script for the built-in server; `GET /health` | NFR | ai | feat |
| M1-04 | `bin/migrate.php`: applies `migrations/*.sql` in order and records what ran | NFR | ai | feat |
| M1-05 | First passing test (`/health`) | NFR | ai | test |
| M1-06 | Commands documented for contributors and the assistant | NFR | ai | docs |
| M1-07 | *Optional:* CI on every push (style, static analysis, unit and integration tests) | NFR | ai | infra |

### M2 · Webhook verification

| ID | Card | Spec | Owner | Type |
|---|---|---|---|---|
| M2-01 | Tests: right token returns the challenge; wrong token, wrong mode or missing parameters return 403 | F1 | ai | test |
| M2-02 | `GET /webhook` handler | F1 | dev | feat |
| M2-03 | HTTPS tunnel to the local app; callback URL and verify token registered in Meta; `messages` field subscribed | F1 | dev | ops |

### M3 · Signature

| ID | Card | Spec | Owner | Type |
|---|---|---|---|---|
| M3-01 | Tests: valid signature, altered body, missing header, wrong prefix, wrong secret, empty secret | F2 | ai | test |
| M3-02 | `X-Hub-Signature-256` validation on the raw body, constant-time comparison, 401 before any processing | F2 | dev | feat |

### M4 · Receive & persist

| ID | Card | Spec | Owner | Type |
|---|---|---|---|---|
| M4-01 | Schema design: conversations, messages, demo orders; keys and indexes justified. Reviewed before any code | F3, F4 | dev | decision |
| M4-02 | Migrations for the schema | F4 | dev | feat |
| M4-03 | Meta payload parser: messages vs. statuses, text vs. other types, no warnings on missing keys | F3 | ai | feat |
| M4-04 | `bin/simulate-message.php`: signs and sends a test payload to the local webhook | F2, F3 | ai | feat |
| M4-05 | Integration tests for the repository against the test database | F3, F4 | ai | test |
| M4-06 | Repository: store inbound message once per `wamid` | F3, F4 | dev | feat |
| M4-07 | Repository: store outbound message | F4 | dev | feat |
| M4-08 | Repository: last N messages of a number in chronological order, stable on equal timestamps | F4 | dev | feat |

### M5 · First echo

| ID | Card | Spec | Owner | Type |
|---|---|---|---|---|
| M5-01 | WhatsApp send client (Guzzle) with mocked-HTTP tests; Graph API version from config | — | ai | feat |
| M5-02 | Wire webhook → echo reply | F4 | dev | feat |
| M5-03 | Mexican number format: `wa_id` arrives as `521…`, sending needs `52…`; one normalization point, tested | F6 | dev | feat |
| M5-04 | Non-text messages (audio, image, location) get the "text only for now" reply | F8 | dev | feat |

### M6 · LLM with tools

| ID | Card | Spec | Owner | Type |
|---|---|---|---|---|
| M6-01 | Tests: text answer, `tool_calls` answer, malformed or wrongly typed arguments, unknown tool, empty content, HTTP 500, timeout (mocked HTTP for the adapter; a fake client for the loop) | F5, F9 | ai | test |
| M6-02 | Provider-neutral `LlmClient` interface and its one adapter: `POST {LLM_BASE_URL}/chat/completions` over Guzzle, connect and total timeouts, one retry with backoff on 429/5xx | F5, F9 | dev | feat |
| M6-03 | Tool loop, max 3 rounds, written against the interface: append the assistant message with its `tool_calls`, then one `tool` message per call with its `tool_call_id` | F5 | dev | feat |
| M6-04 | `get_order_status(order_id)` scoped to the sender's number; another customer's order answers exactly like a missing one | F6 | dev | feat |
| M6-05 | Apology path: any LLM failure ends in a friendly message, never a technical error | F9 | dev | feat |
| M6-06 | One log line per message: masked number, latency, tokens, tools used. Never message text or full number | F10 | dev | feat |
| M6-07 | Cost per typical conversation, from logged usage and the provider's price page (URL + date) | NFR | dev | research |

### M7 · Human handoff

| ID | Card | Spec | Owner | Type |
|---|---|---|---|---|
| M7-01 | Tests including false positives ("¿para cuántas personas es el combo?") and negation ("no necesito un asesor") | F7 | ai | test |
| M7-02 | Rule-based handoff detection: case- and accent-insensitive, simple negation, no LLM | F7 | dev | feat |
| M7-03 | `handoff_to_human(reason)` tool; exhausting 3 tool rounds also hands off | F7 | dev | feat |
| M7-04 | Conversation state (`bot` / `human`) stored; bot stays silent while a human owns it | F7 | dev | feat |
| M7-05 | `bin/release.php <number>` returns the conversation to the bot | F7 | dev | feat |

### M8 · Prompt & evals

| ID | Card | Spec | Owner | Type |
|---|---|---|---|---|
| M8-01 | `prompts/system.md`: role, tools, rules, tone and length, handoff, off-topic handling | F5 | dev | feat |
| M8-02 | `evals/cases.jsonl`, ~20 cases: happy path, missing order, someone else's order, prompt injection, off-topic, angry customer, ambiguous order number | F5–F7 | dev | test |
| M8-03 | `bin/run-evals.php`: real LLM with fixture tools, deterministic checks, pass rate per category, cost of the run | F5 | ai | feat |
| M8-04 | Prompt change rule: each change references a case that failed before and passes after | F5 | dev | docs |
| M8-05 | Pass rate published in the README | — | dev | docs |

### M9 · Close-out

| ID | Card | Spec | Owner | Type |
|---|---|---|---|---|
| M9-01 | `README.md`, one page, written by the developer: what it does, how to run it, a message's flow in 5 lines, next steps, how it was built | — | dev | docs |
| M9-02 | `DECISIONS.md`: at most 5 decisions, 5 lines each | — | dev | docs |
| M9-03 | Acceptance run from a clean clone | all | dev | test |
| M9-04 | 2-minute demo video on a real phone covering the acceptance scenarios | all | dev | docs |
| M9-05 | Pre-release review: end-to-end trace of a message through the code, and failure-mode analysis (LLM unavailable, database failure mid-request, traffic spike) | all | dev | test |
| M9-06 | *Optional, one only:* async queue for an instant 200, delivery statuses, audio transcription, or a web channel | — | dev | feat |

---

## 5. Scope guardrails

- At most ~1,500 lines of PHP in `src/`.
- `README.md`: one page. `DECISIONS.md`: at most 5 decisions of 5 lines.
- One optional extension, only after M9-05.
- Anything listed as out of scope in `SPEC.md` is not built. If it seems worth
  it, it becomes one line in `DECISIONS.md` and work continues.

---

## 6. Risks

| Risk | Impact | Mitigation | When |
|---|---|---|---|
| Mexican numbers: `wa_id` is `521…` but the test number only accepts `52…` (error 131030) | Replies fail; the order ownership check misfires | Normalize in one place, with tests | M5, M6 |
| Tunnel URL changes on every restart | Webhooks stop arriving | Re-register the URL in Meta; documented in the README | M2 |
| A host port is already taken on the developer machine (it happened: 8080) | The app does not start, or the browser reaches another server | App port configurable through `APP_PORT` (default 8088); services published on `127.0.0.1` only | M1, M2 |
| Temporary access token expires | Sends fail while webhooks keep arriving; looks like "the bot is silent" | Long-lived system user token; Graph API errors logged | M5 |
| Slow 200 to Meta triggers retries | Duplicate processing | `wamid` uniqueness (F3); keep the webhook fast; optional queue | M4, M9 |
| LLM latency | Slow replies, Meta retries | Timeouts and apology path (F9); measure latency per message | M6 |
| Provider's OpenAI-compatibility layer has documented limits (`strict` ignored, refusals not reported, no prompt caching) | Unvalidated tool input; silent failures | Validate every tool argument in code; empty or unexpected answers take the apology path; smoke test in M0-08; adapter isolated behind `LlmClient` | M0, M6 |
| Limited LLM credit consumed by eval runs | Development stalls | Provider spend limit; cost printed per eval run; model choice recorded in `DECISIONS.md` | M0, M8 |
| A secret reaches git | Credential compromise | Ignored from commit 1, pre-commit scan, push protection. If it happens: revoke and rotate first, clean history second | Always |
| Guzzle 8 differs from most published examples (Guzzle 7) | Wrong exception handling for timeouts | Use Guzzle 8's `UPGRADING.md` (timeout exceptions are split by phase) | M5, M6 |
| Scope creep | Unfinished project | Guardrails above | Always |
