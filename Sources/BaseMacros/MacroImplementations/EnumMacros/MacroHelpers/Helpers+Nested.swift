//
//  NestedTypes.swift
//  BaseMacros
//
//  Created by Dave Coleman on 7/3/2025.
//

import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

extension MacroHelpers {

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
