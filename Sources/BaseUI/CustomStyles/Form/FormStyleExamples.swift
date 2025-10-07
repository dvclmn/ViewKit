////
////  SwiftUIView.swift
////
////
////  Created by Dave Coleman on 9/7/2024.
////
//
//import SwiftUI
//

//
//
//struct FormExampleView: View {
//  
//  @State private var text: String = ""
//  @FocusState var isFocused: Bool
//  
//  var body: some View {
//    
//    VStack {
//      SectionedForm {
//        FormContent()
//      }
//      
//      Form {
//        FormContent()
//      }
//      .formStyle(.grouped)
//      
//    }
//#warning("Turn this back on")
////    .formStyle(.custom())
//    
//  }
//}
//
//extension FormExampleView {
//  @ViewBuilder
//  func FormContent() -> some View {
//    Section("Details") {
//      LabeledContent {
//        TextField("", text: $text, prompt: Text("Enter conversation name"))
//        
//        
//      } label: {
//        Label("Conversation name", systemImage: Icons.title.icon)
//      }
//      
//      LabeledContent {
//        TextField("", text: $text, prompt: Text("Customise how you address your assistant"))
//        
//        
//      } label: {
//        Label("Assistant name", systemImage: Icons.person.icon)
//      }
//      
//      
//      LabeledContent {
//        
//        Spacer()
//        Button {
//          
//        } label: {
//          Label("Edit", systemImage: Icons.edit.icon)
//        }
//#warning("Turn this back on")
//        //                    .buttonStyle(.custom.size( .small))
//        
//      } label: {
//        Label("Prompt", systemImage: Icons.text.icon)
//        Text("No conversation prompt provided.")
//          .multilineTextAlignment(.leading)
//          .lineLimit(6)
//          .frame(maxWidth: .infinity, alignment: .leading)
//        
//      }
//    }
//  }
//}
//
//#if DEBUG
//#Preview {
//  FormExampleView()
//    .frame(width: 380, height: 700)
//    .background(.black.opacity(0.6))
//}
//#endif
