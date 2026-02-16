//
//  IgnoredCheck.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 16/2/2026.
//

import SwiftSyntax

//extension VariableDeclSyntax {
//  var hasSamplesIgnoredAttribute: Bool {
//    for attrListItem in attributes {
//
//      guard let attr = attrListItem.as(AttributeSyntax.self) else { continue }
//
//      /// Handle identifiers like `@SamplesIgnored` or module-qualified names.
//      if let id = attr.attributeName.as(IdentifierTypeSyntax.self) {
//        return id.name.text == "SamplesIgnored"
//
//      } else if let member = attr.attributeName.as(MemberTypeSyntax.self) {
//        /// Supports forms like `MyMacros.SamplesIgnored`
//        return member.name.text == "SamplesIgnored"
//      }
//      /// As a fallback, string compare on trimmed description
//      if attr.attributeName.trimmedDescription == "SamplesIgnored" {
//        return true
//      }
//    }
//    return false
//  }
//}
