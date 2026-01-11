import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

struct AssociatedValuesMacro: MemberMacro {
  static func expansion(
    of node: AttributeSyntax,
    providingMembersOf declaration: some DeclGroupSyntax,
    in context: some MacroExpansionContext
  ) throws -> [DeclSyntax] {
    guard let enumDecl = declaration.as(EnumDeclSyntax.self) else {
      throw AssociatedValuesMacroError.notAEnum
    }

    return try enumDecl.memberBlock.members.compactMap {
      $0.decl.as(EnumCaseDeclSyntax.self)?
        .elements
        .compactMap { $0 }
    }
    .reduce([], +)
    .compactMap { element -> DeclSyntax? in
      guard let associatedValue = element.parameterClause else {
        return nil
      }

      let parameters = associatedValue.parameters
      let isSingleValue = parameters.count == 1
      
      /// 1. Determine the return type string
      /// If single: just the type (e.g., `CGRect`)
      /// If multiple: the full parameter clause (e.g., `(x: Int, y: Int)`)
      let typeString: String
      if isSingleValue, let firstParam = parameters.first {
        typeString = "\(firstParam.type)"
      } else {
        typeString = "\(associatedValue)"
      }
      
      /// 2. Generate internal variable names for the pattern match
      let variableNames = parameters
        .enumerated()
        .map { index, _ in "v\(index)" }
        .joined(separator: ", ")
      
      return DeclSyntax(
        try VariableDeclSyntax("\(declaration.modifiers)var \(element.name)Value: \(raw: typeString)?") {
          try IfExprSyntax("if case let .\(element.name)(\(raw: variableNames)) = self") {
            if isSingleValue {
              "return v0"
            } else {
              "return (\(raw: variableNames))"
            }
          }
          "return nil"
        }
      )
    }

  }
}
