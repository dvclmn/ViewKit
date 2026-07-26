# ``BaseUI``

Reusable SwiftUI components for macOS and iOS apps.

## Overview

``CardGrid`` displays labelled items as adaptive cards. Supply `data` for an
ungrouped grid, or use its typed `groupedBy` initialiser for small, stable
collections.

For dynamic or expensive grouping, prepare ``CardGridSection`` values when the
source collection changes, then initialise the grid with `sections`. This keeps
grouping work out of the grid's SwiftUI body while preserving a stable,
caller-defined section order.

## Topics

### Quick sliders

- <doc:QuickSlider>
- ``QuickSlider``
- ``SliderGroup``
- ``AppKitSliderTrackStyle``

### Card grids

- ``CardGrid``
- ``CardGridSection``
