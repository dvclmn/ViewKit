//
//  QuickBackgroundExampleView.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 15/2/2026.
//

import CoreTools
import LayoutKit
import SwiftUI

struct QuickBackgroundExampleView: View {

  let imageURL: URL? =
    "https://images.unsplash.com/photo-1770566258012-7d809f99c574?q=80&w=1336&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
    .toURL

  let width: CGFloat = 400

  var body: some View {
    VStack(spacing: Styles.sizeMedium) {

      Text("Rounded Rect")
        .padding(40)
        .quickBackground(
          shape: .rect(cornerRadius: Styles.sizeRegular),
          glass: .regular,
          padding: Styles.sizeSmall,
          tint: .pink,
        )

      Text("Capsule")
        .padding(40)
        .quickBackground(
          shape: .capsule,
          padding: Styles.sizeMedium,
          tint: .black,
        )
    }
    .environment(\.horizontalBias, 3)
    .environment(\.opticalCentreBias, 1.5)
    
    .padding(.vertical, 40)
   
    .background {
      HPack {
        Rectangle().fill(.black.secondary)
          .frame(width: width / 2)
        AsyncImage(url: imageURL) {
          $0.image?
            .resizable()
            .aspectRatio(contentMode: .fill)
        }
        .frame(width: width / 2)
      }
    }
    .frame(width: width)
  }
}

#if DEBUG
#Preview(traits: .size(.normal)) {
  QuickBackgroundExampleView()
}
#endif
