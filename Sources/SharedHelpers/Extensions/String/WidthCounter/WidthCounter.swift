//
//  WidthCounterStyle.swift
//  BoxCore
//
//  Created by Dave Coleman on 29/8/2024.
//

import Foundation
import SwiftUI

extension TextCore {

  public enum WidthCounterStyle: Sendable {
    case ruler
    case digits
  }

  public static func widthCounter(
    _ width: Int,
    style: WidthCounterStyle
  ) -> AttributedString {

    var result = AttributedString()

    switch style {

      case .digits:

        let fullOutput = self.generateDigitCounter(width)
        result.append(fullOutput.tens, addsLineBreak: true)
        
        /// Specify `false` here so we're not left with a trailing line break
        result.append(fullOutput.ones, addsLineBreak: false)

      case .ruler:

        let compactOutput = self.generateCompactCounter(width)

        result.append(compactOutput, addsLineBreak: false)
        result.addLineBreak()

        let pattern = String.pattern(totalCount: width) {
          character("|")
          repeating(".", count: 4)
          character("╷")
          repeating(".", count: 4)
        }

        result.append(
          pattern, addsLineBreak: false
        )
        result.addLineBreak()

    }

    return result
  }

}

struct WidthCounterView: View {

  var body: some View {

    VStack(spacing: 60) {
      Text(TextCore.widthCounter(38, style: .ruler))
      Text(TextCore.widthCounter(38, style: .digits))
    }
    .textSelection(.enabled)
    .monospaced()
    .frame(width: 400, height: 600)
    .background(.black.opacity(0.6))
  }
}

#if DEBUG
#Preview {
  WidthCounterView()
}

#endif
