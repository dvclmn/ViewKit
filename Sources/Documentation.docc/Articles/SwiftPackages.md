# Swift Packages

A description

A handy tip for iterating over all targets, from  [useyourloaf](https://useyourloaf.com/blog/strict-concurrency-checking-in-swift-packages/):

```swift
for target in package.targets {
  var settings = target.swiftSettings ?? []
  settings.append(.enableExperimentalFeature("StrictConcurrency"))
  target.swiftSettings = settings
}
```
