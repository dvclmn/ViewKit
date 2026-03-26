//
//  CellSelectionModifiers.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 23/3/2026.
//

extension CellSelectionMode {
  
//  init(fromModifiers modifiers: Modifiers) {
//    self = Self.mode(for: modifiers)
//  }
//  
//  static let modiferMap: [CellSelectionMode: Modifiers] = [
//    .new: [],
//    .add: [.command],
//    .subtract: [.option],
//  ]
//  
//  static func modifiers(for mode: CellSelectionMode) -> Modifiers {
//    modiferMap[mode] ?? []
//  }
//  
//  static func mode(for modifiers: Modifiers) -> CellSelectionMode {
//    /// 1) Exact match against the canonical map
//    if let exact = modiferMap.first(where: { $0.value == modifiers })?.key {
//      return exact
//    }
//    
//    /// 2) Unique superset match (e.g., Command+Shift counts as Command)
//    let supersetMatches = modiferMap.filter { (_, mapped) in
//      
//      /// treat empty mapping as requiring exact empty
//      if mapped.isEmpty { return false }
//      return modifiers.isSuperset(of: mapped)
//    }
//    if supersetMatches.count == 1, let unique = supersetMatches.first?.key {
//      return unique
//    }
//    
//    /// 3) Fallback policy
//    return .new
//  }
  
}
