# This is the beginning of a **really long** heading so i can see what it does
## Second heading
### Third heading yay

I will build a library of `Message` objects, as `[String]`, and can ~~you write~~ me up a *function* that simply selects one of the **paragraphs** (i.e. items in the array), and ==highlights== it? Also, we need some ***extra emphasis*** on this text.

```swift
let highlightr = Highlightr()
let backticks = "```"
highlightr?.setTheme(to: "xcode-dark-butts")
```

 - I `think this is something` worth thinking about in the context of all tooling we use. 
- If I do my job correctly with the IDE, you shouldn't be thinking about much outside of the program you're writing. 

***

---

- The goal is to keep you focused, so you never have to stop and reach for the documentation of the IDE, or Zig itself. Based on what you're doing

- [x] Finish my changes
- [ ] Push my commits to GitHub
- [ ] Open a pull request
- [x] @mentions, #refs, [links](), **formatting**, and <del>tags</del> supported
- [x] list syntax required (any unordered or ordered list supported)
- [ ] this is a complete item
- [ ] this is an incomplete item

1. First, calculate the available width:

 ```swift
 let availableWidth = self.windowSize.size.width - AppHandler.windowSizeBuffer
 ```

2. Define helper properties for panel widths:

```swift
var sidebarWidth: Double {
sidebar.isEnabled ? sidebar.width : 0
}

var inspectorWidth: Double {
inspector.isEnabled ? inspector.width : 0
}
```

3. Calculate if there's room for content and each panel:

```swift
let roomForContent = availableWidth >= AppHandler.contentMinWidth
let roomForSidebar = availableWidth >= (AppHandler.contentMinWidth + sidebarWidth)
let roomForInspector = availableWidth >= (AppHandler.contentMinWidth + inspectorWidth)
let roomForBoth = availableWidth >= (AppHandler.contentMinWidth + sidebarWidth + inspectorWidth)
```

I think this is something worth thinking about in the context of all tooling we use. If I do my job correctly with the IDE, you shouldn't be thinking about much outside of the program you're writing. The goal is to keep you focused, so you never have to stop and reach for the documentation of the IDE, or Zig itself. Based on what you're doing, all information should be right in front of you, or a click/hotkey away if it is too intrusive to display inline. Little sidequests to find what arguments a function takes, lookup a hotkey, etc., should be kept to a minimum. I'll be keeping this in mind as I work on the IDE.

## And then this heading
And some more words here. If you would like to contribute to the development of Highlightr, please follow the guidelines outlined in the CONTRIBUTING.md file in the GitHub repository.

```swift
# Python program to find the sum of natural using recursive function

def recur_sum(n):
   if n <= 1:
       return n
   else:
       return n + recur_sum(n-1)

# change this value for a different result
num = 16

if num < 0:
   print("Enter a positive number")
else:
   print("The sum is",recur_sum(num))
```

As well as some text down here.

And some here just in case

```
func updateNSView(_ nsView: NSTextView, context: Context) {
    nsView.textStorage?.setAttributedString(text)
}
```

# This is the beginning of a really long heading so i can see what it does
## First, a message
### And a third, a header that's small



I will build a library of `Message` objects, as `[String]`, and can ~~you write~~ me up a *function* that simply selects one of the **paragraphs** (i.e. items in the array), and returns it? Also, we need some ***extra emphasis*** on this text.



As well as some text down here.

And some here just in case
I will build a library of `Message` objects, as `[String]`, and can ~~you write~~ me up a *function* that simply selects one of the **paragraphs** (i.e. items in the array), and returns it? Also, we need some ***extra emphasis*** on this text.

```
func updateNSView(_ nsView: NSTextView, context: Context) {
    nsView.textStorage?.setAttributedString(text)
}
```

As well as some text down here.

And some here just in case

I will build a library of `Message` objects, as `[String]`, and can ~~you write~~ me up a *function* that simply selects one of the **paragraphs** (i.e. items in the array), and returns it? Also, we need some ***extra emphasis*** on this text.
