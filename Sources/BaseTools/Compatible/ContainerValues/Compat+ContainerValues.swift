//
//  ContainerValue.swift
//  Components
//
//  Created by Dave Coleman on 21/11/2024.
//

import SwiftUI

/// I don't use this to it's full extent yet, as I've only needed Bool values so far
public protocol ContainerValueCompatible {
  associatedtype Value

  @available(macOS 15, iOS 18, *)
  var containerKeyPath: WritableKeyPath<ContainerValues, Value> { get }

}

/// Defining my own presets here. This creates a container that is
/// valid on any OS version, with a property `containerKeyPath`
/// that is gated with `@available`
public enum ContainerValueBool: ContainerValueCompatible {
  case isGrouped
  case isEmphasised
  case shouldWiggle
  case hasDividers
  case hasSpacers
  case hasAlternatingRowStyle
  case isFirst
  case isLast
  case isShowingSectionHeader
//  case allowsCanvasClipping
}

extension ContainerValueBool {
  public typealias Value = Bool

  @available(macOS 15, iOS 18, *)
  public var containerKeyPath: WritableKeyPath<ContainerValues, Value> {
    switch self {
      case .isGrouped: \.isGrouped
      case .isEmphasised: \.isEmphasised
      case .shouldWiggle: \.shouldWiggle
      case .hasDividers: \.hasDividers
      case .hasSpacers: \.hasSpacers
      case .hasAlternatingRowStyle: \.hasAlternatingRowStyle
      case .isFirst: \.isFirst
      case .isLast: \.isLast
      case .isShowingSectionHeader: \.isShowingSectionHeader
//      case .allowsCanvasClipping: \.allowsCanvasClipping
    }
  }
}
