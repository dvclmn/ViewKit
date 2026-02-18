//
//  Helpers+Variables.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 27/10/2025.
//

/*
 This source file is part of SwiftAndTipsMacros

 Copyright (c) 2023 Pedro Rojas and project authors
 Licensed under MIT License
 */

//
//  VariableDeclSyntax+Extension.swift
//
//
//  Created by Pedro Rojas on 15/08/23.
//

import SwiftSyntax

/// Used by ``SampleBuilderMacro``
extension VariableDeclSyntax {
  var isStoredProperty: Bool {
    /// Stored properties cannot have more than 1 binding in its declaration.
    guard bindings.count == 1
    else {
      return false
    }

    guard let accesor = bindings.first?.accessorBlock
    else {
      /// Nothing to review. It's a valid stored property
      return true
    }

    switch accesor.accessors {
      case .accessors(let accesorBlockSyntax):
        /// Observers are valid accesors only
        let validAccesors = Set<TokenKind>([
          .keyword(.willSet), .keyword(.didSet),
        ])

        let hasValidAccesors = accesorBlockSyntax.contains {
          /// Other kind of accesors will make the variable a computed property
          validAccesors.contains($0.accessorSpecifier.tokenKind)
        }
        return hasValidAccesors
      case .getter:
        /// A variable with only a getter is not valid for initialization.
        return false
    }

  }

  var typeName: String {
    self.bindings.first?.typeAnnotation?.type.as(IdentifierTypeSyntax.self)?.name.text ?? ""
  }
}
