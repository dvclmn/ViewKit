# Choosing String vs AttributedString

I often find I want the *option* for styled text, and wonder if I am forced to use AttributedString as the storage for text, as a 'just in case'.

I'm noting down some of the domains in BaseHelpers / my apps that this applies to, so I can see if I really do need an AttributedString, or whether I actually just want to highlight specific patterns. A bit like simplified syntax highlighting.

To put it another way; do I really need to manually style xyz attributes? Or do I just need to apply certain semantic styling based on my own small 'grammar' that I grow over time?

## BaseUI
- HelpButton
- DebugTextOverlayModifier
- InfoBar

## SharedHelpers
- QuickLabel
- DisplayString
