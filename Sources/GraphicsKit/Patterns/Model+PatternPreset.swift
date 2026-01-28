//
//  Model+PatternPreset.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 23/1/2026.
//

import ColourKit
import Foundation
import CasePaths

@dynamicMemberLookup
public struct PatternPreset: Sendable, Codable, Equatable, Hashable {
  let style: PatternStyle
  let config: PatternConfiguration
  
  public init(
    style: PatternStyle = .checkerboard,
    config: PatternConfiguration = .default
  ) {
    self.style = style
    self.config = config
  }
}

extension PatternPreset {
  subscript(dynamicMember keyPath: CaseKeyPath<PatternStyle, PatternStyle>) -> PatternStyle? {
    style[case: keyPath]
    //  subscript(dynamicMember keyPath: WritableKeyPath<PatternStyle, PatternStyle>) -> PatternStyle {
    //  subscript dynamicMember keyPath: WritableKeyPath<PatternConfiguration, Any> {
    //    style[case: <#T##KeyPath<Case<PatternStyle>, Case<PatternStyle>>#>]
  }

  public static let opacityCheckerboard = PatternPreset(
    style: .checkerboard,
    config: PatternConfiguration(
      size: 5,
      gap: 2,
      offset: CGSize(width: 0, height: -2),
      primaryColour: .brown,
      secondaryColour: .white
    )
  )

}
