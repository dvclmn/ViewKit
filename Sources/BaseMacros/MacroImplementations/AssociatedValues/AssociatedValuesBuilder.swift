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
    cases
      .filter(\.hasAssociatedValues)
      .compactMap { makeComputedProperty(for: $0) }
  }

  /// Generates the property name for a case's associated values
  /// e.g., "fern" -> "fernValue"
  private func propertyName(for enumCase: EnumCase) -> String {
    "\(enumCase.name)Value"
  }

  // MARK: - Property Generation

  /// Creates a computed property that extracts associated values from an enum case
  private func makeComputedProperty(for enumCase: EnumCase) -> DeclSyntax? {
    guard let associatedValue = enumCase.associatedValues else {
      return nil
    }

    let parameters = associatedValue.parameters
    let typeString = returnTypeString(for: associatedValue)
    let variableNames = uniquedVariableNames(parameters)
    let returnExpression = buildReturnExpression(
      variableNames: variableNames,
      isSingleValue: parameters.count == 1
    )
    let propertyName = propertyName(for: enumCase)

    return DeclSyntax(
      try! VariableDeclSyntax(
        """
        \(detectedEnum.modifiers)var \(raw: propertyName): \(raw: typeString)? {
          if case let .\(raw: enumCase.name)(\(raw: variableNames)) = self {
            return \(raw: returnExpression)
          }
          return nil
        }
        """
      )
    )
  }

  // MARK: - Type String Generation

  /// Determines the return type for the computed property.
  /// - Single associated value: returns the type directly (e.g., `Int`)
  /// - Multiple associated values: returns the full parameter clause as a tuple (e.g., `(String, Bool)`)
  private func returnTypeString(for associatedValue: EnumCaseParameterClauseSyntax) -> String {
    let parameters = associatedValue.parameters

    guard parameters.count == 1, let firstParam = parameters.first else {
      return "\(associatedValue)"
    }
    return "\(firstParam.type)"
  }

  // MARK: - Return Expression Generation

  /// Builds the return expression for the computed property body.
  /// - Single value: returns `v0`
  /// - Multiple values: returns tuple `(v0, v1, ...)`
  private func buildReturnExpression(variableNames: String, isSingleValue: Bool) -> String {
    guard isSingleValue else {
      return "(\(variableNames))"
    }
    return "v0"
  }

  // MARK: - Variable Name Generation

  /// Creates enumerated and v-prefixed variable names for pattern matching
  /// e.g., "v0" or "v0, v1, v2"
  package func uniquedVariableNames(_ parameters: EnumCaseParameterListSyntax) -> String {
    parameters
      .enumerated()
      .map { index, _ in "v\(index)" }
      .joined(separator: ", ")
  }
  //  func build() -> [DeclSyntax] {
  //
  //    detectedEnum.cases.compactMap { element -> DeclSyntax? in
  //      guard let associatedValue = element.associatedValues else {
  //        return nil
  //      }
  //
  //      let parameters = associatedValue.parameters
  //      let isSingleValue = parameters.count == 1
  //
  //      /// 1. Determine the return type string
  //      let typeString: String
  //      if isSingleValue, let firstParam = parameters.first {
  //        typeString = "\(firstParam.type)"
  //      } else {
  //        typeString = "\(associatedValue)"
  //      }
  //
  //      /// 2. Generate internal variable names for the pattern match
  //      let variableNames = uniquedVariableNames(parameters)
  //
  //      /// 3. Build the computed property
  //      let returnExpression: String
  //      if isSingleValue {
  //        returnExpression = "v0"
  //      } else {
  //        returnExpression = "(\(variableNames))"
  //      }
  //
  //      return DeclSyntax(
  //        try! VariableDeclSyntax(
  //          """
  //          \(detectedEnum.modifiers)var \(raw: element.name)Value: \(raw: typeString)? {
  //            if case let .\(raw: element.name)(\(raw: variableNames)) = self {
  //              return \(raw: returnExpression)
  //            }
  //            return nil
  //          }
  //          """
  //        )
  //      )
  //    }
  //  }

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
