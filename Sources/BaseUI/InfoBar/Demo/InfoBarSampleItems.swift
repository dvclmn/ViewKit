//
//  InfoBarSampleItems.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 14/1/2026.
//

import CoreTools
import Foundation

extension SampleContent.ExampleItem: InfoBarSection {

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
