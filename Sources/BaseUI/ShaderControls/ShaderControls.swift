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

  // @Environment(\.viewportSize) private var viewportSize
  @Binding var shader: ShaderEffect
  let persistenceKeyExpanded: String
  let persistenceKeyEnabled: String
  public init(
    shader: Binding<ShaderEffect>,
    persistenceKeyExpanded: String? = nil,
    persistenceKeyEnabled: String? = nil,
  ) {
    self._shader = shader
    self.persistenceKeyExpanded = persistenceKeyExpanded ?? "isShowingShaderControls"
    self.persistenceKeyEnabled = persistenceKeyEnabled ?? "areShaderControlsEnabled"
  }
  public var body: some View {

    DisclosureSection(shader.name, persistenceKey: persistenceKeyExpanded) {

      SliderGroup {
        switch shader {
          case .chromaticAberration:
            if let binding = $shader.chromaticAberration {

              QuickSlider(
                "Strength",
                value: binding.strength.toBindingDouble,
                range: 0...4
              )
              .helpText("Adjust the opacity of the color shift")

              QuickSlider(
                "Fringing",
                value: binding.radialStrength.toBindingDouble,
                range: -40...40,
                minMaxLabels: ("circle.dotted", "circle.dotted.and.circle")
              )
              .helpText("Controls how far apart the colours shift")
            }

          default: StateView("Not yet implemented")
        //
        //
        //        case .fisheye:
        //
        //
        //        case .glitter:
        //
        //
        //        case .crtCurvature:
        //
        //
        //        case .crtLines:
        //
        //
        //        case .filmGrain:
        //
        //
        //        case .ripplePush:
        //
        //
        //        case .psych:
        //
        //
        }
      }
      //      ToggledView(persistenceKey: "areShadersEnabled") {
      //        if let binding = store.dataBinding(.standard).shaderA.chromaticAberration {
      //          SliderGroup {
      //
      //            QuickSlider(
      //              "Strength",
      //              value: binding.strength,
      //              range: 0...4
      //            )
      //
      //            QuickSlider(
      //              "Fringing",
      //              value: binding.radialStrength,
      //              range: -40...40
      //            )
      //          }
      //        }
      //
      //      }
      //      Toggle(
      //        "Enabled",
      //        isOn: store.prefBinding(\.enabled).bindingBool(key: .shaders)
      //      )

    }

  }
}

extension ShaderControls {

}
#if DEBUG
#Preview(traits: .size(.normal)) {
  @Previewable @State var shader = ShaderEffect.chromaticPresetA
  Form {
    ShaderControls(shader: $shader)
  }
  .formStyle(.grouped)
  .frame(width: 300)
  // .environment(store)
}
#endif
