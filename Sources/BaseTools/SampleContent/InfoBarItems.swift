//
//  InfoBarItems.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 14/1/2026.
//

import Foundation
import CoreTools

extension SampleContent {
  public struct ExampleDataStore {
//    public let currentPressure: CGFloat?
    public let isPointerLocked: Bool
    public let isInDrawingMode: Bool
    public let isClicked: Bool
    public let strokeCountCompleted: Int
    public let touchCount: Int
    public let strokeCountActive: Int
    public let pointCountFiltered: Int

    public init(
//      currentPressure: CGFloat? = 0,
      isPointerLocked: Bool = false,
      isInDrawingMode: Bool = false,
      isClicked: Bool = false,
      strokeCountCompleted: Int = 18,
      touchCount: Int = 3,
      strokeCountActive: Int = 1,
      pointCountFiltered: Int = 1492,
    ) {
//      self.currentPressure = currentPressure
      self.isPointerLocked = isPointerLocked
      self.isInDrawingMode = isInDrawingMode
      self.isClicked = isClicked
      self.strokeCountCompleted = strokeCountCompleted
      self.touchCount = touchCount
      self.strokeCountActive = strokeCountActive
      self.pointCountFiltered = pointCountFiltered
    }
  }
}

extension SampleContent {
  public enum ExampleItem: String, LabeledItem, Sendable {
    case counts
    case strokeCountCompleted
    case touchModeActive
    case pointerLocked
    case clickedDown
//    case pressure

    public static var sectionTitle: String { "SampleItems" }

    public var id: String { self.rawValue }

    public var labelText: String {
      switch self {
        case .counts: "Counts"
        case .strokeCountCompleted: "Strokes (Completed)"
        case .touchModeActive: "Touch Mode Active"
        case .pointerLocked: "Pointer Locked"
        case .clickedDown: "Clicked Down"
//        case .pressure: "Pressure"
      }
    }

  }
}
