////
////  File.swift
////  
////
////  Created by Dave Coleman on 26/6/2024.
////
//
//import Foundation
//import SwiftUI
//

//
//public protocol Actionable {
//    var name: String { get }
//    var shortcut: KeyboardShortcut { get }
//    var spacing: ActionableSpacer? { get }
//    var hasKeyLabel: Bool { get }
//}
//
//public extension Actionable {
//    var spacing: ActionableSpacer? {
//        return nil
//    }
//    
//    var hasKeyLabel: Bool {
//        return false
//    }
//}
//
//public enum ActionableSpacer {
//    case right
//    case left
//}
//
//public struct ShortcutTray<Action: Actionable>: ViewModifier {
//    
//    let actions: [Action]
//    let isShowingKeyLabel: Bool
//    
//    @State private var isHovering: Bool = false
//    
//    public func body(content: Content) -> some View {
//        content
//            .overlay(alignment: .bottom) {
//                HStack(spacing: 14) {
//                    ForEach(actions, id: \.name) { action in
//                        if let spacer = action.spacing, spacer == .left {
//                            Spacer()
//                        }
//                        ShortcutLabel(action.name, shortcut: action.shortcut, isShowingLabelHint: action.hasKeyLabel)
//                        if let spacer = action.spacing, spacer == .right {
//                            Spacer()
//                        }
//                    }
//                }
//                .opacity(isHovering ? 1.0 : 0.5)
//                .padding(.horizontal, Styles.sizeRegular)
//                .padding(.vertical, Styles.sizeSmall)
//                .frame(maxWidth: .infinity)
//                .background(.ultraThinMaterial)
//                /// Note: This `Styles.toolbarHeightPrimary` is to provide a larger x-height for more comfortable hovering
//                .frame(maxHeight: Styles.toolbarHeightPrimary, alignment: .bottom)
//                
//                .onHover { hovering in
//                    withAnimation(.snappy(duration: 0.3)) {
//                        isHovering = hovering
//                    }
//                }
//                
//            }
//    }
//}
//public extension View {
//    func shortcutsTray<Action: Actionable>(
//        actions: [Action],
//        isShowingKeyLabel: Bool = false
//    ) -> some View {
//        self.modifier(
//            ShortcutTray(
//                actions: actions,
//                isShowingKeyLabel: isShowingKeyLabel
//            )
//        )
//    }
//}
//

//
//struct ShortcutsTrayExample: View {
//    
//    
//    var body: some View {
//        
//        Text("Hello")
//            .padding(200)
//            .background(.blue.opacity(0.2))
//            .shortcutsTray(actions: ExampleActions.allCases)
//        
//    }
//}
//#Preview {
//    ShortcutsTrayExample()
//        .padding(40)
//        .frame(width: 600, height: 700)
//        .background(.black.opacity(0.6))
//}
