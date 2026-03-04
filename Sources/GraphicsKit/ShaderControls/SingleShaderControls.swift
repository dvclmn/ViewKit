//
//  SingleShaderControls.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 10/2/2026.
//

import CasePaths
import CoreTools
import GraphicsKit
import SwiftUI

struct SingleShaderControlView: View {

  @Binding var shader: ShaderEffect

  var body: some View {

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

      case .crtCurvature:
        if let binding = $shader.crtCurvature {

          QuickSlider(
            "Strength",
            value: binding.toBindingDouble,
            range: 0...40
          )

          //          QuickSlider(
          //            "Zoom",
          //            value: binding.zoom.toBindingDouble,
          //            range: 0...3
          //          )

        }

      case .crtLines:
        if let binding = $shader.crtLines {

          QuickSlider(
            "Spacing",
            value: binding.lineSpacing.toBindingDouble,
            range: 0...40
          )
          QuickSlider(
            "Intensity",
            value: binding.lineIntensity.toBindingDouble,
            range: 0...6
          )
          QuickSlider(
            "Phosphor",
            value: binding.phosphorSize.toBindingDouble,
            range: 0...10
          )
          QuickSlider(
            "Brightness",
            value: binding.brightness.toBindingDouble,
            range: 0...4
          )
        }

      case .radialBlur:

        if let binding = $shader.radialBlur {

          QuickSlider(
            "Blur",
            value: binding.strength.toBindingDouble,
            range: 0...20
          )

          QuickSlider(
            "Start",
            value: binding.start.toBindingDouble,
            range: 0...1,
          )
          .helpText("The blur start point, from view edges to the centre.")

          QuickSlider(
            "Falloff",
            value: binding.end.toBindingDouble,
            range: 0...3,
          )
          .helpText("How gradual or abrupt is the transition from 0-100% blur.")

          QuickSlider(
            "Samples",
            value: binding.samples.toBindingDouble,
            range: 1...200,
          )
        }

      case .checkerboard:
        //      case .checkerboard(let primary, let secondary, let scale, let offset):
        if let binding = $shader.checkerboard {
          ColourPicker(
            primary: binding.primary,
            secondary: binding.secondary,
            components: .all
          )

          QuickSlider(
            "Scale",
            value: binding.scale.toBindingDouble,
            range: 0...40
          )

        }

      case .fisheye,
        .glitter,
        .filmGrain,
        .ripplePush,
        .psych:
        StateView("Not yet implemented")
    }

  }
}
