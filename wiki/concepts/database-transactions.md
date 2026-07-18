---
kind: concept
domain: education
title: Database transactions (ACID)
course: "316"
---

# Database transactions (ACID)

A **transaction** is a sequence of database operations treated as a unit with four guarantees
(**ACID**): **Atomicity** (all-or-nothing, never half-done), **Consistency** (constraints satisfied
at start remain satisfied at end), **Isolation** (transactions behave as if run alone), and
**Durability** (committed effects survive a crash). ^[[sources/notion-316-sql-transactions]] Atomicity
and durability are implemented via **logging** (undo and redo respectively); COMMIT makes effects
final, ROLLBACK undoes them.

## Isolation levels

True isolation means transactions appear to run in a **serial schedule**. For performance a DBMS
instead runs a **serializable** schedule — operations interleave but the result is guaranteed
identical to *some* serial order. ^[[sources/notion-316-sql-transactions]] SQL exposes weaker levels
that trade correctness for concurrency, defined by which anomalies they permit:

| level | dirty reads | non-repeatable reads | phantoms |
| --- | --- | --- | --- |
| READ UNCOMMITTED | possible | possible | possible |
| READ COMMITTED | — | possible | possible |
| REPEATABLE READ | — | — | possible |
| SERIALIZABLE | — | — | — |

The three anomalies: a **dirty read** sees an uncommitted value that may roll back; a
**non-repeatable read** gets different values for the same row read twice; a **phantom** is a new
row appearing in a repeated range query. Lock-based implementations escalate accordingly — from
short-duration read locks up to **range locks** at SERIALIZABLE to block phantom inserts. PostgreSQL
defaults to READ COMMITTED. ^[[sources/notion-316-sql-transactions]]

## Snapshot isolation and write skew

**Snapshot isolation** (a no-lock, MVCC approach) runs each transaction against a private snapshot
and commits only if it hasn't written a row another committed transaction changed. It avoids all the
ANSI anomalies yet is **not** equivalent to SERIALIZABLE: it permits **write skew**, where two
transactions each read a shared invariant, then write disjoint rows that jointly violate it (e.g.
both withdraw against a combined-balance constraint). ^[[sources/notion-316-sql-transactions]] The
fix is to also check no read object was written+committed by another transaction after this one
started. Practical rule: group dependent reads/writes into a transaction, and treat anything below
SERIALIZABLE as dangerous unless performance demands it. Part of [[316]]; relies on constraints and
[[sql]].
