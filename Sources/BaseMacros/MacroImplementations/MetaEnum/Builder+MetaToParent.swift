//
//  Builder+MetaToParent.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 9/2/2026.
//

import MacroToolkit
import SwiftSyntax
import SwiftSyntaxMacros

extension MetaEnumBuilder {
  
  /// Target output:
  /// ```
  /// public init?(fromMeta meta: Self.Meta) {
  ///   switch meta {
  ///     case .linear: self = .linear
  ///     case .cubic: self = .cubic
  ///     case .quadratic: self = .quadratic
  ///     case .catmullRom: return nil
  ///   }
  /// }
  /// ```
  /// Note: Could try using this to generate more defaults:
  /// https://github.com/alschmut/SwiftBuildableMacro?tab=readme-ov-file#builder-default-values
  package var metaToParentInit: DeclSyntax {
    let cases = casesList { item in
      guard item.hasAssociatedValues else {
        return "self = .\(item.name)"
      }

      guard let paramClause = item.associatedValues else {
        return "return nil"
      }

      /// Require defaults for all parameters
      let defaults = item.defaultValuesIfPresent
      guard defaults.count == paramClause.parameters.count else {
        return "return nil"
      }

      /// Build arguments using labels from the parameter clause and values from defaults
      let pairs = zip(paramClause.parameters, defaults)
      let argumentList = pairs.map { param, def -> String in
        let label = param.firstName?.text ?? "_"
        
        /// def.value is the `ExprSyntax` from `InitializerClauseSyntax`
        return "\(label): \(def.value)"
      }.joined(separator: ", ")

      return "self = .\(item.name)(\(argumentList))"
    }

    return """
      \(raw: access) init?(fromMeta meta: Self.Meta) {
        switch meta {
      \(raw: cases)
        }
      }
      """
  }

}
