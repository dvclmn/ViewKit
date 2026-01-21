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

/// Example usage:
/// ```
/// extension SharedKey where Self == FileStorageKey<AnimationDocument>.Default {
///   static var document: Self {
///     .file("animationDocument", default: AnimationDocument())
///   }
/// }
/// ```

//public func file<T: Sendable>(
//  _ file: SharedFile,
//  default defaultValue: @autoclosure @escaping @Sendable () -> T
//) -> some SharedKey<T>
//where T == FileStorageKey<T> {
//  
//  Self[
//    .fileStorage(file.url),
//    default: defaultValue()
//  ]
//}

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

// E.g. default to json for file type
// Hide `applicationSupportDirectory.appending(component` and similar details in implementation, in SharedHelpers
// Use of `fileStorage` should be implicitly applied, based on use of `Self == FileStorageShared<...>`
//extension SharedKey where Self == FileStorageShared<AnimationDocument> {
//  static var document: Self {
//    Something(
//      "animationDocument",
//      fileType: .json,
//      default: AnimationDocument()
//    )
//  }
//}
//extension SharedKey where Base == FileStorageKey<Value>, Self == FileStorageKey<Value>.Default, Value: Sendable {
//  public static func file(
//    _ file: SharedFile,
//    default defaultValue: @autoclosure @escaping @Sendable () -> Value
//  ) -> Self {
//    Self[
//      .fileStorage(file.url),
//      default: defaultValue()
//    ]
//  }
//}


public enum SharedFileType: String {
  case json
}


//extension SharedReaderKey {
//  public static func make<T>(
//    _ fileName: String,
//    type fileExtension: FileExtension = .json,
//    default defaultValue: Value
//  ) -> T {
//    let fileName: String = "\(fileName).\(fileExtension.rawValue)"
//    Self[
//      .fileStorage(
//        .applicationSupportDirectory.appending(component: fileName)
//      ),
//      default: defaultValue
//    ]
//  }
//}
//
//public enum FileExtension: String {
//  case json
//}
