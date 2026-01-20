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

//        Text("Current Stroke Config: " + store.strokeStyle.description)
//          .monospaced()
        Picker("Style", selection: styleKindBinding) {
          ForEach(PathStyle.Meta.allCases) { meta in
            Text(meta.name).tag(meta)
          }
        }

        //
        ////          Text("Line").tag(PathStyle.Meta.line)
        ////          Text("Smooth").tag(PathStyle.Meta.smooth)
        ////          Text("Stamped").tag(PathStyle.Meta.stamped)
        //        }

        if store.strokeStyle.style.isStamped {

          if let shapeBinding = $store.strokeStyle.style[dynamicMember: \.stamped]?.shape {
            //          if let shapeBinding = styleBinding[dynamicMember: \.stamped]?.shape {
            //          if let shapeBinding = styleBinding[dynamicMember: \.stamped]?.shape {
            Picker("Shape", selection: shapeBinding) {
              ForEach(PointShape.allCases) { shape in
                Text(shape.name).tag(shape)
              }
            }
          }
          
          if let radiusBinding = $store.strokeStyle.style[dynamicMember: \.stamped]?.radius {
                        TextScrubber(
                          "Radius",
                          value: radiusBinding,
                          range: 0.1...40,
                          strategy: .continuous
                        )
                        .formatValue { value in
                          value.displayString(places: 2)
                        }
            
          }

          //          if let thing = styleBinding[dynamicMember: \.stamped]?.radius {
          //            //          if let rad = Binding(styleBinding) {
          //
          //          }

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
    .pickerStyle(.segmented)
    .formStyle(.grouped)
    //    .animation(Styles.animationSpringQuickNSubtle, value: store.pathStyle.style.isStamped)

  }
}

extension LilyInspectorView {
  
  private var styleKindBinding: Binding<PathStyle.Meta> {
    Binding(
      get: {
        let kind = store.strokeStyle.style.kind
//        DebugString {
//          Indented("PathStyle 'kind' getter") {
//            Labeled("Whole PathStyle", value: store.strokeStyle.style)
//            Labeled("New 'kind'", value: kind)
//          }
//        }
        return kind
      },
      set: { newMeta in
        let current = store.strokeStyle.style
        store.strokeStyle.style = PathStyle.make(kind: newMeta, preserving: current)
        
        //        store.strokeStyle.style = PathStyle.make(kind: newMeta, preserving: store.strokeStyle.style)
      }
    )
  }


  //  private var styleBinding: Binding<PathStyle> {
  //    Binding(
  //      get: {
  //        let kind = store.strokeStyle.style
  //        //        DebugString {
  //        //          Indented("PathStyle 'kind' getter") {
  //        //            Labeled("Whole PathStyle", value: store.strokeStyle.style)
  //        //            Labeled("New 'kind'", value: kind)
  //        //          }
  //        //        }
  //        return kind
  //      },
  //      set: { newValue in
  //        let current = store.strokeStyle.style
  //        store.strokeStyle.style = PathStyle.make(kind: current.kind, preserving: current)
  //
  //        //        store.strokeStyle.style = PathStyle.make(kind: newMeta, preserving: store.strokeStyle.style)
  //      }
  //    )
  //  }

  //  private func styleBinding<T>(
  //    _ casePath: WritableKeyPath<Case<PathStyle>, T>,
  ////    _ casePath: AnyCasePath<PathStyle, T>
  //  ) -> Binding<T> {
  //    //    private var shapeBinding: Binding<PointShape?> {
  //    Binding {
  //
  //      let radius = store.strokeStyle.style[case: casePath]
  ////      DebugString {
  ////        Indented("Radius getter") {
  ////          Labeled("Whole PathStyle", value: store.strokeStyle.style)
  ////          Labeled("New Radius Value", value: radius)
  ////        }
  ////      }
  //      guard let radius = radius as? T else { fatalError("Hello") }
  //      return radius
  //
  //    } set: { newValue in
  //
  ////      guard let shape = store.strokeStyle.style[case: \.stamped]?.shape else { return }
  ////      store.strokeStyle.style[case: \.stamped] = (shape, newValue)
  ////
  ////      if store.strokeStyle.lastKnownRadius == nil {
  ////        store.strokeStyle.lastKnownRadius = newValue
  ////      }
  //    }
  //  }


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

  //  private var radiusBinding: Binding<Double> {
  //    //    private var shapeBinding: Binding<PointShape?> {
  //    Binding {
  //      let radius = store.strokeStyle.styleRadius
  //      DebugString {
  //        Indented("Radius getter") {
  //          Labeled("Whole PathStyle", value: store.strokeStyle.style)
  //          Labeled("New Radius Value", value: radius)
  //        }
  //      }
  //      return radius
  //
  //    } set: { newValue in
  //
  //      guard let shape = store.strokeStyle.style[case: \.stamped]?.shape else { return }
  //      store.strokeStyle.style[case: \.stamped] = (shape, newValue)
  //
  //      if store.strokeStyle.lastKnownRadius == nil {
  //        store.strokeStyle.lastKnownRadius = newValue
  //      }
  //    }
  //  }

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
    .onAppear {
      store.strokeStyle.style = .stamped(shape: .circle, radius: 3.0)
    }
}
#endif
