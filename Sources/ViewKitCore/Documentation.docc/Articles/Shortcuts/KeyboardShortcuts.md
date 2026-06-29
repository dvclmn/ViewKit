# Keyboard Shortcuts
SwiftUI

Note:
Sometimes I'll find that a certain keyboard shortcut won't work, or display next to the Menu Bar item. It's worth checking if an existing menu item is already using it. Not only your own, but also check 'presets' such as ` SidebarCommands()`, `TextFormattingCommands()` etc.

This is often true for font resizing items, where I've tried to use e.g. `.keyboardShortcut("+", modifiers: .command)`, and `TextFormattingCommands()` has been in use, preventing the shortcut from working.
