# evolutionary-computation

Genetic algorithms, evolution strategies, and other population/distribution-based
search methods, and their use inside or alongside machine-learning systems.

## Contents

- [Inference-time alignment of diffusion models via evolutionary algorithms](/knowledge/machine-learning/evolutionary-computation/inference-time-diffusion-alignment-via-evolutionary-algorithms.md) —
  searches a diffusion model's latent noise (or an orthonormal rotation of it)
  with genetic algorithms and evolution strategies to align outputs with a
  reward objective at inference time, without gradients or fine-tuning
  `em:da2ffb` _(reference)_
- [Evolutionary search in a diffusion model's latent space](/knowledge/machine-learning/evolutionary-computation/evolutionary-search-in-latent-space.md) —
  five draggable widgets over the paper above: the Gaussian shell, why rotation
  is the safe transform, why crossover preserves the distribution, how selection
  pressure collapses a population, and reward as a dot product `em:70f026`
  _(visualization — launches `evolutionary-search-in-latent-space.html`)_
