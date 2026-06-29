The below is my best guess, would like to verify this a bit better tho.

Basic guide to intialising TextKit 1 text view:

```
class ExampleTextView: NSTextView {

  init() {

    let ts = NSTextStorage()
    let lm = BackingLayoutLegacy()
    let tc = NSTextContainer(size: .zero)

    lm.addTextContainer(tc)
    ts.addLayoutManager(lm)

    super.init(frame: .zero, textContainer: tc)
  }
}
```

And for TextKit 2:
```
class ExampleTextView: NSTextView {
  init() {
    
    let ts = NSTextContentStorage()
    let lm = BackingLayout()
    
    ts.addTextLayoutManager(lm)
    
    guard let tc = lm.textContainer else {
      fatalError("No text container for text view")
    }
    
    super.init(frame: .zero, textContainer: tc)
  }
}
```


