//
//  InfoBarItemsSnapshot.swift
//  ViewKit
//
//  Created by Dave Coleman on 23/8/2026.
//

package struct InfoBarItemsSnapshot: Equatable {
  package let items: [InfoBarItem]
  
  package init(items: [InfoBarItem]) {
    self.items = items
  }
  
  package static func == (lhs: Self, rhs: Self) -> Bool {
    guard lhs.items.count == rhs.items.count else { return false }
    
    return zip(lhs.items, rhs.items).allSatisfy { lhsItem, rhsItem in
      lhsItem.label == rhsItem.label
      && lhsItem.content == rhsItem.content
    }
  }
}
