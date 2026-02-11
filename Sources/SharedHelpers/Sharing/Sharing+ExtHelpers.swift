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
/// extension SharedKey where Self == FileStorageKey<MyModel>.Default {
///   static var cacheBacked: Self {
///     .storage("my-cache", defaultValue: MyModel(), directory: .cachesDirectory)
///   }
/// }
/// ```
///
/// Or place the file under a subdirectory inside a base directory:
/// ```
/// extension SharedKey where Self == FileStorageKey<MyModel>.Default {
///   static var waveConfig: Self {
///     .storage(
///       "waveConfig.json",
///       directory: "Configurations",
///       base: .applicationSupportDirectory,
///       defaultValue: MyModel()
///     )
///   }
/// }
/// ```
extension SharedKey {

  /// Creates a file-backed shared key stored under an optional subdirectory inside a base directory.
  /// - Parameters:
  ///   - name: The filename (may include extension) to store.
  ///   - directory: Optional subdirectory to append between the base directory and the file name.
  ///   - base: The base directory URL where the file hierarchy should live. Defaults to Application Support.
  ///   - defaultValue: The default value used if no file exists yet.
  public static func storage<T: Codable>(
    _ name: String,
    directory: String? = nil,
    base: URL = .applicationSupportDirectory,
    defaultValue: T
  ) -> Self where Self == FileStorageKey<T>.Default {
    let folderURL = directory.map { base.appending(component: $0) } ?? base
    return Self[
      .fileStorage(
        folderURL.appending(component: name)
      ),
      default: defaultValue
    ]
  }
}
