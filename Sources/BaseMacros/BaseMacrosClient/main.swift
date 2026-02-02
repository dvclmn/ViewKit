import EnumMacros
import Foundation

// MARK: - Associated Values

/// Synthesises an `OptionSet` to accompany the `enum`
/// Note: The `struct` is a requirement
@AssociatedValues
enum CoolPlants {
  case fern(Int)
  case cactus(String)
  case orchid
}

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
  //  var names: String {
  //    switch self {
  //      case .dog: "Dog"
  //      case .cat: "Cat"
  //      case .fish: "Fish"
  //    }
  //  }
}

// MARK: - MetaEnum

/// Creates a corresponding enum without assoc. values
@MetaEnum
enum AnotherEnum {
  case bird(Int)
  case whale(String)
  case crane(CGFloat = 3.0)
  case shark
}

// MARK: - SetOfOptions

/// Synthesises an `OptionSet` to accompany the `enum`
/// Note: The `struct` is a requirement
@SetOfOptions<UInt8>
struct CoolAnimals {
  enum Options: Int {
    case bat
    case frog  // Test comment
    case apeWithCamelCase
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

/// Expected output:
/// ```
/// public init?(thingOptional: Bool?) {
///   guard let thingOptional else {
///     return nil
///   }
///   self = .thing(thingOptional)
/// }
///
/// public init?(multiOptional: String?, count: Int?) {
///   guard let multiOptional, let count else {
///     return nil
///   }
///   self = .thing(multiOptional, count: count)
/// }
///
/// public init?(noLabelOptional: String?, _ b: Int?) {
///   guard let noLabelOptional, let b else {
///     return nil
///   }
///   self = .thing(noLabelOptional, b)
/// }
/// ```
/// Looking at these pieces:
/// - Only first parameter gets the "Optional" suffix
/// - Might cheat for now and just refer to other params as A B C
@Optinits
public enum Attribute {
  case thing(Bool)
  case multi(String, count: Int)
  case noLabel(Bool, Int)
  case triple(Bool, Int, String)
  case quadNamed(Bool, min: Int, title: String, CGFloat)
  case noValue
}

/// Current issue:
///
/// The case is:
/// ```
/// case quadNamed(Bool, min: Int, title: String, CGFloat)
/// ```
///
/// ```
/// The output is:
/// public init?(quadNamedOptional: Bool?, min: Int?, title: String?, d: CGFloat?) {
///   guard let quadNamedOptional else {
///     return nil
///   }
///   guard let min else {
///     return nil
///   }
///   guard let title else {
///     return nil
///   }
///   guard let d else {
///     return nil
///   }
///   self = .quadNamed(quadNamedOptional, min, title, d)
/// }
/// ```
///
/// The issue that `min` and `title` are missing their labels in the self assignment

struct MyRecord {
  @StaticMemberIterable
  enum Fixtures {
    static let a = MyRecord()
    static let b = MyRecord()
  }
}
