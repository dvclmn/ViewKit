
Example:

```
@State private var numberFormatter: NumberFormatter = {
  var nf = NumberFormatter()
  nf.numberStyle = .decimal
  return nf
}()
```


