//
//  TextGroupExample.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 24/11/2025.
//

import SwiftUI
import CoreTools
import ViewTools
// import BaseTools

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
        
        Text(SampleContent.Strings.paragraphs[3])
          .foregroundStyle(.green)
        
        Text("Hello")
          .foregroundColor(.red)
          .fontWeight(.bold)
        
        Text(SampleContent.Strings.paragraphs[1])
          .foregroundColor(.blue)
          .italic()
        
      }
    }
    .textSelection(.enabled)
    
  }
}
#if DEBUG

#Preview {
  TextGroupExample()
}
#endif
