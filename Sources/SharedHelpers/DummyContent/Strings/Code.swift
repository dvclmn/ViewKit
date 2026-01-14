//
//  Code.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 14/11/2025.
//

public enum ProgrammingLanguage: String, CaseIterable {
  case swift
  case ruby
  case python
  case typescript
}

extension SampleContent.Strings {
  public static func code(language: ProgrammingLanguage) -> [String] {
    switch language {
      case .swift:
        [
          """
          public enum ProgrammingLanguage: String {
          case swift
          case ruby
          case python
          case typescript
          }
          """
        ]
      case .ruby:
        [
          """
          require 'redcarpet'
          markdown = Redcarpet.new("Hello World!")
          puts markdown.to_html
          """,
          """
          rubyCopyEdit# Using puts (adds a new line at the end)
          puts "Hello World!"
          
          # Using print (no newline by default)
          print "Hello World!"
          """,
          """
          rubyCopyEditputs "Enter first number:"
          num1 = gets.chomp.to_i
          
          puts "Enter second number:"
          num2 = gets.chomp.to_i
          
          sum = num1 + num2
          """
        ]
      case .python:
        [
          """
          # This program prints Hello, world!
          print('Hello, world!')
          """,
          
          """
          # create a temporary variable and swap the values
          temp = x
          x = y
          y = temp
          
          print('The value of x after swapping: {}'.format(x))
          """,
          
          """
          # declare global variable
          message = 'Hello'
          
          def greet():
          # declare local variable
          print('Local', message)
          
          greet()
          print('Global', message)
          """
        ]
      case .typescript:
        [
          """
          let device: string | number | boolean; // Union Type
          device = "Mobile";
          device = 4323523;
          """,
          """
          // 2.1 Optionl & Default param
          const sum = (
            a: number,
            b: number,
            c?: string, // Optional param
            d: number = 0 // Default param
          ): number | string => {
            let result: string | number;
            result = a + b + d;
            if (c) {
            result = a + b + c;
            }
            return result;
          };
          """,
          """
          const stringArr = ["Hello", "how", "are", "you"];
          const stringArr2: string[] = ["Hello", "how", "are", "you"];
          // X - stringArr.push(34)
          """,
          """
          let jobayer: Person = {
            name: "Jobayer",
            age: 26,
            premeum: true,
          };
          """
        ]
    }

  }
}
