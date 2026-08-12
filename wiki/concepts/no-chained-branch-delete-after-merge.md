---
kind: concept
domain: projects
title: Never chain a branch delete after a merge in the same command
course: "tradefabe"
---

# Never chain a branch delete after a merge in the same command

`gh pr merge` (and similar merge commands) can fail quietly on a bad flag or a state conflict —
but a shell command chained after it with `;` or `&&` still runs regardless. If that chained
command deletes the branch, the delete then **closes the still-unmerged PR**, and GitHub will not
reopen a PR whose source branch is gone. This has cost multiple reflog recoveries in practice.
^[[sources/repos-tradefabe-claude]]

**The fix is to make merge verification its own explicit step, never chained:**
1. Run the merge command alone.
2. Separately, query the PR's state and confirm it actually reads `MERGED` before doing anything
   else.
3. Only then run the branch-delete step (local + remote), on its own, never `&&`'d onto the merge
   or the verification.

Never use a one-shot "delete branch on merge" flag either, for the same reason — it removes the
verification step that catches a silent merge failure. ^[[sources/repos-tradefabe-claude]]

Generalizable to any CI/CD or git automation, not specific to this repo: any workflow that chains a
destructive step (delete, force-push, deploy) after a command whose failure mode is silent rather
than a nonzero exit code needs an explicit state check between the two steps, not a chain.
