//
//  FormStyle.swift
//
//
//  Created by Dave Coleman on 5/6/2024.
//

// import BaseHelpers


import SwiftUI

//public struct CustomFormStyle: FormStyle {
//  public func makeBody(configuration: Configuration) -> some View {
//    Form {
//      DecomposedView(.section, axis: .vertical) {
//        configuration.content
//      }
//      .containerValueBool(.hasSpacers, true)
//      .containerValueBool(.hasDividers, false)
//    }
//    .formStyle(.columns)
//  }
//}
//
//
//public struct BorderlessFormStyle: FormStyle {
//
//  public func makeBody(configuration: Configuration) -> some View {
//    ScrollView {
//      DecomposedView(.section, axis: .vertical) {
//        configuration.content
//          .containerValueBool(.hasDividers, false)
//          .containerValueBool(.hasSpacers, true)
////          .labeledContentStyle(.alt)
//          .toggleStyle(.smallSwitch)
//          .textFieldStyle(.roundedBorder)
//
//          //          .border(Color.green.opacity(0.3))
//      }
//      .setAxis(.vertical)
//      .setAlignment(.leading)
//      .safeAreaPadding(Styles.sizeMedium.bump)
//    }
//  }
//}
//
//extension FormStyle where Self == CustomFormStyle {
//  public static var custom: CustomFormStyle { .init() }
//}
//extension FormStyle where Self == BorderlessFormStyle {
//  public static var borderless: BorderlessFormStyle { .init() }
//}
//
//
//public struct CustomFormsTestView: View {
//
//  public var body: some View {
//
//    HStack {
//      VStack {
//        Text("Custom (custom)")
//
//        Form {
//          ExampleForm()
//        }
//        .formStyle(.custom)
//      }
//
//      VStack {
//        Text("Custom (borderless)")
//        Form {
//          ExampleForm()
//        }
//        .formStyle(.borderless)
//      }
//
//      VStack {
//        Text("Native (grouped)")
//        Form {
//          ExampleForm()
//        }
//        .formStyle(.grouped)
//      }
//    }
//    .frame(maxWidth: .infinity, maxHeight: .infinity)
//
//  }
//}
//
//extension CustomFormsTestView {
//  @ViewBuilder
//  func ExampleForm() -> some View {
//    Section("Section One") {
//
//      Text("Just plain Text")
//
//      LabeledContent("My title") {
//        Button {
//
//        } label: {
//          Label("Try this out", systemImage: Icons.boat.icon)
//            .labelStyle(.titleOnly)
//        }
//      }
//
//      Toggle("This will work", isOn: .constant(true))
//    }
//
//    Section("Section Two") {
//
//      LabeledContent("Long summary") {
//        TextField("First name", text: .constant(""), prompt: Text("Your name"))
//      }
//
//      QuickPicker(item: .constant(ExampleTab.blarm))
//      //      LabeledContent("These maybe?") {
//      //      }
//
//    }
//  }
//}
//#if DEBUG
//@available(macOS 15, iOS 18, *)
//#Preview(traits: .size(.wide)) {
//  CustomFormsTestView()
//}
//#endif
