//
//  LayoutMode.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 8/10/2025.
//

import BasePrimitives
import EnumMacros
import SwiftUI

// TODO: Is the below still useful?
//public struct LayoutToggle: View {
//
//  @Binding var mode: LayoutMode
//
//  public init(_ mode: Binding<LayoutMode>) {
//    self._mode = mode
//  }
//  public var body: some View {
//
//    Button {
//      mode.moveForward()
//    } label: {
//      MaybeLabel(mode.label)
//    }
//
//  }
//}

@CaseDetection()
public enum LayoutMode: String, CaseCyclable, CaseTogglable, Codable, Sendable {
  public static var defaultCase: LayoutMode { .list }

  case grid
  case list

  public var label: QuickLabel {
    QuickLabel(rawValue.capitalized, symbol: iconString)
  }

  public var iconString: String {
    switch self {
      case .grid: "circle.grid.2x2"
      case .list: "checklist.unchecked"
    }
  }
}
