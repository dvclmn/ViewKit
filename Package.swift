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

    /// Macros
    .library(
      name: "BaseMacros",
      targets: ["EnumMacros", "SampleBuilder"],
    ),
    .executable(
      name: "BaseMacrosClient",
      targets: ["BaseMacrosClient"],
    ),

    /// Helper Libraries
    .library(name: "BaseNetworking", targets: ["BaseNetworking"]),

    .library(
      name: "BasePrimitives",
      targets: [
        "BasePrimitives",
        "MacroHelpers",
      ],
    ),

    .library(
      name: "BaseUI",
      targets: [
        "BaseUI",
        "LayoutKit",
        "ComponentKit",
      ],
    ),

    .library(
      name: "GraphicsKit",
      targets: [
        "GraphicsKit",
        "MotionKit",
//        "CanvasKit",
      ],
    ),

    .library(
      name: "Wrecktangle",
      targets: ["Wrecktangle"],
    ),

    /// Export-only libraries
    .library(name: "ToolKit", targets: ["ToolKit"]),
  ],

  // MARK: - Dependancies
  dependencies: [
    .package(url: "https://github.com/swiftlang/swift-syntax", from: "602.0.0"),
    .package(url: "https://github.com/evgenyneu/keychain-swift", from: "24.0.0"),
    .package(url: "https://github.com/stackotter/swift-macro-toolkit", from: "0.6.0"),
    .package(url: "https://github.com/pointfreeco/swift-case-paths", branch: "1.7.2"),
    .package(url: "https://github.com/SwiftyLab/MetaCodable", from: "1.6.0"),
  ],

  targets: [
    // MARK: - BaseMacro targets
    .macro(
      name: "BaseMacrosImplementation",
      dependencies: [
        .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
        .product(name: "SwiftDiagnostics", package: "swift-syntax"),
        .product(name: "MacroToolkit", package: "swift-macro-toolkit"),
        .module(.macroHelpers),
      ],
      path: .macrosSource + "/MacroImplementations",
    ),

    /// Note: `path` here wants the Macro Declaration source, not the Implementation
    .target(
      name: "EnumMacros",
      dependencies: [
        "BaseMacrosImplementation",
        .module(.macroHelpers),
      ],
      path: .macrosSource + "/MacroDeclarations/EnumMacros",
    ),

    .target(
      name: "SampleBuilder",
      dependencies: [
        "BaseMacrosImplementation",
        .module(.macroHelpers),
      ],
      path: .macrosSource + "/MacroDeclarations/SampleBuilder",
    ),

    .executableTarget(
      name: "BaseMacrosClient",
      dependencies: [
        .module(.enumMacros),
        .module(.sampleBuilder),
        .module(.basePrimitives),
      ],
      path: .macrosSource + "/BaseMacrosClient",
    ),

    // MARK: - Targets

    .target(
      name: "BaseNetworking",
      dependencies: [
        .module(.basePrimitives),
        .product(name: "KeychainSwift", package: "keychain-swift"),
      ],
    ),

    .target(
      name: "BasePrimitives",
      dependencies: [
        .module(.enumMacros),
        .casePaths,
      ],
      resources: [
        .process("Resources/Assets.xcassets"),
        .process("Resources/Fonts"),
      ],
    ),

    .target(
      name: "BaseUI",
      dependencies: [
        .module(.basePrimitives),
        .module(.layoutKit),
      ],
    ),

//    .target(
//      name: "CanvasKit",
//      dependencies: [
//        .module(.basePrimitives),
//        .module(.baseUI),
//      ],
//    ),

    /// Can't think of a better name for this, but `ComponentKit` exists purely
    /// to avoid burdening `BaseUI` with `CasePaths` and `GraphicsKit`
    .target(
      name: "ComponentKit",
      dependencies: [
        .module(.baseUI),
        .module(.basePrimitives),
        .module(.graphicsKit),
        .module(.layoutKit),
        .casePaths,
      ],
    ),

    .target(
      name: "GraphicsKit",
      dependencies: [
        .module(.basePrimitives),
        .casePaths,
      ],
      resources: [
        .process("Shaders/MetalShaders")
      ],
    ),

    .target(
      name: "LayoutKit",
      dependencies: [
        .module(.basePrimitives)
      ],
    ),

    .target(
      name: "MacroHelpers"
    ),

    .target(
      name: "MotionKit",
      dependencies: [
        .module(.basePrimitives)
      ],
    ),

    .target(
      name: "Wrecktangle",
      dependencies: [
        .module(.basePrimitives)
      ],
    ),

    // MARK: - Forwarding modules

    .target(
      name: "ToolKit",
      dependencies: [
        .module(.basePrimitives),
        .module(.baseUI),
        .module(.graphicsKit),
      ],
    ),

    // MARK: - Test targets

    .testTarget(
      name: "BasePrimitivesTests",
      dependencies: [.module(.basePrimitives)],
      exclude: ["BasePrimitives.xctestplan"],
    ),

  ],
)
// MARK: - Type-safe convenience extensions
extension Target.Dependency {
  static func module(_ baseModule: BaseModule) -> Self {
    .target(name: baseModule.name)
  }
  static var casePaths: Self {
    .product(name: "CasePaths", package: "swift-case-paths")
  }
}
extension String {
  static var macrosSource: String { "Sources/BaseMacros" }
}

enum BaseModule {
  case enumMacros
  case sampleBuilder
  case networking
  case basePrimitives
  case baseUI
  case componentKit
  case graphicsKit
  case macroHelpers
  case layoutKit
  case motionKit
  case wrecktangle

  /// Export-only modules
  case toolKit

  var name: String {
    switch self {
      case .enumMacros: "EnumMacros"
      case .sampleBuilder: "SampleBuilder"
      case .networking: "BaseNetworking"
      case .basePrimitives: "BasePrimitives"
      case .baseUI: "BaseUI"
      case .componentKit: "ComponentKit"
//      case .canvasKit: "CanvasKit"
      case .graphicsKit: "GraphicsKit"
      case .macroHelpers: "MacroHelpers"
      case .layoutKit: "LayoutKit"
      case .motionKit: "MotionKit"
      case .wrecktangle: "Wrecktangle"

      /// Export-only
      case .toolKit: "ToolKit"

    }
  }
}
