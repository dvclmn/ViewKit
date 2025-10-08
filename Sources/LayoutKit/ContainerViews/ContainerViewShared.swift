//
//  ContainerViewShared.swift
//  BaseComponents
//
//  Created by Dave Coleman on 20/9/2025.
//

import Foundation

extension Optional where Wrapped == CGFloat {
  public func subElementSpacingReduction(reductionFactor factor: CGFloat = 0.7) -> CGFloat? {
    guard let unwrapped = self else { return self }
    return unwrapped * factor
    
  }
}
