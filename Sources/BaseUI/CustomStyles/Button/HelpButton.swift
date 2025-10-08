//
//  HelpButton.swift
//  Components
//
//  Created by Dave Coleman on 17/11/2024.
//

import SwiftUI


public struct HelpButton: View {
  
  @State private var isPresented: Bool = false
  
  let text: AttributedString
  
  public init(text: AttributedString) {
    self.text = text
  }
  
  public var body: some View {
    
    Button {
      isPresented.toggle()
    } label: {
      Label("More information", systemImage: "questionmark.circle.fill")
    }
//    .buttonStyle(.custom(.titleOnly.style(.plain)))
    .popover(isPresented: $isPresented) {
      Text(text)
        .padding()
        .frame(maxWidth: 280, maxHeight: .infinity)
        .fixedSize(horizontal: false, vertical: true)
    }
    
  }
}
#if DEBUG
@available(macOS 15, iOS 18, *)
#Preview(traits: .size(.normal)) {
  HelpButton(text: AttributedString("*Help*"))
}
#endif

public struct HelpButtonModifier: ViewModifier {
  
  let text: AttributedString
  public func body(content: Content) -> some View {
    HStack(alignment: .top) {
      content
      HelpButton(text: text)
    }
  }
}
public extension View {
  func helpButton(
    text: AttributedString
  ) -> some View {
    self.modifier(
      HelpButtonModifier(text: text)
    )
  }
}

