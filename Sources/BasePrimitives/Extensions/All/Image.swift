//
//  Image.swift
//  Collection
//
//  Created by Dave Coleman on 2/11/2024.
//

import SwiftUI

#if canImport(UIKit)
import UIKit
#endif

#if canImport(AppKit)
import AppKit
#endif


public extension Image {
  init?(data: Data) {
#if canImport(UIKit)
    guard let uiImage = UIImage(data: data) else { return nil }
    self.init(uiImage: uiImage)
#elseif canImport(AppKit)
    guard let nsImage = NSImage(data: data) else { return nil }
    self.init(nsImage: nsImage)
#endif
  }
}



//#if canImport(UIKit)
//extension UIImage {
//    var cgImage: CGImage? {
//        return self.cgImage
//    }
//}
//#endif

#if canImport(AppKit)
public extension NSImage {
  var cgImage: CGImage? {
    var rect = CGRect(origin: .zero, size: self.size)
    return self.cgImage(forProposedRect: &rect, context: nil, hints: nil)
  }
}
#endif



//var resolvedImage: NSImage? {
//  if let primary = NSImage(named: placeholderIconName) {
//    return primary
//  }
//  if let fallbackName = Bundle.main.iconFileName,
//     let fallback = NSImage(named: fallbackName) {
//    return fallback
//  }
//  if let backup = NSImage(named: placeholderIconBackupName) {
//    return backup
//  }
//  return nil
//  }
