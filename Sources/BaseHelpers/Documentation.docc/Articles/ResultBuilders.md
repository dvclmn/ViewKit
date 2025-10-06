# Result Builders

I have starting getting my head around Swift result builders, and getting excited about their potential uses.

Links:
- https://docs.swift.org/compiler/documentation/diagnostics/result-builder-methods/
- 

The most fundamental part of a result builder:
```swift
static func buildBlock(_ components: Component...) -> Component { ... }
```

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
///   let content: [any StringConvertible]
///   let separator: String
///
///   public init(
///     separator: String = .defaultComponentSeparator,
///     @DisplayStringBuilder _ content: () -> [any StringConvertible]
///   ) {
///     self.separator = separator
///     self.content = content()
///   }
/// }
/// ```
