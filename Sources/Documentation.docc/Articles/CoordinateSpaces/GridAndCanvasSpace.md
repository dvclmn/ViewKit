# Coordinate Spaces
Moving between Grid, Canvas and Screen space

Both `CanvasGeometry` and `GridGeometry` conform to `CanvasViewportContext`, allowing them to provide a `CanvasViewportMapping` value.


Notes on `CanvasViewportMapping`:

- The user creates a document of `GridDimensions(width: 80, height: 40)`.
- You define a `GridProjection(cellSize: CGSize(width: 10, height: 18))`.
- You set up your `CanvasViewportMapping` where `canvasSize` is automatically
  calculated via `projection.canvasSize(for: dimensions)`.
- When a user taps the screen:
  - `CanvasViewportMapping` converts the screen tap `CGPoint` to a Canvas
    `CGPoint` (handling pan/zoom perfectly).
  - `GridProjection` converts that Canvas `CGPoint` into a Grid Point (Int, Int).
  - You now know exactly which ASCII cell they tapped, regardless of
    zoom level or pan translation!

Manages the continuous relationship between the Viewport and the Canvas.

Usage in a View/Gesture:
```
let tap = Point<ScreenSpace>(x: gesture.location.x, y: gesture.location.y)
let canvasPoint = viewport.convertToCanvas(tap)
let gridPos = projection.gridPosition(from: canvasPoint)
```

`gridPos` is now a pure (column, row) you can use to look up your ASCII character!

This is the successor of older `CoordinateSpaceContext`
