//
//  Model+SelectionMode.swift
//  BaseComponents
//
//  Created by Dave Coleman on 2/10/2025.
//

import Foundation
import EnumMacros

@CaseDetection
public enum SelectionMode: Sendable {
  case single
  case multi
  
  var name: String {
    switch self {
      case .single: "Single"
      case .multi: "Multi"
    }
  }
}
