//
//  File.swift
//
//
//  Created by Dave Coleman on 30/6/2024.
//

import SwiftUI


public struct SecureTextField: View {
  
  @State private var isLocked: Bool = false
  //    @State private var errorMessage: String
  
  let title: String
  @Binding var text: String
//  let size: ElementSize
  let errorMessage: String?
  let isDisabled: Bool
  let prompt: String?
  let onSubmit: () -> Void
  
  public init(
    _ title: String,
    text: Binding<String>,
//    size: ElementSize = .normal,
    errorMessage: String? = nil,
    isDisabled: Bool = false,
    prompt: String? = nil,
    onSubmit: @escaping () -> Void
  ) {
    self.title = title
    self._text = text
//    self.size = size
    self.errorMessage = errorMessage
    self.isDisabled = isDisabled
    self.prompt = prompt
    self.onSubmit = onSubmit
  }
  
  public var body: some View {
    
    Group {
      if !isLocked {
        TextField(title, text: $text, prompt: prompt != nil ? Text(prompt ?? "") : nil)
          .disabled(isDisabled)
          .onSubmit {
            Task {
              submit()
            }
          }
      } else {
        SecureField(title, text: $text, prompt: prompt != nil ? Text(prompt ?? "") : nil)
          .foregroundStyle(.secondary)
          .disabled(isDisabled)
          .onSubmit {
            Task {
              submit()
            }
          }
      }
    } // END text fields group
    //        .frame(height: size.length)
    .opacity(isDisabled ? 0.5 : 1.0)
//    .textFieldStyle(.custom.action(BaseElementAction(
//      label: isLocked ? "Show key" : "Hide key",
//      icon: isLocked ? "eye.slash" : "eye",
//      isShowing: !text.isEmpty, action: { isLocked.toggle() })))
    
    
    if let errorMessage = errorMessage {
      Text(errorMessage)
    }
    
  }
}

extension SecureTextField {
  private func submit() {
    self.isLocked = true
    self.onSubmit()
  }
}
#if DEBUG
#Preview {
  SecureTextField("Title", text: .constant("923962942"), onSubmit: {})
    .padding(40)
    .frame(width: 340, height: 700)
    .background(.black.opacity(0.6))
}
#endif
