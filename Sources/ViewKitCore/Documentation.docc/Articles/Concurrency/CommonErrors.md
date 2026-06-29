# Common Concnurrency Errors

Try not making the protocol conform to Sendable, instead you'll have to make the type itself sendable, that seems to help.
Quite often adding main actor to the protocol like `struct MyType: @MainActor SomeProtocol` helps
