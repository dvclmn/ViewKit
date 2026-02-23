//
//  Pasteboard.swift
//  Collection
//
//  Created by Dave Coleman on 14/2/2025.
//

import Foundation

public protocol PasteboardCopying {
  func setString(_ string: String)
}

#if canImport(AppKit)
import AppKit
import UniformTypeIdentifiers

extension NSPasteboard: PasteboardCopying {
  public func setString(_ string: String) {
    clearContents()
        setString(string, forType: .string)

//    let data = string.data(using: .utf8)!
//
//    // Primary modern flavour
//    setData(data, forType: .init(UTType.utf8PlainText.identifier))
//
//    // Optional: legacy NSString flavour (still widely used)
//    setString(string, forType: .string)
  }
}

#elseif canImport(UIKit)
import UIKit

extension UIPasteboard: PasteboardCopying {
  public func setString(_ string: String) {
    self.string = string
  }
}
#endif

public func copyStringToClipboard(_ contents: String) {
  DispatchQueue.main.async {
    let pasteboard: PasteboardCopying
    
    #if canImport(AppKit)
    pasteboard = NSPasteboard.general
    
    #elseif canImport(UIKit)
    pasteboard = UIPasteboard.general
    
    #endif
    
    pasteboard.setString(contents)
  }
}
