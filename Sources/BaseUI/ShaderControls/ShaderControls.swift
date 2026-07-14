//
//  ShaderControls.swift
//  ViewKit
//
//  Created by Dave Coleman on 10/2/2026.
//

import CoreTools
import GraphicsKit
import SwiftUI
import ViewTools

public struct ShaderControls: View {

  @AppStorage("shouldLockBlurAndSamples") var shouldLockBlurAndSamples: Bool = true
  @Binding var shaders: [ShaderEffect]

  public init(shaders: Binding<[ShaderEffect]>) {
    self._shaders = shaders
  }

  public var body: some View {

    if !shaders.isEmpty {
      ForEach($shaders) { shader in
        /// This controls the space between the Slider Group header and the Slider content
        VStack(alignment: .leading, spacing: Styles.sizeSmall) {
          SliderGroup(shader.wrappedValue.displayName, spacing: Styles.sizeSmall) {

            SingleShaderControlView(shader: shader)
          }
        }
        .padding(.bottom, Styles.sizeSmall)

      }  // END foreach
      .environment(\.layoutPadding, Styles.sizeSmall)
    } else {
      StateView(
        label: .init("No Shaders", icon: .emoji("🪜")),
        message: "There are no shaders added to the Canvas yet.",
        isMessageCopyable: false,
      ) {
        Button {

        } label: {
          Label("Add", systemImage: Icons.plus.icon)
        }
      }
    }
  }
}

#if DEBUG
#Preview {
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
}
#endif
