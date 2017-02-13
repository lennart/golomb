# golomb

create lists of numbers where each distance between two numbers appears only once.

These lists can be called [Golomb rulers](https://en.wikipedia.org/wiki/Golomb_ruler).

Note: these lists are neither _perfect_ nor _optimal_ Golomb rulers and this is intentional!

## Usage

```haskell
import Data.Golomb

golomb 128
```

will produce a ruler of length `128`.

You can also get a list of relative values from a given ruler:

```haskell
relativize $ golomb 128
```

which returns the same ruler, but all values range from `0.0` to `1.0`.

As a simple test you can also get a list of disjunct pairs with:

```haskell
disjunct $ golomb 128
```

and then calculate distances:

```haskell
distances $ disjunct $ golomb 128
```

which should be a list on unique values (no duplicates).

## Algorithm

The underlying algorithm is trivial.

for a given length of the ruler:

1. make a new ruler containing just the length as the last element
2. take the length and halve it
3. decrement by `1`
4. if the result is greater than `0`
  - add the value to the ruler
  - rerun algorithm with the new value
5. otherwise: add `0` to the ruler and stop

The result will pretty much resemble an exponential curve,
since we are halving each loop (boring).

However, this should be fast.
