//
//  FontSizeCommands.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 25/11/2025.
//

#if canImport(AppKit)
import CoreTools
import SwiftUI



public protocol PreferenceSettable where Self: Observable {
  associatedtype Prefs
  func setPref<T>(
    _ keyPath: WritableKeyPath<Prefs, T>,
    value newValue: T
  )
  func prefBinding<T>(
    _ keyPath: WritableKeyPath<Prefs, T>
  ) -> Binding<T>
  
  func togglePref(
    _ keyPath: WritableKeyPath<Prefs, Bool>
  )
}

public protocol FontSizable where PrefSetter.Prefs == Self {
  associatedtype PrefSetter: PreferenceSettable
//  associatedtype Prefs
  var fontSize: CGFloat { get set }
  var fontStepSize: CGFloat { get }
  var fontSizeRange: ClosedRange<CGFloat> { get }
}

@CommandsBuilder
public func FontSizeCommands<T: FontSizable>(_ placement: CommandGroupPlacement) -> some Commands {
  CommandGroup(after: .newItem) {
    Menu("Font Size") {

      Button {
        T.PrefSetter.prefBinding(<#T##self: PreferenceSettable##PreferenceSettable#>)
//        store.setPref(
//          \.fontSize,
//           value: store.prefs.fontSize.stepping(
//            by: AppHandler.fontStepSize,
//            in: AppHandler.fontSizeRange
//           )
//        )
//
      } label: {
        Label("Increase", systemImage: "textformat.size.larger")
      }
      .keyboardShortcut("+", modifiers: .command)
//      
//      Button {
//        store.setPref(
//          \.fontSize,
//           value: store.prefs.fontSize.stepping(
//            by: -AppHandler.fontStepSize,
//            in: AppHandler.fontSizeRange
//           )
//        )
//      } label: {
//        Label("Decrease", systemImage: "textformat.size.smaller")
//      }
//      .keyboardShortcut("-", modifiers: .command)
//      
//      Button {
//        if store.prefs.fontSize != Preferences.defaultFontSize {
//          store.setPref(\.fontSize, value: Preferences.defaultFontSize)
//          popup.showPopup("Reset font size to default")
//        }
//      } label: {
//        Text("Reset")
//      }
//      .keyboardShortcut("0", modifiers: .command)
//      
    }
  }
}



//struct MenuCommands: Commands {
//  @Bindable var store: AppHandler
//  //  @FocusedBinding(\.exampleData) private var exampleData
//  @Bindable var popup: Popup
//  
//  var body: some Commands {
//    InspectorCommands()
//    SidebarCommands()
//    ToolbarCommands()
//    TextFormattingCommands()
//    TextEditingCommands()
//    
//
//  }
//}
//#endif
//
