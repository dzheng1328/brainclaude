---
kind: concept
domain: education
title: SQL
course: "316"
---

# SQL

SQL is the declarative query language that implements the [[relational-algebra|relational model]] in
real DBMSs. Its query core is **SELECT–FROM–WHERE**: FROM names the input relations (a cross
product), WHERE filters, SELECT projects; `DISTINCT` switches from bag (multiset, SQL's default) to
set semantics. ^[[sources/notion-316-sql-querying]] Layered on top: **subqueries**, **aggregates**
(COUNT/SUM/…) with **GROUP BY** and **HAVING** (a post-aggregation filter), **ORDER BY**, and
`LIMIT`/`OFFSET`.

**Incomplete information** uses NULL with three-valued logic, and **outer joins** preserve unmatched
rows by padding with NULLs — both departures from clean relational algebra. ^[[sources/notion-316-sql-querying]]

## Beyond plain queries

- **Constraints** enforce integrity declaratively: NOT NULL, key declarations, **referential
  integrity** (foreign keys), and CHECK/assertions. ^[[sources/notion-316-sql-constraints]]
- **Views** are named queries usable as virtual tables; they aid abstraction and security. Updating
  through a view is limited, and `INSTEAD OF` triggers make otherwise non-updatable views writable.
  ^[[sources/notion-316-sql-views]]
- **Triggers** make a database "active" — event-condition-action rules firing on insert/update/delete,
  at row or statement level, using transition variables for old/new values. ^[[sources/notion-316-sql-triggers]]
- **Recursion** (`WITH RECURSIVE`) adds the expressive power relational algebra lacks, defined as the
  **least fixed point** of a query iterated from a seed until it stops growing; recursion can be
  linear, nonlinear, or mutual, and fixed points are not in general unique. ^[[sources/notion-316-sql-recursion]]

SQL also spans DDL (CREATE/DROP TABLE) and modification (INSERT/DELETE). Every multi-statement unit
runs inside a [[database-transactions|transaction]]. Part of [[316]]; contrast with the
semi-structured/XML data model (see [[sources/notion-316-xml-dtd]], a concept candidate).
