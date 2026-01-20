//
//  Lily+Inspector.swift
//  Playground
//
//  Created by Dave Coleman on 17/1/2026.
//

import CasePaths
import LilyPad
import SwiftUI
import ToolKit
import VectorKit

struct LilyInspectorView: View {
  @Environment(AppHandler.self) private var store

  //  @State private var stampRadius: CGFloat?
  //  @State private var stampShape: PointShape?

  //  let formatter: NumberFormatter = .init()

  var body: some View {
    @Bindable var store = store

    Form {

      Section("Line Style") {

        Picker("Style", selection: styleBinding) {

          //          ForEach(PathStyle.Cases()., id: \.self) { path in
          //          ForEach(PathStyle.allCasePaths, id: \.self) { path in

          //          }
          ForEach(PathStyle.Meta.allCases) { meta in
            Text(meta.name).tag(meta)
          }
        }
        .pickerStyle(.segmented)

        //
        ////          Text("Line").tag(PathStyle.Meta.line)
        ////          Text("Smooth").tag(PathStyle.Meta.smooth)
        ////          Text("Stamped").tag(PathStyle.Meta.stamped)
        //        }

        if store.strokeStyle.style.isStamped {
          TextScrubber(
            "Radius",
            value: radiusBinding,
            range: 0.1...40,
            strategy: .continuous
          )

          //          QuickPicker(item: $store.strokeStyle.style)

          //                    TextField("Radius", value: $store.pathStyle.radius, formatter: formatter)
        }
        //        TextField("Radius", value: radius, format: .)
        //      }

      }

      //      QuickSlider(
      //        "Stroke Density",
      //        value: $store.strokeDensity.toBindingDouble,
      //        range: 1...50,
      //      )
    }
    .formStyle(.grouped)
    //    .animation(Styles.animationSpringQuickNSubtle, value: store.pathStyle.style.isStamped)

  }
}

extension LilyInspectorView {

  private var styleBinding: Binding<PathStyle.Meta> {
    Binding(
      get: { store.strokeStyle.style.kind },
      set: { newMeta in
        let current = store.strokeStyle.style
        store.strokeStyle.style = PathStyle.make(kind: newMeta, preserving: current)

        //        store.strokeStyle.style = PathStyle.make(kind: newMeta, preserving: store.strokeStyle.style)
      }
    )
  }

  //  private var styleBinding: Binding<PathStyle> {
  //    Binding(
  //      get: { store.strokeStyle.style },
  //      set: { newMeta in
  //        store.strokeStyle.style = newMeta
  //
  //        //        store.strokeStyle.style = PathStyle.make(kind: newMeta, preserving: store.strokeStyle.style)
  //      }
  //    )
  //  }

  private var radiusBinding: Binding<Double> {
    //    private var shapeBinding: Binding<PointShape?> {
    Binding {
      store.strokeStyle.style[case: \.stamped]?.radius ?? 1.0
      //        store.strokeStyle.style.stampedValue?.shape
      //      store.strokeStyle.style.kind
    } set: { newValue in
      //      guard let newValue else { return }
      //      guard let shape = store.strokeStyle.style[case: \.stamped]?.shape else { return  }
      guard let shape = store.strokeStyle.style[case: \.stamped]?.shape else { return }
//      let values: (PointShape, Double) = ()
      store.strokeStyle.style[case: \.stamped] = (shape, newValue)
      //      store.strokeStyle.style[case: \.stamped] = StampedConfig(shape: shape, radius: newValue)

      //      store.strokeStyle.style.modify(\.stamped) { $0.radius = newValue }
      //        store.strokeStyle.style.updateStampShape(new)
      //      store.strokeStyle.style = PathStyle.make(
      //        kind: $0,
      //        preserving: store.strokeStyle.style
      //      )
    }
  }

  //  private var styleBinding: Binding<PathStyle> {
  //    Binding {
  //      store.strokeStyle.style
  //    } set: { newValue in
  //      store.strokeStyle.style = newValue
  //    }
  //
  //    //    Binding {
  //    //      store.strokeStyle.style.kind
  //    //    } set: {
  //    //      store.strokeStyle.style = PathStyle.make(
  //    //        kind: $0,
  //    //        preserving: store.strokeStyle.style
  //    //      )
  //    //    }
  //  }

  //  private var shapeBinding: Binding<PointShape>? {
  //    store.strokeStyle.style.
  //  }

  //  private var styleBinding: Binding<PathStyle> {
  //    Binding {
  //      store.strokeStyle.style
  //      //      store.pathStyle.style
  //      //      PathStylePicker(from: store.pathStyle)
  //    } set: { newValue in
  //      let new: PathStyle? = {
  //        switch newValue {
  //          case .line: return .line
  //          case .smooth: return .smooth
  //          case .stamped:
  //            guard let stampRadius, let stampShape else { return nil }
  //            return .stamped(shape: stampShape, radius: stampRadius)
  //
  //        }
  //      }()
  //
  //      guard let new else { return }
  //      store.strokeStyle.updateStyle(new)
  //    }
  //
  //  }

  //  private var radiusBinding: Binding<CGFloat?> {
  //    Binding {
  //      store.pathStyle.stampedValue?.radius
  //    } set: { newValue in
  //      if let newValue, let shape = store.pathStyle.stampedValue?.shape {
  //        store.pathStyle = .stamped(shape: shape, radius: newValue)
  //      }
  //    }
  //
  //  }

}
#if DEBUG
#Preview(traits: .size(.normal)) {
  @Previewable @State var store = AppHandler()
  LilyInspectorView()
    .environment(store)
    .frame(maxWidth: 300)
}
#endif
