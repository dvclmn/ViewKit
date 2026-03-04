//
//  BundledFont.swift
//  BaseHelpers
//
//  Created by Codex on 4/3/2026.
//

import CoreText
import Foundation
import SwiftUI

#if canImport(AppKit)
import AppKit
#endif

public enum BundledFont: String, CaseIterable, Sendable {
  /// BigBlueTerm437 Nerd Font, regular style.
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

  public var bundledURL: URL? {
    let bundle = BasePrimitivesResources.bundle

    if let directMatch = bundle.url(
      forResource: resourceName,
      withExtension: resourceExtension
    ) {
      return directMatch
    }

    let candidates =
      (bundle.urls(forResourcesWithExtension: resourceExtension, subdirectory: nil) ?? [])
      + (bundle.urls(forResourcesWithExtension: resourceExtension, subdirectory: "Fonts") ?? [])
      + (bundle.urls(forResourcesWithExtension: resourceExtension, subdirectory: "Resources/Fonts") ?? [])

    return candidates.first(where: { $0.lastPathComponent == "\(resourceName).\(resourceExtension)" })
  }

  @discardableResult
  public func register() -> Bool {
    guard let bundledURL else { return false }

    var potentialError: Unmanaged<CFError>?
    let didRegister = CTFontManagerRegisterFontsForURL(
      bundledURL as CFURL,
      .process,
      &potentialError
    )

    if didRegister {
      return true
    }

    guard let error = potentialError?.takeRetainedValue() else {
      return false
    }

    let nsError = (error as Error) as NSError
    let alreadyRegistered = nsError.domain == (kCTFontManagerErrorDomain as String)
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

public enum BundledFonts {
  @discardableResult
  public static func registerAll() -> Bool {
    BundledFont.allCases.allSatisfy { $0.register() }
  }
}

extension GridFont {
  public var bundledFont: BundledFont? {
    switch self {
      case .terminal: .bigBlueTerm
      default: nil
    }
  }

  public func resolvedFont(size: CGFloat) -> Font {
    switch self {
      case .sfMono:
        return .system(size: size, design: .monospaced)

      default:
        if let bundledFont {
          return bundledFont.swiftUIFont(size: size)
        }
        return .custom(rawValue, fixedSize: size)
    }
  }
}
