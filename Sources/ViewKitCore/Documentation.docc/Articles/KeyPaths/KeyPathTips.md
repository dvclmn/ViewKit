
https://www.swiftbysundell.com/tips/using-key-paths-in-switch-statements/
```swift
func ~=<T>(lhs: KeyPath<T, Bool>, rhs: T) -> Bool {
    rhs[keyPath: lhs]
}
```

