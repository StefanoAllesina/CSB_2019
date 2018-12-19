## Summary of Chapter 6

### Warmup exercise: bifurcation diagram

To work a bit with `numpy` and `scipy`, we're going to explore a simple model for population dynamics that however has an interesting behavior, the [logistic map](https://en.wikipedia.org/wiki/Logistic_map). See the nice paper by May ([Nature 1976](https://www.nature.com/articles/261459a0)).

The model is very simple, and is based on discrete dynamics:

<a href="https://www.codecogs.com/eqnedit.php?latex=x_{t&plus;1}&space;=&space;r&space;x_t&space;(1&space;-&space;x_t)" target="_blank"><img src="https://latex.codecogs.com/gif.latex?x_{t&plus;1}&space;=&space;r&space;x_t&space;(1&space;-&space;x_t)" title="x_{t+1} = r x_t (1 - x_t)" /></a>

With initial population size between 0 and 1. Importantly, depending on the parameter  *r*, the population can:

- go extinct
- reach a stable equilibrium
- cycle through a set of values
- display chaotic dynamics

Behavior:

- With *r* between 0 and 1, the population will eventually die, independent of the initial population.
- With *r* between 1 and 2, the population will quickly approach the value  *r−1/r*, independent of the initial population.
- With *r* between 2 and 3, the population will also eventually approach the same value *r−1/r*, but first will fluctuate around that value for some time.
- With *r* between 3 and  *1+sqrt(6)≃3.44949 * from almost all initial conditions the population will approach permanent oscillations between two values. These two values are dependent on *r*.
- With *r* between 3.44949 and 3.54409 (approximately), from almost all initial conditions the population will approach permanent oscillations among four values.
- With *r* increasing beyond 3.54409, from almost all initial conditions the population will approach oscillations among 8 values, then 16, 32, etc. The lengths of the parameter intervals that yield oscillations of a given length decrease rapidly.
- At  *r≃3.56995* we have the onset of chaos, at the end of the period-doubling cascade. From almost all initial conditions, we no longer see oscillations of finite period. Slight variations in the initial population yield dramatically different results over time, a prime characteristic of chaos.
- Most values of *r* beyond 3.56995 exhibit chaotic behaviour, but there are still certain isolated ranges of *r* that show non-chaotic behavior; these are sometimes called islands of stability. For instance, beginning at  *1 + sqrt(8)*  (approximately 3.82843) there is a range of parameters *r* that show oscillation among three values, and for slightly higher values of *r* oscillation among 6 values, then 12 etc.


1. Write code to project the population forward, tracking the population size at time t in the vector `x_t`. Include a parameter that allows to discard the first part of the time series, because we want to remove transient dynamics.

2. Write code to plot the time series (x-axis: time, y-axis: population size).

3. Use the following code to extract the inflection points (i.e., local maxima/minima) in the time series. Plot these values against the value of *r* used to generate the time series, obtaining a bifurcation diagram like


<img src="https://upload.wikimedia.org/wikipedia/commons/b/bd/Bifurcation_diagram_logistic_map_lambda_0_to_4.png" alt="image from the paper" width="500">

Code for extracting max/min:

```python
from scipy.signal import argrelextrema
def get_minmax(x_t):
    local_max = x_t[argrelextrema(x_t, np.greater)[0]]
    local_min = x_t[argrelextrema(x_t, np.less)[0]]
    return np.concatenate((local_max, local_min))
```

Here's a possible [solution](solutions/week5_lm)



