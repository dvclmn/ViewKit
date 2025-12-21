//
//  NSFont+Traits.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 20/11/2025.
//

import AppKit

extension NSFontDescriptor.SymbolicTraits {
  /// Resolves the abstract font traits into a concrete NSFont instance.
  ///
  /// - Parameters:
  ///   - size: The desired point size for the font.
  ///   - baseFont: The starting font family (defaults to System font).
  /// - Returns: A concrete NSFont with the traits applied.
  public func resolvedFont(
    size: CGFloat,
    baseFont: NSFont = .systemFont(ofSize: 0)
  ) -> NSFont {
    // 1. Start with the descriptor of the base font
    let baseDescriptor = baseFont.fontDescriptor

    // 2. If we have no custom traits to apply, simply return the base font at the new size.
    //    guard
    let specificTraits = self
    //    else {
    //      return NSFont(descriptor: baseDescriptor, size: size) ?? baseFont
    //    }

    // 3. Merge existing traits (like generic family info) with your new specific traits.
    // Using .union ensure we don't accidentally remove existing traits needed by the system.
    let combinedTraits = baseDescriptor.symbolicTraits.union(
      specificTraits
    )

    // 4. Create a new descriptor with these applied traits.
    // Note: This returns nil if the font family doesn't support the requested traits (e.g. a font with no Bold version).
    let newDescriptor = baseDescriptor.withSymbolicTraits(combinedTraits)
    //    else {
    //      print("Warning: Could not apply traits \(specificTraits) to base font.")
    //      return NSFont(descriptor: baseDescriptor, size: size) ?? baseFont
    //    }

    // 5. Instantiate the specific NSFont.
    return NSFont(descriptor: newDescriptor, size: size) ?? baseFont
  }
  
  public var prettyDescription: String {
    var desc: [String] = []
    if self.contains(.bold) {
      desc += ["bold"]
    }
    if self.contains(.italic) {
      desc += ["italic"]
    }
    if self.contains(.condensed) {
      desc += ["condensed"]
    }
    if self.contains(.expanded) {
      desc += ["expanded"]
    }
    if self.contains(.monoSpace) {
      desc += ["monoSpace"]
    } else {
      desc += [String(describing: self)]
    }

    guard !desc.isEmpty else {
      return "No traits"
    }
    return desc.joined(separator: ", ")
  }
  
  
}
