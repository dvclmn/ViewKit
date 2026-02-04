//
//  SimpleWaveInspector.swift
//  BaseDemos
//
//  Created by Dave Coleman on 30/1/2026.
//

import CasePaths
import SwiftUI
import ToolKit
import VectorKit

struct SimpleWaveInspector: View {
  @Environment(SimpleWaveHandler.self) private var store
  //  @Environment(\.simpleHandler) private var store
  @Environment(\.frameRate) private var frameRate

  var body: some View {
    @Bindable var store = store

    Form {

      InterpolationPicker(config: $store.wave.config)

      Picker("Frame Rate", selection: frameRate) {
        Text("Unlocked").tag(FrameRate.unlocked)
        Divider()
        ForEach(FrameRate.allCases.filter { !$0.isUnlocked }) { rate in
          Text(rate.rawValue.toString + " fps").tag(rate)
        }
      }

//      WaveControls(wave: $store.wave.wave) { attr in
//        switch attr {
//          case .amplitude: 0...300
//          case .frequency: 0...6
//          default: nil
//        //          case .phase:
//        //          case .noise:
//        }
//        //        attr.isAmplitude ? 0...200 : nil
//      }

      QuickSlider("Samples", intValue: $store.wave.config.sampleCount, range: 2...90)
      QuickSlider("Cycles", value: $store.wave.config.cycles, range: 1...90)
      QuickSlider("Dot Size", value: $store.wave.style.pointStyle.radius, range: 1...90)
    }
    .formStyle(.grouped)

  }
}
extension SimpleWaveInspector {
  private var config: FloatWaveConfig { store.wave.config }

}
