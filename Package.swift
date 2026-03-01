// swift-tools-version: 6.2

import CompilerPluginSupport
import PackageDescription

let package = Package(
  name: "BaseHelpers",
  platforms: [
    //    .iOS("17.0"),
    .macOS("14.0")
  ],
  products: [
    .library(
      name: "BaseMacros",
      targets: ["EnumMacros", "SampleBuilder"]
    ),
    .executable(
      name: "BaseMacrosClient",
      targets: ["BaseMacrosClient"]
    ),

    .library(name: "BaseNetworking", targets: ["BaseNetworking"]),
    .library(name: "BasePrimitives", targets: ["BasePrimitives"]),

    .library(
      name: "BaseUI",
      targets: [
        "BaseUI",
        "LayoutKit",
      ]
    ),

    .library(
      name: "GraphicsKit",
      targets: [
        "GraphicsKit",
        "ColourKit",
        "MotionKit",
        "CanvasKit",
        "VectorKit",
      ]
    ),

    .library(
      name: "GestureKit",
      targets: [
        "GestureKit"
      ]
    ),

    .library(
      name: "SharedHelpers",
      targets: [
        "SharedHelpers",
        "Wrecktangle",
      ]
    ),

    // Export-only libraries
    .library(name: "ToolKit", targets: ["ToolKit"]),
    .library(name: "CoreTools", targets: ["CoreTools"]),
  ],

  // MARK: - Dependancies
  dependencies: [
    //    .package(url: "https://github.com/swiftlang/swift-docc-plugin", from: "1.0.0"),
    .package(url: "https://github.com/swiftlang/swift-syntax", from: "602.0.0"),
    .package(url: "https://github.com/evgenyneu/keychain-swift", from: "24.0.0"),
    .package(url: "https://github.com/stackotter/swift-macro-toolkit", from: "0.6.0"),
    .package(url: "https://github.com/pointfreeco/swift-sharing", from: "2.7.2"),
    .package(url: "https://github.com/pointfreeco/swift-case-paths", branch: "1.7.2"),
    .package(url: "https://github.com/SwiftyLab/MetaCodable", from: "1.6.0"),
    .package(url: "https://github.com/jpsim/Yams", from: "6.2.1"),
    .package(url: "https://github.com/pointfreeco/swift-identified-collections", from: "1.1.1"),
  ],

  targets: [
    // MARK: - BaseMacro targets
    .macro(
      name: "BaseMacrosImplementation",
      dependencies: [
        .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
        .product(name: "SwiftDiagnostics", package: "swift-syntax"),
        .product(name: "MacroToolkit", package: "swift-macro-toolkit"),
      ],
      path: .macrosSource + "/MacroImplementations",
    ),

    /// Note: `path` here wants the Macro Declaration source, not the Implementation
    .target(
      name: "EnumMacros",
      dependencies: ["BaseMacrosImplementation", .module(.primitives)],
      path: .macrosSource + "/MacroDeclarations/EnumMacros",
    ),

    .target(
      name: "SampleBuilder",
      dependencies: ["BaseMacrosImplementation", .module(.primitives)],
      path: .macrosSource + "/MacroDeclarations/SampleBuilder",
    ),

    .executableTarget(
      name: "BaseMacrosClient",
      dependencies: [
        .module(.enumMacros),
        .module(.sampleBuilder),
        .module(.primitives),
      ],
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
      resources: [
        .process("Assets.xcassets")
      ],
    ),

    .target(
      name: "BaseUI",
      dependencies: [
        .module(.coreTools),
        .module(.sampleBuilder),
        .module(.colourKit),
        .module(.layoutKit),
        .module(.graphicsKit),
        .module(.gestureKit),
        .module(.vectorKit),
        .module(.canvasKit),
        .sharing,
        .casePaths,
      ],
    ),

    /// Note: The only target that depends on BaseUI
    .target(
      name: "CanvasKit",
      dependencies: [
        .module(.coreTools),
        .module(.gestureKit),
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
        .casePaths,
      ]
    ),

    .target(
      name: "GraphicsKit",
      dependencies: [
        .module(.coreTools),
        .module(.colourKit),
        .module(.vectorKit),
        .casePaths,
        .metaCodable,
      ],
      resources: [
        .process("Shaders/MetalShaders")
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
      name: "SharedHelpers",
      dependencies: [
        .module(.primitives),
        .module(.enumMacros),
        .module(.sampleBuilder),
        .sharing,
        .casePaths,
      ],
      resources: [.process("Grid/Fonts")]
    ),

    .target(
      name: "VectorKit",
      dependencies: [
        .module(.coreTools),
        .module(.colourKit),
        .casePaths,
        .metaCodable,
        .identifiedCollections,
        .product(name: "Yams", package: "Yams"),

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
        .module(.graphicsKit),
      ],
    ),

    // MARK: - Test targets
    .testTarget(
      name: "SharedHelpersTests",
      dependencies: [.module(.sharedHelpers)],
    ),
    .testTarget(
      name: "BasePrimitivesTests",
      dependencies: [.module(.primitives)],
      exclude: ["BasePrimitives.xctestplan"],
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
  static var metaCodable: Self {
    .product(name: "MetaCodable", package: "MetaCodable")
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
  case sampleBuilder
  case networking
  case primitives
  case baseUI
  case canvasKit
  case colourKit
  case gestureKit
  case graphicsKit
  case layoutKit
  //  case lilypad
  case motionKit
  case sharedHelpers
  case vectorKit
  case wrecktangle

  /// Export-only modules
  case toolKit
  case coreTools

  var name: String {
    switch self {
      case .enumMacros: "EnumMacros"
      case .sampleBuilder: "SampleBuilder"
      case .networking: "BaseNetworking"
      case .primitives: "BasePrimitives"
      case .baseUI: "BaseUI"
      case .canvasKit: "CanvasKit"
      case .colourKit: "ColourKit"
      case .gestureKit: "GestureKit"
      case .graphicsKit: "GraphicsKit"
      case .layoutKit: "LayoutKit"
      //      case .lilypad: "LilyPad"
      case .motionKit: "MotionKit"
      case .sharedHelpers: "SharedHelpers"
      case .vectorKit: "VectorKit"
      case .wrecktangle: "Wrecktangle"

      /// Export-only
      case .toolKit: "ToolKit"
      case .coreTools: "CoreTools"
    }
  }
}
