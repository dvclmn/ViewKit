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
    .library(name: "BaseNetworking", targets: ["BaseNetworking"]),
    .library(name: "BaseUI", targets: ["BaseUI"]),
    .library(name: "CanvasKit", targets: ["CanvasKit"]),
    .library(name: "ColourKit", targets: ["ColourKit"]),
    //    .library(name: "ComponentTools", targets: ["ComponentTools"]),
    .library(name: "CurveKit", targets: ["CurveKit"]),
    .library(name: "GestureKit", targets: ["GestureKit"]),
    .library(name: "GraphicsKit", targets: ["GraphicsKit"]),
    .library(name: "MotionKit", targets: ["MotionKit"]),
    .library(name: "PopupKit", targets: ["PopupKit"]),
    .library(name: "SearchKit", targets: ["SearchKit"]),
    .library(name: "SharedHelpers", targets: ["SharedHelpers"]),
    .library(name: "VectorKit", targets: ["VectorKit"]),
    .library(name: "WaveKit", targets: ["WaveKit"]),
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
      ],
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
    .package(url: "https://github.com/ukushu/Ifrit", from: "3.0.0"),
    .package(url: "https://github.com/pointfreeco/swift-sharing", from: "2.7.2"),
    .package(url: "https://github.com/kean/Nuke", from: "12.8.0"),
  ],

  // MARK: - Targets

  targets: [
    .target(
      name: "BaseHelpers",
      dependencies: [
        .targetDep(.sharedHelpers),
        .targetDep(.macros),
        .targetDep(.curveKit),
        .targetDep(.colourKit),
        .targetDep(.vectorKit),
        .product(name: "NSUI", package: "nsui"),
      ],
      //      resources: [.process("Assets.xcassets")],
    ),
    .target(
      name: "BaseNetworking",
      dependencies: [
        .targetDep(.baseHelpers),
        .product(name: "KeychainSwift", package: "keychain-swift"),
      ],
    ),
    .target(
      name: "BaseUI",
      dependencies: [
        .targetDep(.baseHelpers),
        .targetDep(.sharedHelpers),
        .targetDep(.curveKit),
        .targetDep(.colourKit),
        .sharing,
        .product(name: "NukeUI", package: "Nuke"),
      ],
    ),
    .target(name: "CanvasKit"),
    .target(
      name: "ColourKit",
      dependencies: [
        .targetDep(.sharedHelpers),
        .targetDep(.curveKit),
      ],
    ),

    .target(
      name: "CurveKit",
      dependencies: [
        .targetDep(.colourKit)
      ]
    ),
    .target(name: "GestureKit"),
    .target(name: "GraphicsKit"),
    .target(name: "MotionKit"),
    .target(name: "PopupKit"),
    .target(
      name: "SearchKit",
      dependencies: [
        .product(name: "IfritStatic", package: "Ifrit")
      ]),
    .target(name: "SharedHelpers"),
    .target(name: "WaveKit"),
    .target(name: "VectorKit"),
    .target(name: "Wrecktangle"),

    // MARK: - BaseMacro targets
    .macro(
      name: "BaseMacrosGuts",
      dependencies: [
        .targetDep(.sharedHelpers),
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
  static func targetDep(_ baseModule: BaseModule) -> Self {
    //    "\(baseModule.targetName)"
    .target(name: baseModule.targetName)
    //    .product(name: baseModule.targetName, package: "BaseHelpers")
  }
  static var sharing: Self {
    .product(name: "Sharing", package: "swift-sharing")
  }
}
extension String {
  static func macroDecl(_ macroName: String) -> String {
    return "Sources/BaseMacrosSources/MacroDeclarations/" + macroName
  }
}

/// List of common modules for convenience
enum BaseModule {
  case baseHelpers
  case macros
  case networking
  case baseUI
  // case canvasKit
  case colourKit
  //  case componentTools
  case curveKit
  case gestureKit
  case graphicsKit
  // case motionKit
  // case popupKit
  // case searchKit
  case sharedHelpers
  case vectorKit
  // case waveKit
  // case wrecktangle

  var targetName: String {
    switch self {
      case .baseHelpers: "BaseHelpers"
      case .macros: "BaseMacrosGuts"  // Guts?
      case .networking: "BaseNetworking"
      case .baseUI: "BaseUI"
      case .colourKit: "ColourKit"
      case .curveKit: "CurveKit"
      case .gestureKit: "GestureKit"
      case .graphicsKit: "GraphicsKit"
      case .sharedHelpers: "SharedHelpers"
      case .vectorKit: "VectorKit"
    }
  }
}
