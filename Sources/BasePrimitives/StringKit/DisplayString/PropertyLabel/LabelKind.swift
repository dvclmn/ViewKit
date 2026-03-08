//
//  LabelKind.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 8/3/2026.
//

public enum LabelKind {
  case main
  case property
}

extension LabelKind {
  public init?(from separatorKind: SeparatorKind) {
    switch separatorKind {
      case .label: self = .main
      case .propertyLabel: self = .property
      case .componentDelimiter: return nil
    }
  }

  public var separatorKind: SeparatorKind { .init(from: self) }
}
