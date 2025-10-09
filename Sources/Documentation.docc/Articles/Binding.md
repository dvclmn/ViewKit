# Binding

I sometimes get confused on the 'direction of travel' for a Binding. Especially/mostly when creating a custom Binding.

Take the below example. This is a custom Binding for a SwiftUI `TextField`. I get stuck on; wait, what is the thing I am getting? Like, where from? 

Am I getting the string value that the user typed? From the `Textfield`? Or am I getting data from my store, and returning *that*?
```swift
  func cellBinding(id: Cell.ID) -> Binding<String> {
    Binding {
      return data[cellID: id]?.content.text

    } set: { newValue in
      // ...
    }
  }
```

Some notes on getting a hang of this.

- Main thing is not to duplicate State ownership. There should be only one source of truth

