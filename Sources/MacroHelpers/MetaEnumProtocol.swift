//
//  MetaEnumProtocol.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 9/2/2026.
//

//import CasePaths
import SwiftUI

/// Note: This is applied to the parent, not the Meta Enum.
/// This gives me: “case identity” (meta) + maybe a default instance
/// thanks to `init?(fromMeta:)`
public protocol MetaEnum {
  associatedtype Meta: MetaEnumNested

  /// Current “case only”
  var meta: Meta { get }

  /// Build a “reasonable default” instance for this case (or nil if impossible)
  init?(fromMeta: Meta)
}

public protocol MetaEnumNested: CaseIterable, Hashable, Identifiable where AllCases: RandomAccessCollection {
  var name: String { get }
}
