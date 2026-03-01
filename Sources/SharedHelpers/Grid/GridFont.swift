//
//  GridFont.swift
//  SwiftBox
//
//  Created by Dave Coleman on 29/8/2024.
//

import SwiftUI

public enum GridFont: String, Sendable, Codable, Hashable, Equatable, Pickable, CaseIterable, Identifiable {

  public static let pickerLabel: QuickLabel = "Font"

  case menlo = "Menlo"
  case sfMono = "SF Mono"
  case courier = "Courier New"
  case monaco = "Monaco"
  case ibm = "AcPlus IBM BIOS"
  case ibmEGA = "Ac437 IBM EGA 8x14"
  case geist = "Geist Mono"
  case jetBrains = "JetBrains Mono"

  public var id: String { rawValue }
  public var name: String { rawValue }

  public var label: QuickLabel { QuickLabel(name) }
}

extension GridFont {
//  @available(*, deprecated, message: "Prefer more accurate/flexible `CharacterSizeModifier`")
//  public var baseSize: CGSize {
//    switch self {
//      case .menlo: CGSize(9.04, 18)
//      case .sfMono: CGSize(9.27, 18)
//      case .courier: CGSize(9, 16.95)
//      case .monaco: CGSize(9, 19)
//      case .ibm: CGSize(12.48, 15.65)
//      case .geist: CGSize(12.48, 15.65)
//      case .jetBrains: CGSize(12.48, 15.65)
//    }
//  }

//  public static func registerIBM() {
//    //    JetBrainsMono.allCases.forEach {
//    registerFont(bundle: .module, fontName: Self.ibm.rawValue, fontExtension: "ttf")
//    //    }
//  }
//
//  fileprivate static func registerFont(bundle: Bundle, fontName: String, fontExtension: String) {
//
//    guard let fontURL = bundle.url(forResource: fontName, withExtension: fontExtension),
//      let fontDataProvider = CGDataProvider(url: fontURL as CFURL),
//      let font = CGFont(fontDataProvider)
//    else {
//      fatalError("Couldn't create font from data")
//    }
//
//    var error: Unmanaged<CFError>?
//
//    CTFontManagerRegisterGraphicsFont(font, &error)
//  }
}

//extension Font {
  //  private static func custom(_ font: JetBrainsMono, relativeTo style: Font.TextStyle) -> Font {
  //    custom(font.rawValue, size: style.size, relativeTo: style)
  //  }

//  public static func ibm(size: CGFloat) -> Font {
//    custom(GridFont.ibm.rawValue, fixedSize: size)
//  }
  //  static let jetBrainsMonoLargeTitle = custom(.bold, relativeTo: .largeTitle)
  //  static let jetBrainsMonoLargeTitleBlack = custom(.extraBold, relativeTo: .largeTitle)
  //  static let jetBrainsMonoLargeTitleSemiBold = custom(.medium, relativeTo: .largeTitle)
  //  static let jetBrainsMonoTitle1 = custom(.bold, relativeTo: .title)
  //  static let jetBrainsMonoTitle2 = custom(.medium, relativeTo: .title2)
  //  static let jetBrainsMonoTitle3 = custom(.medium, relativeTo: .title3)
  //  static let jetBrainsMonoHeadline = custom(.medium, relativeTo: .headline)
  //  static let jetBrainsMonoSubHeadline = custom(.regular, relativeTo: .subheadline)
  //  static let jetBrainsMonoSubHeadlineItalic = custom(.italic, relativeTo: .subheadline)
  //  static let jetBrainsMonoSubHeadlineSemiBold = custom(.medium, relativeTo: .subheadline)
  //  static let jetBrainsMonoFootnote = custom(.regular, relativeTo: .footnote)
  //  static let jetBrainsMonoFootnoteSemiBold = custom(.medium, relativeTo: .footnote)
  //  static let jetBrainsMonoCaption = custom(.regular, relativeTo: .caption2)

//}
