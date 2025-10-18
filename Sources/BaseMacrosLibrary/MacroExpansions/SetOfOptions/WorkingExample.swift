//
//  WorkingExample.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 17/10/2025.
//

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
///
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
/// }
/// ```
