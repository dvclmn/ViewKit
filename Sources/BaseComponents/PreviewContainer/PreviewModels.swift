//
//  PreviewModels.swift
//  Components
//
//  Created by Dave Coleman on 15/10/2024.
//

import Foundation

public enum PreviewElement: Equatable {
  case sidebar(isFloating: Bool = false)
  case inspector
  case toolbar
  case splitView
}

public enum PreviewWidth {
  case ultraWide
  case veryWide
  case wide
  case normal
  case narrow
  case tight

  public var value: CGFloat {
    switch self {
      case .ultraWide: 1280
      case .veryWide: 960
      case .wide: 760
      case .normal: 640
      case .narrow: 400
      case .tight: 260
    }
  }
}

public enum PreviewHeight {
  case normal
  case short

  public var value: CGFloat {
    switch self {
      case .normal: 680  // Was 780-90 for Xcode 16 and lower
      case .short: 500
    }
  }
}

//extension CGSize {
//  public static let previewStandard: CGSize = CGSize(width: 480, height: 720)
//  public static let previewWide: CGSize = CGSize(width: 580, height: 720)
//  public static let previewExtraWide: CGSize = CGSize(width: 780, height: 720)
//}
