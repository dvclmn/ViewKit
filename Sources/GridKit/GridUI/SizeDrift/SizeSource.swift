//
//  SizeSource.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 18/12/2025.
//

import SwiftUI

enum CharacterSizeSource {
  case unitSize(CGSize?)
  case sentence(CGSize?)
  
  var name: String {
    switch self {
      case .unitSize: "Unit Size"
      case .sentence: "Sentence"
    }
  }
  
  var size: CGSize? {
    switch self {
      case .unitSize(let size): size
      case .sentence(let size): size
    }
  }
  
  var colour: Color {
    switch self {
      case .unitSize: Color.green
      case .sentence: Color.blue
    }
  }
}
