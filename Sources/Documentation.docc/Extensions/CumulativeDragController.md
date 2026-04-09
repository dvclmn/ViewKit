
This controller manages the lifecycle of drag offset tracking, with axis constraints,
anchoring at drag start, and accumulation of translation deltas.


## Strategy Enum
- `external`: The controller accepts the current external offset at drag start and computes
  new offsets based on translation deltas. No internal state is owned.
- `internal(initial: CGSize)`: The controller owns the offset state starting from the given initial value,
  updating it internally during drag.


## Usage

Use the `begin(with:)` method at the start of a drag gesture to anchor the offset.
- For `.external` strategy, pass the current external offset as `currentExternalValue`.
- For `.internal` strategy, `currentExternalValue` is ignored.

Use the `update(translation:)` method to apply new translation deltas and get the updated offset.

Call `end()` to clear the anchor at the end of a drag.

If the external state jumps unexpectedly mid-drag in `.external` mode,
call `reanchor(to:)` to reset the anchor and avoid jumps.

In `.internal` mode, use `resetInternal(to:)` to replace the owned offset value,
optionally syncing the anchor if a drag is in progress.


## Axis Behaviour

The offset accumulation respects the configured `AxisMode`:
- `.both`: accumulate both width and height.
- `.horizontal`: accumulate only width, keep height fixed.
- `.vertical`: accumulate only height, keep width fixed.


## Notes

- This controller consolidates the behaviour of the previous separate trackers into one,
  enabling flexible ownership and better resilience to external state changes.
- When using `.external` mode, you must provide the current offset explicitly at drag start.
- Be mindful to call `reanchor(to:)` if the external model changes mid-gesture to prevent drift.


## Example Integration with SwiftUI Gesture:

```swift
@State private var offset: CGSize = .zero
@GestureState private var dragTranslation: CGSize = .zero

var body: some View {
  let dragController = CumulativeDragHandler(axisMode: .both, strategy: .external)
  let dragGesture = DragGesture()
    .onChanged { value in
      dragController.begin(with: offset)
      offset = dragController.update(translation: value.translation)
    }
    .onEnded { _ in
      dragController.end()
    }

  Rectangle()
    .offset(offset)
    .gesture(dragGesture)

```
