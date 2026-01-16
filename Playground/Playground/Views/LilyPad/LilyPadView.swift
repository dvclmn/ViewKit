//
//  LilyPadView.swift
//  Playground
//
//  Created by Dave Coleman on 16/1/2026.
//

import SwiftUI

struct ExampleView: View {
  @Environment(AppHandler.self) private var store
  var body: some View {
    
    Text("Hello")
      .padding(40)
      .frame(width: 600, height: 700)
      .background(.black.opacity(0.6))
    
  }
}
#if DEBUG
@available(macOS 14.0, *)
#Preview(traits: .size(.normal)) {
  @Previewable @State var store = AppHandler()
  ExampleView()
    .environment(store)
}
#endif
