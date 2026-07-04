//
//  Model+Group.swift
//  BaseComponents
//
//  Created by Dave Coleman on 19/9/2025.
//

import SwiftUI

public typealias ItemGroup<T> = [String: [T]]

extension EnvironmentValues {
  @Entry public var sectionHeaderColour: AnyShapeStyle? = nil
//  @Entry public var sectionNameTransform: (String) -> String = { $0 }
}

extension View {
  
  /// Example usage:
  /// ```
  /// .environment(
  ///   \.sectionNameTransform,
  ///   { string in
  ///     switch string {
  ///       case "false": return "Not in Library"
  ///       default: return "In Library"
  ///     }
  ///   }
  /// )
  /// ```
//  public func transformSectionName(_ transform: @escaping (String) -> String) -> some View {
//    self.environment(\.sectionNameTransform, transform)
//  }
}
