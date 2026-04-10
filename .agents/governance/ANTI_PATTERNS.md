# Recognized Anti-Patterns

## Fat Controller

Controller mixes transport concerns with business logic, persistence, or orchestration overload.

## Repository With Domain Logic

Repository validates core business invariants or performs domain decisions.

## Anemic Entity

Entity acts only as a data bag while business behavior lives elsewhere without good reason.

## God Service

One service owns too many operations and reasons to change.

## DTO With Domain Behavior

DTO contains core business logic or invariants that belong elsewhere.

## Test That Verifies Implementation

Test is tightly coupled to collaborator interaction structure rather than observable behavior.

## Excessive Mocking

Test setup reveals overly coupled production design.

## Fake Integration Test

Integration test uses unrealistic fake persistence or infrastructure substitutes.

## E2E Covering Domain Logic

UI/system-level test verifies details that belong in unit or integration layers.

## Time-Coupled Domain Logic

Domain uses system clock directly where deterministic testing matters.
