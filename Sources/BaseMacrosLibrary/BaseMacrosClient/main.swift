import EnumMacros
import Foundation

// MARK: - Case detection
@CaseDetection
enum ExampleEnum {
  case dog
  case cat
  case fish
}

@CaseDetection(includesNames: true)
enum ExampleEnumNames {
  case dog
  case cat
  case fish
  var names: String {
    switch self {
      case .dog: "Dog"
      case .cat: "Cat"
      case .fish: "Fish"
    }
  }
}

// MARK: - MetaEnum

/// Seems to help create a corresponding enum without assoc. values?
@MetaEnum
enum AnotherEnum {
  case bird(Int)
  case whale(String)
  case shark
}

@MetaEnum(includesCaseDetection: false)
enum AnotherEnumWithCaseDetect {
  case bird(Int)
  case whale(String)
  case shark
}

// MARK: - SetOfOptions

/// Synthesises an `OptionSet` to accompany the `enum`
/// Note: The `struct` is a requirement
@SetOfOptions<UInt8>
struct CoolAnimals {
  enum Options: Int {
    case bat
    case frog
    case ape
  }
}

//struct Thing {
//
//  var otherThing: CoolAnimals {
//    let thing: CoolAnimals = .bat
//
//    thing.contains(.frog)
//
//  }
//
//}
