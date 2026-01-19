//
//  PlaygroundTab.swift
//  Playground
//
//  Created by Dave Coleman on 19/1/2026.
//

import CoreTools

enum PlaygroundTab: String, LabeledItem, CaseIterable, Hashable, Codable {
  case home
  case lilypad
  case sliders
  
  //  var areShortcutsEnabled: Bool { true }
}
