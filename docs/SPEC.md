# Product specification

<!-- Card M0-01. Written by the developer. Every requirement must be testable
     and referenced by ID (F1–F10) from docs/ROADMAP.md. -->

## 1. Overview

<!-- What the bot is, which fictional business it serves, what customers can
     do with it, and when a human takes over. 3–5 lines. -->

## 2. Functional requirements

<!-- One row per requirement, F1–F10. State the observable behavior, including
     the failure case (e.g. which status code, which reply). -->

| ID | Requirement |
| F1 | GET /webhook returns hub.challenge with 200 only when hub.verify_token matches the configured token; otherwise 403. |

## 3. Non-functional requirements

<!-- Stack and versions, how it runs, LLM configuration, secrets handling,
     test strategy, local tooling. -->

## 4. Constraints

<!-- Hard caps: lines of PHP, README length, number of decisions, number of
     optional extensions. -->

## 5. Out of scope

<!-- What will not be built, even if it looks like a good idea. -->

## 6. Acceptance criteria

<!-- How a reviewer verifies the project from a clean clone, and the scenarios
     the demo video must show. -->

## 7. Glossary

<!-- Domain terms used in this spec (wamid, phone_number_id, handoff, ...). -->
