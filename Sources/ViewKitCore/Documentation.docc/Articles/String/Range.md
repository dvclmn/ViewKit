Possibly helpful notes:
Source - https://stackoverflow.com/a
Posted by Sulthan, modified by community. See post 'Timeline' for change history
Retrieved 2025-12-21, License - CC BY-SA 4.0

```swift
let text = "abc"
let index2 = text.index(text.startIndex, offsetBy: 2) //will call succ 2 times
let lastChar: Character = text[index2] //now we can index!

let range: Range<String.Index> = text.range(of: "b")!
let index: Int = text.distance(from: text.startIndex, to: range.lowerBound)

```
