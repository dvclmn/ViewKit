//
//  Codable+Conformance.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 11/3/2026.
//

import Foundation

extension IdentifiedList: Codable where Element: Codable {
  public init(from decoder: any Decoder) throws {
    let container = try decoder.singleValueContainer()
    let decoded = try container.decode([Element].self)
    self.init(decoded)
  }
  public func encode(to encoder: any Encoder) throws {
    var container = encoder.singleValueContainer()
    try container.encode(elements)
  }
}
