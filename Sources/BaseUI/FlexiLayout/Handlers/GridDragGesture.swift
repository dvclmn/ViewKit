//
//  GridDragGesture.swift
//  BaseComponents
//
//  Created by Dave Coleman on 2/10/2025.
//

import SwiftUI

/// Going to try using `MarqueeDragGesture`
//struct GridDragGesture: Gesture {
////  @Binding var tracker: CumulativeDragTracker
////  @Binding var offset: CGSize
////  let minDragDistance: CGFloat
////  let isDragging: (Bool) -> Void
//  
//  var body: some Gesture {
//    
//    DragGesture(minimumDistance: 0)
//      .onChanged { value in
//        
//        handler.isDragging = true
//        handler.lastDragLocation = value.location
//        
//        /// This handles the actual drawing of the bounding shape
//        updateSelectionRect(start: value.startLocation, current: value.location)
//        handler.updateSelectedItems(selected: $selected, with: modifiers)
//      }
//      .onEnded { _ in
//        handler.isDragging = false
//        handler.selectionRect = nil
//        
//        /// When the drag ends, if anything was selected, update both anchors
//        /// to the first selected item (for future shift-clicks)
//        if let firstSelectedID = selected.first {
//          /// Only update the fixed anchor if we're not in the middle of a shift operation
//          if !modifiers.contains(.shift) {
//            handler.fixedAnchorItemID = firstSelectedID
//          }
//          handler.lastClickedItemID = firstSelectedID
//        }
//      }
////    DragGesture(minimumDistance: minDragDistance)
////      .onChanged { gestureValue in
////        tracker.beginIfNeeded(latestValue: offset)
////        guard let newOffset = tracker.computeOffset(translation: gestureValue.translation) else { return }
////        offset = newOffset
////        isDragging(true)
////      }
////      .onEnded { gestureValue in
////        tracker.end()
////        isDragging(false)
////      }
//  }
//}
