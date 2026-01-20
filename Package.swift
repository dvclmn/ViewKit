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
      name: "BaseMacros",
      targets: ["EnumMacros"]
    ),
    .executable(
      name: "BaseMacrosClient",
      targets: ["BaseMacrosClient"]
    ),
    .library(name: "BasePrimitives", targets: ["BasePrimitives"]),
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

    .library(name: "ColourKit", targets: ["ColourKit"]),
    .library(name: "GestureKit", targets: ["GestureKit"]),
    .library(name: "LilyPad", targets: ["LilyPad"]),
    .library(name: "SharedHelpers", targets: ["SharedHelpers"]),
    .library(name: "VectorKit", targets: ["VectorKit"]),
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
    .package(url: "https://github.com/pointfreeco/swift-case-paths", from: "1.7.2"),
    //    .package(
    //      url: "https://github.com/pointfreeco/swift-identified-collections", from: "1.1.1"),
  ],

  targets: [
    // MARK: - BaseMacro targets
    .macro(
      name: "BaseMacrosImplementation",
      dependencies: [
        .module(.primitives),
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
      name: "BasePrimitives",
      dependencies: [.casePaths],
    ),

    .target(
      name: "BaseUI",
      dependencies: [
        .module(.coreTools),
        .module(.colourKit),
        .module(.layoutKit),
        .module(.graphicsKit),
        .module(.gestureKit),
        .sharing,
      ],
    ),

    .target(
      name: "ColourKit",
      dependencies: [
        .module(.coreTools)
      ],
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
        .module(.coreTools),
        .module(.colourKit),
        .module(.vectorKit),
      ]
    ),

    .target(
      name: "LayoutKit",
      dependencies: [
        .module(.coreTools),
        .module(.vectorKit),
        .module(.graphicsKit),
      ]
    ),

    .target(
      name: "MotionKit",
      dependencies: [
        .module(.coreTools)
      ]
    ),

    .target(
      name: "LilyPad",
      dependencies: [
        .module(.coreTools),
        .module(.gestureKit),
        .module(.colourKit),
        .casePaths
      ]
    ),

    .target(
      name: "SharedHelpers",
      dependencies: [
        .module(.primitives),
        .module(.enumMacros),
        //        .identifiedCollections,
        .sharing,
      ],
    ),

    .target(
      name: "VectorKit",
      dependencies: [
        .module(.coreTools),
        .casePaths
      ]
    ),

    .target(
      name: "Wrecktangle",
      dependencies: [
        .module(.coreTools)
      ]
    ),

    // MARK: - Forwarding modules
    .target(
      name: "CoreTools",
      dependencies: [
        .module(.primitives),
        .module(.sharedHelpers),
        .module(.enumMacros),
      ],
    ),

    .target(
      name: "ToolKit",
      dependencies: [
        .module(.coreTools),
        .module(.baseUI),
        //        .module(.layoutKit),
      ],
    ),

    // MARK: - Forwarding modules
    .testTarget(
      name: "SharedHelpersTests",
      dependencies: [.module(.sharedHelpers)]
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
  static var casePaths: Self {
    .product(name: "CasePaths", package: "swift-case-paths")
  }
  //  static var identifiedCollections: Self {
  //    .product(name: "IdentifiedCollections", package: "swift-identified-collections")
  //  }
  static var nsui: Self {
    .product(name: "NSUI", package: "nsui")
  }
}
extension String {
  static var macrosSource: String { "Sources/BaseMacros" }
}

enum BaseModule {
  case sharedHelpers
  case primitives
  case enumMacros
  case networking
  case baseUI
  //  case baseTypes
  //  case canvasKit
  case colourKit
  case vectorKit
  case gestureKit
  case graphicsKit
  //  case gridKit
  case layoutKit
  case lilypad
  case motionKit

  //  case stringKit
  case wrecktangle

  /// Export-only modules
  case toolKit
  case coreTools

  var name: String {
    switch self {
      /// Keeping this as SharedHelpers for now, for ease
      /// May rename to BaseHelpers later
      case .sharedHelpers: "SharedHelpers"
      case .primitives: "BasePrimitives"
      case .enumMacros: "EnumMacros"
      case .networking: "BaseNetworking"
      case .baseUI: "BaseUI"
      //      case .baseTypes: "BaseTypes"
      //      case .canvasKit: "CanvasKit"
      case .colourKit: "ColourKit"
      case .vectorKit: "VectorKit"
      case .gestureKit: "GestureKit"
      case .graphicsKit: "GraphicsKit"
      //      case .gridKit: "GridKit"
      case .layoutKit: "LayoutKit"
      case .lilypad: "LilyPad"
      case .motionKit: "MotionKit"

      //      case .stringKit: "StringKit"
      case .wrecktangle: "Wrecktangle"

      /// Export-only
      case .toolKit: "ToolKit"
      case .coreTools: "CoreTools"
    }
  }
}
