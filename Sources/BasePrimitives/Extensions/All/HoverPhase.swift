//
//  HoverPhase.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 13/3/2026.
//

import SwiftUI

extension HoverPhase {
  public var location: CGPoint? {
    switch self {
      case .active(let loc): loc
      case .ended: nil
    }
  }

  public var interactionPhase: InteractionPhase {
    .init(fromHover: self)
  }
}
