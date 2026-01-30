//
//  Model+StrokeDebug.swift
//  Paperbark
//
//  Created by Dave Coleman on 21/6/2025.
//

import Foundation

//enum StrokeDebugMetadata: String, CaseIterable, Identifiable {
//  case rotation
//  case translation
//  case scale
//  
//  var id: String { rawValue }
//  var title: String { rawValue.capitalized }
//  var icon: String {
//    switch self {
//      case .rotation: "􂝔"
//      case .translation: "􀧐"
//      case .scale: "􂁟"
//    }
//  }
//  static func activeEdits(for strokeOutput: StrokeRenderOutput) -> String {
//    let data = allCases.filter { metadata in
//      switch metadata {
//        case .rotation: strokeOutput.transform.hasRotation
//        case .translation: strokeOutput.transform.hasTranslation
//        case .scale: strokeOutput.transform.hasScale
//      }
//    }
//    return data.map { $0.icon }.joined()
//  }
//}
