//
//  Popup+Loading.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 16/2/2026.
//

import SwiftUI
import SampleBuilder

//@SampleBuilder(numberOfItems: 3, dataGeneratorType: .random)
public enum PopupLoading: Sendable {
  case indeterminate
  /// Not yet supported
//  case determinate(Binding<Double>)
  case none
}
