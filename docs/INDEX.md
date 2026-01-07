# Documentation Index

Welcome to Solonoid! This is your guide to project documentation. Start here to find what you're looking for.

## Quick Links

### For Players
- **[How to Play](GAMEPLAY.md)** - Learn the rules and gameplay mechanics
- **[README](../README.md)** - Project overview and features

### For Developers
- **[Build Guide](BUILD.md)** - How to compile and run the project
- **[Architecture Guide](ARCHITECTURE.md)** - Technical design and code structure
- **[Contributing Guide](CONTRIBUTING.md)** - How to contribute code

### For Maintainers
- **[Changelog](../CHANGELOG.md)** - Version history and release notes
- **[Roadmap](../ROADMAP.md)** - Future plans and feature timeline

---

## Documentation by Topic

### Getting Started

1. **First Time?**
   - Read: [README](../README.md) - 5 min overview
   - Then: [GAMEPLAY.md](GAMEPLAY.md) - Learn how to play
   - Finally: [BUILD.md](BUILD.md) - Get it running

2. **Want to Contribute?**
   - Read: [CONTRIBUTING.md](CONTRIBUTING.md) - Contribution guidelines
   - Then: [ARCHITECTURE.md](ARCHITECTURE.md) - Understand the code
   - Finally: Check [Issues](https://github.com/oddurs/solonoid/issues) for tasks

3. **Installing the Project**
   - See: [BUILD.md](BUILD.md) → Installation section
   - Also: [BUILD.md](BUILD.md) → Troubleshooting section

### Game Design

- **[GAMEPLAY.md](GAMEPLAY.md)**
  - How to play
  - Rules and mechanics
  - Strategy tips
  - FAQ

- **[ROADMAP.md](../ROADMAP.md)**
  - Planned features
  - Version timeline
  - Game mode ideas

### Technical Documentation

- **[ARCHITECTURE.md](ARCHITECTURE.md)**
  - System overview
  - Layer descriptions
  - Data flow
  - Design patterns
  - Testing strategy

- **[BUILD.md](BUILD.md)**
  - Requirements
  - Installation
  - Building
  - Testing
  - Debugging
  - Performance

### Project Management

- **[CHANGELOG.md](../CHANGELOG.md)**
  - Version history
  - New features per version
  - Known issues
  - Release criteria

- **[ROADMAP.md](../ROADMAP.md)**
  - Feature timeline
  - Version goals
  - Success metrics
  - Getting involved

### Contributing

- **[CONTRIBUTING.md](CONTRIBUTING.md)**
  - Code of conduct
  - Setup instructions
  - Development workflow
  - Pull request process
  - Code style guide
  - Testing requirements

---

## File Organization

```
docs/
├── ARCHITECTURE.md     # Technical design (9 sections)
├── BUILD.md            # Build & dev guide (10 sections)
├── CONTRIBUTING.md     # Contribution guidelines (8 sections)
├── GAMEPLAY.md         # How to play (8 sections)
├── INDEX.md            # This file
│
Parent Directory/
├── README.md           # Project overview
├── LICENSE             # MIT License
├── CHANGELOG.md        # Version history
├── ROADMAP.md          # Future plans
└── .gitignore          # Git rules
```

---

## Common Tasks

### "I want to..."

**...learn how to play**
- Read: [GAMEPLAY.md](GAMEPLAY.md)
- Time: ~10 minutes

**...build and run the project**
- Read: [BUILD.md](BUILD.md) → Installation
- Time: ~15 minutes

**...understand the code architecture**
- Read: [ARCHITECTURE.md](ARCHITECTURE.md)
- Time: ~30 minutes

**...fix a bug or add a feature**
- Read: [CONTRIBUTING.md](CONTRIBUTING.md)
- Then: [ARCHITECTURE.md](ARCHITECTURE.md)
- Time: ~1 hour setup + implementation

**...set up my development environment**
- Read: [BUILD.md](BUILD.md) → Setting Up
- Time: ~30 minutes

**...deploy to App Store**
- Read: [BUILD.md](BUILD.md) → Deployment
- Time: ~2 hours (first time)

**...report a bug**
- Read: [CONTRIBUTING.md](CONTRIBUTING.md) → Issue Reporting
- Time: ~5 minutes

**...see what's coming next**
- Read: [ROADMAP.md](../ROADMAP.md)
- Time: ~10 minutes

**...understand the release process**
- Read: [CHANGELOG.md](../CHANGELOG.md) → Release Criteria
- Time: ~5 minutes

---

## Documentation Standards

All documentation follows these guidelines:

- **Clarity**: Written for the target audience
- **Completeness**: Covers main topics thoroughly
- **Organization**: Clear structure with sections and links
- **Examples**: Code examples where appropriate
- **Maintenance**: Kept up-to-date with code changes

---

## Contributing to Documentation

Good documentation is crucial! Here's how to improve it:

1. **Found an error?**
   - Fix it and submit a PR
   - See [CONTRIBUTING.md](CONTRIBUTING.md)

2. **Found something unclear?**
   - Open an issue with suggestions
   - Or improve it yourself

3. **Want to add documentation?**
   - Create a new file in `docs/`
   - Link it from this index
   - Follow the format of existing docs

---

## Quick Reference

### Key Concepts

- **HexGrid**: Core game logic with 19-tile hexagon
- **Direction**: 6 cardinal directions (E, NE, NW, W, SW, SE)
- **HexCoordinate**: Axial (q, r) coordinate system
- **Tile**: Individual value with empty/filled state
- **GameState**: High-level game management
- **HexTileNode**: Visual tile rendering
- **HexGridNode**: Grid container with animations

### Key Commands

```bash
# Build
xcodebuild -scheme "solonoid iOS" -configuration Debug

# Clean
xcodebuild clean -scheme "solonoid iOS"

# Test
xcodebuild -scheme "solonoid iOS" test

# Open in Xcode
open solonoid.xcodeproj
```

### Important Files

- Game logic: `solonoid Shared/HexGrid.swift`
- Main scene: `solonoid Shared/GameScene.swift`
- Visuals: `solonoid Shared/HexTileNode.swift` + `HexGridNode.swift`
- Entry point: `solonoid iOS/GameViewController.swift`

---

## Getting Help

### Resources

- **GitHub Issues**: Report bugs or request features
- **GitHub Discussions**: Ask questions (if enabled)
- **Documentation**: Start here!
- **Code Examples**: See individual files and tests

### Asking Questions

When asking for help:
1. Check [CONTRIBUTING.md](CONTRIBUTING.md) FAQ
2. Search existing issues and discussions
3. Provide clear description and context
4. Include steps to reproduce (for bugs)
5. Be respectful and specific

---

## Document Metadata

| Document | Purpose | Target Audience | Length | Updated |
|----------|---------|-----------------|--------|---------|
| README.md | Overview | Everyone | ~5 min | 2026-01-07 |
| GAMEPLAY.md | Game rules | Players | ~10 min | 2026-01-07 |
| ARCHITECTURE.md | Technical design | Developers | ~30 min | 2026-01-07 |
| BUILD.md | Build & test | Developers | ~20 min | 2026-01-07 |
| CONTRIBUTING.md | Contribution guide | Contributors | ~20 min | 2026-01-07 |
| CHANGELOG.md | Version history | Everyone | ~5 min | 2026-01-07 |
| ROADMAP.md | Future plans | Everyone | ~15 min | 2026-01-07 |
| INDEX.md | Doc guide | Everyone | ~10 min | 2026-01-07 |

---

## Tips for Using This Documentation

1. **Use the Table of Contents**: Most long documents have TOC links
2. **Follow Links**: Click links to jump to related topics
3. **Check Examples**: Look for code examples marked with ```` ```swift ````
4. **Search**: Use Ctrl+F or Cmd+F to find terms within documents
5. **Print**: Documents are designed to be printable
6. **Share**: Link directly to sections for specific help

---

For questions about this documentation, please open an issue on GitHub.

Happy coding! 🎮✨
