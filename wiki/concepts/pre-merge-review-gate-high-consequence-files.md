---
kind: concept
domain: projects
title: Mandatory pre-merge review gate for narrow, high-consequence files
course: "tradefabe"
---

# Mandatory pre-merge review gate for narrow, high-consequence files

For a repo with a small class of files whose correctness matters far more than the rest of the
codebase — a schema, a pricing rule, a strategy specification, an evaluation gate — a single
missed review of a change to one of those files can be expensive in a way a missed review
elsewhere isn't. The fix is a **mandatory, named review step scoped specifically to that file
class**, run before merging any PR that touches it, rather than relying on general code review to
catch it. ^[[sources/repos-tradefabe-claude]]

**Why general review isn't enough.** The gate here was added *after* it was skipped once already —
a new primitive merged into the high-consequence file class with no doctrine review, caught only in
retrospect. A gate that exists but isn't mandatory (relies on someone remembering to invoke it)
fails exactly the way ordinary review already does. ^[[sources/repos-tradefabe-claude]]

**Shape of the gate:** a dedicated reviewer (here, a subagent with a fixed checklist) that must run
specifically before merging any PR touching the narrow file class — not a general "review this PR"
step, but one scoped to catch the specific failure class the file class is exposed to.
^[[sources/repos-tradefabe-claude]]

Generalizable to any repository with a narrow set of high-blast-radius files: database migration
files, IAM/permission policies, pricing/billing logic, safety-critical configuration. The pattern
is naming the file class explicitly and gating merges on it, rather than trusting general review
discipline to catch changes there with the same rigor as everything else.
