// swift-tools-version: 6.1

import CompilerPluginSupport
import PackageDescription

let package = Package(
  name: "BaseHelpers",
  platforms: [
    .iOS("17.0"),
    .macOS("14.0"),
  ],
  products: [
    // MARK: - Helpers
    .library(name: "BaseHelpers", targets: ["BaseHelpers"]),
    .library(name: "BaseColour", targets: ["BaseColour"]),
    .library(name: "BaseNetworking", targets: ["BaseNetworking"]),
    .library(name: "ComponentTools", targets: ["ComponentTools"]),
    .library(name: "ColourExtract", targets: ["ColourExtract"]),
    .library(name: "CurveFunctions", targets: ["CurveFunctions"]),
    .library(name: "GridCanvas", targets: ["GridCanvas"]),
    .library(name: "LilyPad", targets: ["LilyPad"]),

    /// Common resources shared between `BaseHelpers` and `BaseMacros`
    .library(name: "SharedHelpers", targets: ["SharedHelpers"]),
    .library(name: "Wrecktangle", targets: ["Wrecktangle"]),

    // MARK: - Macros
    .library(
      name: "BaseMacros",
      targets: [
        "AssociatedValues",
        "CaseDetection",
        "MetaEnum",
        "Persistable",
        "SetOfOptions",
      ]
    ),
    .executable(
      name: "BaseMacrosClient",
      targets: ["BaseMacrosClient"]
    ),
  ],

  // MARK: - Dependancies
  dependencies: [
    .package(url: "https://github.com/swiftlang/swift-docc-plugin", from: "1.0.0"),
    .package(url: "https://github.com/swiftlang/swift-syntax", from: "600.0.1"),
    .package(url: "https://github.com/mattmassicotte/nsui", from: "1.3.0"),
    .package(url: "https://github.com/evgenyneu/keychain-swift", from: "24.0.0"),
    .package(url: "https://github.com/stackotter/swift-macro-toolkit", from: "0.6.0"),
  ],
  targets: [

    // MARK: - Other targets
    .target(
      name: "BaseHelpers",
      dependencies: [
        .sharedHelpers,
        .baseMacros,
        "CurveFunctions",
        "BaseColour",
        .product(name: "NSUI", package: "nsui"),
      ],
      //      resources: [.process("Assets.xcassets")],
    ),
    .target(
      name: "BaseNetworking",
      dependencies: [
        .baseHelpers,
        .product(name: "KeychainSwift", package: "keychain-swift"),
      ],
    ),
    .target(
      name: "BaseColour",
      dependencies: [
        .sharedHelpers,
        "CurveFunctions",
      ],
    ),
    .target(
      name: "ComponentTools",
      dependencies: [
        .baseHelpers,
        "BaseColour",
        .sharedHelpers,
        //        .baseMacros,
      ]),
    .target(name: "ColourExtract"),
    .target(name: "CurveFunctions"),
    .target(name: "GridCanvas", dependencies: [.baseHelpers]),
    .target(name: "LilyPad", dependencies: [.baseHelpers]),
    .target(name: "SharedHelpers"),
    .target(name: "Wrecktangle"),

    // MARK: - BaseMacro targets
    .macro(
      name: "BaseMacrosGuts",
      dependencies: [
        .sharedHelpers,
        .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
        .product(name: "SwiftCompilerPlugin", package: "swift-syntax"),
        .product(name: "MacroToolkit", package: "swift-macro-toolkit"),
      ],
      path: "Sources/BaseMacrosSources/MacroExpansions",
    ),
    .target(
      name: "AssociatedValues",
      dependencies: ["BaseMacrosGuts"],
      path: .macroDecl("AssociatedValues")
    ),
    .target(
      name: "CaseDetection",
      dependencies: ["BaseMacrosGuts"],
      path: .macroDecl("CaseDetection")
    ),
    .target(
      name: "MetaEnum",
      dependencies: ["BaseMacrosGuts"],
      path: .macroDecl("MetaEnum")
    ),
    .target(
      name: "Persistable",
      dependencies: ["BaseMacrosGuts"],
      path: .macroDecl("Persistable")
    ),
    .target(
      name: "SetOfOptions",
      dependencies: ["BaseMacrosGuts"],
      path: .macroDecl("SetOfOptions")
    ),

    .executableTarget(
      name: "BaseMacrosClient",
      dependencies: [
        "AssociatedValues",
        "CaseDetection",
        "MetaEnum",
        "Persistable",
        "SetOfOptions",
      ],
      path: "Sources/BaseMacrosSources/BaseMacrosClient",
    ),

  ],
)
// MARK: - Convenient type-safe extensions
extension Target.Dependency {
  static var baseHelpers: Self { "BaseHelpers" }
  static var sharedHelpers: Self { "SharedHelpers" }
  static var baseMacros: Self { "BaseMacrosGuts" }
}
extension String {
  static func macroDecl(_ macroName: String) -> String {
    return "Sources/BaseMacrosSources/MacroDeclarations/" + macroName
  }
}
