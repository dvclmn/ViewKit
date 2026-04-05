//
//  SelectionKind.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 25/3/2026.
//

//import EnumMacros

//@CaseDetection
public enum SelectionKind {
  case single // tap
  case multiple // drag
  
  public var isSingle: Bool {
    if case .single = self {
      return true
    }
    return false
  }
  
  public var isMultiple: Bool {
    if case .multiple = self {
      return true
    }
    return false
  }
  
}


/// Expresses how this selection was executed by the user
//@CaseDetection
public enum SelectionGesture {
  case tap
  case drag
  
  public var isTap: Bool {
    if case .tap = self {
      return true
    }
    return false
  }
  
  public var isDrag: Bool {
    if case .drag = self {
      return true
    }
    return false
  }
}
