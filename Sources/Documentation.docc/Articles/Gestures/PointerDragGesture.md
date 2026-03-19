# PointerDragModifier

A unified view modifier that handles tap and drag gestures together.

Supports three drag modes via ``DragBehavior``:
- Marquee: draws a transient selection rect, cleared on drag end.
- Continuous: accumulates offset across drags (suitable for panning).
- None: drag is disabled; tap-only.

# Ownership modes

## Mode A — Binding (simple)
```swift
.onPointerDragGesture(rect: $dragRect, behaviour: .marquee)
```
The modifier owns the gesture math and writes the result directly to the
binding. No event callback — the binding is the single source of truth.
External changes to the binding are automatically picked up between
gestures (e.g. a reset button clearing the offset).

## Mode B — Event callback (advanced)
```swift
.onPointerDragGesture(behaviour: .marquee) { event, phase in ... }
```
The modifier tracks state internally, but the **caller** receives raw
``DragGestureEvent`` values to route through their own pipeline (e.g.
tool resolution in CanvasKit). The modifier still handles marquee
drawing via its own internal rect.

To keep the modifier in sync with external state changes (e.g. scroll
wheel, programmatic pan), pass the external value via `observing:`:
```swift
.pointerDragGesture(
    observing: $interactionState.dragRect,
    behaviour: .continuous
) { event, phase in
    interactionState.handleInput(...)
}
```
The modifier reads this binding for sync but **never writes** to it,
preventing double-writes. The callback is the sole output channel.

> Important: Do **not** combine a writable binding (Mode A) with an
> event callback (Mode B). That creates two writers for the same value.
> Use Mode A *or* Mode B, not both.

# External mutation support

Both modes handle external mutations to the drag value. When code
outside the modifier changes the value (reset button, scroll gesture,
programmatic pan), the modifier detects the change and updates its
internal baseline. This ensures the next drag gesture starts from the
correct position rather than a stale internal value.

The sync only occurs when the modifier is **not** actively gesturing,
to avoid fighting with the live gesture.
