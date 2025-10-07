////
////  File.swift
////
////
////  Created by Dave Coleman on 7/7/2024.
////
//
//import Foundation
//import SwiftUI
//

//
//struct LabeledContentExampleView: View {
//  
//  @State private var text: String = ""
//  @State private var slider: Double = .zero
//  @State private var toggle: Bool = false
//  
//  var body: some View {
//    
//    Form {
//      
//      ExampleSection("Non-compressed")
//      
//      ExampleSection("Compressed section")
//        .frame(maxWidth: 320)
//      
//      Section("Statistics") {
//        
//        LabeledContent {
//          Toggle("", isOn: $toggle)
//        } label: {
//          Label("Show Message info", systemImage: Icons.info.icon)
//        }
//        
//        LabeledContent {
//          Text("20")
//        } label: {
//          Label("Messages", systemImage: Icons.message.icon)
//        }
//        
//        
//        LabeledContent {
//          
//          Text("10")
//        } label: {
//          Label("Words", systemImage: "text.word.spacing")
//          
//        }
//        
//      }
//      
//      
//      Section("Example label") {
//        Text("20%")
//          .monospacedDigit()
//        Slider(
//          value: $slider,
//          in: 0.01...0.89
//        )
//        .controlSize(.mini)
//        .frame(
//          minWidth: 80,
//          maxWidth: 140
//        )
//        
//        Section("Nested") {
//          
//          Text("Lorem ipsum is placeholder text commonly used in the graphic, print, and web designing industries. It resembles Latin, with non-sensical words and phrases, and is used to fill space in a design to showcase fonts or layouts.")
//        }
//        
//      }
//      
//    } // END form
//    .padding()
////    .formStyle(.custom())
//  }
//  
//  @ViewBuilder
//  func ExampleSection(_ title: String) -> some View {
//    Section(title) {
////    CustomSection(title) {
//      
//      LabeledContent {
//        TextField("", text: $text, prompt: Text("Conversation name"))
//        //                    .textFieldStyle(.customField())
//        
//        
//      } label: {
//        Label("Conversation name", systemImage: Icons.title.icon)
//        Text("Additional context, insight, information and other materials. The question is; where to display it?")
//      }
//      
//      
//      LabeledContent {
//        TextField("", text: $text, prompt: Text("Assistant name"))
////          .textFieldStyle(.custom)
//        
//        Button {
//          
//        } label: {
//          Label("Go do that", systemImage: Icons.text.icon)
//        }
//        //                .buttonStyle(.custom())
//        
//      } label: {
//        Label("Assistant name", systemImage: Icons.person.icon)
//      }
//      
//    }
//    
//  }
//}
//
//#if DEBUG
//#Preview {
//  LabeledContentExampleView()
//    .frame(width: 540, height: 760)
//    .background(.black.opacity(0.6))
//}
//
//#endif
