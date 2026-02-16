/*
 This source file is part of SwiftAndTipsMacros

 Copyright (c) 2023 Pedro Rojas and project authors
 Licensed under MIT License
*/

//
//  SampleBuilderMacro+Enum.swift
//
//
//  Created by Pedro Rojas on 19/08/23.
//

import BasePrimitives
import MacroToolkit
import SwiftSyntax
import SwiftSyntaxMacros

// MARK: - Enums
extension SampleBuilderMacro {
  static func SampleBuilderMacroForEnum(
    enumDecl: EnumDeclSyntax,
    numberOfItems: Int,
    generatorType: DataGeneratorType,
    context: some SwiftSyntaxMacros.MacroExpansionContext
  ) -> [SwiftSyntax.DeclSyntax] {

    let cases = enumDecl.memberBlock.members.compactMap {
      $0.decl.as(EnumCaseDeclSyntax.self)
    }

    let access = Enum(enumDecl).access

    if cases.isEmpty {
      SampleBuilderDiagnostic.report(
        diagnostic: .enumWithEmptyCases,
        node: Syntax(enumDecl),
        context: context
      )
      return []
    }

    let sampleCode = generateSampleCodeSyntax(
      sampleData: generateSampleArrayCases(
        cases: cases,
        access: access,
        numberOfItems: numberOfItems,
        generatorType: generatorType
      )
    )

    return [DeclSyntax(sampleCode)]
  }

  static func generateSampleArrayCases(
    cases: [EnumCaseDeclSyntax],
    access: String,
    numberOfItems: Int,
    generatorType: DataGeneratorType
  ) -> ArrayElementListSyntax {
    var arrayElementListSyntax = ArrayElementListSyntax()

    let totalNumberOfCases = replicateCases(
      cases: cases,
      numberOfItems: numberOfItems
    )

    for caseItem in totalNumberOfCases {
      let parameters = caseItem.parameters.map {
        ParameterItem(
          identifierName: $0.0?.text,
          identifierType: $0.1,
          category: nil,
          accessLevel: access,
        )
      }

      let caseExpression =
        if caseItem.hasAssociatedValues {
          ExprSyntax(
            FunctionCallExprSyntax(
              calledExpression: MemberAccessExprSyntax(
                period: .periodToken(),
                name: .identifier(caseItem.name)
              ),
              leftParen: .leftParenToken(),
              arguments: getParameterListForSampleElement(
                parameters: parameters,
                generatorType: generatorType
              ),
              rightParen: .rightParenToken()
            )
          )
        } else {
          ExprSyntax(
            MemberAccessExprSyntax(
              period: .periodToken(),
              name: .identifier(caseItem.name)
            )
          )
        }

      arrayElementListSyntax.append(
        ArrayElementSyntax(
          leadingTrivia: .newline,
          expression: caseExpression,
          trailingComma: .commaToken()
        )
      )
    }

    return arrayElementListSyntax
  }

  static func replicateCases(
    cases: [EnumCaseDeclSyntax],
    numberOfItems: Int
  ) -> [EnumCaseDeclSyntax] {
    var totalNumberOfCases: [EnumCaseDeclSyntax] = []

    /// we will extend the cases according to the number of items.
    /// for example, if cases are [case1, case2, case3]
    /// and numberOfItems = 2, the result should be [case1, case2].
    ///
    /// If cases are [case1, case2] and numberOfItems = 7, the result
    /// should be [case1, case2, case1, case2, case1, case2, case1]
    for i in 0..<numberOfItems {
      totalNumberOfCases.append(
        cases[i % cases.count]
      )
    }

    return totalNumberOfCases
  }
}

extension EnumCaseDeclSyntax {
  var hasAssociatedValues: Bool {
    self.elements.first?.parameterClause != nil
  }

  var name: String {
    guard let caseName = self.elements.first?.name.text
    else {
      fatalError("Compiler Bug: Case name not found")
    }

    return caseName
  }

  var parameters: [(TokenSyntax?, TypeSyntax)] {
    self.elements.first?.parameterClause?.parameters.map {
      ($0.firstName, $0.type)
    } ?? []
  }
}
