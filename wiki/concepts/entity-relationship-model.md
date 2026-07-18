---
kind: concept
domain: education
title: Entity-relationship model
course: "316"
---

# Entity-relationship (E/R) model

The E/R model is a high-level, diagram-based **design** notation (not directly implemented by any
DBMS) for specifying a schema before translating it to relations. ^[[sources/notion-316-er-design]]
Its primitives: **entity sets** (rectangles), **relationship sets** among entities (diamonds), and
**attributes** (ovals); a key is shown by underlining its attributes.

**Multiplicity** constrains how many entities relate: many-many, many-one (each E relates to ≤1 F),
or one-one. **Weak entity sets** (double rectangle) draw part of their key from another entity set
through a **supporting relationship** (double diamond), which must be many-one or one-one so the key
source is unambiguous. **ISA** (triangle) models subclassing. Relationships can be *n*-ary — and
genuinely n-ary relationships cannot be reduced to binary ones. ^[[sources/notion-316-er-design]]

## Translation to relations

Entity sets become tables (attributes→columns, key→key). Relationship sets become tables holding
the connected entities' keys plus any relationship attributes, with the multiplicity determining the
table's key; supporting relationships for weak entities need no separate table. ^[[sources/notion-316-er-design]]

**ISA has three translation strategies**, each a different tradeoff:
- **Entity-in-all-superclasses (E/R style):** a subclass row appears in every ancestor table, each
  carrying only its own attributes + inherited key. All entities of a class findable in one table,
  but a subclass's attributes are scattered.
- **Entity-in-most-specific-class (OO style):** each entity in exactly one table, carrying all
  inherited attributes. Attributes co-located, but entities of a class are scattered.
- **All-entities-in-one-table (NULL style):** one table for the whole hierarchy with NULLs where
  attributes don't apply. Everything in one place, at the cost of many NULLs.

Part of [[316]]; produces schemas that [[database-normalization]] then refines, grounded in
[[functional-dependencies]] and [[relational-algebra]].
