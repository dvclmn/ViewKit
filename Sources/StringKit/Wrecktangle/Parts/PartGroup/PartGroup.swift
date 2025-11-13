//
//  PartGroup.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 12/11/2025.
//

extension Box {
  struct PartGroup: Sendable, Codable, Equatable {
    var parts: [Box.PartStructure] = []

    public init(parts: [Box.PartStructure]) {
      self.parts = parts
    }

    init(@PartGroupBuilder _ parts: () -> [Box.PartStructure]) {
      self.parts = parts()
    }
  }
}

