//
//  SampleBuilder+Helpers.swift
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
  static func generateSampleCodeSyntax(
    sampleData: ArrayElementListSyntax
  ) -> IfConfigDeclSyntax {
    let returnType = ArrayTypeSyntax(
      leftSquare: .leftSquareToken(),
      element: IdentifierTypeSyntax(
        name: .keyword(.Self)
      ),
      rightSquare: .rightSquareToken()
    )

    let sampleCode = VariableDeclSyntax(
      modifiers: DeclModifierListSyntax {
        DeclModifierSyntax(name: .keyword(.static))
      },
      bindingSpecifier: .keyword(.var),
      bindings: PatternBindingListSyntax {
        PatternBindingSyntax(
          pattern: IdentifierPatternSyntax(
            identifier: .identifier("sample")
          ),
          typeAnnotation: TypeAnnotationSyntax(
            colon: .colonToken(),
            type: returnType
          ),
          accessorBlock: AccessorBlockSyntax(
            leftBrace: .leftBraceToken(),
            accessors: .getter(
              CodeBlockItemListSyntax {
                CodeBlockItemSyntax(
                  item: .expr(
                    ExprSyntax(
                      ArrayExprSyntax(
                        leftSquare: .leftSquareToken(),
                        elements: sampleData,
                        rightSquare: .rightSquareToken(leadingTrivia: .newline)
                      )
                    )
                  )
                )

              }
            ),
            rightBrace: .rightBraceToken()
          )
        )
      }
    )

    // This will make the code available only on DEBUG mode
    return IfConfigDeclSyntax(
      clauses: IfConfigClauseListSyntax {
        IfConfigClauseSyntax(
          poundKeyword: .poundIfToken(),
          condition: DeclReferenceExprSyntax(
            baseName: .identifier("DEBUG")
          ),
          elements: .decls(
            MemberBlockItemListSyntax {
              MemberBlockItemSyntax(decl: sampleCode)
            }
          )
        )
      }
    )
  }

  static func getDataGeneratorType(
    from node: SwiftSyntax.AttributeSyntax
  ) -> DataGeneratorType {
    guard let argumentTuple = node.arguments?.as(LabeledExprListSyntax.self)
    else {
      fatalError("Compiler bug: Argument must exist")
    }

    guard
      let generatorArgument = argumentTuple.first(
        where: { $0.label?.text == "dataGeneratorType" }
      ),
      let argumentValue = generatorArgument.expression.as(MemberAccessExprSyntax.self)?.declName.baseName,
      let generatorType = DataGeneratorType(rawValue: argumentValue.text)
    else {
      // return default generator type
      return .random
    }

    return generatorType
  }

  static func getNumberOfItems(
    from node: SwiftSyntax.AttributeSyntax
  ) throws -> Int {
    guard let argumentTuple = node.arguments?.as(LabeledExprListSyntax.self)?.first
    else {
      fatalError("Compiler bug: Argument must exist")
    }

    if let prefixExpression = argumentTuple
      .expression
      .as(PrefixOperatorExprSyntax.self)
    {
      return negativeNumberOfItems(expression: prefixExpression)
      
    } else if let integerExpression = argumentTuple
      .expression
      .as(IntegerLiteralExprSyntax.self),
      let numberOfItems = Int(integerExpression.literal.text)
    {
      return numberOfItems
    }

    return 0  // Will throw .argumentNotGreaterThanZero in Xcode
  }

  static func negativeNumberOfItems(
    expression: PrefixOperatorExprSyntax
  ) -> Int {
    let operatorToken = expression
      .operator
      .text

    guard
      let integerExpression = expression
        .expression
        .as(IntegerLiteralExprSyntax.self),
      let numberOfItems = Int(operatorToken + integerExpression.literal.text)
    else {
      return 0  // Will throw .argumentNotGreaterThanZero in Xcode
    }

    return numberOfItems
  }

  /// Used for both Structs and Enums
  static func getParameterListForSampleElement(
    parameters: [ParameterItem],
    generatorType: DataGeneratorType
  ) -> LabeledExprListSyntax {

    var parameterList = LabeledExprListSyntax()

    for parameter in parameters {

      let expressionSyntax = getExpressionSyntax(
        from: parameter.identifierType,
        generatorType: generatorType,
        category: parameter.category
      )

      let isNotLast = parameter.identifierType != parameters.last?.identifierType
      let parameterElement = LabeledExprSyntax(
        label: parameter.hasName ? .identifier(parameter.identifierName!) : nil,
        colon: parameter.hasName ? .colonToken() : nil,
        expression: expressionSyntax,
        trailingComma: isNotLast ? .commaToken() : nil
      )

      parameterList.append(parameterElement)
    }

    return parameterList
  }

}
// MARK: - Attribute helpers

extension AttributeSyntax {
  /// Returns true if this attribute's name matches `SamplesIgnored`, supporting
  /// both unqualified (e.g., `@SamplesIgnored`) and module-qualified names
  fileprivate var isSamplesIgnored: Bool {
    /// Use a robust textual check on the attribute name to avoid tight coupling
    /// to specific SwiftSyntax node kinds. This covers `IdentifierTypeSyntax`,
    /// `MemberTypeSyntax`, and other type name forms.
    let name = attributeName.trimmedDescription
    return name == "SamplesIgnored" || name.hasSuffix(".SamplesIgnored")
  }
}

extension VariableDeclSyntax {
  /// True when the declaration has an attached `@SamplesIgnored` attribute.
  var hasSamplesIgnoredAttribute: Bool {
    for item in attributes {
      if let attr = item.as(AttributeSyntax.self), attr.isSamplesIgnored {
        return true
      }
    }
    return false
  }
}

extension SampleBuilderMacro {
  /// Convenience filter to remove variables marked with `@SamplesIgnored`.
  /// Use this in places like `getValidParameterList` before mapping to
  /// `ParameterItem`.
  static func filterOutIgnored(_ variables: [VariableDeclSyntax]) -> [VariableDeclSyntax] {
    variables.filter { !$0.hasSamplesIgnoredAttribute }
  }
}
