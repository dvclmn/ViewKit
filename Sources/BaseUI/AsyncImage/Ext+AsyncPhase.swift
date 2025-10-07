//
//  Ext+AsyncPhase.swift
//  BaseComponents
//
//  Created by Dave Coleman on 24/9/2025.
//

import SwiftUI

extension AsyncImagePhase {
  var colour: Color {
    switch self {
      case .empty: Color.gray
      case .success(_): Color.clear
      case .failure(_): Color.orange
      @unknown default: Color.gray
    }
  }
}
