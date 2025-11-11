# @TaskLocal

Context: ``Wrecktangle``
 This allows the leaving off of the `Box.GlyphType.join`'s
 `Box.JoinType`, when declared in a `Part` builder closure.
 For cleaner syntax.

 Previously, the join type needed to be redundantly repeated, both
 in the Part init, and the Glyph definition, as below:
 ```
 Part(.join(.leading)) {
   Glyph.join(x: .increased, y: .standard, type: .leading)
 }
 ```
 Now, using `PartContext` and `Box/GlyphType/join(x:y:)`
 (the static property, not the enum case), I can omit the `type:`
 argument, and the Part/Glyph join type is still correctly passed through.
 ```
 Part(.join(.leading)) {
   Glyph.join(x: .increased, y: .standard)
 }
 ```
