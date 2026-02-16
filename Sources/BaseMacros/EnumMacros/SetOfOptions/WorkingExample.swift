//
//  WorkingExample.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 17/10/2025.
//

/// ## Example usage:
/// ```
/// @SetOfOptions<UInt8>
/// struct CoolAnimals {
///   enum Options: Int {
///     case bat
///     case frog  // Test comment
///     case apeWithCamelCase
///   }
/// }
/// ```


/// ## Macro expansion:
/// ```
/// let rawValue: UInt8
///
/// init(rawValue: UInt8) {
///   self.rawValue = rawValue
/// }
///
/// static let bat: Self = Self(rawValue: 1 << Options.bat.rawValue)
///
/// static let frog: Self = Self(rawValue: 1 << Options.frog.rawValue)
///
/// static let apeWithCamelCase: Self = Self(rawValue: 1 << Options.apeWithCamelCase.rawValue)
///
/// static let all: Self = [
///   .bat,
///   .frog,
///   .apeWithCamelCase,
/// ]
///
/// static func stringValue(
///   for option: Options,
///   isSnakeCase: Bool = false
/// ) -> String {
///   switch option {
///     case .bat:
///       "bat"
///     case .frog:
///       "frog"
///     case .apeWithCamelCase:
///       isSnakeCase ? "ape_with_camel_case" : "apeWithCamelCase"
///   }
/// }
///
/// func stringValueJoined(isSnakeCase: Bool = false) -> String {
///   var strings: [String] = []
///   if self.contains(.bat) {
///     strings.append(Self.stringValue(for: Options.bat, isSnakeCase: isSnakeCase))
///   }
///   if self.contains(.frog) {
///     strings.append(Self.stringValue(for: Options.frog, isSnakeCase: isSnakeCase))
///   }
///   if self.contains(.apeWithCamelCase) {
///     strings.append(Self.stringValue(for: Options.apeWithCamelCase, isSnakeCase: isSnakeCase))
///   }
///   return strings.joined(separator: ", ")
/// }
/// ```
