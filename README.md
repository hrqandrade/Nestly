# Nestly

A UIKit property-discovery app demonstrating safe Server-Driven UI.

## Requirements

- Xcode 16+
- iOS 18+
- XcodeGen 2.45+

## Getting started

```bash
xcodegen generate
open Nestly.xcodeproj
```

## Validate

```bash
xcodebuild test \
  -project Nestly.xcodeproj \
  -scheme Nestly \
  -destination 'platform=iOS Simulator,name=iPhone 16 Pro' \
  CODE_SIGNING_ALLOWED=NO
```

The project is being delivered in stages. The current baseline contains the UIKit shell, local package boundaries, design tokens, an initial fixture, and CI.
