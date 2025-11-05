# Types
An overview of Wrecktangles main Types and their roles.


| Type | Shape | Output | Notes |
| ---- | ----- | ------ | ----- |
| Box | Uses the `@BoxBuilder` builder to give Box it’s components   | Combines multiple `Line`s into single final `AttributedString` |                                                              |
| Line | Describes 3 PartTypes, where 1 and 3 are usually fixed-width, and 2 is either text, or a repeated character, dynamically fitted to the Box width | Produces a flattened `AttributedString` for each Line        | Built from `StringStack` joining logic                       |
| PartType | A composite of `GlyphType`s, describing similar usage purpose to `GlyphType` | Produces `GlyphStack` for a Part                             | Useful for describing how glyphs should be joined together to achieve a specific structure. Does not care about specific glyphs, just GlyphTypes. |
| GlyphType   | enum describing a single `Character`, for the purpose of: horizontal/vertical, join, corner, etc. | Output should be a single `Character`?                       | Useful for describing a Glyph’s *purpose*, without dictating it’s actual style, aka which specific Unicode glyph to use. |
| Theme | Holds onto `FrameStyle`, the `GlyphSet` to use, and Box Padding | | |
| StringStack | Holds onto 2D grid of characters: `[[Character]]`            | Outputs single`AttributedString`                             | API to join stacks/grids of characters into lines of text — padded with whitespace where required |
| GlyphStack  | Typealias for 2D grid of `GlyphType`:`[[GlyphType]]`         |                                                              |                                                              |




