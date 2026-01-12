# Result Builders

I have starting getting my head around Swift result builders, and getting excited about their potential uses.

Links:
- https://docs.swift.org/compiler/documentation/diagnostics/result-builder-methods/
- "Write a DSL in Swift using result builders" — WWDC21

## buildBlock

The most fundamental part of a result builder:
```swift
static func buildBlock(_ components: Component...) -> Component { … }
```

Visualising how `buildBlock` works behind the scenes:

I haven't connected the dots in this way yet, so this is helpful. Seeing the way the child parts inside the `Example {…}` closure are *the* entities that are passed, one by one, to the variadic argument for `buildBlock`.

```
Example {
  let v0 = Thing("abc")
  let v1 = Thing("123")
  return ExampleBuilder.buildBlock(v0, v1)
}
```

```
Example {
  Thing("abc")
  Thing("123")
}
```

```swift
@resultBuilder
struct ExampleBuilder {
  static func buildBlock(_ components: [Component]...) -> [Component] {
    components...
  }
}

```

Tip: Modifier-style methods, such as `.padding()` below, actually end up changing the value of `Text("abc")` before the compiler sees it.

```
Text("abc")
  .padding(10)
```

They can also be composed together, or 'chained', to change the *previously* modified value, and so on.


> Tip: The value returned by `buildBlock`, is the value that gets returned by the closure

## buildOptional

Notes:
- An `if` statement without an `else` is not actually handled by the `buildEither` methods. It's processed by `buildOptional`
- This is because if the `if` returns `false`, that property will remain uninitialised. So the builder needs to know how to handle a `nil` value








## `buildBlock`
`buildBlock` stitches multiple expressions together (... arguments).

## `buildExpression`
This one seems important too, but interestingly it doesn't *have* to be part of a builder.

`buildExpression`s answer the question “How do I turn this thing into something that fits in your building pipeline?”.




/// Good to remember:
/// The `{Example}Builder` (the type decorated directly with
/// `@resultBuilder`), is not the right place to have various
/// parameters passed in, like a function would.
///
/// The place for this is on the *function or type* that *uses*
/// the builder. Such as the below `DisplayString`.
///
/// It accepts a parameter, `separator`, making this type
/// the place that can be configured. Not the builder itself.
/// ```
/// public struct DisplayString {
///   let content: [any StringRenderable]
///   let separator: String
///
///   public init(
///     separator: String = .defaultComponentSeparator,
///     @DisplayStringBuilder _ content: () -> [any StringRenderable]
///   ) {
///     self.separator = separator
///     self.content = content()
///   }
/// }
/// ```
