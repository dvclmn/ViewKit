//
//  Popup+Loading.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 16/2/2026.
//

import SwiftUI
//import SampleBuilder

//@SampleBuilder(numberOfItems: 3, dataGeneratorType: .random)
public enum PopupLoadingIndicator: Sendable, Equatable {
  case indeterminate // Shows spinning indicator, no progress value
  /// Not yet supported
  /// Shows loading bar with progress
//  case determinate(Binding<Double>)
  case none
}
