//
//  Values+Helpers.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 9/2/2026.
//

import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros
import MacroToolkit

extension AssociatedValuesBuilder {
  package var cases: [EnumCase] { detectedEnum.cases }
  package var access: String { detectedEnum.accessLevel?.name ?? "" }
}

/// Note: a Case (not the whole enum itself)
struct AssociatedValuesCase {
  
}
