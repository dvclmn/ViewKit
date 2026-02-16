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

  /// Identifiers of static variables that are "self-typed":
  /// either explicitly (`Self` / `MyType` / qualified `Module.MyType`)
  /// or inferred via obvious initialisers (`.init()`, `MyType()`, etc.)
  fileprivate var selfTypedStaticVariableIdentifiers: [String] {
    guard let typeName else { return [] }
    let acceptedTypeNames: Set<String> = [typeName, "Self"]
    
    return memberBlock.members
      .flatMap { $0.children(viewMode: .fixedUp).compactMap { $0.as(VariableDeclSyntax.self) } }
      .filter(\.hasStaticModifier)
      .flatMap { decl in
        decl.bindings.compactMap { binding -> String? in
          guard let ident = binding.pattern.as(IdentifierPatternSyntax.self)?.identifier.text else {
            return nil
          }
          
          // 1) Explicitly typed?
          if let annotated = binding.typeAnnotation?.type.simpleTypeName,
             acceptedTypeNames.contains(annotated) || annotated == typeName
          {
            return ident
          }
          
          // 2) No type annotation — try infer from initializer
          if binding.typeAnnotation == nil,
             let initExpr = binding.initializer?.value,
             initExpr.isObviouslySelfInitialiser(enclosingTypeName: typeName)
          {
            return ident
          }
          
          return nil
        }
      }
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

extension TypeSyntax {
  /// Best-effort "base" name for simple comparisons.
  /// - `Self` -> "Self"
  /// - `MyRecord` -> "MyRecord"
  /// - `MyModule.MyRecord` -> "MyRecord"
  fileprivate var simpleTypeName: String? {
    if let ident = self.as(IdentifierTypeSyntax.self) {
      return ident.name.text
    }
    if let member = self.as(MemberTypeSyntax.self) {
      return member.name.text
    }
    return trimmedDescription
  }
}

extension ExprSyntax {
  /// Heuristically detect obvious "this constructs Self" initialisers:
  /// `.init(...)`, `Self.init(...)`, `MyType(...)`, `MyType.init(...)`
  fileprivate func isObviouslySelfInitialiser(enclosingTypeName: String) -> Bool {
    guard let call = self.as(FunctionCallExprSyntax.self) else { return false }
    
    // `.init(...)` or `Self.init(...)` or `MyType.init(...)`
    if let member = call.calledExpression.as(MemberAccessExprSyntax.self),
       member.declName.baseName.text == "init"
    {
      // `.init(...)` (no base) => within type context, this is Self
      if member.base == nil { return true }
      
      // `Self.init(...)` or `MyType.init(...)`
      if let baseIdent = member.base?.as(DeclReferenceExprSyntax.self)?.baseName.text {
        return baseIdent == "Self" || baseIdent == enclosingTypeName
      }
      
      // Sometimes bases appear as identifiers in other shapes — fall back on text
      let baseText = member.base?.trimmedDescription
      if baseText == "Self" || baseText == enclosingTypeName { return true }
    }
    
    // `MyType(...)` (calling the type as a function)
    if let callee = call.calledExpression.as(DeclReferenceExprSyntax.self)?.baseName.text {
      return callee == enclosingTypeName
    }
    
    return false
  }
}
