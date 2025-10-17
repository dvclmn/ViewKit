# Macros

Some macros

## `@SetOfOptions`

Useful to remember:
- Adds `OptionSet` conformance to the *struct*, not the enum
- That's why the cases don't conflict with the `OptionSet` static properties


```swift
@SetOfOptions<Int>
struct ShippingOptions {
  enum Options: Int {
    case nextDay
    case secondDay
    case priority
    case standard
  }
}
```


