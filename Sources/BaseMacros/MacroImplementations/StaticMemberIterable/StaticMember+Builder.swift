//
//  StaticMember+Builder.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 14/2/2026.
//

import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

/// Collects the data needed to synthesise `allStaticMembers` and assembles the
/// final `[DeclSyntax]` output.
struct StaticMemberIterableBuilder {

  /// The access level of the attached declaration (e.g. `"public"`), or an
  /// empty string when none is explicitly written (i.e. `internal`-by-default).
  let accessLevel: String

  /// The identifier names of every explicitly-`static` variable found in the
  /// declaration's member block.
  let staticMemberNames: [String]

  init(decl: some DeclGroupSyntax) {
    self.accessLevel = decl.accessLevelKeyword
    self.staticMemberNames = decl.staticVariableIdentifiers
  }
}

extension StaticMemberIterableBuilder {

  func build() -> [DeclSyntax] {
    /// Mirror the parent's access level
    let access = accessLevel.isEmpty ? "" : "\(accessLevel) "
    let members = staticMemberNames.joined(separator: ", ")
    return ["\(raw: access)static let allStaticMembers = [\(raw: members)]"]
  }
}

extension DeclGroupSyntax {

  /// The text of the first access-level modifier on this declaration, if one
  /// is explicitly written (e.g. `"public"`, `"fileprivate"`).
  fileprivate var accessLevelKeyword: String {
    modifiers.first(where: \.isAccessLevelModifier)?.name.text ?? ""
  }

  /// All identifier names that belong to an explicitly-`static` variable
  /// declaration in this type's member block.
  fileprivate var staticVariableIdentifiers: [String] {
    memberBlock.members
      .flatMap { $0.children(viewMode: .fixedUp).compactMap { $0.as(VariableDeclSyntax.self) } }
      .filter(\.hasStaticModifier)
      .compactMap(\.firstBindingIdentifier)
  }
}

extension DeclModifierSyntax {

  /// Returns `true` when this modifier is one of the five Swift access-level
  /// keywords: `public`, `package`, `internal`, `fileprivate`, or `private`.
  fileprivate var isAccessLevelModifier: Bool {
    switch name.tokenKind {
      case .keyword(.public), .keyword(.package), .keyword(.internal),
        .keyword(.fileprivate), .keyword(.private):
        return true
      default:
        return false
    }
  }
}

extension VariableDeclSyntax {

  /// Returns `true` when the declaration carries a `static` modifier.
  fileprivate var hasStaticModifier: Bool {
    modifiers.contains { $0.name.tokenKind == .keyword(.static) }
  }

  /// The identifier text of the first pattern binding, if one exists.
  ///
  /// For a declaration like `static let foo = Bar()` this returns `"foo"`.
  fileprivate var firstBindingIdentifier: String? {
    bindings
      .compactMap { $0.pattern.as(IdentifierPatternSyntax.self)?.identifier.text }
      .first
  }
}
