//
//  InfoBarSampleItems.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 14/1/2026.
//

import CoreTools
import Foundation

extension SampleContent.ExampleItem: InfoBarSection {

  public func makeItem(from source: SampleContent.ExampleDataStore) -> InfoBarItem {
    let displayFormat: DisplayFormat = .init(
      decimalPlaces: 0,
      labelStyle: .none,
      separatorVisibility: .component
    )
    let text: String? =
      switch self {
        case .clickedDown: source.isClicked.description
        default: nil
      }

    return InfoBarItem(
      sectionKey: Self.sectionTitle,
      label: self.labe,
      content: text ?? "nil"
    )
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
