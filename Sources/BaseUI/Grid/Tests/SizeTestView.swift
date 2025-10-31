//
//  SizeTestView.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 31/10/2025.
//

import SwiftUI
import StringShared

public struct SizeTestView: View {
  
  let size: CGFloat
  public var body: some View {
    
    Text("I'm a sentence with 73 characters. I want to see when we reach the thing.")
      .setCharacterUnitSize()
      .gridFont(.sfMono, size: size)
      .gridGuide()
    
//      .environment(\.unitSize, CGSize(width: 1, height: 2))
    
    
      .padding(100)
    
  }
}
#if DEBUG
#Preview {
  SizeTestView(size: 28)
}
#endif
