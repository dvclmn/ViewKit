//
//  Shared+Ext.swift
//  TemplateProject
//
//  Created by Dave Coleman on 16/1/2026.
//

import Foundation
import Sharing

extension SharedKey where Self == FileStorageKey<DrawingData>.Default {
  static var drawing: Self {
    Self[
      .fileStorage(
        .applicationSupportDirectory.appending(component: "lilypadDrawing.json")
      ),
      default: DrawingData(points: [])
    ]
  }
}

//extension SharedKey where Self == FileStorageKey<Preferences>.Default {
//  static var preferences: Self {
//    Self[
//      .fileStorage(
//        .applicationSupportDirectory.appending(component: "preferences.json")
//      ),
//      default: Preferences()
//    ]
//  }
//}
