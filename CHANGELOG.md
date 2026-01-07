# Changelog

All notable changes to Solonoid will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Planned Features
- Sound effects and background music
- Difficulty levels and game modes
- Score persistence and leaderboards
- Game statistics and achievements
- Visual themes and customization
- Haptic feedback on tile moves
- Tutorial and onboarding flow
- Dark mode support

## [0.1.0] - 2026-01-07

### Added
- Initial release of Solonoid
- Hexagonal grid (19-tile 3-4-5-4-3 layout)
- 6-directional movement (E, NE, NW, W, SW, SE)
- Tile merging mechanics (identical tiles combine)
- Score tracking and display
- Game-over detection and restart functionality
- Smooth tile animations (movement and appearance)
- Color-coded tiles by value
- Touch-based swipe input (all 6 directions)
- iOS 14.0+ support
- Core architecture with separated model/view/controller layers

### Architecture
- `HexCoordinate`: Axial coordinate system for hex grid
- `Direction`: 6 cardinal directions with offset vectors
- `Tile`: Individual tile representation
- `HexGrid`: Core game logic engine
- `GameState`: Game state and score management
- `HexTileNode`: Visual hexagon tile rendering
- `HexGridNode`: Grid container with coordinate conversion
- `GameScene`: Main scene and input handling

### Documentation
- Comprehensive README with feature overview
- Architecture documentation (ARCHITECTURE.md)
- Gameplay guide (GAMEPLAY.md)
- Contribution guidelines (CONTRIBUTING.md)
- Build and development guide (BUILD.md)
- MIT License

---

## Version History Notes

### Release Criteria

A release is made when:
1. All planned features for the version are complete
2. No critical bugs remain
3. All tests pass
4. Documentation is updated
5. Changelog is updated

### Versioning Scheme

- **MAJOR**: Breaking changes to gameplay or API
- **MINOR**: New features, backward compatible
- **PATCH**: Bug fixes and small improvements

### Support Policy

- Latest version: Full support
- Previous version: Critical bugs only
- Older versions: Community support

---

## Future Release Plans

### v0.2.0 - Audio and Polish
- [ ] Sound effects for moves and merges
- [ ] Background music with volume control
- [ ] Haptic feedback on tile moves
- [ ] Visual polish and animations refinement
- [ ] Performance optimizations

### v0.3.0 - Game Modes
- [ ] Multiple difficulty levels
- [ ] Time-attack mode
- [ ] Endless mode variations
- [ ] Tutorial mode
- [ ] Custom board sizes

### v0.4.0 - Persistence
- [ ] Save/load game state
- [ ] Score history
- [ ] Player statistics
- [ ] iCloud sync (optional)
- [ ] Privacy-focused analytics

### v1.0.0 - Full Release
- [ ] App Store submission
- [ ] Complete feature set
- [ ] Comprehensive documentation
- [ ] Community feedback integration
- [ ] Long-term support commitment

---

## Known Issues

### Current
- None reported

### Limitations
- iOS only (macOS and tvOS removed for v0.1)
- No sound/music in v0.1
- No persistence in v0.1
- No online leaderboards

---

## Contributing

See [CONTRIBUTING.md](docs/CONTRIBUTING.md) for information about:
- Reporting bugs
- Requesting features
- Submitting pull requests
- Development setup
