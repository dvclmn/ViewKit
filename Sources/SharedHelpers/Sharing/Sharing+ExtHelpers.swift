//
//  Sharing+ExtHelpers.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 21/1/2026.
//

import Foundation
import Sharing

/// Example usage:
/// ```
/// extension SharedKey where Self == FileStorageKey<AnimationDocument>.Default {
///   static var document: Self {
///     .file("animationDocument", default: AnimationDocument())
///   }
/// }
/// ```
extension SharedKey {
  public static func storage<T: Codable>(
    _ name: String,
    defaultValue: T
  ) -> Self where Self == FileStorageKey<T>.Default {
    Self[
      .fileStorage(
        .applicationSupportDirectory.appending(component: name)
      ),
      default: defaultValue
    ]
  }
}

public struct SharedFile {
  public let name: String
  public let type: SharedFileType

  public init(_ name: String, type: SharedFileType = .json) {
    self.name = name
    self.type = type
  }

  public var url: URL {
    .applicationSupportDirectory
      .appending(component: "\(name).\(type.rawValue)")
  }
}

public enum SharedFileType: String {
  case json
}
