

## Parts

A `PartType` is a composition of `GlyphType`s. See ``Box/GlyphType``. 
`PartType` describes a stack of multiple Characters, and a `GlyphType` describes a *single* character.
See also ``Box/GlyphStack``, the output type for `PartType`

Example:
```
// A 3x2 Corner
┏━━
┃ ┌


// A 3x1 Trailing Join
┤ ║

```
Note: these are not visual/styling presets. They are more from the fabrication perspective. This many by this many, or something. No 'this fun glyph', and this one, and so on.

### Flexibility

/// Describes whether this Part be repeated dynamically
/// along a given Axis. Or whether it is single-use, in a
/// specific location in a structure.
///
/// In future, I think the code should establish how
/// long the repeatable `Part` is (along the relevant axis),
/// and thus how the fitting should be calculated, given
/// the available box width/height.

### Location

/// This introduces the concept of *valid orientation*;
/// for the top of a Box, the Part must be constructed with
/// the strong glyph at the top, and the light glyph at the bottom,
/// according to the intent of the Theme.
///
/// For the bottom of a frame, the light is top, and the strong
/// is bottom, and so on for walls etc.
///
/// For example, a Theme may define a double-walled frame
/// with contrasting weights for each wall character, like the below,
/// where the top is strong, and the 'interior' is lighter.
///
/// ```
///   ━━━━
///   ────
///
/// ```
