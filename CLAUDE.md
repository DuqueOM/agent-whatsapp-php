# agent-whatsapp-php

WhatsApp customer-service bot (Meta WhatsApp Cloud API) for a fictional
business, in PHP 8.3 + MySQL 8.4, with an LLM that calls tools through the
OpenAI-compatible Chat Completions format (provider: Anthropic). What to
build: `docs/SPEC.md` (written in card M0-01; until then, the roadmap cards
define the scope). Order of work, card status and who writes each piece:
`docs/ROADMAP.md`.

## Working agreement

- Code ownership follows the `Owner` field of each card in the roadmap.
- `dev` cards are core logic owned by the developer. Agree on the expected
  behavior, write the failing tests first, then review the implementation. Do
  not write the implementation unless the developer explicitly asks for it.
- `ai` cards are scaffolding. Generate them in small, reviewable steps; a card
  is not Done until the developer has reviewed every line.
- Respect the WIP limits and pull policy in the roadmap; update the board when
  a card changes column.

## Scope

- Do not build anything listed as out of scope in the spec. If something
  deserves it, note it in one line in `DECISIONS.md` and move on.
- Respect the caps in the spec and the roadmap guardrails.
- Do not use subagents unless the developer asks: every change must be visible.

## Stack and commands

PHP 8.3, Composer, PDO + MySQL 8.4, Guzzle 8, PHPUnit 12, PHP_CodeSniffer,
PHPStan 2.
No web framework. LLM calls go over raw HTTP with Guzzle (no SDK) to
`POST {LLM_BASE_URL}/chat/completions`, behind a provider-neutral `LlmClient`
interface. Only the OpenAI-compatible adapter exists; do not add others unless
a card asks for it.

- First run: `cp .env.example .env`, fill in the values, then enable the hooks
  with `git config core.hooksPath .githooks`
- Start: `docker compose up -d`. Run it again after every Docker restart: the
  containers do not start on their own.
- App: `http://localhost:8088` (`APP_PORT` in `.env`; the container listens on
  8080). MySQL from the host: `127.0.0.1:3306`, not `localhost` (that means a
  local socket) and not `db` (that name exists only inside the Compose network).
- Install dependencies: `docker compose run --rm app composer install`
- Tests: `docker compose exec app composer test`
- Style (PSR-12): `docker compose exec app composer lint` (auto-fix: `lint:fix`)
- Static analysis (PHPStan level 6): `docker compose exec app composer analyse`
- Both, as the pre-commit hook runs them: `docker compose exec app composer check`.
  The hook runs gitleaks, then PHPCS on the staged PHP files and PHPStan on the
  whole working tree: a half-finished file with errors blocks any commit until
  it is fixed.
- Migrations: `docker compose exec app php bin/migrate.php` (card M1-04)

## Conventions

- Code, names, comments and tests in English; customer-facing text in Spanish
  (Mexico).
- `declare(strict_types=1);` in every PHP file, PSR-4 autoload under `src/`
  (`App\`), PSR-12 style.
- SQL only through prepared statements.
- PHPStan level 6 must pass. Array contents are typed in PHPDoc
  (`list<string>`, `array{wamid: string}`). No baseline; any ignore needs a
  one-line reason next to it.
- Secrets only in `.env` (gitignored); `.env.example` holds fake values. Never
  print secrets, full phone numbers or customer text in output, logs or
  commits.
- Small commits, one per card or step. Commits for `dev` cards are made by the
  developer.
- When a problem took more than 30 minutes, add its cause and fix to the
  matching skill.
