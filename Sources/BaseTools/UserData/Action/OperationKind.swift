//
//  CRUDOperation.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 13/10/2025.
//

//import EnumMacros

public enum UpdateKind {
  case withUndo(action: String? = nil)
  case standard
}

extension UpdateKind {
  public var isWithUndo: Bool {
    if case .withUndo = self {
      return true
    }
    return false
  }
  
  public var isStandard: Bool {
    if case .standard = self {
      return true
    }
    return false
  }
}

public protocol OperationPerforming {
  associatedtype ComponentID: Hashable
  mutating func perform(
    _ op: OperationKind,
    on component: ComponentID
  )
}


public enum OperationKind {
//public enum CRUD {
  case create
  case read
  case update
  case delete
}
