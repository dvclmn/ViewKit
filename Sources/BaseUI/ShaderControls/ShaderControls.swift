//
//  ShaderControls.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 10/2/2026.
//

import CasePaths
import CoreTools
import GraphicsKit
import SwiftUI

public struct ShaderControls: View {

  @AppStorage("shouldLockBlurAndSamples") var shouldLockBlurAndSamples: Bool = true

  @Binding var shaders: [ShaderEffect]
  let persistenceKeyExpanded: String
  let persistenceKeyEnabled: String

  public init(
    shaders: Binding<[ShaderEffect]>,
    persistenceKeyExpanded: String? = nil,
    persistenceKeyEnabled: String? = nil,
  ) {
    self._shaders = shaders
    self.persistenceKeyExpanded =
      persistenceKeyExpanded ?? "isShowingShaderControls_\(shaders.wrappedValue.reduce("") { $0 + $1.name })"
    self.persistenceKeyEnabled =
      persistenceKeyEnabled ?? "areShaderControlsEnabled_\(shaders.wrappedValue.reduce("") { $0 + $1.name }))"
  }
  public var body: some View {

//    VStack(alignment: .leading, spacing: Styles.sizeHuge) {
      ForEach($shaders) { shader in

        /// This controls the space between the Slider Group header and the Slider content
        VStack(alignment: .leading, spacing: Styles.sizeSmall) {
          SliderGroup(shader.wrappedValue.name, spacing: Styles.sizeSmall) {
            SingleShaderControlView(shader: shader)
          }
        }
        .padding(.bottom, Styles.sizeSmall)

      }  // END foreach
      .togglable(persistenceKey: persistenceKeyEnabled, defaultEnabled: true)
      .environment(\.layoutPadding, Styles.sizeSmall)
//    }

  }
}

extension ShaderControls {

}
#if DEBUG
#Preview(traits: .size(.normal)) {
  @Previewable @State var shaders: [ShaderEffect] = [
    .chromaticPresetA,
    .crtCurvature(strength: 2),
    .crtLines(),

  ]
  Form {
    ShaderControls(shaders: $shaders)
  }
  .formStyle(.grouped)
  .frame(width: 300)
  // .environment(store)
}
#endif
