# GPU programming

Programming GPUs directly: compilation backends, cross-vendor intermediate
representations, and the capability gaps between graphics/compute APIs.

## Contents

- [Zig and GPUs (Ali Cheraghi)](/knowledge/SWE/gpu-programming/zig-gpu-backends.md) — Zig's two GPU compilation paths (a self-hosted SPIR-V backend for Vulkan/OpenCL, and an LLVM-based path to native PTX/AMDGCN), and the OpenCL-vs-Vulkan capability gaps — pointer casting between address spaces, correctly-rounded math — behind Vulkan's lower behavior-test pass rate.
