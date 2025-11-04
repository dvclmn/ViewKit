# Wrecktangle

Outline of types

Box
  GlyphSet
  GlyphType

GlyphMap

BoxPart
  PartType
    Join
    Corner
    Location


## Box Parts

```
┏━━━━
┃ ┌

```

```
┏━━
┃ ┌

```


## Lines

I've determined it's very important to distinguish between a Text line, and a Structure Line, because a Text Line *cannot* be represented by three `PartType`s alone. Text needs to be 'intercepted' and reflowed. And Structure Lines need to have their `body` PartType repeated as needed.

So `LineType` is neccesary to unify these two types of Lines. LineType is the return type for `@BoxBuilder` components. So that the output can be switched over, and handled as needed.



## Notes

Trying to improve how Boxes are constructed, and what the instructions for the Builder look like. Balancing delcarative, and imperative.

Repeating Parts Would be neat to create an API to provide a horizontal / vertical / either build block (`Part`), and have it be stitched together and repeated. Could make for some fun, even emergent frame styles.

Do I make the API *dimension-first*, where you can supply whatever construction of characters you, as long as the dimensions are correct (e.g. `1x2`, `4x5`, whatever). This provides perhaps more creative control, but places more responsibility on the theme designer, to get the parts matching up right. More user-error prone.

Or, make it more declarative, where you just supply a Theme or preferred pre-fabbed GlyphSet, with some other parameters, and you 'get what you get'?
