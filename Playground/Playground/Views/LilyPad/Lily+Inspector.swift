//
//  Lily+Inspector.swift
//  Playground
//
//  Created by Dave Coleman on 17/1/2026.
//

import SwiftUI
import ToolKit

struct LilyInspectorView: View {
  @Environment(AppHandler.self) private var store
  var body: some View {
    @Bindable var store = store
    
    Form {
      QuickPicker(item: $store.pathStyle)
      
      QuickSlider(
        "Stroke Density",
        value: $store.strokeDensity.toBindingDouble,
        range: 1...10,
        type: .native
      )
    }
    .formStyle(.grouped)
    
  }
}

extension LilyInspectorView {
  
}
#if DEBUG
#Preview(traits: .size(.normal)) {
  @Previewable @State var store = AppHandler()
  LilyInspectorView()
    .environment(store)
    .frame(maxWidth: 300)
}
#endif
