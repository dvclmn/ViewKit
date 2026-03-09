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
    // MARK: - Macros
    .library(
      name: "BaseMacros",
      targets: ["EnumMacros", "SampleBuilder"]
    ),
    .executable(
      name: "BaseMacrosClient",
      targets: ["BaseMacrosClient"]
    ),

    // MARK: - Helper Libraries
    .library(name: "BaseNetworking", targets: ["BaseNetworking"]),

    .library(
      name: "BasePrimitives",
      targets: [
        "BasePrimitives",
        "MacroHelpers",
//        "CasePathHelpers",
      ]
    ),

    .library(
      name: "BaseUI",
      targets: [
        "BaseUI",
        "LayoutKit",
        "ComponentKit",
        //        "UIPrimitives",
      ]
    ),

    //    .library(name: "DrawingPrimitives", targets: ["DrawingPrimitives"]),

    .library(
      name: "GraphicsKit",
      targets: [
        "GraphicsKit",
        //        "ColourKit",
        "MotionKit",
        "CanvasKit",
//        "ActionLines",
//        "GraphicsModels",
        //        "VectorKit",
      ]
    ),

    .library(
      name: "GestureKit",
      targets: [
        "GestureKit"
      ]
    ),

    .library(
      name: "Wrecktangle",
      targets: ["Wrecktangle"]
    ),

    //    .library(
    //      name: "SharedHelpers",
    //      targets: [
    //        "SharedHelpers",
    //        "Wrecktangle",
    //      ]
    //    ),

    // Export-only libraries
    .library(name: "ToolKit", targets: ["ToolKit"]),
//    .library(name: "CoreTools", targets: ["CoreTools"]),
  ],

  // MARK: - Dependancies
  dependencies: [
    //    .package(url: "https://github.com/swiftlang/swift-docc-plugin", from: "1.0.0"),
    .package(url: "https://github.com/swiftlang/swift-syntax", from: "602.0.0"),
    .package(url: "https://github.com/evgenyneu/keychain-swift", from: "24.0.0"),
    .package(url: "https://github.com/stackotter/swift-macro-toolkit", from: "0.6.0"),
    //    .package(url: "https://github.com/pointfreeco/swift-sharing", from: "2.7.2"),
    .package(url: "https://github.com/pointfreeco/swift-case-paths", branch: "1.7.2"),
    .package(url: "https://github.com/SwiftyLab/MetaCodable", from: "1.6.0"),
    //    .package(url: "https://github.com/jpsim/Yams", from: "6.2.1"),
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
        //        .module(.basePrimitives)
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
//        .module(.coreTools),
        .product(name: "KeychainSwift", package: "keychain-swift"),
      ],
    ),

    .target(
      name: "BasePrimitives",
      dependencies: [
        .module(.enumMacros),
        .metaCodable,
        .casePaths,
        .identifiedCollections,
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
        .module(.sampleBuilder),
        //        .module(.colourKit),
        .module(.layoutKit),
        //        .module(.drawingPrimitives),
        .module(.graphicsKit),
        .module(.gestureKit),
        //        .module(.vectorKit),
        .module(.canvasKit),
        //        .module(.uiPrimitives),
        //        .sharing,
        .casePaths,
      ],
    ),

    .target(
      name: "CanvasKit",
      dependencies: [
        .module(.basePrimitives),
        .module(.gestureKit),
        //        .module(.uiPrimitives),
        //        .module(.drawingPrimitives),
      ],
    ),

//    .target(
//      name: "CasePathHelpers",
//      dependencies: [
//        .module(.macroHelpers),
//        .casePaths,
//      ],
//    ),

//    .target(
//      name: "ActionLines",
//      dependencies: [
//        .module(.coreTools),
//        .casePaths,
//        .metaCodable,
//      ],
//    ),

    /// Currently, this main advantage of this seems to be that
    /// it doesn't depend on Gesture, Vector or CanvasKit.
    .target(
      name: "ComponentKit",
      dependencies: [
        .module(.basePrimitives),
        //        .module(.colourKit),
        //        .module(.drawingPrimitives),
        .module(.graphicsKit),
        .module(.layoutKit),
        //        .module(.uiPrimitives),
        .casePaths,
      ],
    ),

    //    .target(
    //      name: "ColourKit",
    //      dependencies: [
    //        .module(.basePrimitives)
    //      ],
    //    ),

    //    .target(
    //      name: "DrawingPrimitives",
    //      dependencies: [
    //        .module(.basePrimitives)
    ////        .module(.coreTools),
    ////        .module(.gestureKit),
    ////        .module(.uiPrimitives),
    //      ],
    //    ),

    .target(
      name: "GestureKit",
      dependencies: [
        .module(.basePrimitives),
        .module(.layoutKit),
        //        .module(.vectorKit),
        .casePaths,
      ]
    ),
    
//      .target(
//        name: "GraphicsModels",
//        dependencies: [
//          .module(.basePrimitives),
//          .module(.enumMacros),
//          .metaCodable,
//          .casePaths,
//        ]
//      ),

    .target(
      name: "GraphicsKit",
      dependencies: [
        .module(.basePrimitives),
        //        .module(.colourKit),
        //        .module(.drawingPrimitives),
        //        .module(.vectorKit),
        //        .module(.uiPrimitives),
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
        .module(.basePrimitives)
        //        .module(.coreTools)
      ]
    ),

    .target(
      name: "MacroHelpers",
      dependencies: [
        //          .module(.coreTools)
      ]
    ),

    .target(
      name: "MotionKit",
      dependencies: [
        .module(.basePrimitives),
      ]
    ),

    //    .target(
    //      name: "SharedHelpers",
    //      dependencies: [
    //        .module(.basePrimitives),
    //        .module(.enumMacros),
    //        .module(.sampleBuilder),
    //        .module(.macroHelpers),
    //        .sharing,
    //        .casePaths,
    //      ],
    //    ),

    //    .target(
    //      name: "UIPrimitives",
    //      dependencies: [
    //        .module(.coreTools),
    //        .module(.layoutKit),
    //      ],
    //    ),

    //    .target(
    //      name: "VectorKit",
    //      dependencies: [
    //        //        .module(.coreTools),
    //        .module(.basePrimitives),
    //        .module(.enumMacros),
    //        //        .module(.drawingPrimitives),
    //        //        .module(.colourKit),  // Consider trying to remove this dep.
    //        //        .module(.colourKit),
    //        //        .module(.uiPrimitives),
    //        .casePaths,
    //        .metaCodable,
    //        .identifiedCollections,
    //        //        .product(name: "Yams", package: "Yams"),
    //
    //      ]
    //    ),

    .target(
      name: "Wrecktangle",
      dependencies: [
        .module(.basePrimitives),
      ]
    ),

    // MARK: - Forwarding modules
//    .target(
//      name: "CoreTools",
//      dependencies: [
//        .module(.basePrimitives),
//        //        .module(.sharedHelpers),
//        .module(.enumMacros),
//      ],
//    ),

    .target(
      name: "ToolKit",
      dependencies: [
        .module(.basePrimitives),
        .module(.baseUI),
        .module(.graphicsKit),
      ],
    ),

    // MARK: - Test targets
    //    .testTarget(
    //      name: "SharedHelpersTests",
    //      dependencies: [.module(.sharedHelpers)],
    //    ),
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
  //  static var sharing: Self {
  //    .product(name: "Sharing", package: "swift-sharing")
  //  }
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
  case basePrimitives
  case baseUI
  case componentKit
  case canvasKit
//  case casePathHelpers
  //  case colourKit
  //  case drawingPrimitives
  case gestureKit
//  case graphicsModels
  case graphicsKit
  case macroHelpers
  case layoutKit
  //  case lilypad
  case motionKit
  //  case sharedHelpers
  //  case uiPrimitives
  //  case vectorKit
  case wrecktangle

  /// Export-only modules
  case toolKit
//  case coreTools

  var name: String {
    switch self {
      case .enumMacros: "EnumMacros"
      case .sampleBuilder: "SampleBuilder"
      case .networking: "BaseNetworking"
      case .basePrimitives: "BasePrimitives"
//      case .casePathHelpers: "CasePathHelpers"
      case .baseUI: "BaseUI"
      case .componentKit: "ComponentKit"
      case .canvasKit: "CanvasKit"
      //      case .colourKit: "ColourKit"
      //      case .drawingPrimitives: "DrawingPrimitives"
      case .gestureKit: "GestureKit"
      case .graphicsKit: "GraphicsKit"
//      case .graphicsModels: "GraphicsModels"
      case .macroHelpers: "MacroHelpers"
      case .layoutKit: "LayoutKit"
      //      case .lilypad: "LilyPad"
      case .motionKit: "MotionKit"
      //      case .sharedHelpers: "SharedHelpers"
      //      case .uiPrimitives: "UIPrimitives"
      //      case .vectorKit: "VectorKit"
      case .wrecktangle: "Wrecktangle"

      /// Export-only
      case .toolKit: "ToolKit"
//      case .coreTools: "CoreTools"
    }
  }
}
