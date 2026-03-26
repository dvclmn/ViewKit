//
//  SelectionKind.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 25/3/2026.
//

import EnumMacros

@CaseDetection
public enum SelectionKind {
  case single // tap
  case multiple // drag
}


/// Expresses how this selection was executed by the user
@CaseDetection
public enum SelectionGesture {
  case tap
  case drag
}
