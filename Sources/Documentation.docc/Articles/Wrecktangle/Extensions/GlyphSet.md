# GlyphSet

A collection of character glyphs used to render box components, such as
corners, edges, and joins.

A `GlyphSet` defines a mapping between each `GlyphType.Role` and a concrete
character (or sequence of characters) used for rendering that role.

There are two main usage modes:

1. **Exhaustive Sets**
   - Define all required glyphs directly.
   - No fallback is used.
   - Example: `.sharp`

2. **Override Sets**
   - Define only the subset of glyphs that differ from a base style.
   - Any missing glyphs are resolved through the `fallback` chain.
   - Example: `.rounded` may override only the corner glyphs from `.sharp`.

### Example
```swift
public static var rounded: GlyphSet {
    GlyphSet(fallback: .sharp) {
        Glyph("╭", .corner(.topLeading))
        Glyph("╮", .corner(.topTrailing))
        Glyph("╰", .corner(.bottomLeading))
        Glyph("╯", .corner(.bottomTrailing))
    }
}
```

When resolving a glyph, lookups first consult this set’s `map`.  
If no entry is found, resolution continues recursively through the
optional `fallback` chain.
