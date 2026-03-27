//
//  ContainerEnv.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 15/2/2026.
//

import SwiftUI

@available(macOS 15, iOS 18, *)
extension ContainerValues {
  @Entry public var isGrouped: Bool = false
  @Entry public var isEmphasised: Bool = false
  @Entry public var shouldWiggle: Bool = false
  @Entry public var hasDividers: Bool = false
  @Entry public var hasSpacers: Bool = true
  @Entry public var hasAlternatingRowStyle: Bool = false
  @Entry public var isFirst: Bool = false
  @Entry public var isLast: Bool = false
  @Entry public var isShowingSectionHeader: Bool = true
}
