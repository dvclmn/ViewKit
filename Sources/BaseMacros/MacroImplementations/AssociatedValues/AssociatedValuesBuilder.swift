//
//  AssociatedValuesBuilder.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 9/2/2026.
//

import MacroToolkit
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

struct AssociatedValuesBuilder {

  let detectedEnum: Enum

  init(
    node: AttributeSyntax,
    decl: some DeclGroupSyntax,
  ) throws {
    /// Guards the whole `AssociatedValuesBuilder` type behind a
    /// fundamental check to ensure we're working with an enum
    guard let enumDecl = decl as? EnumDeclSyntax else {
      throw MacroError("@AssociatedValues can only be attached to an enum declaration")
    }
    self.detectedEnum = Enum(enumDecl)
  }
}

extension AssociatedValuesBuilder {

  func build() -> [DeclSyntax] {
    
    detectedEnum.cases.compactMap { element -> DeclSyntax? in
      guard let associatedValue = element.associatedValues else {
        return nil
      }
      
      let parameters = associatedValue.parameters
      let isSingleValue = parameters.count == 1
      
      /// 1. Determine the return type string
      let typeString: String
      if isSingleValue, let firstParam = parameters.first {
        typeString = "\(firstParam.type)"
      } else {
        typeString = "\(associatedValue)"
      }
      
      /// 2. Generate internal variable names for the pattern match
      let variableNames = uniquedVariableNames(parameters)
      
      /// 3. Build the computed property
      let returnExpression: String
      if isSingleValue {
        returnExpression = "v0"
      } else {
        returnExpression = "(\(variableNames))"
      }
      
      return DeclSyntax(
        try! VariableDeclSyntax(
          """
          \(detectedEnum.modifiers)var \(raw: element.name)Value: \(raw: typeString)? {
            if case let .\(raw: element.name)(\(raw: variableNames)) = self {
              return \(raw: returnExpression)
            }
            return nil
          }
          """
        )
      )
    }
  }
  
//  func build() -> [DeclSyntax] {
//
//    //    let cases = try detectedEnum.memberBlock.members.compactMap {
//    //      $0.decl.as(EnumCaseDeclSyntax.self)?
//    //        .elements
//    //        .compactMap { $0 }
//    //    }
//
//    let thing = detectedEnum.cases
//      .compactMap { element -> EnumCase? in
//        //      .compactMap { element -> DeclSyntax? in
//        guard let associatedValue = element.associatedValues else {
//          return nil
//        }
//
//        let parameters = associatedValue.parameters
//        let isSingleValue = parameters.count == 1
//
//        /// 1. Determine the return type string
//        /// If single: just the type (e.g., `CGRect`)
//        /// If multiple: the full parameter clause (e.g., `(x: Int, y: Int)`)
//        let typeString: String
//        if isSingleValue, let firstParam = parameters.first {
//          typeString = "\(firstParam.type)"
//        } else {
//          typeString = "\(associatedValue)"
//        }
//
//        /// 2. Generate internal variable names for the pattern match
//
//        let variableDecl = try VariableDeclSyntax(
//          """
//          \(detectedEnum.modifiers)var \(raw: element.name)Value: \(raw: typeString)?
//          """)
//
//        //        providingMembersOf declaration: some DeclGroupSyntax,
//        //        return DeclSyntax(
//        //          try VariableDeclSyntax() {
//        //            try IfExprSyntax("if case let .\(element.name)(\(raw: variableNames)) = self") {
//        //              if isSingleValue {
//        //                "return v0"
//        //              } else {
//        //                "return (\(raw: variableNames))"
//        //              }
//        //            }
//        //            "return nil"
//        //          }
//        //        )
//      }  // end compact map
//
//    //    return
//  }
}
