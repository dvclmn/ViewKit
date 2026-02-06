I've often found it useful to have deterministic and cachable randomisation, so that e.g. SwiftUI state changes don't cause unintended regeneration of randomised values.


# Migration

I recently refactored this domain, and found it complex to migrate. Notes below


## Old shape
- RandomisationParameters<T> with:
  - ranges: [ClosedRange<T>] or sometimes a single range
  - additionalParams: [String: AnyHashable]
- Call sites often accessed parameters​.additional​Params["key"] and ranges directly.

## New shape
- RandomisationSpec<T> (aliased to RandomisationParameters<T> for migration)
- domain: RandomDomain<T>
  - .single(ClosedRange<T>) or .multiple([ClosedRange<T>])
  - Access via spec​.domain​.ranges
- influences: [AnyInfluenceKey: AnyHashable]
  - Typed accessors via spec​.influence(for: ​Influence​Key​<​Value>)
  - Extensible, type-safe keys

Why it’s better
- Domain is explicit and can represent disjoint ranges.
- Influences are type-safe and discoverable (no stringly-typed bags).
- Call sites can define keys without central coordination.

## Migrating from `RandomisationParameters<T>` to `RandomisationSpec<T>`

### 1) Type naming and property alignment
Replace direct usage of bounds or ranges fields:
• Legacy: parameters​.ranges or parameters​.bounds​.ranges
• New: parameters​.domain​.ranges
• Example change (ActionLinesHandler):
• Before:

```
let rangesComponent = parameters.bounds.ranges
```

```
let rangesComponent = parameters.domain.ranges
```


When constructing a spec:
• Before:
```
RandomisationParameters(bounds: .multiple([0.0...(2.0 * .pi)]), influences: [:])
```

After:
```
RandomisationParameters(domain: .multiple([0.0...(2.0 * .pi)]), influences: [:])
```

Or:
```
RandomisationParameters(ranges: [0.0...(2.0 * .pi)])
```


### 2) Replace additionalParams reads with typed influences

Old:
```
let roughness = parameters.additionalParams["roughness"] as? CGFloat ?? 10
```

New:

```
// Define canonical keys once (recommended)
extension InfluenceKey where Value == CGFloat {
  public static var roughness: InfluenceKey<CGFloat> { "roughness" }
  public static var jitter: InfluenceKey<CGFloat> { "jitter" }
}

// Use them:
let roughness: CGFloat = parameters.influence(for: .roughness) ?? 10
let jitter: CGFloat = parameters.influence(for: .jitter) ?? 1.0
```

• If you need compatibility with call sites that might still pass Double influences:
```
let roughness: CGFloat =
parameters.influence(for: .roughness)
?? parameters.influence(for: InfluenceKey<Double>("roughness")).map(CGFloat.init)
?? 10
```
Important: do not expect a property named additionalParams on the new spec. Use influence(for:).

3) Update RandomGeneratable defaults

• Keep the protocol signature as-is (thanks to the typealias):

```
static func generate(
  count: Int,
  using generator: inout any RandomNumberGenerator,
  parameters: RandomisationParameters<Value>
) -> Self
```
• Provide a modern convenience overload if you like:

```
public extension RandomGeneratable {
  static func generate(
    count: Int,
    using generator: inout any RandomNumberGenerator,
    spec: RandomisationSpec<Value>
  ) -> Self {
    generate(count: count, using: &generator, parameters: spec)
  }
}
```


• Default implementation for numeric Value types should use the new domain:
                                ```
                                extension RandomGeneratable where Value.RawSignificand: FixedWidthInteger {
  public static func generate(
    count: Int,
    using generator: inout RandomNumberGenerator,
    parameters: RandomisationParameters<Value>
  ) -> Value {
    guard let range = parameters.domain.ranges.first else { return 0 }
    return Value.random(in: range, using: &generator)
  }
}
```


