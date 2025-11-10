# ``FrameStyle``

Defines the structural layout of a box’s frame, describing how parts
such as corners, edges, and joins are composed.

A `FrameStyle` maps each `PartType` (e.g. `.horizontal(.top)`, `.corner(.topLeading)`)
to a `Part`, which in turn describes the glyphs that make up that section.

Styles can be combined using `merged(overrides:)`, where parts defined in
the overrides map replace existing definitions with matching `PartType` keys.

This enables layered construction of complex frame styles:

```swift
public static var double: FrameStyle {
    Frame {
        Part(.horizontal(.top)) {
            Row { GlyphType.h(.increased) }
            Row { GlyphType.h(.standard) }
        }
    }
    .merged(overrides: Box.JoinType.doubleJoin.parts)
    .merged(overrides: Box.CornerType.doubleCorner.parts)
}
```

Unlike `GlyphSet`, frame styles are merged *eagerly*: the result of merging
produces a new, flattened `FrameStyle` with no retained reference to its
predecessors.

