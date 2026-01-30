//
//  CatmullConfiguration.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 29/1/2026.
//

import Foundation

public struct CatmullRomConfiguration: Sendable, Codable, Equatable, Hashable, Identifiable {
  public let id: UUID
  let tension: CGFloat
  let alpha: CGFloat  // Future: centripetal/chordal parameterization
                      //  var endpointHandling: EndpointHandling = .clamp
  public init(
    tension: CGFloat = 0.5,
    alpha: CGFloat = 0.5
  ) {
    self.id = UUID()
    self.tension = tension
    self.alpha = alpha
  }
  //  public static let standard: CatmullRomConfiguration = CatmullRomConfiguration()
}

