//
//  ShaderControls.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 10/2/2026.
//

//import CasePaths
import CoreTools
import GraphicsKit
import SwiftUI
import UIPrimitives

public struct ShaderControls: View {

  @AppStorage("shouldLockBlurAndSamples") var shouldLockBlurAndSamples: Bool = true
  @Binding var shaders: [ShaderEffect]

  public init(shaders: Binding<[ShaderEffect]>) {
    self._shaders = shaders
  }
  public var body: some View {

    ForEach($shaders) { shader in

      /// This controls the space between the Slider Group header and the Slider content
      VStack(alignment: .leading, spacing: Styles.sizeSmall) {
        SliderGroup(shader.wrappedValue.name, spacing: Styles.sizeSmall) {
          Text("Bring back `SingleShaderControlView`")
          //          SingleShaderControlView(shader: shader)
        }
      }
      .padding(.bottom, Styles.sizeSmall)

    }  // END foreach
    .environment(\.layoutPadding, Styles.sizeSmall)
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
