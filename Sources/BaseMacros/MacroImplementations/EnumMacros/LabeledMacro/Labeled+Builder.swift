//
//  Labeled+Builder.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 18/2/2026.
//

import MacroToolkit
import SwiftDiagnostics
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

struct LabeledBuilder {
  let detectedEnum: Enum

  init(
    node: AttributeSyntax,
    decl: some DeclGroupSyntax,
    context: some MacroExpansionContext
  ) throws {
    self.detectedEnum = try LabeledHelpers.detectEnum(
      in: decl,
      context: context
    )
  }
}
extension LabeledBuilder {
  func build() -> [DeclSyntax] {
    [
      DeclSyntax("\(raw: detectedEnum.access) var id: String { rawValue }"),
      DeclSyntax("\(raw: detectedEnum.access) var name: String { rawValue.capitalized }"),
//      DeclSyntax("\(raw: detectedEnum.access) var icon: LabelIcon? { rawValue.capitalized }"),
      DeclSyntax("\(raw: detectedEnum.access) var label: String { QuickLabel(name, icon: IconLiteral(from: icon)) }"),
    ]
  }
}
