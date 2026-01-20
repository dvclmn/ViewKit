//
//  Lilypad+Toolbar.swift
//  Playground
//
//  Created by Dave Coleman on 20/1/2026.
//

import SwiftUI

struct ToolbarView: ToolbarContent {
  @Environment(AppHandler.self) private var store
  
  var body: some ToolbarContent {
    ToolbarItem {
      Button("Clear") {
        store.setDrawing(\.strokes, value: [:])
        //            store.setDrawing(\.strokes, value: [])
      }
      .keyboardShortcut(.delete, modifiers: [])
    }
    ToolbarItem {
      if store.isDrawingEnabled {
        Button("Exit Drawing Mode") {
          store.isDrawingEnabled = false
        }
        .keyboardShortcut(.escape, modifiers: [])
        .tint(.purple)
        
      } else {
        Button("Enter Drawing Mode") {
          store.isDrawingEnabled = true
        }
      }
      //          Toggle("Toggle Drawing", isOn: $store.isDrawingEnabled)
      
    }

  }
}
