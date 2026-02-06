//
//  WaveformPicker.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 6/2/2026.
//

import SwiftUI

struct WaveformPicker: View {
  @Binding var waveform: Waveform
  //  @Binding var selection: Double

  let waveforms = ["Sine", "Triangle", "Square", "Sawtooth"]

  var body: some View {
    Picker("", selection: $waveform) {

      ForEach(Waveform.allCases) { form in
        HStack {
          WaveForm(form)
          //          WaveformPreview(type: index)
          //          Text(waveforms[index])
        }
        .tag(form)
      }

    }
    .pickerStyle(.inline)
  }

}

extension WaveformPicker {
  @ViewBuilder
  private func WaveForm(_ form: Waveform) -> some View {
    Canvas { context, size in
      //    GeometryReader { geometry in
      let path = Path { p in
        let width = size.width
        let height = size.height
        let midHeight = height / 2

        p.move(to: CGPoint(x: 0, y: midHeight))

        for x in 0...Int(width) {
          let progress = Double(x) / width
          let y: Double

          switch form {
            case .sine:  // Sine
              y = midHeight + sin(progress * .pi * 2) * (height / 2)
            case .triangle:  // Triangle
              y =
                midHeight + (abs(((progress * 4).truncatingRemainder(dividingBy: 2.0) - 1) * 2) - 1)
                * (height / 2)
            case .square:  // Square
              y =
                midHeight + (progress * 2).truncatingRemainder(dividingBy: 1.0) < 0.5
                ? height / 2 : -height / 2
            case .sawtooth:  // Sawtooth
              y = midHeight + ((progress * 2).truncatingRemainder(dividingBy: 1.0) - 0.5) * height

          }

          p.addLine(to: CGPoint(x: Double(x), y: y))
        }
      }
      context.stroke(path, with: .color(.brown), lineWidth: 2)
      //      .stroke(Color.primary, lineWidth: 1)
    }
  }
}

#if DEBUG
#Preview {
  // @Previewable @State var store = AppHandler()
  @Previewable @State var waveform: Waveform = .sine
  WaveformPicker(waveform: $waveform)
    .frame(width: 300, height: 600)
  // .environment(store)
}
#endif
