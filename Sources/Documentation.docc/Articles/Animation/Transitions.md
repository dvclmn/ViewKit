# Transitions

I always forget the order to apply things, to get View transitions to work.

It's animation on the top level, transition within.

```
VStack {
  Text("Hello")
  .transition(.opacity)
}
.animation(.default)
```


