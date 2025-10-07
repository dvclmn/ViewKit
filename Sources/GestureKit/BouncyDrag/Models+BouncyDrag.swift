//
//  Models+BouncyDrag.swift
//  BaseComponents
//
//  Created by Dave Coleman on 21/8/2025.
//

import Foundation
import BaseHelpers
import CurveKit

enum DragMethod: Sendable {
  case twoFingerPan
  case clickAndDrag
  case idle

//  var offset: CGSize? {
//    switch self {
//      case .twoFingerPan(let size): return size
//      case .clickAndDrag(let size): return size
//      case .idle: return nil
//    }
//  }
  
  /// How much to increase (or reduce) the offset effect
  /// for two-finger pan based dragging, which tends to
  /// require a bit more movement for the same result
  static let panSensitivityFactor: CGFloat = 1.8
}

struct BouncyScale{
  let deadZone: CGFloat = 10
  let maxEffectThreshold: CGFloat = 10.4
  let curve: CurveFunction = .cubic
}
