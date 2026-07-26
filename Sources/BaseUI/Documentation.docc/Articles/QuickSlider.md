# QuickSlider

`QuickSlider` is BaseUI's labelled numeric-control surface. It adds a
consistent label, formatted value, help text, reset affordances, and optional
stepper to the platform slider that performs the actual interaction.

The control intentionally prefers the platform implementation. It does not
replace a native slider merely to draw a different track.

## Choose a route

The initialiser, rather than a late style modifier, selects the control route.

| Call site | macOS route | iOS route |
| --- | --- | --- |
| `QuickSlider(_:value:range:step:neutralValue:)` | SwiftUI `Slider` | SwiftUI `Slider` |
| `QuickSlider(_:intValue:range:step:)` | SwiftUI `Slider` | SwiftUI `Slider` |
| `QuickSlider(_:value:range:trackStyle:)` | `AppKitSlider` through `NSViewRepresentable` | Unavailable |

The standard `Double` initialiser is the normal choice. On macOS and iOS 26 or
later, its `neutralValue` is forwarded to SwiftUI's native slider API. The
`Int` initialiser always uses a discrete step: an omitted `step` means one
integer, and write-back rounds the temporary `Double` representation before
updating the integer binding.

The custom-track initialiser is compiled only for macOS and requires an
``AppKitSliderTrackStyle``. It gives AppKit responsibility for interaction,
keyboard handling, accessibility, and native thumb appearance while BaseUI
draws only the track recipe.

```swift
#if os(macOS)
struct TemperatureTrack: AppKitSliderTrackStyle {
  func makeAppKitTrack(configuration: Configuration) -> AppKitSliderTrack {
    .linearGradient([
      .init(red: 0.15, green: 0.45, blue: 0.95),
      .init(red: 0.98, green: 0.30, blue: 0.18),
    ])
  }
}

QuickSlider(
  "Temperature",
  value: $temperature,
  range: -1...1,
  trackStyle: TemperatureTrack(),
)
#endif
```

There is intentionally no SwiftUI custom-track fallback on iOS. Until BaseUI
gains a UIKit counterpart to the AppKit bridge, custom colour controls use the
native slider there. This prevents an older gesture-driven implementation from
silently becoming the iOS product behaviour.

## Compose the surrounding presentation

Use ``SliderGroup`` to align adjacent QuickSlider labels, controls, and
formatted values in a `Grid`. The following modifiers control the shared
presentation surface:

- `sliderComponents(_:)` shows or hides the label, help text, and formatted
  value. For an AppKit custom track, it can also independently show the track
  and native thumb. A SwiftUI `Slider` is an opaque native control, so those
  two options do not remove its internal track or thumb.
- `sliderMaxWidth(_:)` limits the central control without constraining the
  label or value column.
- `stepStyle(_:)` leaves the native stepped slider alone or adds a linked
  native `Stepper` when the slider has a step.
- `sliderDefaultValue` remains an environment value for the double-click reset
  and the formatted-value context menu. It is distinct from `neutralValue`:
  the former is BaseUI's reset value; the latter is SwiftUI's semantic marker.

## Understand the handler lifecycle

Each `QuickSlider` keeps one internal `SliderHandler` in `@State`. It owns only
the transient ``SliderPhase`` (`dragging` or `idle`) for that SwiftUI view
identity. A direct pointer or keyboard edit changes the phase and invokes the
current `didChangeSlider` closure once per transition.

The handler does not own the bound value, range, label, step, custom track, or
callback. Those remain immutable inputs on the current `QuickSlider` view
value and are passed explicitly to the child views. This separation matters:
SwiftUI may recreate a view struct many times while retaining its `@State`; a
handler that captured presentation configuration during its original
initialisation would otherwise continue to use stale inputs.

Changing the slider's SwiftUI identity—for example, by adding a changing
`.id(...)`—creates a new handler and resets its editing phase. Treat that as a
genuine lifetime change, not as a redraw mechanism.

## Work with SwiftUI diffing and the AppKit bridge

For the standard route, SwiftUI diffs the native `Slider` like any other view.
For the macOS custom route, SwiftUI creates the `NSView` once for a stable
identity, then calls `updateNSView` with current values. `AppKitSlider` refreshes
its coordinator's binding and callback each update, compares scalar and track
properties before invalidating display, and leaves layout to SwiftUI.

Keep custom styles cheap and pure. `makeAppKitTrack(configuration:)` may run
during normal value or environment updates, so build a small drawing recipe;
do not perform file I/O, networking, expensive image processing, or use a
changing `.id(...)` to force refreshes. If an interaction is slow, profile the
view body and representable-update lanes in the SwiftUI Instruments template
before adding caching or invalidation workarounds.

## Migration from the retired SwiftUI custom slider

`QuickSlider.SliderCustom`, the generic SwiftUI `SliderTrackStyle` route, the
custom `track:` initialiser, and `.sliderTrackStyle(...)` have been removed.
The modifier previously only wrote an environment value that QuickSlider did
not consume, so it never selected a visible style. Migrate supported macOS
custom tracks to ``AppKitSliderTrackStyle`` and guard those call sites with
`#if os(macOS)` when they live in cross-platform source.
