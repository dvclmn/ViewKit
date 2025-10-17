//
//  Handler+ExampleSearch.swift
//  BaseComponents
//
//  Created by Dave Coleman on 20/9/2025.
//

import Ifrit
import LayoutKit
import SharedHelpers
import SwiftUI

extension Fuse: FuzzyProvider {}

@MainActor
@Observable
final class ExampleSearchHandler: FuzzySearchHandler, Sendable {
  typealias Provider = Fuse
  typealias Item = SearchableItem
  let provider = Fuse()
  var collection: [Item] = Item.allCases
  var searchString: String = ""
  let searchDebouncer = AsyncDebouncer()
  //  var searchResults: IdentifiedArrayOf<FuzzyMatch<CoolItem>> = []
  var selectedResult: Item.ID? = nil
  var isSearchPresented: Bool = false
  var searchState: SearchState<Item>? = nil
  var layoutMode: LayoutMode = .list
}
