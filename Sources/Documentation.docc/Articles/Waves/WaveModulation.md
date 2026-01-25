
## Normalised Index
Compute the modulation value given the current time and a normalised index
E.g if your property should vary by a sine wave that travels
over time while also spanning a fixed number of cycles over your circles,
you can use this value directly.

## More on `normalisedIndex`
A normalised index is not time — it is space / structure

Multiplying it by cycles answers this:
"Across this domain, how many full oscillations should exist?"

Depending on context, a `normalisedIndex` could be:
- the index of a circle in a row of circles
- the x-position of a point across a width
- the progress along a path
- a radial distance normalised to a maximum
- a vertex index in a mesh

- Parameters:
  - effectiveTime: A consistent elapsed time value
  - normalisedIndex: A position along some domain, scaled into [0, 1]
  - cycles: <#cycles description#>
- Returns: <#description#>
