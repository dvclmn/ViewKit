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
  
  let gridConfig: GridConfiguration = .init(
    fillStyle: <#T##GridFillStyle#>,
    colour: <#T##Color#>,
    lineWidth: <#T##CGFloat#>,
    density: <#T##DisplayDensity#>
  )
  
  var body: some View {
    
    Text("Character Size: \(unitSize, default: "nil")")
    
    Canvas(
      opaque: true,
      rendersAsynchronously: true) { context, size in
        context.drawInfiniteGrid(in: size, config: <#T##GridConfiguration#>)
      }
    
  }
}
