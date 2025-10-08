//
//  Model+LayoutMode.swift
//  BaseComponents
//
//  Created by Dave Coleman on 5/9/2025.
//

import SwiftUI
import SharedHelpers
import LayoutKit

public protocol ListLayoutMode: View {}
public protocol GridLayoutMode: View {}

public enum VerticalPadding: String, Codable, Sendable {
  case compact
  case roomy
}

public struct CycleLayoutMode: View {
  @Binding var mode: LayoutMode
  public init(mode: Binding<LayoutMode>) {
    self._mode = mode
  }
  public var body: some View {

    Cycler(item: $mode) { mode in
      MaybeLabel(mode.label)
    }

  }
}
