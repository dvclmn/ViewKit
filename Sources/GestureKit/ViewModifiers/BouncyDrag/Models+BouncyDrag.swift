//
//  Models+BouncyDrag.swift
//  BaseComponents
//
//  Created by Dave Coleman on 21/8/2025.
//

import Foundation
//import VectorKit
import BasePrimitives

enum DragMethod: Sendable {
  case clickAndDrag
  case idle
}

struct BouncyScale {
  let deadZone: CGFloat = 10
  let maxEffectThreshold: CGFloat = 10.4
  let curve: CurveFunction = .cubic
}
