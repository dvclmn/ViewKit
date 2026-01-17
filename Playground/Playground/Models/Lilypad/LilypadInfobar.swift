//
//  LilypadInfobar.swift
//  Playground
//
//  Created by Dave Coleman on 17/1/2026.
//

import ToolKit

public enum LilyPadSectionKey: InfoBarSectionKey {
  public static let title = "Example Section"
}

enum LilyPadInfoItem: String, InfoBarSection, CaseIterable {

  typealias Source = AppHandler
  typealias SectionKey = LilyPadSectionKey

  case pointCount
  case strokeCount
}

extension LilyPadInfoItem {
  var labelText: String { rawValue.capitalized }
  var icon: IconLiteral {
    switch self {
      case .pointCount: .preset(.antenna)
      case .strokeCount: .preset(.binoculars)
    }
  }
  func getContent(from source: AppHandler, format: DisplayFormat) -> String {
    switch self {
      case .pointCount: source.drawing.pointCount.toString
      case .strokeCount: source.drawing.strokeCount.toString
    }
  }

}
