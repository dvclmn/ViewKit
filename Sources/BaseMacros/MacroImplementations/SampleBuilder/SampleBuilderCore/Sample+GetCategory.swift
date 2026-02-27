//
//  Sample+GetCategory.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 16/2/2026.
//

import SwiftCompilerPlugin
import SwiftDiagnostics
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

extension SampleBuilderMacro {

  static func getDataCategory(
    from variableDecl: VariableDeclSyntax,
    generatorType: DataGeneratorType,
    context: MacroExpansionContext
  ) -> DataCategory? {

    /// Skip categorization for ignored properties
    if variableDecl.hasSamplesIgnoredAttribute {
      return nil
    }

    /// Check if SampleBuilderItem is used.
    guard
      let attribute = variableDecl.attributes
        .first(where: {
          $0.as(AttributeSyntax.self)?
            .attributeName
            .as(IdentifierTypeSyntax.self)?
            .name.text == "SampleBuilderItem"
        })?.as(AttributeSyntax.self)

    else {
      return DataCategory.noCategory
    }

    if generatorType == .default {
      /// Since default will always the return the same value,
      /// Using SampleBuilderItem is useless and will throw a warning.
      SampleBuilderDiagnostic.report(
        diagnostic: .sampleBuilderItemRedundant,
        node: Syntax(attribute),
        context: context
      )
    }

    if let simpleCategoryString = attribute  // All categories except image
      .arguments?
      .as(LabeledExprListSyntax.self)?
      .first?.expression
      .as(MemberAccessExprSyntax.self)?
      .declName.baseName.text
    {

      return DataCategory(rawValue: simpleCategoryString)
    }

    if let imageCategoryExpression = attribute
      .arguments?
      .as(LabeledExprListSyntax.self)?.first?
      .expression.as(FunctionCallExprSyntax.self),

      imageCategoryExpression
        .calledExpression.as(MemberAccessExprSyntax.self)?
        .declName.baseName.text == "image"
    {

      /// Image's width and height
      let argumentsValues = imageCategoryExpression.arguments.compactMap {
        Int($0.expression.as(IntegerLiteralExprSyntax.self)?.literal.text ?? "")
      }

      guard argumentsValues.count == 2
      else {
        return DataCategory.noCategory
      }

      return DataCategory(imageWidth: argumentsValues[0], height: argumentsValues[1])
    }

    return DataCategory.noCategory
  }
}
