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
