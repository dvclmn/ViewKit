//
//  CaseDetection.swift
//  BaseMacros
//
//  Created by Dave Coleman on 18/9/2025.
//

//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2023 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import MacroToolkit
import SwiftSyntax
import SwiftSyntaxMacros

// Obtained from Swift example macros
// https://github.com/swiftlang/swift-syntax/blob/main/Examples/Sources/MacroExamples/Implementation/Member/CaseDetectionMacro.swift
// Additional modifications based on stackotter's MacroToolkit

extension CaseDetectionMacro: MemberMacro {
//public enum CaseDetectionMacro: MemberMacro {
  public static func expansion(
    of node: AttributeSyntax,
    providingMembersOf decl: some DeclGroupSyntax,
    conformingTo: [TypeSyntax],
    in context: some MacroExpansionContext
  ) throws -> [DeclSyntax] {

    let macro = try CaseDetectionMacro(node: node, decl: decl)
    return macro.makeCaseDetector()
  }
}
