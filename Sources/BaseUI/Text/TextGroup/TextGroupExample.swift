//
//  TextGroupExample.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 24/11/2025.
//

import SwiftUI
import CoreTools

@available(macOS 14.0, *)
struct TextGroupExample: View {
  
  var body: some View {
    
    VStack {
      TextGroup(separator: " • ") {
        Text("Hello")
        
        switch (true, false) {
          case (true, true):
            Text("Valid")
          case (false, _):
            Text("Missing").foregroundStyle(.tertiary)
          case (_, false):
            Text("Error").foregroundStyle(.red)
        }
        
        if Bool.random() {
          Text("Extra")
        }
      }
      
      TextGroup {
        
        Text(DummyContent.Strings.paragraphs[3])
          .foregroundStyle(.green)
        
        Text("Hello")
          .foregroundColor(.red)
          .fontWeight(.bold)
        
        Text(DummyContent.Strings.paragraphs[1])
          .foregroundColor(.blue)
          .italic()
        
      }
    }
    .textSelection(.enabled)
    
  }
}
#if DEBUG
@available(macOS 14.0, *)
#Preview {
  TextGroupExample()
}
#endif
