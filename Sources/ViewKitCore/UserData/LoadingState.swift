//
//  LoadingState.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 6/2/2026.
//

import EnumMacros
import Foundation

@CaseDetection
@AssociatedValues
public enum LoadState<Value> {
  case idle
  case loading
  case failed(Error)
  case ready(Value)
}
