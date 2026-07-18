---
kind: concept
domain: projects
title: Neural network quantization
course: "hw-cnn-accelerator"
---

# Neural network quantization

To run a neural network on integer hardware, its floating-point weights and activations must be
**quantized** to fixed-width integers. The scheme is often forced by what the datapath can represent,
not chosen for convenience — in [[hw-cnn-accelerator]] the processing element is a pure signed
int8×int8→int32 [[binary-multiplication|MAC]] ([[twos-complement-arithmetic]]) with no zero-point or
bias-add path, which dictates every choice below. ^[[sources/repos-hw-cnn-decisions]]

## Symmetric, per-tensor, zero-point-zero

Because there is no zero-point datapath, quantization must be **symmetric affine with zero-point 0**:

$$s_X = \frac{\max|X|}{127}, \qquad q_X = \text{clip}\!\left(\text{round}(X/s_X),\, -128,\, 127\right)$$

Asymmetric quantization (a nonzero zero-point) simply can't be represented. For the same reason the
trained model uses **no bias and no BatchNorm** — `pe.v` has no add-constant path, so a bias literally
cannot exist in the hardware. ^[[sources/repos-hw-cnn-decisions]]

## Requantization and argmax invariance

Between layers, an int32 accumulator must be rescaled back to int8. With per-tensor scales this is one
positive multiplier $M_1 = (s_\text{in} s_{W1})/s_\text{hidden}$, and applying ReLU on the int32
accumulator *before* scaling is exact because $M_1 > 0$ commutes with ReLU. The **final layer needs no
requantization at all**: dequantizing is multiplication by a single positive scalar
$s_\text{hidden}s_{W2}$ that is identical for every output, so $\arg\max$ over the raw int32 logits
equals $\arg\max$ over the dequantized floats — the hardware output is used as-is. ^[[sources/repos-hw-cnn-decisions]]

The key discipline: choose the quantization scheme the hardware can compute *exactly*, so the test
oracle is bit-exact integer arithmetic rather than an approximation with tolerance.

Part of [[hw-cnn-accelerator]]. Feeds the operands consumed by [[systolic-array-dataflow]]; grounded in
[[twos-complement-arithmetic]].
