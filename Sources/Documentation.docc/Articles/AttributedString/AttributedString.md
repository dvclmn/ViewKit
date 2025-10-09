# AttributedString


Anatomy
- String: The raw text content
- Attributes: Style metadata attached to ranges of that text
- Runs: Contiguous ranges where attributes don't change

## Replace attributes
Handy way to replace a kind of attribute(s) with another
https://forums.swift.org/t/attributedstring-it-s-a-string-a-range-a-dictionary-to-allow-type-safe-access-of-attributes-but-i-m-having-a-hard-time-understanding-how-to-access-with-what-address-index/76204/14
```
attrString.replaceAttributes(
    AttributeContainer
      .measurement(.value)
      .numberSymbol(.decimalSeparator),
    with: AttributeContainer.foregroundColor(.blue)
  )
)
```


## Transform attributes

```
attrString.transformingAttributes(\.numberSymbol, \.measurement, \.numberPart, \.foregroundColor) {
    $3.value = if $0.value == .decimalSeparator {
        .green
    } else if $1.value == .unit {
        .orange
    } else if $2.value == .fraction {
        .blue
    } else {
        nil
    }
}
```

## Runs
A "run" is just a continuous stretch of text where nothing changes about the styling. When any attribute changes (color, font, size, etc.), that's where one run ends and the next begins.

Instead of Swift checking every single character's attributes individually (which would be slow and tedious), it groups consecutive characters with identical attributes together. This is much more efficient!

For example, if you have "Hello World" where "Hello World" is all bold, that's just ONE run with the attribute "bold" applied to all 11 characters, rather than 11 separate characters each marked as bold.

```
var copy = attrString
attrString.runs.forEach { run in
    if run.measurement == .unit {
        var attributes = run.attributes
        attributes.merge(AttributeContainer([NSAttributedString.Key.foregroundColor : NSColor.orange]))
        copy[run.range].setAttributes(attributes)
    }
}
return copy
```



```swift
let attributedString: AttributedString = {
var result = AttributedString("Hello ")
result.foregroundColor = .black

var world = AttributedString("World")
world.foregroundColor = .red
world.font = .boldSystemFont(ofSize: 20)
result.append(world)

return result
}()

// Examine runs
for run in attributedString.runs {
print("Run text: \(attributedString[run.range])")
print("Attributes: \(run.attributes)")
print("---")
}
```



## Ranges

```swift
let string = "Hello, World!"
let attributedString = AttributedString(string)

// Different range types
let stringRange: Range<String.Index> = string.range(of: "World")!
let attributedRange: Range<AttributedString.Index> = attributedString.range(of: "World")!

// Conversions
let fromStringRange = Range(attributedRange, in: string)
let fromAttributedRange = Range(stringRange, in: attributedString)
```

## Regex — pattern matching

Regex.Match.range is Your Friend

When using regex with `AttributedString`, the match's range property gives you the exact `Range<AttributedString.Index>` you need for attribute application.

```swift
let text = "Call me at 555-1234 or 555-5678"
var attributedString = AttributedString(text)

// Find phone numbers
let phonePattern = #"\d{3}-\d{4}"# 
let regex = try! Regex(phonePattern)

for match in attributedString.matches(of: regex) {
let matchRange = match.range  // Range<AttributedString.Index>

// Apply attributes to the matched range
attributedString[matchRange].foregroundColor = .blue
attributedString[matchRange].font = .boldSystemFont(ofSize: 16)
}
```


Un-checked example from DeepMind:
```swift
func createStyledText() -> AttributedString {
let markdownText = """
# Welcome
This is *important* text with a [link](https://example.com).
Contact: john@example.com or call 555-0123.
"""

var attributedString = AttributedString(markdownText)

// Style headings (lines starting with #)
let headingRegex = try! Regex("^# .*$", options: .anchorsMatchLines)
for match in attributedString.matches(of: headingRegex) {
attributedString[match.range].font = .systemFont(ofSize: 24, weight: .bold)
attributedString[match.range].foregroundColor = .purple
}

// Style emphasized text (*text*)
let emphasisRegex = try! Regex("\\*[^*]+\\*")
for match in attributedString.matches(of: emphasisRegex) {
// Adjust range to exclude the asterisks
let contentRange = attributedString.index(after: match.range.lowerBound)..<attributedString.index(before: match.range.upperBound)
attributedString[contentRange].font = .italicSystemFont(ofSize: 16)
}

return attributedString
}
```


