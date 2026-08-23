# Info Bars

Collect lightweight status content from descendants and present it once at the bottom of a view hierarchy.

## Overview

Apply `infoBarView(isEnabled:)` as high in the hierarchy as participating views require. The presenter owns a stable registration store and supplies only that reference through the environment. Descendants register independently, so changing one value updates one InfoBar row without propagating a changing preference through the source tree or rebuilding every section.

For high-frequency text such as a pointer location, use `infoBarValue(_:label:section:isEnabled:format:)`:

```swift
CanvasView()
  .infoBarValue(
    pointerPosition,
    label: LabelDescriptor("Pointer", symbol: "cursorarrow.motionlines"),
    section: PointerSection.self
  ) { position in
    "x: \(position.x.formatted()), y: \(position.y.formatted())"
  }
  .infoBarView()
```

The value must be `Equatable`. InfoBar calls the formatter only when the value changes, preserves the row identity, and updates only the stored text payload.

## Rich content

Use `infoBarItem(_:section:isEnabled:content:)` for arbitrary SwiftUI content:

```swift
DocumentView()
  .infoBarItem(syncState, section: DocumentSection.self) { state in
    HStack(spacing: 4) {
      ProgressView()
        .controlSize(.small)
      Text(state.message)
      Button("Cancel", action: state.cancel)
    }
  }
  .infoBarView()
```

The closure uses SwiftUI's `ContentBuilder`, which is an alias for `ViewBuilder`. The builder provides familiar heterogeneous view composition; the environment-backed store, rather than the builder itself, performs descendant registration.

Include every parent-owned input that affects the item in the equatable value. The no-value `infoBarItem(section:isEnabled:content:)` overload is for static content or a child view that observes its own binding or `@Observable` model.

Rich content is type-erased only at the individual registration boundary. This is a deliberate trade-off: heterogeneous items can share one store while an update remains isolated to the affected row.

## Existing item descriptors

The existing `addInfoBarItems` overloads remain available and now use the same stable registration path. `InfoBarKey` remains as a compatibility bridge for clients that emit the preference directly, but new code should use registration APIs because direct preferences still require SwiftUI to aggregate values through the ancestor chain.

InfoBar uses direct stacks for its small, eager status layout. It intentionally does not use `DecomposedView`: decomposing sections and subviews adds dynamic traversal work that is unnecessary when the bar already has explicit section and item models.
