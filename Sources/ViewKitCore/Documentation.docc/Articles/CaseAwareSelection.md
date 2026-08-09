# Case-Aware Selection

Preserve associated values while selecting enum cases across one or several SwiftUI views.

## Overview

An enum with associated values represents both a case identity and the value held by that case. A standard SwiftUI selection control can select the complete enum value, but constructing a new value whenever the case changes also reconstructs its payload. Returning to a previously edited case then loses the person's earlier input.

`CasePathHandler` separates those responsibilities. A generated `Meta` value identifies only the case, while the handler caches the last complete enum value used for each case during its lifetime. Selection controls bind to `Meta`; application content continues to bind to the complete enum and its associated values.

For example, an inspector can model its active group and nested selection together:

```swift
import CasePaths
import EnumMacros

@MetaEnum
@CasePathable
enum InspectorTab {
  case appearance(Appearance = .wave)
  case controls(Controls = .general)

  enum Appearance: CaseIterable {
    case wave
    case lines
    case dots
  }

  enum Controls: CaseIterable {
    case general
    case pan
  }
}
```

## Choose the Appropriate Level

Use the highest-level API whose layout matches the feature:

| API | Use it when |
| --- | --- |
| `CasePicker` | The picker and its case-specific editor form one self-contained control group. |
| `CaseMetaPicker` | A picker changes the case, but the corresponding content is presented elsewhere. |
| `CasePathHandler.metaBinding(_:)` | A `List`, sidebar, menu, command, or custom control needs direct access to case-only selection. |
| `CaseTabView` | Both selection and content should use a complete tab-container presentation. |

All four use the same underlying rule: select with `Meta`, edit with the complete enum value.

## Build a Self-Contained Enum Editor

`CasePicker` owns its handler and presents its content immediately after the picker. This is the concise choice for an editor whose selection and associated-value controls belong in the same local layout:

```swift
CasePicker("Interpolation", selection: $interpolation) { interpolation in
  if let bezier = interpolation.case(\.bezier) {
    BezierControls(curve: bezier)
  }

  if let spring = interpolation.case(\.spring) {
    SpringControls(configuration: spring)
  }
}
```

The content receives a `CaseProxy`, which returns a binding only for the active case.

Like SwiftUI's native controls, `CasePicker` offers separate initialisers for a string title and a custom picker label. Omit the title when supplying the label closure:

```swift
CasePicker(selection: $interpolation) { interpolation in
  InterpolationControls(interpolation: interpolation)
} label: {
  Label("Interpolation", systemImage: "point.topleft.down.to.point.bottomright.curvepath")
}
```

The picker label and the labels for its selectable cases are separate concepts. When a case needs richer presentation, use `caseLabel:` alongside either picker-label route:

```swift
CasePicker("Interpolation", selection: $interpolation) { interpolation in
  InterpolationControls(interpolation: interpolation)
} caseLabel: { meta in
  Label(meta.name, systemImage: symbolName(for: meta))
}
```

## Separate a Toolbar Picker from Inspector Content

When selection and content occupy different parts of the interface, keep the handler at their nearest stable common owner. Pass it to `CaseMetaPicker` in the toolbar, then route the complete binding in the inspector body:

```swift
struct EditorView: View {
  @Binding var inspectorTab: InspectorTab
  @State private var inspectorTabHandler: CasePathHandler<InspectorTab>

  init(inspectorTab: Binding<InspectorTab>) {
    self._inspectorTab = inspectorTab
    self._inspectorTabHandler = State(
      initialValue: CasePathHandler(initialValue: inspectorTab.wrappedValue)
    )
  }

  var body: some View {
    inspectorContent
      .toolbar {
        ToolbarItem {
          CaseMetaPicker(
            "Inspector Group",
            selection: $inspectorTab,
            handler: inspectorTabHandler
          )
          .pickerStyle(.segmented)
        }
      }
  }

  @ViewBuilder
  private var inspectorContent: some View {
    switch inspectorTab {
      case .appearance:
        if let appearance = $inspectorTab.appearance {
          AppearanceInspector(selection: appearance)
        }

      case .controls:
        if let controls = $inspectorTab.controls {
          ControlsInspector(selection: controls)
        }
    }
  }
}
```

The toolbar selects only `InspectorTab.Meta.appearance` or `.controls`. Each inspector branch owns the picker for its simple nested enum. Switching from Appearance to Controls and back restores the last complete Appearance value held by the handler.

Keep the handler outside conditional toolbar content. If hiding the inspector removes and recreates the picker, the stable parent still retains the inactive payloads.

## Drive a Sidebar or Other Selection Surface

`CasePathHandler` does not require a picker. Bind a sidebar list directly to the meta value:

```swift
List(selection: tabHandler.metaBinding($tab)) {
  ForEach(Tab.Meta.allCases, id: \.self) { meta in
    Label(meta.name, systemImage: icon(for: meta))
      .tag(meta)
  }
}
```

The same approach works for menus and custom controls. For imperative commands, call `switchTo(_:binding:)` on the shared handler.

## Share One Selection History

Every control that can change the same enum should use the same `CasePathHandler`. For example, a toolbar picker and menu commands should not each create their own handler. Separate handlers maintain separate caches and can restore different payloads.

`CasePathHandler` is a reference type so several views can intentionally share this identity. The bound enum remains the source of truth for the active value; the handler owns only the switching policy and inactive-case history.

## Understand the Lifetime Boundary

Payload history lasts only as long as the handler. This is usually appropriate for view-local editing state and workspace navigation during an application session.

If inactive selections must survive relaunch, persist them as explicit application data. A single associated-value enum can encode the payload of only its active case, and `CasePathHandler` deliberately does not turn presentation history into persistence.

When `init?(fromMeta:)` cannot construct every case, choose an appropriate `CaseFallbackStrategy` when creating the handler. The default keeps the current value rather than claiming to select an unrepresentable case.
