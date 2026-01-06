// swift-tools-version: 6.2

import CompilerPluginSupport
import PackageDescription

let package = Package(
  name: "BaseHelpers",
  platforms: [
    .iOS("17.0"),
    .macOS("13.0"),
  ],
  products: [
    .library(
      name: "BaseMacros",
      targets: ["EnumMacros"]
    ),
    .executable(
      name: "BaseMacrosClient",
      targets: ["BaseMacrosClient"]
    ),
    .library(name: "BaseTypes", targets: ["BaseTypes"]),
    .library(name: "BaseNetworking", targets: ["BaseNetworking"]),
    .library(
      name: "BaseUI",
      targets: [
        "BaseUI",
        "GraphicsKit",
        "LayoutKit",
        "MotionKit",
      ]
    ),
    .library(name: "CanvasKit", targets: ["CanvasKit"]),
    .library(name: "ColourKit", targets: ["ColourKit"]),
    .library(name: "GestureKit", targets: ["GestureKit"]),
    .library(name: "GridKit", targets: ["GridKit"]),
    .library(name: "GridUI", targets: ["GridUI"]),
    .library(name: "VectorKit", targets: ["VectorKit"]),
    .library(name: "SharedHelpers", targets: ["SharedHelpers"]),
    .library(name: "StringKit", targets: ["StringKit"]),
    .library(name: "Wrecktangle", targets: ["Wrecktangle"]),

    // Export-only libraries
    .library(name: "ToolKit", targets: ["ToolKit"]),
    .library(name: "CoreTools", targets: ["CoreTools"]),
  ],

  // MARK: - Dependancies
  dependencies: [
    //    .package(url: "https://github.com/swiftlang/swift-docc-plugin", from: "1.0.0"),
    .package(url: "https://github.com/swiftlang/swift-syntax", from: "600.0.1"),
    //    .package(url: "https://github.com/mattmassicotte/nsui", from: "1.3.0"),
    .package(url: "https://github.com/evgenyneu/keychain-swift", from: "24.0.0"),
    .package(url: "https://github.com/stackotter/swift-macro-toolkit", from: "0.6.0"),
    .package(url: "https://github.com/pointfreeco/swift-sharing", from: "2.7.2"),
    .package(
      url: "https://github.com/pointfreeco/swift-identified-collections", from: "1.1.1"),
  ],

  targets: [
    // MARK: - BaseMacro targets
    .macro(
      name: "BaseMacrosImplementation",
      dependencies: [
        .module(.sharedHelpers),
        .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
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

    // MARK: - Targets

    .target(
      name: "BaseNetworking",
      dependencies: [
        .module(.coreTools),
        .product(name: "KeychainSwift", package: "keychain-swift"),
      ],
    ),

    .target(
      name: "BaseUI",
      dependencies: [
        .module(.coreTools),
//        .module(.vectorKit),
//        .module(.colourKit),
        .module(.layoutKit),
        .module(.graphicsKit),
//        .module(.gestureKit),
//        .module(.gridKit),
//        .module(.wrecktangle),
        .sharing,
      ],
    ),

    .target(
      name: "BaseTypes",
      dependencies: [
        .module(.coreTools),
        .module(.gridKit),
        .identifiedCollections,
        .sharing,
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
      dependencies: [.module(.coreTools)],
    ),

    .target(
      name: "VectorKit",
      dependencies: [.module(.sharedHelpers)]
    ),

    .target(
      name: "GestureKit",
      dependencies: [
        .module(.coreTools),
        .module(.layoutKit),
        .module(.vectorKit),
      ]
    ),

    .target(
      name: "GraphicsKit",
      dependencies: [
        .module(.sharedHelpers),
        .module(.colourKit),
//        .module(.gridKit),
      ]
    ),

    .target(
      name: "GridKit",
      dependencies: [
        .module(.coreTools),
        .module(.colourKit),
        .module(.layoutKit),
      ]
    ),

    .target(
      name: "GridUI",
      dependencies: [
        .module(.coreTools),
        .module(.layoutKit),
        .module(.gridKit),
      ]
    ),

    .target(
      name: "LayoutKit",
      dependencies: [.module(.coreTools)]
    ),

    .target(
      name: "MotionKit",
      dependencies: [.module(.coreTools)]
    ),

    .target(
      name: "SharedHelpers",
      dependencies: [.identifiedCollections]
    ),

    .target(
      name: "StringKit",
      dependencies: [
        .module(.sharedHelpers),
        .module(.enumMacros),
      ]
    ),

    .target(
      name: "Wrecktangle",
      dependencies: [
        .module(.coreTools),
        .module(.gridKit),
        .module(.baseTypes),
      ]
    ),

    // MARK: - Forwarding modules
    .target(
      name: "CoreTools",
      dependencies: [
        .module(.sharedHelpers),
        .module(.stringKit),
        .module(.enumMacros),
      ],
    ),

    .target(
      name: "ToolKit",
      dependencies: [
        .module(.coreTools),
        .module(.baseUI),
        .module(.baseTypes),
        .module(.layoutKit),
      ]
    ),

  ],
)
// MARK: - Type-safe convenience extensions
extension Target.Dependency {
  static func module(_ baseModule: BaseModule) -> Self {
    .target(name: baseModule.name)
  }
  static var sharing: Self {
    .product(name: "Sharing", package: "swift-sharing")
  }
  static var identifiedCollections: Self {
    .product(name: "IdentifiedCollections", package: "swift-identified-collections")
  }
  static var nsui: Self {
    .product(name: "NSUI", package: "nsui")
  }
}
extension String {
  static var macrosSource: String { "Sources/BaseMacros" }
}

enum BaseModule {
  case enumMacros
  case networking
  case baseUI
  case baseTypes
  case canvasKit
  case colourKit
  case vectorKit
  case gestureKit
  case graphicsKit
  case gridKit
  case layoutKit
  case motionKit
  case sharedHelpers
  case stringKit
  case wrecktangle

  /// Export-only modules
  case toolKit
  case coreTools

  var name: String {
    switch self {
      case .enumMacros: "EnumMacros"
      case .networking: "BaseNetworking"
      case .baseUI: "BaseUI"
      case .baseTypes: "BaseTypes"
      case .canvasKit: "CanvasKit"
      case .colourKit: "ColourKit"
      case .vectorKit: "VectorKit"
      case .gestureKit: "GestureKit"
      case .graphicsKit: "GraphicsKit"
      case .gridKit: "GridKit"
      case .layoutKit: "LayoutKit"
      case .motionKit: "MotionKit"
      case .sharedHelpers: "SharedHelpers"
      case .stringKit: "StringKit"
      case .wrecktangle: "Wrecktangle"

      /// Export-only
      case .toolKit: "ToolKit"
      case .coreTools: "CoreTools"
    }
  }
}
