//
//  GenerateSampleSyntax.swift
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
import MacroToolkit

extension SampleBuilderMacro {
  static func generateSampleCodeSyntax(
    sampleData: ArrayElementListSyntax,
    access: AccessModifier?,
  ) -> IfConfigDeclSyntax {

    let returnType = ArrayTypeSyntax(
      leftSquare: .leftSquareToken(),
      element: IdentifierTypeSyntax(
        name: .keyword(.Self)
      ),
      rightSquare: .rightSquareToken()
    )
    
    let accessString = (access ?? .internal).name
    let accessTokenSyntax: TokenSyntax = TokenSyntax(stringLiteral: accessString)

    let sampleCode = VariableDeclSyntax(
      modifiers: DeclModifierListSyntax {
        DeclModifierSyntax(name: accessTokenSyntax)
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

    /// This will make the code available only on DEBUG mode
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

}
