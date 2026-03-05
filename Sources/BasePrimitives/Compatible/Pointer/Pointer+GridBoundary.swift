//
//  Compat+DirectionalModels.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 22/2/2026.
//

extension GridBoundaryPoint {

  public var toCompatPointerStyle: PointerStyleCompatible {
    let style = PointerStyleCompatible.frameResize(
      position: self.toCompatFrameResizePosition,
      directions: .all
    )
    return style
  }

  var toCompatFrameResizePosition: FrameResizePositionCompatible {
    switch self {
      case .topLeading: .topLeading
      case .topTrailing: .topTrailing
      case .bottomLeading: .bottomLeading
      case .bottomTrailing: .bottomTrailing
      case .top: .top
      case .trailing: .trailing
      case .leading: .leading
      case .bottom: .bottom
    }
  }

}
