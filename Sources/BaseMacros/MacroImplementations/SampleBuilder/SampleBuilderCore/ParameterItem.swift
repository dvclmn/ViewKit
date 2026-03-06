/*
 This source file is part of SwiftAndTipsMacros

 Copyright (c) 2023 Pedro Rojas and project authors
 Licensed under MIT License
*/

//
//  InitParameterItem.swift
//
//
//  Created by Pedro Rojas on 16/08/23.
//

import MacroHelpers
import MacroToolkit
import SwiftSyntax

struct ParameterItem {
  let identifierName: String?
  let identifierType: TypeSyntax
  let category: DataCategory?
  //  let accessLevel: String
  //  let accessLevel: AccessModifier

  var hasName: Bool { identifierName != nil }
}
