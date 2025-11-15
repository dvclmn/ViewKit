// swift-tools-version: 6.2

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
      name: "BaseMacrosLibrary",
      targets: ["EnumMacros"]
    ),
    .executable(
      name: "BaseMacrosClient",
      targets: ["BaseMacrosClient"]
    ),
    .library(name: "BaseModels", targets: ["BaseModels"]),
    .library(name: "BaseNetworking", targets: ["BaseNetworking"]),
    .library(
      name: "BaseUI",
      targets: [
        "BaseUI",
        "GestureKit",
        "GraphicsKit",
        "LayoutKit",
        "MotionKit",
      ]
    ),
    .library(name: "CanvasKit", targets: ["CanvasKit"]),
    .library(name: "ColourKit", targets: ["ColourKit"]),
    .library(name: "CurveKit", targets: ["CurveKit"]),
    .library(name: "SharedHelpers", targets: ["SharedHelpers"]),
    .library(name: "StringKit", targets: ["StringKit"]),

    // Export-only libraries
    .library(name: "ToolKit", targets: ["ToolKit"]),
    .library(name: "BaseUtilities", targets: ["BaseUtilities"]),
  ],

  // MARK: - Dependancies
  dependencies: [
    .package(url: "https://github.com/swiftlang/swift-docc-plugin", from: "1.0.0"),
    .package(url: "https://github.com/swiftlang/swift-syntax", from: "600.0.1"),
    .package(url: "https://github.com/mattmassicotte/nsui", from: "1.3.0"),
    .package(url: "https://github.com/evgenyneu/keychain-swift", from: "24.0.0"),
    .package(url: "https://github.com/stackotter/swift-macro-toolkit", from: "0.6.0"),
    .package(url: "https://github.com/pointfreeco/swift-sharing", from: "2.7.2"),
    .package(url: "https://github.com/pointfreeco/swift-identified-collections", from: "1.1.1"),
  ],

  // MARK: - Targets

  targets: [
    .target(
      name: "BaseNetworking",
      dependencies: [
        .module(.baseUtilities),
        .product(name: "KeychainSwift", package: "keychain-swift"),
      ],
    ),
    .target(
      name: "BaseUI",
      dependencies: [
        .module(.curveKit),
        .module(.colourKit),
        .module(.layoutKit),
        .module(.graphicsKit),
        .module(.gestureKit),
        .module(.baseUtilities),
        .sharing,
//        .nsui,
      ],
    ),
    .target(
      name: "BaseModels",
      dependencies: [
        .module(.baseUtilities),
        .sharing,
        .product(name: "IdentifiedCollections", package: "swift-identified-collections"),
      ],
    ),
    .target(
      name: "CanvasKit",
      dependencies: [
        .module(.baseUI),
        .module(.sharedHelpers),
        .module(.gestureKit),
        .sharing,
      ],
    ),

    .target(
      name: "ColourKit",
      dependencies: [
        .module(.sharedHelpers),
        .module(.curveKit),
        .nsui,
        //        .product(name: "CasePaths", package: "swift-case-paths"),
      ],
    ),

    .target(
      name: "CurveKit",
      dependencies: [
        .module(.sharedHelpers)
      ]
    ),

    .target(
      name: "GestureKit",
      dependencies: [
        .module(.baseUtilities),
        .module(.layoutKit),
        .module(.curveKit),
      ]
    ),
    .target(
      name: "GraphicsKit",
      dependencies: [
        .module(.sharedHelpers),
        .module(.colourKit),
      ]
    ),
    .target(
      name: "LayoutKit",
      dependencies: [
        .module(.baseUtilities)
      ]
    ),

    .target(
      name: "MotionKit",
      dependencies: [
        .module(.baseUtilities)
      ]
    ),
    .target(name: "SharedHelpers"),

    .target(
      name: "StringKit",
      dependencies: [
        .module(.sharedHelpers),
        .module(.enumMacros),
      ]
    ),

    .target(
      name: "BaseUtilities",
      dependencies: [
        .module(.sharedHelpers),
        .module(.stringKit),
        .module(.enumMacros),
      ],
    ),

    .target(
      name: "ToolKit",
      dependencies: [
        .module(.baseUI),
        .module(.baseModels),
        .module(.layoutKit),
        .module(.enumMacros),
        .module(.stringKit),
        .module(.sharedHelpers),
      ]
    ),

    // MARK: - BaseMacro targets
    .macro(
      name: "BaseMacrosImplementation",
      dependencies: [
        .module(.sharedHelpers),
        .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
        .product(name: "SwiftCompilerPlugin", package: "swift-syntax"),
        .product(name: "SwiftDiagnostics", package: "swift-syntax"),
        .product(name: "MacroToolkit", package: "swift-macro-toolkit"),
      ],
      path: .macrosSource + "/MacroImplementations",
    ),

    .target(
      name: "EnumMacros",
      dependencies: ["BaseMacrosImplementation"],
      path: .macrosSource + "/MacroDeclarations",
    ),
    .executableTarget(
      name: "BaseMacrosClient",
      dependencies: ["EnumMacros"],
      path: .macrosSource + "/BaseMacrosClient",
    ),

  ],
)
// MARK: - Convenient type-safe extensions
extension Target.Dependency {
  static func module(_ baseModule: BaseModule) -> Self {
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
  static var macrosSource: String { "Sources/BaseMacrosLibrary" }
}

/// List of common modules for convenience
enum BaseModule {

  case enumMacros
  case networking
  case baseUI
  case baseModels
  case canvasKit
  case colourKit
  case curveKit
  case gestureKit
  case graphicsKit
  case layoutKit
  case motionKit
  case sharedHelpers
  case stringKit

  /// Export-only modules
  case toolKit
  case baseUtilities

  var name: String {
    switch self {
      case .enumMacros: "EnumMacros"
      case .networking: "BaseNetworking"
      case .baseUI: "BaseUI"
      case .baseModels: "BaseModels"
      case .canvasKit: "CanvasKit"
      case .colourKit: "ColourKit"
      case .curveKit: "CurveKit"
      case .gestureKit: "GestureKit"
      case .graphicsKit: "GraphicsKit"
      case .layoutKit: "LayoutKit"
      case .motionKit: "MotionKit"
      case .sharedHelpers: "SharedHelpers"
      case .stringKit: "StringKit"
      case .toolKit: "ToolKit"
      case .baseUtilities: "BaseUtilities"
    }
  }
}
