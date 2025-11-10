//
//  Part+Span.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 9/11/2025.
//

extension Box {
  public enum PartSpan {
    case fill
    case fixed(Int)
    
    public static var single: PartSpan { .fixed(1) }
  }
}
