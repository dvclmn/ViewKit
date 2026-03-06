//
//  BundledFont.swift
//  BaseHelpers
//
//  Created by Codex on 4/3/2026.
//

import CoreText
import SwiftUI

#if canImport(AppKit)
import AppKit
#endif

public enum BundledFonts {
  @discardableResult
  public static func registerAll() -> Bool {
    BundledFont.allCases.allSatisfy { $0.register() }
  }
}

public enum BundledFont: String, CaseIterable, Sendable {
  case bigBlueTerm = "BigBlueTerm437NerdFont-Regular"
}

extension BundledFont {
  public var postScriptName: String {
    switch self {
      case .bigBlueTerm: "BigBlueTerm437NF"
    }
  }

  /// The stable name used by `Font.custom(...)` and in `GridFont.terminal`.
  public var swiftUIFontName: String {
    switch self {
      case .bigBlueTerm: "BigBlueTerm437 Nerd Font"
    }
  }

  public var resourceName: String { rawValue }
  public var resourceExtension: String { "ttf" }
}

// MARK: - Register
extension BundledFont {
  @discardableResult
  public func register() -> Bool {
    guard let bundledURL else { return false }

    var potentialError: Unmanaged<CFError>?

    let didRegister = CTFontManagerRegisterFontsForURL(
      bundledURL as CFURL,
      .process,
      &potentialError
    )

    if didRegister { return true }

    guard let error = potentialError?.takeRetainedValue() else {
      return false
    }

    let nsError = (error as Error) as NSError
    let alreadyRegistered =
      nsError.domain == (kCTFontManagerErrorDomain as String)
      && nsError.code == CTFontManagerError.alreadyRegistered.rawValue

    return alreadyRegistered
  }

  public func swiftUIFont(size: CGFloat) -> Font {
    _ = register()
    return .custom(swiftUIFontName, fixedSize: size)
  }

  #if canImport(AppKit)
  public func nsFont(size: CGFloat) -> NSFont {
    _ = register()

    if let postScript = NSFont(name: postScriptName, size: size) {
      return postScript
    }

    if let displayName = NSFont(name: swiftUIFontName, size: size) {
      return displayName
    }

    return NSFont.monospacedSystemFont(ofSize: size, weight: .regular)
  }
  #endif
}
