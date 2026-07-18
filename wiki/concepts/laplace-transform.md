---
kind: concept
domain: education
title: Laplace transform
course: "353"
---

# Laplace transform

The Laplace transform turns a calculus problem (derivatives, in time $t$) into an algebra problem
(polynomials, in a complex frequency $s$). It is the improper integral ^[[sources/notion-353-course-improper-integral-laplace-transform]]

$$F(s) = \mathcal{L}\{f(t)\}(s) = \int_0^\infty e^{-st} f(t)\,dt$$

"Multiply by $e^{-st}$ to damp the function, then integrate forever"; it exists wherever that
integral converges (guaranteed if $f$ is piecewise continuous and $|f(t)| \le Ke^{at}$). It is
**linear**, and a small table covers most needs: $\mathcal{L}\{1\} = 1/s$, $\mathcal{L}\{e^{at}\} =
1/(s-a)$, $\mathcal{L}\{t^n\} = n!/s^{n+1}$. ^[[sources/notion-353-course-improper-integral-laplace-transform]]

## Solving ODEs

The key property turns differentiation into multiplication, folding in initial conditions ^[[sources/notion-353-course-improper-integral-laplace-transform]]:

$$\mathcal{L}\{f'\} = sF(s) - f(0), \qquad \mathcal{L}\{f''\} = s^2F(s) - sf(0) - f'(0)$$

So an ODE becomes an algebraic equation for $Y(s)$; **partial fractions** break $Y(s)$ into table
terms, and the inverse transform recovers $y(t)$. E.g. $y'' - 3y' + 2y = 0$, $y(0)=1$, $y'(0)=0$
gives $Y(s) = (s-3)/[(s-2)(s-1)] = -1/(s-2) + 2/(s-1)$, so $y(t) = -e^{2t} + 2e^t$. ^[[sources/notion-353-course-improper-integral-laplace-transform]]

## Discontinuous forcing, convolution, impulses

Three tools handle the hard right-hand sides ^[[sources/notion-353-course-improper-integral-laplace-transform]]:

- **Unit step / time shift** — $\mathcal{L}\{u_c(t)f(t-c)\} = e^{-cs}F(s)$; an $e^{-cs}$ factor in
  $F(s)$ means a delayed signal. **s-axis translation**: $\mathcal{L}\{e^{at}f(t)\} = F(s-a)$.
- **Convolution** — the inverse of a *product* of transforms is not a product but a convolution:
  $\mathcal{L}^{-1}\{F(s)G(s)\} = (f*g)(t) = \int_0^t f(\tau)g(t-\tau)\,d\tau$. (This is the same
  convolution integral that appears in [[280]] signals & systems.)
- **Dirac delta** — an idealized impulse with $\int_0^\infty \delta_a(t)\,dt = 1$ and
  $\mathcal{L}\{\delta(t-a)\} = e^{-as}$, so $\mathcal{L}\{\delta(t)\} = 1$.

Part of [[353]] (Math 353). The worked arithmetic on this source is reliable; a few symbolic glitches
(a malformed $\mathcal{L}\{\cos t\}$, and the delta "sifting" property referenced but never stated)
are noted in [[contradictions]] and are not reproduced here.
