# Contributing Guide

Thank you for your interest in contributing to Solonoid! This document provides guidelines and instructions for contributing.

## Code of Conduct

We are committed to providing a welcoming and inspiring community for all. Please be respectful of other contributors and users.

## Getting Started

### Prerequisites
- macOS 10.15 or later
- Xcode 12.0 or later
- Git
- Basic Swift knowledge

### Setting Up Your Development Environment

1. **Fork the Repository**
   ```bash
   # Visit https://github.com/oddurs/solonoid
   # Click "Fork" in the top-right corner
   ```

2. **Clone Your Fork**
   ```bash
   git clone https://github.com/YOUR_USERNAME/solonoid.git
   cd solonoid
   ```

3. **Add Upstream Remote**
   ```bash
   git remote add upstream https://github.com/oddurs/solonoid.git
   ```

4. **Create a Feature Branch**
   ```bash
   git checkout -b feature/your-feature-name
   # or for bug fixes:
   git checkout -b fix/bug-description
   ```

5. **Open in Xcode**
   ```bash
   open solonoid.xcodeproj
   ```

## Development Workflow

### Before You Start

1. **Check Existing Issues**: Look at [Issues](https://github.com/oddurs/solonoid/issues) to avoid duplicate work
2. **Start a Discussion**: For major changes, open an issue first to discuss your approach
3. **Review Architecture**: Read [docs/ARCHITECTURE.md](ARCHITECTURE.md) to understand the codebase

### Making Changes

1. **Follow Code Style**
   - Use 4-space indentation
   - Follow [Swift API Design Guidelines](https://swift.org/documentation/api-design-guidelines/)
   - Keep line length to 100 characters when practical
   - Use meaningful variable and function names

2. **Code Organization**
   ```swift
   // Good: Clear structure with MARK comments
   class HexGrid {
       // MARK: - Properties
       private(set) var tiles: [HexCoordinate: Tile] = [:]
       
       // MARK: - Initialization
       init() { }
       
       // MARK: - Public Methods
       func move(in direction: Direction) -> Bool { }
       
       // MARK: - Private Methods
       private func updateScore() { }
   }
   ```

3. **Write Descriptive Commits**
   ```bash
   # Good
   git commit -m "feat: add haptic feedback for tile moves"
   git commit -m "fix: prevent double-merge in single move"
   
   # Avoid
   git commit -m "update"
   git commit -m "bug fix"
   ```

4. **Keep Commits Atomic**
   - One logical change per commit
   - Don't mix formatting and feature changes
   - Make it easy to review and revert if needed

### Testing Your Changes

1. **Build the Project**
   ```bash
   xcodebuild -scheme "solonoid iOS" -configuration Debug
   ```

2. **Run on Simulator**
   - Select an iPhone simulator in Xcode
   - Press `Cmd + R` to build and run
   - Test on multiple device sizes

3. **Test on Device** (if possible)
   - Connect your iPhone
   - Select it as the build target
   - Test actual touch input and performance

4. **Manual Testing Checklist**
   - [ ] Game starts without crashes
   - [ ] Tiles spawn correctly
   - [ ] Swipes in all 6 directions work
   - [ ] Merges happen correctly
   - [ ] Score updates properly
   - [ ] Game-over detection works
   - [ ] Restart button functions
   - [ ] No memory leaks (check Instruments)

## Types of Contributions

### Bug Fixes
- Identify the issue clearly
- Include steps to reproduce
- Reference any related issues
- Test thoroughly before submitting

### Features
- Keep features focused and scoped
- Update documentation as needed
- Consider backward compatibility
- Add usage examples

### Documentation
- Fix typos and improve clarity
- Add examples where helpful
- Keep diagrams up-to-date
- Document architecture decisions

### Performance Improvements
- Profile before and after
- Measure actual improvement
- Include benchmark results
- Don't sacrifice readability without benefit

## Submitting Changes

### Pull Request Process

1. **Ensure Your Branch is Up-to-Date**
   ```bash
   git fetch upstream
   git rebase upstream/main
   ```

2. **Push Your Branch**
   ```bash
   git push origin feature/your-feature-name
   ```

3. **Create a Pull Request**
   - Go to https://github.com/oddurs/solonoid
   - Click "New Pull Request"
   - Select your branch and write a description
   - Follow the PR template

4. **PR Description Template**
   ```markdown
   ## Description
   Brief explanation of what this PR does
   
   ## Type of Change
   - [ ] Bug fix
   - [ ] New feature
   - [ ] Documentation update
   - [ ] Performance improvement
   
   ## Related Issues
   Fixes #123
   
   ## Testing
   - [ ] Tested on simulator
   - [ ] Tested on device
   - [ ] All existing functionality still works
   
   ## Screenshots (if applicable)
   Include before/after screenshots
   
   ## Checklist
   - [ ] Code follows style guidelines
   - [ ] Documentation updated
   - [ ] No new warnings generated
   - [ ] Changes are tested
   ```

5. **Respond to Review Comments**
   - Be open to feedback
   - Ask clarifying questions if needed
   - Make requested changes promptly

## Code Review Standards

When reviewing PRs, we look for:

### Functionality
- ✅ Does it work as intended?
- ✅ Are edge cases handled?
- ✅ Are there any obvious bugs?

### Code Quality
- ✅ Is the code clear and readable?
- ✅ Are there meaningful variable names?
- ✅ Is the code DRY (Don't Repeat Yourself)?
- ✅ Are there appropriate comments?

### Architecture
- ✅ Does it follow the project architecture?
- ✅ Are dependencies appropriate?
- ✅ Is the change maintainable?

### Testing
- ✅ Is the change tested?
- ✅ Do all tests pass?
- ✅ Are there any performance impacts?

### Documentation
- ✅ Is the code documented?
- ✅ Are there example usages?
- ✅ Is README updated if needed?

## Issue Reporting

### Reporting Bugs

Use the bug report template:
```markdown
## Description
Clear description of the bug

## Steps to Reproduce
1. Do this
2. Then do this
3. The bug happens

## Expected Behavior
What should happen

## Actual Behavior
What actually happens

## Environment
- iOS version
- iPhone model
- Xcode version

## Screenshots/Logs
Include relevant images or logs
```

### Feature Requests

Use the feature request template:
```markdown
## Description
Clear description of the feature

## Motivation
Why is this feature needed?

## Proposed Solution
How should this work?

## Alternative Solutions
Other approaches considered

## Additional Context
Any other relevant information
```

## Style Guide

### Naming Conventions

```swift
// Classes and Structs: UpperCamelCase
class HexGrid { }
struct HexCoordinate { }

// Functions and Variables: lowerCamelCase
func moveInDirection() { }
var tileCount: Int

// Constants: UpperCamelCase
let MaximumScore = 100000

// Private: prefix with underscore (optional)
private var _internalState: String
```

### Documentation Comments

```swift
/// Brief description of what this does
///
/// Longer explanation if needed. Can span multiple lines
/// to describe behavior, parameters, and return values.
///
/// - Parameters:
///   - param1: Description of param1
///   - param2: Description of param2
/// - Returns: Description of return value
/// - Throws: Conditions that throw errors
///
/// - Example:
///   ```swift
///   let result = myFunction(param1: value)
///   ```
func myFunction(param1: String, param2: Int) -> Bool {
    // Implementation
}
```

### Comments in Code

```swift
// Use for complex logic explanation
// Keep comments up-to-date with code changes
// Avoid obvious comments like "increment i"

// MARK: - Section Name
// Use MARK comments to organize code sections
```

## Project Architecture Guidelines

When contributing, please maintain these architectural principles:

1. **Separation of Concerns**
   - Keep game logic separate from UI
   - Model layer has no SpriteKit dependencies
   - Visual layer doesn't contain game rules

2. **No Circular Dependencies**
   - HexGrid doesn't know about HexTileNode
   - GameScene coordinates between them
   - One-way dependencies are preferred

3. **Immutable Value Types**
   - Use `struct` for data models
   - Use `class` for controllers and managers
   - Avoid mutable global state

4. **Testability**
   - Write code that can be tested without UI
   - Avoid tight coupling
   - Use dependency injection where appropriate

## Questions?

- **Open an Issue**: For questions about the project
- **Check Docs**: See [docs/ARCHITECTURE.md](ARCHITECTURE.md) and [docs/GAMEPLAY.md](GAMEPLAY.md)
- **Email**: Contact the maintainers directly

## Recognition

Contributors will be recognized in:
- [README.md](../README.md) contributors section
- GitHub's contributors page
- Release notes for their changes

## License

By contributing, you agree that your contributions will be licensed under the same MIT License that covers the project.

---

Thank you for contributing to Solonoid! 🎮✨
