//
//  Sharing+ExtHelpers.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 21/1/2026.
//

import Foundation
import Sharing

public typealias AppStorageShared<T: Sendable> = AppStorageKey<T>.Default
public typealias FileStorageShared<T: Sendable> = FileStorageKey<T>.Default
public typealias MemoryShared<T: Sendable> = InMemoryKey<T>.Default

extension SharedReaderKey {
  public static func make<T>(
    _ fileName: String,
    type fileExtension: FileExtension = .json,
    default defaultValue: Value
  ) -> T {
    let fileName: String = "\(fileName).\(fileExtension.rawValue)"
    Self[
      .fileStorage(
        .applicationSupportDirectory.appending(component: fileName)
      ),
      default: defaultValue
    ]
  }
}

public enum FileExtension: String {
  case json
}
