//
//  Lily+Inspector.swift
//  Playground
//
//  Created by Dave Coleman on 17/1/2026.
//

import SwiftUI
import ToolKit
import VectorKit

struct LilyInspectorView: View {
  @Environment(AppHandler.self) private var store

  let formatter: NumberFormatter = .init()

  var body: some View {
    @Bindable var store = store

    Form {

      Section("Line Style") {
        QuickPicker(item: $store.pathStyle.style)
        //      QuickPicker(item: $store.pathStyle)
        //      if let radius = Binding(radiusBinding) {
        if store.pathStyle.style.isStamped {
          QuickPicker(item: $store.pathStyle.shape)
          TextField("Radius", value: $store.pathStyle.radius, formatter: formatter)
        }
        //        TextField("Radius", value: radius, format: .)
        //      }

      }
      
      QuickSlider(
        "Stroke Density",
        value: $store.strokeDensity.toBindingDouble,
        range: 1...50,
        type: .native
      )
    }
    .formStyle(.grouped)
    .animation(Styles.animationSpringQuickNSubtle, value: store.pathStyle.style.isStamped)

  }
}

extension LilyInspectorView {

  private var styleBinding: Binding<PathStylePicker> {
    Binding {
      store.pathStyle.style
      //      PathStylePicker(from: store.pathStyle)
    } set: {
      store.pathStyle.updateStyle($0)
    }

  }

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
