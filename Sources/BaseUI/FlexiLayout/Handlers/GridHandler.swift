//
//  DragHandler.swift
//  BaseComponents
//
//  Created by Dave Coleman on 18/3/2025.
//

#if os(macOS)

import SwiftUI
import BasePrimitives
//import InteractionKit

extension Flexi {

  @MainActor
  @Observable

  final class GridHandler {

    var itemFrames: [Item.ID: CGRect] = [:]
    var itemSpacing: CGFloat? = nil
    var viewSize: CGSize? = nil

    //    var gridContext: GridContext<Item>?

    var selected: Set<Item.ID> = []
    var modifiers: Modifiers = []

    /// The bounding box of the active selection
    var selectionRect: CGRect?
    var isDragging: Bool = false

    /// Fixed anchor point - doesn't change during shift-selections
    var fixedAnchorItemID: Item.ID?

    /// Last clicked item - changes with each click
    var lastClickedItemID: Item.ID?

    var lastDragLocation: CGPoint?

    @ObservationIgnored let selectionHitThreshold: CGFloat = 1

    /// Helper method to get the fixed anchor item
    func getFixedAnchorItem(in items: [Item]) -> Item? {
      guard let anchorID = fixedAnchorItemID else { return nil }
      return items.first(where: { $0.id == anchorID })
    }

    /// Helper method to get the last clicked item
    func getLastClickedItem(in items: [Item]) -> Item? {
      guard let clickedID = lastClickedItemID else { return nil }
      return items.first(where: { $0.id == clickedID })
    }

  }
}

extension Flexi.GridHandler {

  var columnCount: Int? {
    guard let viewWidth = viewSize?.width,
      let itemWidth,
      let itemSpacing
    else { return nil }
    let columnCount = Int(floor((viewWidth + itemSpacing) / (itemWidth + itemSpacing)))
    return columnCount
  }

  /// This relies on the Grid items all being the same size
  var itemWidth: CGFloat? {
    let rects = itemFrames.values
    guard let widthOfFirst = rects.first?.width else { return nil }

    /// Small tolerance for floating-point precision issues
    let tolerance: CGFloat = 0.5

    guard rects.allSatisfy({ abs($0.width - widthOfFirst) <= tolerance }) else {
      return nil
    }

    return widthOfFirst
  }

  func neighbourID(
    from currentID: Item.ID,
    direction: Direction,
    data: [Item],
  ) -> Item.ID? {
    guard let currentIndex = data.firstIndex(where: { $0.id == currentID }),
      let columnCount
    else { return nil }

    let row = currentIndex / columnCount
    let col = currentIndex % columnCount
    var newIndex: Int?

    switch direction {
      case .left:
        if col > 0 { newIndex = currentIndex - 1 }

      case .right:
        if col < columnCount - 1, currentIndex + 1 < data.count {
          newIndex = currentIndex + 1
        }

      case .up:
        if row > 0 {
          newIndex = currentIndex - columnCount
        }

      case .down:
        let downIndex = currentIndex + columnCount
        if downIndex < data.count {
          newIndex = downIndex
        }
    }

    return newIndex.map { data[$0].id }
  }

  func updateSelectedItems(
    selected: Binding<Set<Item.ID>>
  ) {
    /// Perhaps this can be handled more centrally —
    /// but the selection Rect needs to exist for
    /// item selection to even make sense / be possible.
    guard let selectionRect else { return }

    let selectionFilter: [Item.ID: CGRect] = itemFrames.filter { item, frame in
      frame.insetBy(
        dx: -selectionHitThreshold,
        dy: -selectionHitThreshold,
      ).intersects(selectionRect)
    }
    let filteredKeys: [Item.ID] = selectionFilter.compactMap { $0.key }
    let newSelection = Set(filteredKeys)

    /// If this is the first drag event, capture the first selected item as anchors
    if let firstSelectedID = newSelection.first {
      if fixedAnchorItemID == nil {
        fixedAnchorItemID = firstSelectedID
      }
      lastClickedItemID = firstSelectedID
    }

    if modifiers.contains(.command) {
      if modifiers.contains(.shift) {
        /// Command+Shift+Drag: Remove the items in the drag selection from the overall selection
        selected.wrappedValue.subtract(newSelection)
      } else {
        /// Command+Drag: Add the items in the drag selection to the overall selection
        selected.wrappedValue.formUnion(newSelection)
      }
    } else {
      /// Regular drag: Replace the entire selection with the items in the drag selection
      selected.wrappedValue = newSelection
    }
  }

  func handleTap(
    itemID: Item.ID,
    data: [Item],
  ) {
    if isDragging { return }

    /// Find the position of the tapped item in the collection
    guard let tappedIndex = data.firstIndex(where: { $0.id == itemID }) else {
      return
    }

    /// Update the last clicked item ID
    lastClickedItemID = itemID

    /// Handle different modifier key combinations
    if modifiers.contains(.command) {
      /// Command key: Toggle selection of individual item
      handleCommandKey(id: itemID)

    } else if modifiers.contains(.shift) {
      handleShiftKey(id: itemID, data: data, tappedIndex: tappedIndex)

    } else {
      /// No modifiers: Clear selection and select just this item
      selected = [itemID]

      /// Without modifiers, we reset the anchor point to this new item
      fixedAnchorItemID = itemID
    }
  }

  private func handleCommandKey(id: Item.ID) {
    if selected.contains(id) {
      selected.remove(id)
    } else {
      selected.insert(id)
    }

    /// Command clicks update both anchor points to enable
    /// subsequent shift-selections from this item
    fixedAnchorItemID = id

  }

  private func handleShiftKey(
    id: Item.ID,
    data: [Item],
    tappedIndex: Int,
  ) {

    /// Shift key: Select a range from the fixed anchor point to the current item
    if let anchorID = fixedAnchorItemID,
      let anchorIndex = data.firstIndex(where: { $0.id == anchorID })
    {

      /// Start with existing command-selected items
      var newSelection = modifiers.contains(.command) ? selected : []

      let minIndex = min(tappedIndex, anchorIndex)
      let maxIndex = max(tappedIndex, anchorIndex)

      /// Add all items in the range to the selection
      for index in minIndex...maxIndex {
        newSelection.insert(data[index].id)
      }

      selected = newSelection

      /// Important: Don't update the fixed anchor during shift-selection
      /// This allows the range to be expanded/contracted on subsequent shift-clicks
    } else {
      /// If there's no previous anchor, just select this item
      selected = [id]
      fixedAnchorItemID = id
    }

  }

}

#endif

extension Array where Element: Identifiable {
  func indexMap() -> [Element.ID: Int] {
    var map: [Element.ID: Int] = [:]
    for (idx, element) in enumerated() {
      map[element.id] = idx
    }
    return map
  }
}
