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
  func build() throws -> [DeclSyntax] {
    // Build a switch body for 'icon' by scanning enum cases for @Icon
//    let switchCases: [String] = try detectedEnum.cases.map { enumCase in
//
//      guard let caseNative = EnumCaseDeclSyntax(enumCase._syntax) else {
//        throw MacroError("Couldn't cast to `EnumCaseDeclSyntax`")
//      }
//
//      let attrs = caseNative.attributes
//      let hasIconAttr = attrs.contains { element in
//        element.as(AttributeSyntax.self)?.attributeName.trimmedDescription == "Icon"
//      }
//      guard hasIconAttr else {
//        throw MacroError("`@Icon` attribute not found")
//      }
//
//      guard let first = attrs.first?.as(AttributeSyntax.self) else {
//        throw MacroError("Error getting first attribute")
//      }

//      return "Nothing"
      //      let attribute = MacroAttribute(first)
      //      let arg = attribute.argument(labeled: "icon")

      //      let arg = first.arguments
      //
      //      if let iconString = arg?._syntax.as(.) {
      //
      //      }
      //      let firstArg = attrs.compactMap { element in
      //        element.
      //        element.arguments?.as(LabeledExprListSyntax.self)?.first
      //      }
      // Look for a peer @Icon attribute attached to this case element
      //      if let attrs = enumCase._syntax.
      //         attrs.contains(where: { attr in
      //           attr.as(AttributeSyntax.self)?.attributeName.trimmedDescription == "Icon"
      //         }) {
      //        // Extract the argument text of @Icon(...) and try to map to IconLiteral
      //        if let attr = attrs.compactMap({ $0.as(AttributeSyntax.self) }).first(where: { $0.attributeName.trimmedDescription == "Icon" }),
      //           let firstArg = attr.arguments?.as(LabeledExprListSyntax.self)?.first {
      //          let argExpr = firstArg.expression
      //          // Support .symbol("...") and .emoji("...") and bare string literal
      //          if let call = argExpr.as(FunctionCallExprSyntax.self),
      //             let member = call.calledExpression.as(MemberAccessExprSyntax.self) {
      //            let baseName = member.declName.baseName.text
      //            if let str = call.arguments.first?.expression.as(StringLiteralExprSyntax.self)?.segments.compactMap({ $0.as(StringSegmentSyntax.self)?.content.text }).joined() {
      //              if baseName == "symbol" { return "case .\(caseName): return .symbol(\"\(str)\")" }
      //              if baseName == "emoji" { return "case .\(caseName): return .emoji(\"\(str)\")" }
      //            }
      //          }
      //          if let strLit = argExpr.as(StringLiteralExprSyntax.self) {
      //            let value = strLit.segments.compactMap { $0.as(StringSegmentSyntax.self)?.content.text }.joined()
      //            return "case .\(caseName): return .symbol(\"\(value)\")"
      //          }
      //        }
      //      }
      //      // Default: no icon for this case
      //      return "case .\(caseName): return nil"
//    }

//    let iconSwitch = (["switch self:"] + switchCases).joined(separator: "\n      ")
//
//    let iconProperty = """
//      \(detectedEnum.access) var icon: IconLiteral? {
//        \(iconSwitch)
//      }
//      """

    return [
      DeclSyntax("\(raw: detectedEnum.access) var id: String { rawValue }"),
      DeclSyntax("\(raw: detectedEnum.access) var name: String { rawValue.capitalized }"),
      //      DeclSyntax(iconProperty),
      DeclSyntax("\(raw: detectedEnum.access) var label: QuickLabel { QuickLabel(name, icon: nil) }"),
//      DeclSyntax("\(raw: detectedEnum.access) var label: QuickLabel { QuickLabel(name, icon: IconLiteral(from: icon)) }"),
    ]
  }
}
