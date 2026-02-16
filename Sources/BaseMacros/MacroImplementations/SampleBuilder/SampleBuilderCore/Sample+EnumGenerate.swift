//
//  Sample+EnumGenerate.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 16/2/2026.
//

import BasePrimitives
import SwiftCompilerPlugin
import SwiftDiagnostics
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

extension SampleBuilderMacro {

  /// Example output:
  /// ```
  /// [
  ///   .case1(DataGenerator.random().int(), DataGenerator.random().string()),
  ///   .case2,
  ///   .case3(Product.sample.first!),
  ///   .case4([DataGenerator.random().string(): Product.sample.first!]),
  /// ]
  /// ```
  static func generateSampleArrayCases(
    cases: [EnumCaseDeclSyntax],
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
//          accessLevel: access,
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

}
