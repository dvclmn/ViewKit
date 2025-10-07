//
//  File.swift
//
//
//  Created by Dave Coleman on 26/5/2024.
//

//#if os(macOS)
//
//
//
//import Foundation
//import SwiftUI
//

//import BaseHelpers
//import BaseComponents

//import MarkdownEditor

//enum TextEditorActions: Actionable, CaseIterable {
//    case exit
//    case save
//
//    var name: String {
//        switch self {
//        case .exit:
//            "Exit"
//        case .save:
//            "Save & Exit"
//        }
//    }
//
//    var shortcut: KeyboardShortcut {
//        switch self {
//        case .exit:
//                .init(.escape, modifiers: [])
//        case .save:
//                .init(.return, modifiers: .command)
//        }
//    }
//
//    var spacing: ActionableSpacer? {
//
//        switch self {
//        case .exit:
//            nil
//        case .save:
//                .left
//        }
//
//    }
//
//    var hasKeyLabel: Bool {
//        switch self {
//        case .exit:
//            true
//        case .save:
//            false
//        }
//    }
//
//}

//public struct TextEditorView<Editor: View>: View {
//  
//  @Environment(\.dismiss) private var dismiss
//  
//  @Binding private var text: String
//  
//  private let title: String?
//  private let grainientSeed: Int?
//  private let uiDimming: Double
//  private let hasToolbar: Bool
//  
//  @State private var localTextValue: String = ""
//  @State private var isAlerting: Bool = false
//  
//  @State private var rect: NSRect = .zero
//  
//  let editor: (String) -> Editor
//  
//  public init(
//    text: Binding<String>,
//    title: String? = nil,
//    grainientSeed: Int? = nil,
//    uiDimming: Double = 0.4,
//    hasToolbar: Bool = true,
//    @ViewBuilder editor: @escaping (String) -> Editor
//  ) {
//    self._text = text
//    self.title = title
//    self.grainientSeed = grainientSeed
//    self.uiDimming = uiDimming
//    self.hasToolbar = hasToolbar
//    self.editor = editor
//  }
//  
//  public var body: some View {
//    
//    
//    self.editor(text)
////    MarkdownEditor(text: $localTextValue)
//
////      .customToolbar(title, hasBackButton: true, isDisabled: !hasToolbar) {
//        Button {
//          text = localTextValue
//          dismiss()
//        } label: {
//          Label("Save", systemImage: "checkmark")
//        }
////        .buttonStyle(.custom.titleOnly)
//        
//        .keyboardShortcut(.return, modifiers: [.command])
////      }
//    //        .shortcutsTray(actions: TextEditorActions.allCases)
//      .alert("Discard changes and exit?", isPresented: $isAlerting) {
//        Button("Discard and exit") {
//          dismiss()
//        }
//      }
//      .onAppear {
//        localTextValue = text
//      }
//      .grainient(seed: grainientSeed, uiDimming: uiDimming)
//  }
//  
//}
//#Preview {
//  TextEditorView(
//    text: .constant("Example"),
//    title: "Conversation Prompt",
//    uiDimming: 0.5
//  )
//  .frame(width: 600, height: 700)
//  .grainient(seed: Grainient.jungleFlower.seed)
//}

//#endif
