//
//  LabelPart.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 7/2/2026.
//

// import CoreTools
import EnumMacros
import SwiftUI

@CaseDetection
public enum LabelPart {
  case title
  case icon
}

extension LabelPart {
  public func weight(
    override: Font.Weight? = nil,  // Usually from environment
  ) -> Font.Weight? {
    override ?? weight
  }

  private var weight: Font.Weight {
    switch self {
      case .title: .regular
      case .icon: .semibold
    }
  }
}
