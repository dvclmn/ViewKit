//
//  UUID.swift
//  Collection
//
//  Created by Dave Coleman on 2/11/2024.
//

import Foundation

extension UUID {

  /// Looking for truncation, e.g. `1234...4567`?
  /// See `StringKit/String/truncate`
  //  public func truncated(
  //    to maxLength: Int = 8,
  //    style: TruncationStyle =
  //  )

  /// Will return a new `UUID()` if `uuidString` cannot be initialised
  public static func mock(_ id: Int) -> UUID {
    let hex = String(format: "%012x", id)
    return UUID(uuidString: "00000000-0000-0000-0000-\(hex)") ?? UUID()
  }
  
  public init(fromInt value: Int) {
    self = .mock(value)
  }
}

//extension UUID: @retroactive RawRepresentable {
//  public var rawValue: String {
//    self.uuidString
//  }
//
//  public typealias RawValue = String
//
//  public init?(rawValue: RawValue) {
//    self.init(uuidString: rawValue)
//  }
//}
