//
//  Sample+StructGenerate.swift
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
  ///   .init(price: DataGenerator.random().int(), description: ...),
  ///   .init(price: DataGenerator.random().int(), description: ...),
  ///   .init(price: DataGenerator.random().int(), description: ...),
  /// ]
  /// ```
  static func generateSampleData(
    parameters: [ParameterItem],
    numberOfItems: Int,
    generatorType: DataGeneratorType
  ) -> ArrayElementListSyntax {
    let parameterList = getParameterListForSampleElement(
      parameters: parameters,
      generatorType: generatorType
    )

    var arrayElementListSyntax = ArrayElementListSyntax()

    for _ in 1...numberOfItems {
      arrayElementListSyntax
        .append(
          ArrayElementSyntax(
            leadingTrivia: .newline,
            expression: FunctionCallExprSyntax(
              calledExpression: MemberAccessExprSyntax(
                period: .periodToken(),
                name: .keyword(.`init`)
              ),
              leftParen: .leftParenToken(),
              arguments: parameterList,
              rightParen: .rightParenToken()
            ),
            trailingComma: .commaToken()
          )
        )
    }

    return arrayElementListSyntax
  }
}
