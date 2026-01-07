# Build and Development Guide

## System Requirements

- **macOS**: 10.15 (Catalina) or later
- **Xcode**: 12.0 or later
- **iOS Deployment Target**: 14.0+
- **Swift**: 5.3 or later

## Installation

### Using Xcode

1. **Clone the repository**
   ```bash
   git clone https://github.com/oddurs/solonoid.git
   cd solonoid
   ```

2. **Open the project**
   ```bash
   open solonoid.xcodeproj
   ```

3. **Select the iOS target**
   - In Xcode, select "solonoid iOS" from the scheme dropdown

4. **Select a simulator or device**
   - Choose from the device selector dropdown

5. **Build and Run**
   - Press `Cmd + R` or click the Play button

### From Command Line

```bash
# Build for iOS Simulator
xcodebuild -scheme "solonoid iOS" -configuration Debug -sdk iphonesimulator

# Build for Device
xcodebuild -scheme "solonoid iOS" -configuration Release -sdk iphoneos

# List available schemes
xcodebuild -list
```

## Building

### Development Build
```bash
# Clean build
xcodebuild clean -scheme "solonoid iOS"

# Build
xcodebuild -scheme "solonoid iOS" -configuration Debug
```

### Release Build
```bash
xcodebuild -scheme "solonoid iOS" -configuration Release
```

### Build Settings

Common build settings can be modified in:
- Xcode: Click project → Target → Build Settings
- Key settings:
  - Deployment Target: iOS 14.0
  - Swift Language Version: Swift 5.3+
  - Other Swift Flags: Add as needed

## Project Structure

```
solonoid/
├── solonoid.xcodeproj/          # Xcode project configuration
│   ├── project.pbxproj
│   ├── xcshareddata/
│   └── xcuserdata/              # Ignore in git
│
├── solonoid Shared/             # Shared game code
│   ├── GameScene.swift          # Main game scene (UI controller)
│   ├── HexCoordinate.swift      # Hex grid coordinates (Model)
│   ├── Direction.swift          # Movement directions (Model)
│   ├── Tile.swift               # Tile data (Model)
│   ├── HexGrid.swift            # Game logic engine (Model)
│   ├── GameState.swift          # Game state management (Model)
│   ├── HexTileNode.swift        # Tile visual node (View)
│   ├── HexGridNode.swift        # Grid container node (View)
│   ├── GameScene.sks            # Scene definition
│   ├── Actions.sks              # Reusable animations
│   └── Assets.xcassets/         # Images, colors, icons
│
├── solonoid iOS/                # iOS-specific code
│   ├── AppDelegate.swift
│   ├── GameViewController.swift
│   └── Base.lproj/
│       ├── Main.storyboard
│       └── LaunchScreen.storyboard
│
├── docs/                        # Documentation
│   ├── ARCHITECTURE.md          # Technical architecture
│   ├── GAMEPLAY.md              # How to play
│   ├── CONTRIBUTING.md          # Contribution guidelines
│   └── BUILD.md                 # This file
│
├── README.md                    # Project overview
├── LICENSE                      # MIT License
└── .gitignore                   # Git ignore rules
```

## Testing

### Manual Testing Checklist

Test these aspects of the game:

**Game Logic:**
- [ ] Game starts with 2 tiles
- [ ] New tiles spawn after each move
- [ ] Tiles merge correctly (2+2=4, etc.)
- [ ] Score updates after merges
- [ ] Game detects game-over correctly

**User Input:**
- [ ] Swipe right (E) works
- [ ] Swipe left (W) works
- [ ] Swipe upper-right (NE) works
- [ ] Swipe upper-left (NW) works
- [ ] Swipe lower-right (SE) works
- [ ] Swipe lower-left (SW) works
- [ ] Minimum swipe distance respected

**UI:**
- [ ] Score label displays and updates
- [ ] Game-over overlay appears when appropriate
- [ ] Restart button works
- [ ] Layout responsive on different device sizes

**Performance:**
- [ ] Game runs at 60 FPS
- [ ] No memory leaks (check Instruments)
- [ ] Smooth tile animations
- [ ] No stuttering or lag

### Using Instruments

1. **Open Instruments**
   - Xcode → Open Developer Tool → Instruments
   - Or: Cmd + I while running the app

2. **Memory Leaks**
   - Profile → Allocations
   - Watch for growing memory after repeated gameplay

3. **Performance**
   - Profile → System Trace
   - Check for consistent 60 FPS frame rate

4. **Specific Issues**
   - Memory Leaks: Find retain cycles
   - Core Animation: Check for offscreen rendering
   - CPU: Identify hot spots

## Debugging

### Enable Debug Logging

In `GameScene.swift`, you can add print statements:

```swift
print("Move in direction: \(direction)")
print("Grid changed: \(moved)")
print("New score: \(gameState.score)")
```

### Common Issues

**Issue: Game crashes on startup**
- Check that all files are included in target
- Verify file references in xcodeproj
- Check console for error messages

**Issue: Tiles not displaying**
- Verify HexTileNode hexagon path is valid
- Check that HexGridNode is added to scene
- Verify coordinate conversion math

**Issue: Swipes not detected**
- Check that view supports gesture recognition
- Verify swipe distance threshold (30 points)
- Check gesture recognizer targets

**Issue: Memory usage increasing**
- Look for retained circular references
- Check that nodes are removed from scene
- Verify SKAction completion handlers

### Using LLDB Debugger

```lldb
# Set breakpoint on symbol
breakpoint set --name "HexGrid.move"

# Continue execution
continue

# Print variable
p gameState.score

# Evaluate expression
expr gameState.getHexGrid().tiles

# Step into next function
step

# Step over next function
next
```

## Code Quality

### Swift Linting

Use [SwiftLint](https://github.com/realm/SwiftLint) to enforce style:

```bash
# Install SwiftLint
brew install swiftlint

# Run on project
swiftlint
```

### Code Formatting

Consider using [SwiftFormat](https://github.com/nicklockwood/SwiftFormat):

```bash
# Install
brew install swiftformat

# Format directory
swiftformat solonoid\ Shared/
```

## Continuous Integration

For future GitHub Actions setup:

```yaml
name: iOS Build

on: [push, pull_request]

jobs:
  build:
    runs-on: macos-latest
    steps:
      - uses: actions/checkout@v2
      - name: Build
        run: xcodebuild -scheme "solonoid iOS" -configuration Debug
```

## Documentation Generation

Generate documentation from code comments:

```bash
# Using Swift-DocC (Xcode 13.3+)
xcodebuild docbuild -scheme "solonoid iOS"

# View in Xcode Documentation
Help → Developer Documentation
```

## Deployment

### To App Store

1. **Create Apple Developer Account**: developer.apple.com
2. **Create App ID**: In Apple Developer Portal
3. **Configure Signing**: Xcode → Signing & Capabilities
4. **Build Archive**:
   ```bash
   xcodebuild -scheme "solonoid iOS" archive
   ```
5. **Submit with Xcode Organizer**
   - Window → Organizer
   - Select archive
   - Distribute App

### To TestFlight

1. Create archive (see above)
2. In Xcode Organizer, select "Validate App"
3. Select "Distribute App"
4. Choose TestFlight
5. Follow upload wizard

## Troubleshooting Build Issues

### Pod Issues (if using CocoaPods)
```bash
pod install
pod update
```

### Cache Issues
```bash
# Clear derived data
rm -rf ~/Library/Developer/Xcode/DerivedData/*

# Clean build
xcodebuild clean -scheme "solonoid iOS"
```

### Signing Issues
1. Xcode → Preferences → Accounts
2. Click your Apple ID
3. Click "Manage Certificates"
4. Create new certificates if needed
5. Update signing in Build Settings

### Git LFS (if using large files)
```bash
brew install git-lfs
git lfs install
```

## Performance Optimization

### Typical Performance Targets
- **Memory**: < 100 MB at runtime
- **CPU**: < 30% during gameplay
- **Frame Rate**: Stable 60 FPS
- **Startup Time**: < 2 seconds

### Optimization Techniques
1. **Reduce Node Count**: Remove non-essential SKNodes
2. **Optimize Rendering**: Use SpriteKit best practices
3. **Profile Early**: Use Instruments from day one
4. **Batch Operations**: Group similar updates
5. **Asset Optimization**: Compress images appropriately

## Resources

- [Apple SpriteKit Documentation](https://developer.apple.com/documentation/spritekit)
- [Swift Language Guide](https://docs.swift.org/swift-book/)
- [Xcode Help](https://help.apple.com/xcode/)
- [iOS Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/ios/)

## Getting Help

- **Issues**: GitHub Issues page
- **Discussions**: GitHub Discussions (if enabled)
- **Email**: Contact project maintainers
- **Documentation**: See docs/ folder
