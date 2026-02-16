//
//  SOO+StructBuilder.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 9/2/2026.
//

import MacroToolkit
import SwiftDiagnostics
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

struct SetOfOptionsBuilder {
  let parentStruct: Struct
  let optionsEnum: Enum
  let rawType: TypeSyntax

  init(
    node: AttributeSyntax,
    decl: some DeclGroupSyntax,
    conformingTo: [TypeSyntax],
    context: some MacroExpansionContext,
  ) throws {

    /// 1) Ensure we’re attached to a struct
    guard let structDecl = decl as? StructDeclSyntax else {
      throw MacroError("@SetOfOptions must be attached to a struct")
    }

    self.parentStruct = Struct(structDecl)

    /// 2) Find nested enum named "Options"
    guard
      let optionsEnumDecl = structDecl.memberBlock.members
        .compactMap({ $0.decl.as(EnumDeclSyntax.self) })
        .first(where: { $0.name.text == "Options" })
    else {
      throw MacroError("@SetOfOptions requires nested enum named 'Options'")
    }

    self.optionsEnum = Enum(optionsEnumDecl)

    /// 3) Extract RawType from attribute generic args (e.g. `@SetOfOptions<UInt8>`)
    guard let raw = Self.getRawType(from: node) else {
      throw MacroError("@SetOfOptions<RawType> generic argument is required, e.g. @SetOfOptions<UInt8>")
    }
    self.rawType = raw

  }
}

extension SetOfOptionsBuilder {

  var access: String {
    parentStruct.accessLevel?.name ?? ""
  }
  //  var access: String { parentStruct.accessLevel?.name ?? "" }

  func build() -> [DeclSyntax] {
    let result: [DeclSyntax] =
      rawValueMethods()
      + staticProperties()
      + [
        optionSetAllProperty(),
        stringValueProperty(),
        optionSetStringJoinedMethod(),
      ]

    return result
  }

}
extension SetOfOptionsBuilder {
  var snakeConditional: String { "isSnakeCase" }

  private static func getRawType(from attribute: AttributeSyntax) -> TypeSyntax? {
    let args = attribute.attributeName.as(IdentifierTypeSyntax.self)?.genericArgumentClause
    let rawType = args?.arguments.first?.argument
    return TypeSyntax(rawType)
  }

  func rawValueMethods() -> [DeclSyntax] {
    [
      "\(raw: access) let rawValue: \(rawType)",
      "\(raw: access) init(rawValue: \(rawType)) { self.rawValue = rawValue }",
    ]
  }

  func staticProperties() -> [DeclSyntax] {
    optionsEnum.cases.map { element -> DeclSyntax in
      "\(raw: access) static let \(raw: element.name): Self = Self(rawValue: 1 << \(raw: optionsEnum.identifier).\(raw: element.name).rawValue)"
    }
  }

  func optionSetStringJoinedMethod() -> DeclSyntax {
    let thingy = optionsEnum.optionSetStringBuilder(
      snakeConditional: snakeConditional
    )
    return """
      \(access) func stringValueJoined(isSnakeCase: Bool = false) -> String {
        var strings: [String] = []
        \(thingy)
        return strings.joined(separator: ", ")
      }
      """
      .toDeclSyntax
  }

  func optionSetAllProperty() -> DeclSyntax {

    let allContent = optionsEnum.casesList(.memberList(trailing: ","))
    //    let allContent = optionsEnum.casesList { item in
    //      "." + item.name + ","
    //    }
    return """
        \(access) static let all: Self = [\(allContent)]
      """
      .toDeclSyntax
  }

  func stringValueProperty() -> DeclSyntax {

    let stringSwitchCases = optionsEnum.casesList(
      .switchCase { element in
        let camel = element.name
        let snake = camel.camelCaseToSnakeCase

        // If both versions are identical, just return the raw string literal.
        if camel == snake {
          return "\"\(camel)\""
        }
        // Otherwise, return the ternary expression only; the preset supplies the `case .name:` prefix.
        return "isSnakeCase ? \"\(snake)\" : \"\(camel)\""
      }
    )

    return """
      \(raw: access) static func stringValue(
        for option: \(raw: optionsEnum.identifier), 
        \(raw: snakeConditional): Bool = false
      ) -> String {
        switch option {
            \(raw: stringSwitchCases)
        } 
      }
      """
  }

}
