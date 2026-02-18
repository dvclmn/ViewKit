//
//  LabeledIconMacro.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 18/2/2026.
//

import MacroToolkit
import SwiftDiagnostics
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros
import BasePrimitives

public struct LabeledIconMacro: PeerMacro {

  public static func expansion(
    of node: SwiftSyntax.AttributeSyntax,
    providingPeersOf declaration: some SwiftSyntax.DeclSyntaxProtocol,
    in context: some SwiftSyntaxMacros.MacroExpansionContext
  ) throws -> [SwiftSyntax.DeclSyntax] {
    
    let icon = getIcon(from: node)
    
    guard let enumCase = declaration.as(EnumCaseDeclSyntax.self)
//      let variableDecl =
//        declaration
//        .as(EnumCase.self),
//      variableDecl.isStoredProperty
    else {
      throw MacroError("@Icon can only be attached to an enum case")
//      SampleBuilderItemDiagnostic.report(
//        diagnostic: .notAStoredProperty,
//        node: node,
//        context: context
//      )
      return []
    }

    
    /// Ultimately this returns nothing, but trying to get the kind of
    /// icon defined by the user, attached to an enum case, such as
    /// `@Icon(.symbol("tray.fill")) case tray`
    return []
  }
  
  /// Extracts the provided `SampleBuilderItemCategory` from the
  /// `@SampleBuilderItem` peer macro `category` argument.
  /// `AttributeSyntax` refers to the `@​Sample​Builder​Item` attribute itself
  static func getIcon(from node: AttributeSyntax) -> LabelIcon {
//  static func getDataCategory(from node: AttributeSyntax) -> DataCategory {
    guard let argumentTuple = node.arguments?.as(LabeledExprListSyntax.self)?.first else {
//      fatalError("Compiler bug: Argument must exist")
    }
    
    let iconType = argumentTuple
      .expression
      .as(MemberAccessExprSyntax.self)
//      .declName.baseName.text,
    
//    guard iconType, let iconResult = iconType as? LabelIcon else {
//      throw
//    }
      
    }
        
//    let iconResult = LabelIcon
    

    
      
//    } else if let imageCategoryString = argumentTuple
//      .expression
//      .as(FunctionCallExprSyntax.self)?
//      .description
//      .dropFirst(),  // it removes the dot from .image(...)
//              let dataCategory = DataCategory(rawValue: String(imageCategoryString))
//    {
//      return dataCategory
//    }
//    
//    fatalError("Compiler bug: Argument must exist")
  }
}
