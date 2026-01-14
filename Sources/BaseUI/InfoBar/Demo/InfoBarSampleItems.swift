//
//  InfoBarSampleItems.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 14/1/2026.
//



public struct ExampleStore {
  var currentPressure: CGFloat? = 0
  var isPointerLocked: Bool = false
  var isInDrawingMode: Bool = false
  var isClicked: Bool = false
  var strokeCountCompleted: Int = 18
  var touchCount: Int = 3
  var strokeCountActive: Int = 1
  var pointCountFiltered: Int = 1492
}

public enum ExampleItem: String, Sendable, InfoBarSection {
  
  //public enum ExampleItem: String, InfoBarSection {
  
  case counts
  //  case touchCount
  //  case strokeCountActive
  //  case pointCountFiltered
  case strokeCountCompleted
  case touchModeActive
  case pointerLocked
  case clickedDown
  case pressure
  
  public static var sectionTitle: String { "Example" }
  
  public var label: QuickLabel { QuickLabel(self.name) }
  
  public static let itemsKey: String = "InfoBarItems"
  //  public let elements: [Self] = [
  
  public static let defaultItems: Set<Self> = [
    .counts,
    //    .touchCount,
    //    .pointCountFiltered,
      .touchModeActive,
    .pointerLocked,
    .pressure,
  ]
  
  public var id: String { self.rawValue }
  
  public var name: String {
    switch self {
      case .counts: "Counts"
      case .strokeCountCompleted: "Strokes (Completed)"
      case .touchModeActive: "Touch Mode Active"
      case .pointerLocked: "Pointer Locked"
      case .clickedDown: "Clicked Down"
      case .pressure: "Pressure"
    }
  }
  
  public static func buildItems(from source: ExampleStore) -> [InfoBarItem] {
    
    allCases.map { item in
      InfoBarItem(
        sectionKey: sectionTitle,
        label: item.label,
        content: item.content(source)
      )
    }
  }
  
  func makeItem(from source: CanvasHandler) -> BaseUI.InfoBarItem {
    //  func content(_ source: ExampleStore) -> String {
    //  func content(_ handler: CanvasHandler, modifiers: Modifiers) -> AttributedString {
    switch self {
      case .counts: source.touchCount.toString
      case .strokeCountCompleted: source.strokeCountCompleted.toString
      default: "unknown"
    }
  }
  
}
