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

extension SampleContent.ExampleItem: InfoBarSection {
  public typealias Source = SampleContent.ExampleDataStore
  public typealias SectionKey = SampleContent.ExampleSectionKey

  public var icon: IconLiteral {
    switch self {
      case .counts: .fromPreset(.binoculars)
      case .strokeCountCompleted: .fromPreset(.binoculars)
      case .touchModeActive: .fromPreset(.binoculars)
      case .pointerLocked: .fromPreset(.binoculars)
      case .clickedDown: .fromPreset(.binoculars)
      case .pressure: .fromPreset(.binoculars)
    }
  }
  
  public func getContent(
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
