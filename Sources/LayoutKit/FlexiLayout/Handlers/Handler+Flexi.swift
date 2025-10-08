//
//  Handler+Flexi.swift
//  BaseComponents
//
//  Created by Dave Coleman on 29/9/2025.
//

import BaseHelpers
import CaseDetection
import Sharing
import SwiftUI

@Observable
final class FlexiHandler<Item: Sendable & Identifiable & Equatable> {
  
  var singleSelection: Item.ID? = nil
  var multiSelection: Set<Item.ID> = []
  let selectionMode: SelectionMode
  
  /// For `GridView` only
  var scrolledID: Item.ID?
  
  var groupPath: KeyPath<Item, String>? = nil
  
  init(mode selectionMode: SelectionMode) {
    self.selectionMode = selectionMode
  }
}
