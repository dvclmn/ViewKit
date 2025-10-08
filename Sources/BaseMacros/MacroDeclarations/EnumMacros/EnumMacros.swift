//
//  AssociatedValues.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 4/10/2025.
//

// MARK: - Associated Values
// Full credit to Andrea Bernardini for this
// AssociatedValues macro. See repo:
// https://github.com/bernndr/swift-macros/
@attached(member, names: arbitrary)
public macro AssociatedValues() = #externalMacro(
  module: "BaseMacros",
  type: "AssociatedValuesMacro"
)

// MARK: - CaseDetection
/// Add computed properties named `is<Case>` for each case element in the enum.
@attached(member, names: arbitrary)
public macro CaseDetection(includesNames: Bool = false) =
#externalMacro(
  module: "BaseMacros",
  type: "CaseDetectionMacro"
)

// MARK: - MetaEnum
@attached(member, names: named(Meta))
public macro MetaEnum() = #externalMacro(
  module: "BaseMacros",
  type: "MetaEnumMacro"
)

// MARK: - Option Set

/// Create an option set from a struct that contains a nested `Options` enum.
///
/// Attach this macro to a struct that contains a nested `Options` enum
/// with an integer raw value. The struct will be transformed to conform to
/// `OptionSet` by
///   1. Introducing a `rawValue` stored property to track which options are set,
///    along with the necessary `RawType` typealias and initializers to satisfy
///    the `OptionSet` protocol.
///   2. Introducing static properties for each of the cases within the `Options`
///    enum, of the type of the struct.
///
/// The `Options` enum must have a raw value, where its case elements
/// each indicate a different option in the resulting option set. For example,
/// the struct and its nested `Options` enum could look like this:
///
///     @SetOfOptions
///     struct ShippingOptions {
///       private enum Options: Int {
///         case nextDay
///         case secondDay
///         case priority
///         case standard
///       }
///     }
@attached(member, names: arbitrary)
@attached(extension, conformances: OptionSet, Sendable)
public macro SetOfOptions<RawType>() = #externalMacro(
  module: "BaseMacros",
  type: "SetOfOptionsMacro"
)
