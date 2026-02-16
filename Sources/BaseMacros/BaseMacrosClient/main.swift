import BasePrimitives
import EnumMacros
import Foundation
import SampleBuilder

// MARK: - Associated Values

/// Generates optional properties for cases with associated values,
/// for more streamlined access.
@AssociatedValues
enum CoolPlants {
  case fern(Int)
  case cactus(String, Bool)
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

/// This inference is intentionally heuristic. It will not catch cases like the below.
///
/// This could return `MyRecord`, but macro can’t know:
/// `static let x = makeDefaultRecord()`
///
/// If `MyRecord` is an enum, could be `Self`, but ambiguous:
/// `static let y = .someCase`
@StaticMemberIterable
struct MyRecord {
  static let a = MyRecord()
  static let b: Self = .init()
  static let c: MyRecord = .init()
  static let d: String = "hello"
}

// MARK: - SampleData

@SampleBuilder(numberOfItems: 10, dataGeneratorType: .default)
struct Example {
  let item1: UUID
  let item2: Int
}

for element in Example.sample {
  print(element.item1, element.item2)
}

@SampleBuilder(numberOfItems: 3, dataGeneratorType: .random)
struct Review {
  let rating: Int
  let time: Date
  @SamplesIgnored let product: Product
}

@SampleBuilder(numberOfItems: 3, dataGeneratorType: .random)
struct Product {
  var price: Int
  var description: String
}

@SampleBuilder(numberOfItems: 3, dataGeneratorType: .random)
struct Profile {
  @SampleBuilderItem(category: .firstName)
  let firstName: String

  @SampleBuilderItem(category: .lastName)
  let lastName: String

  @SampleBuilderItem(category: .image(width: 300, height: 300))
  let profileImage: URL
}

for profile in Profile.sample {
  print(profile.firstName, profile.lastName, profile.profileImage)
}

@SampleBuilder(numberOfItems: 6, dataGeneratorType: .random)
enum MyEnum {
  indirect case case1(String, Int, String, [String])
  case case2
  case case3(Product)
  case case4([String: Product])
}
