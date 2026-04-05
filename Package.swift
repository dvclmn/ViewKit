// swift-tools-version: 6.3

import CompilerPluginSupport
import PackageDescription

let package = Package(
  name: "BaseHelpers",
  platforms: [
    .iOS("17.0"),
    .macOS("14.0"),
  ],
  products: [
    .library(name: "BaseNetworking", targets: ["BaseNetworking"]),

    .library(
      name: "BaseTools",
      targets: ["BaseTools"],
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
      ],
    ),

    .library(
      name: "Wrecktangle",
      targets: ["Wrecktangle"],
    ),

    /// Export-only library
    .library(name: "ToolKit", targets: ["ToolKit"]),
  ],

  // MARK: - Dependancies
  dependencies: [
    .package(url: "https://github.com/evgenyneu/keychain-swift", from: "24.0.0"),
    .package(url: "https://github.com/pointfreeco/swift-case-paths", branch: "1.7.2"),
    .package(url: "https://github.com/SwiftyLab/MetaCodable", from: "1.6.0"),
    .package(url: "https://github.com/dvclmn/InteractionKit", branch: "main"),
    .package(url: "https://github.com/dvclmn/BaseMacros", branch: "main"),
    .package(url: "https://github.com/dvclmn/BasePrimitives", branch: "main"),
  ],

  // MARK: - Targets
  targets: [
    .target(
      name: "BaseNetworking",
      dependencies: [
        .extDependency(.basePrimitives),
        .extDependency(.keychainSwift),
      ],
    ),

    .target(
      name: "BaseTools",
      dependencies: [
        .extDependency(.enumMacros),
        .extDependency(.casePaths),
        .extDependency(.basePrimitives),
        .extDependency(.interactionKit),
      ],
      //      resources: [
      //        .process("Resources/Assets.xcassets"),
      //        .process("Resources/Fonts"),
      //      ],
    ),

    .target(
      name: "BaseUI",
      dependencies: [
        .module(.layoutKit),
        .extDependency(.basePrimitives),
        .module(.baseTools),
        .extDependency(.enumMacros),
        //        .extDependency(.interactionKit),
      ],
    ),

    /// Can't think of a better name for this, but `ComponentKit` exists purely
    /// to avoid burdening `BaseUI` with `CasePaths` and `GraphicsKit`
    .target(
      name: "ComponentKit",
      dependencies: [
        .module(.baseUI),

        .extDependency(.basePrimitives),
        .module(.baseTools),

        .module(.graphicsKit),
        .module(.layoutKit),
        .extDependency(.casePaths),
      ],
    ),

    .target(
      name: "GraphicsKit",
      dependencies: [

        .extDependency(.basePrimitives),
        .module(.baseTools),

        .extDependency(.enumMacros),
        .extDependency(.casePaths),
        //        .extDependency(.interactionKit),
      ],
      resources: [
        .process("Shaders/MetalShaders")
      ],
    ),

    .target(
      name: "LayoutKit",
      dependencies: [

        .extDependency(.basePrimitives),
        .module(.baseTools),

        //        .extDependency(.basePrimitives),
        //        .extDependency(.interactionKit),
        .extDependency(.enumMacros),
      ],
    ),

    .target(
      name: "MotionKit",
      dependencies: [

        .extDependency(.basePrimitives),
        .module(.baseTools),

        //        .extDependency(.basePrimitives)
      ],
    ),

    .target(
      name: "Wrecktangle",
      dependencies: [

        .extDependency(.basePrimitives),
        .module(.baseTools),

        //        .extDependency(.basePrimitives)
      ],
    ),

    // MARK: - Forwarding modules

    .target(
      name: "ToolKit",
      dependencies: [

        .extDependency(.basePrimitives),
        .module(.baseTools),

        //        .extDependency(.basePrimitives),
        .module(.baseUI),
        //        .module(.graphicsKit),
      ],
    ),

    // MARK: - Test targets

    //    .testTarget(
    //      name: "BasePrimitivesTests",
    //      dependencies: [.module(.basePrimitives)],
    //      exclude: ["BasePrimitives.xctestplan"],
    //    ),
  ],
)
// MARK: - Type-safe factory helpers
extension Target.Dependency {
  static func module(_ name: InternalModule) -> Self {
    .target(name: name.name)
  }

  static func extDependency(_ dependency: ExternalDependency) -> Self {
    .product(
      name: dependency.reference.0,
      package: dependency.reference.1 ?? dependency.reference.0,
    )
  }

}

enum ExternalDependency {
  case basePrimitives
  case enumMacros
  case casePaths
  case interactionKit
  case keychainSwift
  case macroToolkit

  var reference: (String, String?) {
    switch self {
      case .basePrimitives: ("BasePrimitives", nil)
      case .enumMacros: ("BaseMacros", nil)
      case .casePaths: ("CasePaths", "swift-case-paths")
      case .interactionKit: ("InteractionKit", nil)
      case .keychainSwift: ("KeychainSwift", "keychain-swift")
      case .macroToolkit: ("MacroToolkit", "swift-macro-toolkit")
    }
  }
}

enum InternalModule {
  case networking
  case baseTools
  case baseUI
  case componentKit
  case graphicsKit
  case layoutKit
  case motionKit
  case wrecktangle

  /// Export-only modules
  case toolKit

  var name: String {
    switch self {
      case .networking: "BaseNetworking"
      case .baseTools: "BaseTools"
      case .baseUI: "BaseUI"
      case .componentKit: "ComponentKit"
      case .graphicsKit: "GraphicsKit"
      case .layoutKit: "LayoutKit"
      case .motionKit: "MotionKit"
      case .wrecktangle: "Wrecktangle"

      /// Export-only
      case .toolKit: "ToolKit"

    }
  }
}
