# Pipeline

An example of a single Line's journey:

Box Builder > Box Component > LineType > `StringStack` > 




The `@BoxBuilder` accepts Box Components, which are required to provide an array of `LineTypes`, as their output.


A `GlyphType` describes a single `Character`.
A `PartType` describes a composition of `GlyphTypes`, like a Tile.

A `GlyphType` must consult a `GlyphSet` (via Dictionary lookup) to obtain a Character. The user can select different GlyphSets to customise the Box appearance.

Currently, a Box is expressed and rendered line-by-line, using a simple result builder DSL.


1. A PartType asks each of its GlyphTypes to resolve and provide their Character, based on the selected GlyphSet.

2. For a period of time, a PartType can be expressed as 

How do I figure out `GlyphStack`  `StringStack` -> `String`
