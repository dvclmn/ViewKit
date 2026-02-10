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
            value: binding.strength.toBindingDouble,
            range: 0...90
          )

          QuickSlider(
            "Zoom",
            value: binding.zoom.toBindingDouble,
            range: 0...3
          )

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
            range: 0...10
          )
          .helpText("Control the amount of Blur")

          QuickSlider(
            "Start",
            value: binding.start.toBindingDouble,
            range: 0...2,
          )
          .helpText("How far out from the origin does the Blur begin")

          QuickSlider(
            "End",
            value: binding.end.toBindingDouble,
            range: 0.5...3,
          )
          .helpText("How far out from the origin do we reach 100% blurriness")

          QuickSlider(
            "Samples",
            value: binding.samples.toBindingDouble,
            range: 1...100,
          )
          //          .disabled(shouldLockBlurAndSamples)
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
