# Solonoid

A 2048-inspired puzzle game on a hexagonal grid with 6 directional movement. Built for iOS using SpriteKit, featuring smooth animations and elegant hex-grid mechanics.

## Features

- **Hexagonal Grid Gameplay**: 19-tile hex grid in a 3-4-5-4-3 pattern
- **6-Direction Movement**: Swipe in any direction to move and merge tiles
- **2048-Style Merging**: Identical adjacent tiles merge into their sum
- **Smooth Animations**: Fast easing animations for tile movement and appearance
- **Score Tracking**: Real-time score calculation and display
- **Game-Over Detection**: Automatically detects when no valid moves remain
- **Responsive Design**: Supports iPhone and iPad with adaptive layouts

## Getting Started

### Requirements

- iOS 14.0+
- Xcode 12.0+
- Swift 5.3+

### Installation

1. Clone the repository:
```bash
git clone https://github.com/yourusername/solonoid.git
cd solonoid
```

2. Open the Xcode project:
```bash
open solonoid.xcodeproj
```

3. Select the iOS target and run on a simulator or device:
   - Select your target device
   - Press `Cmd + R` to build and run

## Gameplay

### How to Play

1. **Goal**: Combine tiles to create increasingly larger numbers
2. **Movement**: Swipe in any of 6 directions:
   - Right (E), Upper-Right (NE), Upper-Left (NW)
   - Left (W), Lower-Left (SW), Lower-Right (SE)
3. **Merging**: When two tiles with the same value touch, they merge into one tile with their sum
4. **New Tiles**: After each move, a new tile spawns randomly (90% chance of 2, 10% chance of 4)
5. **Game Over**: When no moves are possible, the game ends

## Architecture

The game uses a clean, modular architecture separating game logic from visual representation:

### Core Model Layer
- **HexCoordinate**: Axial coordinate system for hex grid positions
- **Direction**: 6 cardinal directions with offset vectors
- **Tile**: Individual tile value and state
- **HexGrid**: Core game logic (movement, merging, spawning)
- **GameState**: Game state management and scoring

### Visual Layer
- **HexTileNode**: Individual hexagon tile rendering
- **HexGridNode**: Container managing tile positions and animations
- **GameScene**: Main scene coordinating gameplay and input

For detailed architecture documentation, see [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md).

## Development

### Project Structure

```
solonoid/
├── solonoid Shared/      # Shared game code (iOS-focused)
│   ├── GameScene.swift   # Main game scene
│   ├── HexCoordinate.swift
│   ├── Direction.swift
│   ├── Tile.swift
│   ├── HexGrid.swift
│   ├── GameState.swift
│   ├── HexTileNode.swift
│   ├── HexGridNode.swift
│   ├── GameScene.sks
│   ├── Actions.sks
│   └── Assets.xcassets/
├── solonoid iOS/         # iOS-specific code
│   ├── AppDelegate.swift
│   ├── GameViewController.swift
│   └── Base.lproj/
└── docs/                 # Documentation
```

### Building and Running

```bash
# Open in Xcode
open solonoid.xcodeproj

# Build from command line
xcodebuild -scheme "solonoid iOS" -configuration Debug

# Run tests (if available)
xcodebuild -scheme "solonoid iOS" test
```

## Contributing

Contributions are welcome! Please read [CONTRIBUTING.md](docs/CONTRIBUTING.md) for guidelines on:
- Code style and conventions
- Submitting pull requests
- Reporting issues
- Feature requests

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- Inspired by the 2048 puzzle game
- Uses Apple's SpriteKit framework for 2D graphics
- Built with Swift and Xcode

## Future Enhancements

- [ ] Sound and music effects
- [ ] Difficulty levels and game modes
- [ ] Leaderboard/score persistence
- [ ] Tutorial and onboarding
- [ ] Haptic feedback on moves
- [ ] Themes and visual customization
- [ ] Game statistics and achievements
