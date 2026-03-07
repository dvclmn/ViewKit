//
//  GroupBoxExampleView.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 24/1/2026.
//

import SwiftUI
import BasePrimitives

struct CustomGroupBoxView: View {
  
  var body: some View {
    
    GroupBox("Start Point") {
      HStack {
        Rectangle()
          .aspectRatio(1, contentMode: .fit)
          .frame(maxWidth: 60)
        
        Text(SampleContent.Strings.paragraphs[6])
      }
      .frame(maxWidth: .infinity, alignment: .leading)
    }
    .groupBoxStyle(.custom)
    .padding(120)
    
  }
}
#if DEBUG
@available(macOS 15, iOS 18, *)
#Preview(traits: .size(.normal)) {
  CustomGroupBoxView()
}
#endif
