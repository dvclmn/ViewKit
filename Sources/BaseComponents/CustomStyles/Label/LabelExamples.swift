//
//  LabelExamples.swift
//  BaseComponents
//
//  Created by Dave Coleman on 7/3/2025.
//

import SwiftUI
import BaseHelpers

//public struct LabelExampleView: View {
//  
//  public var body: some View {
//    
//    VStack(alignment: .leading, spacing: Styles.sizeMedium) {
//
//      ExampleLabel("Native Automatic Style")
//        .labelStyle(.automatic)
//      
//      ExampleLabel("Base Custom Label")
//        .labelStyle(.base)
//      
//      GroupBox("MaybeLabels") {
//        MaybeLabel("One with title")
//        MaybeLabel(QuickLabel("Got an Emoji", .emoji("🛼")))
//        MaybeLabel("With title and icon", icon: .symbol("car"))
//      }
//      .groupBoxStyle(.custom)
//    }
//    .frame(maxWidth: .infinity, maxHeight: .infinity)
//    .background(.black.secondary)
//    
//  }
//}
//extension LabelExampleView {
//  @ViewBuilder
//  func ExampleLabel(_ title: String) -> some View {
//    Label(title, systemImage: Icons.getRandomIcon)
//  }
//}
//#if DEBUG
//@available(macOS 15, iOS 18, *)
//#Preview(traits: .size(.normal)) {
//  LabelExampleView()
//}
//#endif
//
