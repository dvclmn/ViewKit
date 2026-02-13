//
//  InfoBarSampleItems.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 14/1/2026.
//

import CoreTools
import Foundation

extension SampleContent {
  public enum ExampleSectionKey: InfoBarSectionKey {
    public static let title = "Example Section"
  }
}

extension SampleContent.ExampleItem: InfoBarItemDescriptor {
  public typealias Source = SampleContent.ExampleDataStore
  public typealias SectionKey = SampleContent.ExampleSectionKey

  public var icon: IconLiteral {
    switch self {
      case .counts: .preset(.binoculars)
      case .strokeCountCompleted: .preset(.binoculars)
      case .touchModeActive: .preset(.binoculars)
      case .pointerLocked: .preset(.binoculars)
      case .clickedDown: .preset(.binoculars)
      case .pressure: .preset(.binoculars)
    }
  }
  
  public func content(
    from source: SampleContent.ExampleDataStore,
    format: DisplayFormat
  ) -> String {

    return switch self {
      case .clickedDown: source.isClicked.description
      default: "nil"
    }
  }

  //  func makeItem(from source: CanvasHandler) -> BaseUI.InfoBarItem {
  //    //  func content(_ source: ExampleStore) -> String {
  //    //  func content(_ handler: CanvasHandler, modifiers: Modifiers) -> AttributedString {
  //    switch self {
  //      case .counts: source.touchCount.toString
  //      case .strokeCountCompleted: source.strokeCountCompleted.toString
  //      default: "unknown"
  //    }
  //  }
}
