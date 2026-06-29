Understanding the Types
To demystify the docs:

`AnyCasePath<Root, Value>`: Type-erased case path - the workhorse type that actually does the embed/extract operations
`CaseKeyPath<Root, Value>`: Just a typealias for `KeyPath<Case<Root>, Case<Value>>` - this is what `\.wave` produces
`Case<T>`: A phantom wrapper type used by the key path system (you never construct it directly)

When you write `\.wave`:

Swift sees it as a key path to the Cases namespace: `\LineShape.Cases.wave`
This has type `CaseKeyPath<LineShape, Int>` (which is really `KeyPath<Case<LineShape>, Case<Int>>`)
`AnyCasePath.init(_: CaseKeyPath)` converts it to the runtime representation

The .init() you had to add was making the AnyCasePath initializer explicit. The fix above makes it happen automatically in the method signature.
