//
//  ImportModifier.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 15/11/2025.
//

import SwiftUI

public struct ImportStringModifier: ViewModifier {
  
  let fileName: String
  let stringDidLoad: (String) -> Void
  
  public func body(content: Content) -> some View {
    content
      .onAppear {
        do {
          let string = try ImportHandler.loadStringFromBundle(
            named: "example01",
            withExtension: "md",
            bundle: .main
          )
          stringDidLoad(string)
          
        } catch {
          print("Error loading string: \(error)")
        }
      }
  }
}
extension View {
  public func loadString(
    with fileName: String,
    _ stringDidLoad: @escaping (String) -> Void
  ) -> some View {
    self.modifier(
      ImportStringModifier(
        fileName: fileName,
        stringDidLoad: stringDidLoad
      )
    )
  }
}
