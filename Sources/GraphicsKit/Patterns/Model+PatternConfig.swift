//
//  Model+Patterns.swift
//  Components
//
//  Created by Dave Coleman on 19/11/2024.
//

import ColourTools
import CoreGraphics
import CoreTools
import ViewTools
import BaseTools
import ColourTools
import Foundation

public struct PatternConfiguration: Codable, Equatable, Hashable, Sendable {

  /// This is a generic reference to the 'main' size-y quality of the pattern,
  /// that makes sense to receive a size. Not ideal/clear, needs improvement.
  var size: Double

  /// Again, a generic value for whatever most represents a 'gap',
  /// in the assigned `PatternStyle`
  var gap: Double
  var offset: CGSize

  var primaryColour: HSVColour
  var secondaryColour: HSVColour

  public init(
    size: Double = 30,
    gap: Double = 10,
    offset: CGSize = .zero,
    primaryColour: HSVColour = .white,
    secondaryColour: HSVColour = .brown
  ) {
    self.size = size
    self.gap = gap
    self.offset = offset
    self.primaryColour = primaryColour
    self.secondaryColour = secondaryColour
  }
}

extension PatternConfiguration {
  public static let `default`: PatternConfiguration = .init()
}
