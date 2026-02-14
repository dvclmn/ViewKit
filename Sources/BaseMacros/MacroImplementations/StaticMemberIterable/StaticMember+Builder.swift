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
  let typeName: String?

  /// The identifier names of every explicitly-`static` variable found in the
  /// declaration's member block.
  ///
  /// Only static members with an explicit type annotation matching the
  /// parent type name are included. Members with inferred types, or with
  /// a different explicit type (e.g. `static let defaultIndex: Int`), are
  /// excluded — keeping `allStaticMembers` homogeneously typed as `[Self]`.
  ///
  /// Note: Annotate `Self`-typed statics explicitly (e.g. `static let x: MyType = ...`)
  /// to ensure they are picked up. Inferred types cannot be resolved at macro
  /// expansion time.
  let staticMemberNames: [String]

  init(decl: some DeclGroupSyntax) {
    self.accessLevel = decl.accessLevelKeyword
    self.staticMemberNames = decl.selfTypedStaticVariableIdentifiers
    self.typeName = decl.typeName
  }
}

extension StaticMemberIterableBuilder {

  func build() -> [DeclSyntax] {
    /// Mirror the parent's access level
    let access = accessLevel.isEmpty ? "" : "\(accessLevel) "
    let members = staticMemberNames.joined(separator: ", ")
    guard let typeName else { return [] }
    return ["\(raw: access)static let allStaticMembers: [\(raw: typeName)] = [\(raw: members)]"]
  }
}

extension DeclGroupSyntax {

  /// The declared name of this type, regardless of its kind (struct, class,
  /// enum, actor). Returns `nil` for `extension` blocks and other group
  /// syntax that has no single canonical name.
  fileprivate var typeName: String? {
    if let s = self as? StructDeclSyntax { return s.name.text }
    if let c = self as? ClassDeclSyntax { return c.name.text }
    if let e = self as? EnumDeclSyntax { return e.name.text }
    if let a = self as? ActorDeclSyntax { return a.name.text }
    return nil
  }

  /// Identifiers of static variables whose explicit type annotation matches
  /// the parent type's name — i.e. the `Self`-typed static members.
  fileprivate var selfTypedStaticVariableIdentifiers: [String] {
    let name = typeName ?? "Self"
    return memberBlock.members
      .flatMap { $0.children(viewMode: .fixedUp).compactMap { $0.as(VariableDeclSyntax.self) } }
      .filter { $0.hasStaticModifier && $0.hasDeclaredType(name) }
      .compactMap(\.firstBindingIdentifier)
  }

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

  /// Returns `true` if any binding carries an explicit type annotation whose
  /// trimmed text matches `typeName`.
  ///
  /// Handles the common simple case: `static let x: TypeName = ...`
  /// Does not match inferred types, optionals (`TypeName?`), or
  /// collections (`[TypeName]`) — intentionally, since those aren't
  /// cleanly `Self`-typed for the purposes of `allStaticMembers`.
  fileprivate func hasDeclaredType(_ typeName: String) -> Bool {
    bindings.contains { binding in
      binding.typeAnnotation?.type.trimmedDescription == typeName
    }
  }
}
