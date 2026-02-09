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

// MARK: - OLD, disregard

/// ```swift
/// nonisolated struct Debugging: Sendable, Codable, Equatable, OptionSet {
///
///   nonisolated enum Options: Int, Sendable, Codable, CaseIterable, Identifiable {
///
///     case columnWidths
///     case rowNumbers
///     case cellFrames
///     case frames
///     case gridBackground
///     case tallestCell
///     case debugText
///     case staticLayoutText
///
///     var id: Int { rawValue }
///
///     var name: String {
///       switch self {
///         case .columnWidths: "Column Widths"
///         case .rowNumbers: "Row Numbers"
///         case .cellFrames: "Cell Frames"
///         case .frames: "Frames"
///         case .gridBackground: "Grid Background"
///         case .tallestCell: "Tallest Cell"
///         case .debugText: "Debug Text"
///         case .staticLayoutText: "Static Layout Text"
///       }
///     }
///
///     var matchingOption: Debugging {
///       return Debugging(rawValue: 1 << self.rawValue)
///       //      return Debugging(rawValue: self.rawValue)
///     }
///   }
/// }


///   // EXPANSION BELOW
///   public init(rawValue: Int) {
///     self.rawValue = rawValue
///   }
///   public let rawValue: Int
///
///   public static let columnWidths = Self(rawValue: 1 << 0)
///   public static let rowNumbers = Self(rawValue: 1 << 1)
///   public static let cellFrames = Self(rawValue: 1 << 3)
///   public static let frames = Self(rawValue: 1 << 4)
///   public static let gridBackground = Self(rawValue: 1 << 5)
///   public static let tallestCell = Self(rawValue: 1 << 6)
///   public static let debugText = Self(rawValue: 1 << 7)
///   public static let staticLayoutText = Self(rawValue: 1 << 8)
///
///   public static let all: Self = [
///     .columnWidths,
///     .rowNumbers,
///     .cellFrames,
///     .frames,
///     .gridBackground,
///     .tallestCell,
///     .debugText,
///     .staticLayoutText,
///   ]
///
///
/// }
/// ```

