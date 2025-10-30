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
//    case off
    case ruler
    case digits
  }

  public static func widthCounter(
    _ width: Int,
    style: WidthCounterStyle
  ) -> AttributedString {

    var result = AttributedString()

    switch style {
//      case .off:
//        break

      case .digits:

        let fullOutput = self.generateDigitCounter(width)

        result.append(fullOutput.tens, addsLineBreak: true)
        result.append(fullOutput.ones, addsLineBreak: true)

      case .ruler:

        let compactOutput = self.generateCompactCounter(width)

        result.append(compactOutput, addsLineBreak: false)
        result.addLineBreak()
        //        #warning("Need to go back to file String+Repeater, as I commented this out when something elsewhere was breaking")

        //        let pattern = "I need to fix this, this is turned off!"
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
