import AppKit
import Testing
@testable import BasePrimitives

@Suite("ASCII colour assets")
struct ASCIIColourAssetTests {
  @Test("Every ASCIIColour case maps to a colourset in Assets.xcassets")
  func allAssetsExist() {
    for asciiColour in ASCIIColour.allCases {
      let colour = NSColor(
        named: NSColor.Name(asciiColour.rawValue),
        bundle: BasePrimitivesResources.bundle
      )
      #expect(colour != nil, "Missing colour asset for \(asciiColour.rawValue)")
    }
  }
}
