//
//  CellSelectionCanvas.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 25/2/2026.
//

import SwiftUI
import CoreTools

struct CellSelectionCanvas: View {
   @Environment(\.unitSize) private var unitSize
  
  var body: some View {
    
    Text("Character Size: \(unitSize, default: "nil")")
    
    Canvas(
      opaque: true,
      rendersAsynchronously: true) { context, size in
        context.draw
      }
    
  }
}
