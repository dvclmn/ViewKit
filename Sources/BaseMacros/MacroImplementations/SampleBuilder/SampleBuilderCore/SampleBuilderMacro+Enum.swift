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

    let access = Enum(enumDecl).accessLevel

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
        numberOfItems: numberOfItems,
        generatorType: generatorType
      ),
      access: access
    )

    return [DeclSyntax(sampleCode)]
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
