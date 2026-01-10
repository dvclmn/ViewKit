//
//  ImportModifier.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 15/11/2025.
//

import SwiftUI

public struct ImportStringModifier: ViewModifier {

  let name: String
  let fileExtension: String
  let bundle: Bundle
  let stringDidLoad: (String) -> Void

  public func body(content: Content) -> some View {
    content
      .onAppear {
        do {
          let string = try ImportHandler.loadString(
            named: name,
            withExtension: fileExtension,
            bundle: bundle
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
    named: String,
    fileExtension: String,
    bundle: Bundle = .main,
    _ stringDidLoad: @escaping (String) -> Void
  ) -> some View {
    self.modifier(
      ImportStringModifier(
        name: named,
        fileExtension: fileExtension,
        bundle: bundle,
        stringDidLoad: stringDidLoad
      )
    )
  }
}
