//
//  OtherHelpers.swift
//  BaseMacros
//
//  Created by Dave Coleman on 20/5/2025.
//

import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros
import MacroToolkit

extension String {
  public var toDeclSyntax: DeclSyntax {
    DeclSyntax(stringLiteral: self)
  }
}

package enum MacroHelpers {

  // MARK: - Nested
  public static func findNestedStruct(
    in structDecl: StructDeclSyntax,
    withTypeName typeName: IdentifierTypeSyntax
  ) -> StructDeclSyntax? {

    let nestedStruct = findNestedStructs(in: structDecl) { nestedDecl in
      nestedDecl.name.text == typeName.name.text
    }
    .first

    if nestedStruct == nil {
      print("Couldn't find it")
    }

    return nestedStruct
  }

  private static func findNestedStructs(
    in structDecl: StructDeclSyntax,
    where predicate: (StructDeclSyntax) -> Bool
  ) -> [StructDeclSyntax] {

    return structDecl.memberBlock.members.compactMap { member in
      if let nestedDecl = member.decl.as(StructDeclSyntax.self), predicate(nestedDecl) {
        return nestedDecl
      }
      return nil
    }
  }

  /// This returns *all* structs found, no matching against anything.
  /// Helpful for debugging, seeing what (if anything) can be found.
  public static func listNestedStructs(
    in structDecl: StructDeclSyntax
  ) -> [StructDeclSyntax] {
    return findNestedStructs(in: structDecl) { _ in true }
  }

}

extension AttributeSyntax {

  /// Uses MacroToolKit, returns bool value for a Macro attribute if present.
  /// Such as `@CaseDetection(includesNames: true)`
  public func boolArgument(labeled label: String) -> Bool {
    let argument = MacroAttribute(self).argument(labeled: label)?.asBooleanLiteral
    return argument?.value ?? false
  }
}

extension TypeSyntax {
  var isArray: Bool { self.as(ArrayTypeSyntax.self) != nil }
  var isSimpleType: Bool { self.as(IdentifierTypeSyntax.self) != nil }
  var isDictionary: Bool { self.as(DictionaryTypeSyntax.self) != nil }
  var isOptional: Bool { self.as(OptionalTypeSyntax.self) != nil }
}


//extension MacroHelpers {

//  public static func retrieveStringArgument(from node: AttributeSyntax) -> String? {
//    /// Check if there are any arguments.
//    /// `LabeledExprListSyntax` refers to the list of parameters in a function signature.
//    /// `StringLiteralExprSyntax` refers to parameters of type `String`.
//    guard let arguments = node.arguments?.as(LabeledExprListSyntax.self),
//      !arguments.isEmpty,
//      let firstArgExpression = arguments.first?.expression,
//      let stringExpression = firstArgExpression.as(StringLiteralExprSyntax.self)
//    else {
//      return nil
//    }
//
//    /// Extract the string value
//    let segments: StringLiteralSegmentListSyntax = stringExpression.segments
//    guard segments.count == 1, let segment = segments.first?.as(StringSegmentSyntax.self) else {
//      return nil
//    }
//    return segment.content.text
//  }

//  public static func findTypeName(
//    in structDecl: StructDeclSyntax,
//    forProperty propertyType: VariableDeclSyntax
//  ) -> IdentifierTypeSyntax? {
//
//    if let binding = propertyType.bindings.first,
//      let typeAnnotation = binding.typeAnnotation,
//      let typeName = typeAnnotation.type.as(IdentifierTypeSyntax.self)
//    {
//      return typeName
//    }
//    return nil
//  }

//  public static func findExtensions(
//    of structDecl: StructDeclSyntax,
//    in context: some MacroExpansionContext
//  ) -> [ExtensionDeclSyntax] {
//    /// Get the parent node of the struct declaration
//    guard let parent = structDecl.parent else {
//      return []
//    }
//
//    /// Traverse the parent node to find extensions of the original struct
//    var extensions: [ExtensionDeclSyntax] = []
//    for child in parent.children(viewMode: .all) {
//      if let ext = child.as(ExtensionDeclSyntax.self),
//        ext.extendedType.as(IdentifierTypeSyntax.self)?.name.text == structDecl.name.text
//      {
//        extensions.append(ext)
//      }
//    }
//
//    return extensions
//  }

//}

extension Array where Element == String {
  var joinedLines: String { joined(separator: "\n") }

  func joined(_ separator: String) -> String {
    joined(separator: separator)
  }
}

extension String {
  var camelCaseToSnakeCase: String {
    var result = ""

    for (index, char) in enumerated() {
      if char.isUppercase {
        if index > 0 { result.append("_") }
        result.append(char.lowercased())
      } else {
        result.append(char)
      }
    }

    return result
  }
}
