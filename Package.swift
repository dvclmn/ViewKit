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
    .library(
      name: "BaseHelpers",
      targets: [
        "BaseHelpers",
        // AssociatedValues, CaseDetection, MetaEnum & SetOfOptions
        "EnumMacros",
        "Persistable",
        "StringKit",
        "ToolKit",
      ]
    ),
    .executable(
      name: "BaseMacrosClient",
      targets: ["BaseMacrosClient"]
    ),
    .library(name: "BaseNetworking", targets: ["BaseNetworking"]),
    .library(
      name: "BaseUI",
      targets: [
        "BaseUI",
        "GestureKit",
        "GraphicsKit",
        "LayoutKit",
        "MotionKit",
        //        "StyleKit",
      ]
    ),
    .library(name: "CanvasKit", targets: ["CanvasKit"]),
    .library(name: "ColourKit", targets: ["ColourKit"]),
    .library(name: "CurveKit", targets: ["CurveKit"]),
    .library(name: "SharedHelpers", targets: ["SharedHelpers"]),
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
        .dep(.sharedHelpers),
        //        .dep(.macros),
        .dep(.curveKit),
        .dep(.colourKit),
        .product(name: "NSUI", package: "nsui"),
      ],
      //      resources: [.process("Assets.xcassets")],
    ),
    .target(
      name: "BaseNetworking",
      dependencies: [
        .dep(.baseHelpers),
        .product(name: "KeychainSwift", package: "keychain-swift"),
      ],
    ),
    .target(
      name: "BaseUI",
      dependencies: [
        .dep(.baseHelpers),
        .dep(.sharedHelpers),
        .dep(.curveKit),
        .dep(.enumMacros),
        .dep(.colourKit),
        .dep(.layoutKit),
        .sharing,
        .product(name: "IfritStatic", package: "Ifrit"),
        .product(name: "NukeUI", package: "Nuke"),
      ],
    ),
    .target(
      name: "CanvasKit",
      dependencies: [
        .dep(.sharedHelpers)
      ], ),

    .target(
      name: "ColourKit",
      dependencies: [
        .dep(.sharedHelpers),
        .dep(.curveKit),
      ],
    ),

    .target(
      name: "CurveKit",
      dependencies: [
        .dep(.sharedHelpers)
      ]
    ),
    .target(
      name: "ToolKit",
      dependencies: [
        .dep(.baseHelpers),
        .dep(.enumMacros),
        .dep(.baseUI),
        .dep(.layoutKit),
        .dep(.stringKit),
        .dep(.sharedHelpers),
      ]
    ),
    .target(name: "GestureKit"),
    .target(
      name: "GraphicsKit",
      dependencies: [
        .dep(.sharedHelpers)
      ]
    ),

    .target(
      name: "LayoutKit",
      dependencies: [
        .dep(.sharedHelpers),
        .dep(.enumMacros),
      ]
    ),

    .target(name: "MotionKit"),
    //    .target(
    //      name: "SearchKit",
    //      dependencies: [
    //
    //      ]
    //    ),
    .target(name: "SharedHelpers"),

    .target(
      name: "StringKit",
      dependencies: [
        .nsui,
        .dep(.sharedHelpers),
        .dep(.enumMacros),
      ]
    ),

    // MARK: - BaseMacro targets
    .macro(
      name: "BaseMacros",
      dependencies: [
        .dep(.sharedHelpers),
        .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
        .product(name: "SwiftCompilerPlugin", package: "swift-syntax"),
        .product(name: "MacroToolkit", package: "swift-macro-toolkit"),
      ],
      path: .macrosSource + "/MacroExpansions",
    ),
    .target(
      name: "Persistable",
      dependencies: ["BaseMacros"],
      path: .macroDecl("Persistable")
    ),
    .target(
      name: "EnumMacros",
      dependencies: ["BaseMacros"],
      path: .macroDecl("EnumMacros")
    ),
    .executableTarget(
      name: "BaseMacrosClient",
      dependencies: [
        "EnumMacros",
        "Persistable",
      ],
      path: .macrosSource + "/BaseMacrosClient",
    ),

  ],
)
// MARK: - Convenient type-safe extensions
extension Target.Dependency {
  static func dep(_ baseModule: BaseModule) -> Self {
    .target(name: baseModule.name)
  }
  static var sharing: Self {
    .product(name: "Sharing", package: "swift-sharing")
  }
  static var nsui: Self {
    .product(name: "NSUI", package: "nsui")
  }
}
extension String {
  static func macroDecl(_ macroName: String) -> String {
    return .macrosSource + "/MacroDeclarations/" + macroName
  }
  static var macrosSource: String { "Sources/BaseMacros" }
}

/// List of common modules for convenience
enum BaseModule {
  case baseHelpers
  //  case macros
  case enumMacros
  case persistable
  case networking
  case baseUI  // Aka BaseComponents
  case canvasKit
  case colourKit
  case curveKit
  case gestureKit
  case graphicsKit
  case layoutKit
  case motionKit
  case sharedHelpers
  case stringKit
  //  case styleKit

  var name: String {
    switch self {
      case .baseHelpers: "BaseHelpers"
      case .enumMacros: "EnumMacros"
      case .persistable: "Persistable"
      //      case .macros: "BaseMacrosGuts"  // Guts?
      case .networking: "BaseNetworking"
      case .baseUI: "BaseUI"
      case .canvasKit: "CanvasKit"
      case .colourKit: "ColourKit"
      case .curveKit: "CurveKit"
      case .gestureKit: "GestureKit"
      case .graphicsKit: "GraphicsKit"
      case .layoutKit: "LayoutKit"
      case .motionKit: "MotionKit"
      case .sharedHelpers: "SharedHelpers"
      case .stringKit: "StringKit"
    //      case .styleKit: "StyleKit"
    }
  }
}
