---
kind: concept
domain: education
title: Linear ODE systems and the eigenvalue method
course: "353"
---

# Linear ODE systems and the eigenvalue method

A first-order linear system $\mathbf{x}' = A\mathbf{x}$ is solved by turning it into an eigenvalue
problem. By **superposition**, any linear combination of solutions is a solution; $n$ solutions are
**linearly independent** iff their **Wronskian** (the determinant of the solution matrix) is nonzero,
in which case their combination is the general solution. ^[[sources/notion-353-course-matrices-eigenvalues-two-point]]

## The eigenvalue method

If $\lambda$ is an eigenvalue of $A$ (a root of the characteristic equation $|A - \lambda I| = 0$)
with eigenvector $\mathbf{v}$ (solving $(A - \lambda I)\mathbf{v} = \mathbf{0}$), then
$\mathbf{x}(t) = \mathbf{v}e^{\lambda t}$ is a solution. The recipe: find all eigenvalues, find an
independent eigenvector for each, and combine. ^[[sources/notion-353-course-matrices-eigenvalues-two-point]]

- **Distinct real eigenvalues** — one $\mathbf{v}e^{\lambda t}$ per eigenvalue; always independent.
- **Complex eigenvalues** $\lambda = p \pm qi$ — the complex solution
  $(\mathbf{a} + i\mathbf{b})e^{(p+qi)t}$ splits via $e^{(p+qi)t} = e^{pt}(\cos qt + i\sin qt)$ into two
  real oscillating-decaying solutions.
- **Repeated (defective) eigenvalues** — a multiplicity-$k$ eigenvalue with too few eigenvectors needs
  generalized ones: a second solution $\mathbf{x}_2 = (\mathbf{v}_1 t + \mathbf{v}_2)e^{\lambda t}$
  where $(A - \lambda I)\mathbf{v}_2 = \mathbf{v}_1$ — the matrix analogue of the $te^{rt}$ trick for
  repeated scalar roots.

A worked **two-tank mixing problem** ($\mathbf{x}' = A\mathbf{x}$ for salt flowing between brine
tanks) yields eigenvalues $0$ and $-13/20$ and the constants $c_1 = 15/13$, $c_2 = 120/13$ — the
$\lambda = 0$ mode is the conserved steady state. ^[[sources/notion-353-course-matrices-eigenvalues-two-point]]

## Nonhomogeneous systems

For $\mathbf{x}' = P(t)\mathbf{x} + \mathbf{f}$, once a **fundamental matrix** $\Phi(t)$ (columns are
independent homogeneous solutions) is known, variation of parameters gives a particular solution
$\mathbf{x}_p = \Phi(t)\int \Phi(t)^{-1}\mathbf{f}(t)\,dt$. ^[[sources/notion-353-course-matrices-eigenvalues-two-point]]

Part of [[353]] (Math 353). *(The source's two-point boundary-value-problem section that follows has
operator-sign errors and stops before the $\lambda > 0$ case — see [[contradictions]] — so that
material is not promoted here. The separate scalar variation-of-parameters page is also withheld: its
worked example executes the method incorrectly. The matrix-VoP example above, by contrast, is correct
and complete.)*
