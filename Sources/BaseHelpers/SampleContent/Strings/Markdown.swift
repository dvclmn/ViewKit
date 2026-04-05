//
//  File.swift
//
//
//  Created by Dave Coleman on 16/6/2024.
//

import Foundation

extension SampleContent.Strings {

  public struct Markdown {

    public static let smallCodeBlock: String = """

      ```    
      let highlightr = Highlightr()
      highlightr?.setTheme(to: "xcode-dark-butts")

      ```

      And then these words here. If you would like to `contribute to the development` of Highlightr, please follow the guidelines outlined in the CONTRIBUTING.md file in the GitHub repository.

      ```swift

      # Python program to find the sum of natural using recursive function ram to find the sum of natural using recursive function ram to find the sum of natural using recursive function ram to find the sum of natural using recursive function

      def recur_sum(n):
      if n <= 1:
      ```
      """

    public static let codeBlocks: String = """

      Some Swift code:

      ```swift
      import Shortcuts


      struct MessageInputView: View {

      @Environment(\\.store) private var store

      @State private var metrics: String = ""
      @State private var isManualMode: Bool = false

      //  @State private var editorHeight: CGFloat = .zero

      @Bindable var conversationStore: StoreOf<SingleShrimConversation>

      let syntaxButtons: [Markdown.Syntax] = [.bold, .italic, .inlineCode]

      @FocusState var focused: Focus.State.Element?

      //  @Bindable var conversation: StoreOf<SingleChumeConversation>

      var body: some View {

      @Bindable var focus = store.scope(state: \\.focus, action: \\.focus)
      @Bindable var preferences: StoreOf<Preferences> = store.scope(state: \\.preferences, action: \\.preferences)
      ```
      """

    static let twoInlineCode: String = """
      This brief `inline code`, with text contents, lines `advance expanding` the view in the current writing direction.

      It does have more than two paragraphs, which I'm hoping will help me to verify that the code is able to count elements of a particular kind of markdown syntax, not just fragments or paragraphs.

      We'll have to just see if it works.

      Thank you for sharing your code and explaining your setup. It's great to see you're working on a markdown parsing and styling system using TextKit 2. Let's address your questions and then discuss some ideas for your implementation.

      Invalidating Attributes:

      When you call invalidateAttributes(in: NSRange) on a text storage, you're essentially telling the text system that the attributes in the specified range may have changed and need to be recalculated. This doesn't `remove` or modify the attributes directly; instead, it triggers the text system to update its internal caches and redraw the affected text. This is useful when you've made `changes` to the text or its `attributes and want` to ensure that the display is updated correctly.

      Regarding your markdown parsing and styling setup:

      Your approach of separating the parsing (which is more expensive) and the styling (which should be more nimble) is a good strategy. Here are some ideas and suggestions to potentially improve `your implementation`.
      """

    static let shortSample: String = """
      This *brief* block quote, with ==text contents==, lines `advance 
      expanding` the view in the current writing direction.ExampleView".

      Includes one line break.

      Followed by another. In addition, here is a list:

      - [AttributeContainer](http://apple.com) is a container for attributes.
      - By configuring the container, we can set, replace, and merge
      - A large number of attributes for a string (or fragment) at once.
      """

    public static let anotherMarkdownString: String = """
      # This is the beginning of a really long heading so i can see what it does
      ## First, a message
      ### And a third, a header that's small
      I will build a library of `Message` objects, as `[String]`, and can ~~you write~~ me up a *function* that simply selects one of the **paragraphs** (i.e. items in the array), and returns it? Also, we need some ***extra emphasis*** on this text.

      ```
      func updateNSView(_ nsView: NSTextView, context: Context) {
          nsView.textStorage?.setAttributedString(text)
      }
      ```

      As well as some text down here.

      And some here just in case
      """

    public static let shortMarkdownBasics: String = """
      # Markdown samples
      ## Overview of the sample
      Usually, `NSTextView` manages the *layout* process inside **the viewport** interacting ~~with its delegate~~.

      - [AttributeContainer](http://apple.com) is a container for attributes.
      - By configuring the container, we can set, replace, and merge
      - A large number of attributes for a string (or fragment) at once.

      ### Markdown syntax summary

      A `viewport` is a _rectangular_ area within a ==flipped coordinate system== expanding along the y-axis, with __bold alternate__, as well as ***bold italic*** emphasis, which has a alt version with ___three underscores___ like that.

      1. You’d mentioned this is rendered within an OpenGL window
      2. Despite the implementation details under the hood
      3. They can only speculate, but perhaps OpenGL here is useful

      ```python
      // There is also some basic code
      var x = y
      ```

      > This *brief* block quote, with ==text contents==, lines `advance expanding` the view in the current writing direction.ExampleView
      """

  }

}
