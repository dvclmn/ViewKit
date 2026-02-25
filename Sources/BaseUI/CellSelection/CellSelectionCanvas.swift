//
//  CellSelectionCanvas.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 25/2/2026.
//

import SwiftUI
import CoreTools
import GraphicsKit

struct CellSelectionCanvas: View {
   @Environment(\.unitSize) private var unitSize
  
  var body: some View {
    
    Text("Character Size: \(unitSize, default: "nil")")
    
    Canvas(
      opaque: true,
      rendersAsynchronously: true) { context, size in
        context.drawInfiniteGrid(in: <#T##CGRect#>, config: <#T##GridConfiguration#>)
      }
    
  }
}
