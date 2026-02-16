/*
 This source file is part of SwiftAndTipsMacros

 Copyright (c) 2023 Pedro Rojas and project authors
 Licensed under MIT License
*/

//
//  SampleBuilderMacro+Struct.swift
//
//
//  Created by Pedro Rojas on 19/08/23.
//

import BasePrimitives
import MacroToolkit
import SwiftSyntax
import SwiftSyntaxMacros

extension SampleBuilderMacro {
  static func SampleBuilderMacroForStruct(
    structDecl: StructDeclSyntax,
    numberOfItems: Int,
    generatorType: DataGeneratorType,
    context: MacroExpansionContext
  ) -> [SwiftSyntax.DeclSyntax] {
    let validParameters = getValidParameterList(
      from: structDecl,
      generatorType: generatorType,
      context: context
    )

    let sampleCode = generateSampleCodeSyntax(
      sampleData: generateSampleData(
        parameters: validParameters,
        numberOfItems: numberOfItems,
        generatorType: generatorType
      )
    )

    return [DeclSyntax(sampleCode)]
  }

  static func getValidParameterList(
    from structDecl: StructDeclSyntax,
    generatorType: DataGeneratorType,
    context: MacroExpansionContext
  ) -> [ParameterItem] {
    let storedPropertyMembers = filterOutIgnored(
      structDecl.memberBlock.members
        .compactMap { $0.decl.as(VariableDeclSyntax.self) }
        .filter { $0.isStoredProperty }
    )

    let initMembers = structDecl.memberBlock.members
      .compactMap {
        $0.decl.as(InitializerDeclSyntax.self)
      }



    if initMembers.isEmpty {
      /// No custom init around. We use the memberwise initializer's properties:
      return storedPropertyMembers.compactMap {
        if let identifier = $0.bindings.first?
          .pattern
          .as(IdentifierPatternSyntax.self)?
          .identifier.text,
          let type = $0.bindings.first?
            .typeAnnotation?
            .type
        {

          return (identifier, type, getDataCategory(from: $0, generatorType: generatorType, context: context))
        }

        return nil
      }.map {
        ParameterItem(
          identifierName: $0.0,
          identifierType: $0.1,
          category: $0.2,
//          accessLevel: access,
        )
      }
    }

    let largestParameterList =
      initMembers
      .map {
        getParametersFromInit(initSyntax: $0, access: access)
      }.max {
        $0.count < $1.count
      } ?? []

    return largestParameterList
  }

  static func getParametersFromInit(
    initSyntax: InitializerDeclSyntax,
//    access: String,
  ) -> [ParameterItem] {
    let parameters = initSyntax.signature.parameterClause.parameters

    return parameters.map {
      ParameterItem(
        identifierName: $0.firstName.text,
        identifierType: $0.type,
        category: nil,
//        accessLevel: access
      )
    }
  }

}
