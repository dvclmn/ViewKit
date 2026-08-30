# Info Bars

Collect lightweight status content from descendants and present it once at the bottom of a view hierarchy.

## Overview

Apply `infoBarView(isEnabled:)` as high in the hierarchy as participating views require. The presenter owns a stable registration store and supplies only that reference through the environment. Descendants register independently, so changing one value updates one InfoBar row without propagating a changing preference through the source tree or rebuilding every section.

For high-frequency text such as a pointer location, use `infoBarValue(_:label:isEnabled:format:)`:

```swift
CanvasView()
  .infoBarValue(
    pointerPosition,
    label: LabelDescriptor("Pointer", symbol: "cursorarrow.motionlines")
  ) { position in
    "x: \(position.x.formatted()), y: \(position.y.formatted())"
  }
  .infoBarView()
```

The value must be `Equatable`. InfoBar calls the formatter only when the value changes, preserves the row identity, and updates only the stored text payload. This produces an unsectioned item.

## Additional view content

Use the presenter’s leading and trailing content closures for richer SwiftUI content that doesn't fit the homogeneous `InfoBarItem` model. This content has a statically known view type and is rendered once at the corresponding end of the contributed item sequence; it isn't stored in `InfoBarStore` or available through descendant registration. Leading and trailing describe ordering within the same horizontally scrolling sequence, not content pinned to the physical edges of the bar.

```swift
CanvasView()
  .infoBarValue(pointerPosition, label: LabelDescriptor("Pointer")) { position in
    "x: \(position.x.formatted()), y: \(position.y.formatted())"
  }
  .infoBarView(
    leadingContent: {
      DocumentInfoBarPreset()
    },
    trailingContent: {
      ModifierKeysInfoBarPreset()
    }
  )
```

Leading and trailing content inherit environment values available where `infoBarView` is applied. Environment values installed only within a descendant don't flow upwards into the presenter; pass the required state explicitly, install the environment value above `infoBarView`, or let a reusable preset establish its own local observation.

## Sections

Use the section overload only when the item should be visibly grouped:

```swift
CanvasView()
  .infoBarValue(pointerPosition, label: LabelDescriptor("Pointer"), section: PointerSection.self) { position in
    "x: \(position.x.formatted()), y: \(position.y.formatted())"
  }
  .infoBarView()
```

Registrations form unsectioned and sectioned groups in the order each group first appears in the source hierarchy. Items inside a group retain registration order.

## Existing item descriptors

The existing `infoBarItems` overloads remain available and now use the same stable registration path. Their no-key overloads are unsectioned; item descriptors declare their section explicitly through `SectionKey`.

InfoBar uses direct stacks for its small, eager status layout. It intentionally does not use `DecomposedView`: decomposing sections and subviews adds dynamic traversal work that is unnecessary when the bar already has explicit section and item models.
