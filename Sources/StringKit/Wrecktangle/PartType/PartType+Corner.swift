//
//  PartType+Corner.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 30/10/2025.
//

extension Box {
  public enum CornerType: String, Hashable, Sendable, Codable {
    case topLeading
    case topTrailing
    case bottomLeading
    case bottomTrailing
  }
}
