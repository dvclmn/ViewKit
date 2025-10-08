//
//  CustomLabeledContent.swift
//  BaseComponents
//
//  Created by Dave Coleman on 15/6/2025.
//

import SwiftUI

//public struct CustomLabeledContentAlt: LabeledContentStyle {
//
//  @Environment(\.layoutConfig) private var layoutConfig
//
//  public func makeBody(configuration: Configuration) -> some View {
//
//    //    DynamicStack(axis: layoutConfig.axis) {
//    HStack {
//      VStack {
//        configuration.label
//        //          .foregroundStyle(.secondary.opacity(0.8))
//      }
//      .frame(maxWidth: .infinity, alignment: .leading)
//
//      configuration.content
//        .frame(maxWidth: .infinity, alignment: .trailing)
//        .toggleStyle(.smallSwitch)
//        .textFieldStyle(.roundedBorder)
//      //        .controlSize(.small)
//      //    }
//
//      //        .frame(maxWidth: layoutConfig.fullWidthValue, alignment: layoutConfig.alignment)
//    }
//  }
//}
//
//extension LabeledContentStyle where Self == CustomLabeledContentAlt {
//  public static var alt: CustomLabeledContentAlt { CustomLabeledContentAlt() }
//}
//
