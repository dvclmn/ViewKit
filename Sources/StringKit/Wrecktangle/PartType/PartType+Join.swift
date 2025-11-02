//
//  PartType+Join.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 30/10/2025.
//

extension Box {

  /// Describes where the joining takes place
  public enum JoinType: Hashable, Sendable, Codable {
    case leading  // ┠
    case trailing  // ┨
    case top  // ┯
    case bottom  // ┷
    case cross  // ╂
  }
}
