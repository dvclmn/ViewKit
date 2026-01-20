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

        //        QuickPicker(item: $store.strokeStyle.style, allItems: [
        //
        //        ])
        //        QuickPicker(item: $store.strokeStyle.style)
        //        QuickPicker(item: $store.pathStyle.style)
        //      QuickPicker(item: $store.pathStyle)
        //      if let radius = Binding(radiusBinding) {

        if store.strokeStyle.style.isStamped {
          //        if store.pathStyle.style.isStamped {

          //          if let shape = Binding(shapeBinding) {
          //            QuickPicker(item: shape)
          //          }
          //          QuickPicker(item: $store.strokeStyle.style)

          //          TextScrubber(
          //            "Radius",
          //            value: $store.pathStyle.radius,
          //            range: store.pathStyle.range,
          //            strategy: .continuous
          //          )
          //          TextField("Radius", value: $store.pathStyle.radius, formatter: formatter)
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

  private var styleBinding: Binding<PathStyle> {
    Binding {
      store.strokeStyle.style
    } set: { newValue in
      store.strokeStyle.style = newValue
    }

    //    Binding {
    //      store.strokeStyle.style.kind
    //    } set: {
    //      store.strokeStyle.style = PathStyle.make(
    //        kind: $0,
    //        preserving: store.strokeStyle.style
    //      )
    //    }
  }

  //  private var shapeBinding: Binding<PointShape>? {
  //    store.strokeStyle.style.
  //  }

  //  private var shapeBinding: Binding<PointShape?> {
  //    Binding {
  //      store.strokeStyle.style.stampedValue?.shape
  ////      store.strokeStyle.style.kind
  //    } set: {
  //      guard let new = $0 else { return }
  //      store.strokeStyle.style.updateStampShape(new)
  ////      store.strokeStyle.style = PathStyle.make(
  ////        kind: $0,
  ////        preserving: store.strokeStyle.style
  ////      )
  //    }
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
