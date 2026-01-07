# Architecture Guide

## Overview

Solonoid uses a modular, layered architecture that separates game logic from presentation. This design enables clean code, easy testing, and straightforward feature additions.

## Architecture Layers

### 1. Core Model Layer (Game Logic)

The model layer contains pure Swift logic with no dependencies on SpriteKit or UIKit:

#### **HexCoordinate** (`HexCoordinate.swift`)
- **Purpose**: Represents positions on the hex grid using axial coordinates
- **Key Features**:
  - Axial coordinate system (q, r) for efficient hex math
  - Pre-calculated 19-position grid (3-4-5-4-3 pattern)
  - Neighbor finding and distance calculation
- **Responsibilities**:
  - Convert between coordinate systems
  - Validate positions within grid bounds
  - Calculate neighbor positions

```swift
let coord = HexCoordinate(q: 0, r: 0)
let neighbors = coord.neighbors()  // Get all 6 neighbors
let distance = coord.distance(to: other)
```

#### **Direction** (`Direction.swift`)
- **Purpose**: Represents the 6 cardinal directions on a hex grid
- **Values**: NE, E, SE, SW, W, NW
- **Features**:
  - Axial offset vectors for each direction
  - Opposite direction calculation
- **Usage**:
  ```swift
  let dir = Direction.ne
  let opposite = dir.opposite  // Returns .sw
  ```

#### **Tile** (`Tile.swift`)
- **Purpose**: Represents a single tile on the grid
- **Properties**:
  - `value`: Integer value (0 for empty)
  - `isMergedThisTurn`: Prevents double-merging in one move
- **Factory Methods**:
  - `Tile.empty`: Creates an empty tile
  - `Tile.newSpawn()`: Creates a new tile (90% 2, 10% 4)

#### **HexGrid** (`HexGrid.swift`)
- **Purpose**: Core game logic engine
- **Responsibilities**:
  - Maintains tile state for all 19 positions
  - Implements move algorithm (slide + merge)
  - Spawns new tiles after valid moves
  - Detects valid moves and game-over conditions
- **Key Methods**:
  ```swift
  func move(in direction: Direction) -> Bool  // Returns true if grid changed
  func hasValidMoves() -> Bool                 // Check if game continues
  func reset()                                  // Start a new game
  ```
- **Algorithm**:
  1. For each position, find the furthest it can slide in a direction
  2. Merge with next non-empty tile if values match (and not merged this turn)
  3. Spawn random new tile if grid changed
  4. Return whether the grid changed

#### **GameState** (`GameState.swift`)
- **Purpose**: High-level game state management
- **Responsibilities**:
  - Track score (sum of all tiles)
  - Track move count
  - Detect win/lose conditions
  - Coordinate HexGrid updates
- **Key Methods**:
  ```swift
  func move(in direction: Direction) -> Bool
  func reset()
  func getHexGrid() -> HexGrid
  ```

### 2. Visual Layer (Presentation)

The visual layer handles all rendering and animation using SpriteKit:

#### **HexTileNode** (`HexTileNode.swift`)
- **Extends**: `SKShapeNode`
- **Purpose**: Renders a single hexagon tile with value
- **Features**:
  - Regular hexagon shape (pointy-top orientation)
  - Dynamic coloring based on tile value
  - Value label rendering
  - Animation methods for movement and appearance
- **Key Methods**:
  ```swift
  init(at coordinate: HexCoordinate, size: CGFloat, value: Int = 0)
  func animateAppear(duration: TimeInterval = 0.1)
  func animateMove(to position: CGPoint, duration: TimeInterval = 0.15)
  ```

#### **HexGridNode** (`HexGridNode.swift`)
- **Extends**: `SKNode`
- **Purpose**: Container managing all tile visual nodes
- **Responsibilities**:
  - Convert hex coordinates to screen positions
  - Create/update/remove tile nodes as game state changes
  - Manage tile animations
- **Coordinate Conversion**:
  - Uses pointy-top hexagon math
  - Formula: 
    - `x = hexWidth * (3/2 * q)`
    - `y = -hexHeight * (r + q/2) / 2`
- **Key Methods**:
  ```swift
  func updateGrid(with hexGrid: HexGrid)
  func hexToScreen(_ hex: HexCoordinate) -> CGPoint
  func animateTileMove(from: HexCoordinate, to: HexCoordinate)
  ```

### 3. Integration Layer (Scene Management)

#### **GameScene** (`GameScene.swift`)
- **Extends**: `SKScene`
- **Purpose**: Main game scene coordinating all systems
- **Responsibilities**:
  - Initialize and manage GameState and HexGridNode
  - Handle user input (swipe gestures)
  - Update visuals after each move
  - Display score and game-over UI
  - Manage restart functionality
- **Input Handling**:
  - Detects swipe angle using `atan2()`
  - Maps 0-360° to 6 hex directions (60° zones each)
  - Minimum swipe distance of 30 points
- **Key Methods**:
  ```swift
  func moveInDirection(_ direction: Direction)
  func showGameOverOverlay()
  func restartGame()
  ```

## Data Flow

### Move Sequence

```
User Swipe Input
    ↓
GameScene.touchesEnded() calculates angle
    ↓
GameScene.moveInDirection(direction)
    ↓
GameState.move(in direction)
    ↓
HexGrid.move(in direction) - core logic
    ↓
HexGrid.spawnNewTile()
    ↓
GameScene updates visuals
    ↓
HexGridNode.updateGrid() creates/updates nodes
    ↓
HexTileNode animations render changes
```

## Key Design Patterns

### Separation of Concerns
- **Model** handles all game logic independently
- **View** handles all rendering
- **Controller** (GameScene) coordinates interactions
- This enables unit testing of game logic without UI

### Immutable Coordinates
- `HexCoordinate` is a value type (struct)
- Enables safe copying and comparison
- Can be used as dictionary keys

### Factory Methods
- `HexCoordinate.allPositions`: Pre-calculated valid positions
- `Tile.newSpawn()`: Randomized spawn logic
- `GameScene.newGameScene()`: Consistent scene creation

### Animation Abstraction
- `HexTileNode` encapsulates animation logic
- `GameScene` doesn't need to know animation details
- Easy to adjust timing and easing in one place

## Extensibility Points

### Adding New Game Modes
1. Extend `GameState` with mode-specific logic
2. Add mode-specific rules to `HexGrid.move()`

### Customizing Visual Style
1. Modify color palette in `HexTileNode.colorForValue()`
2. Adjust hexagon size in `HexGridNode(hexSize:)`
3. Change animation timings in `HexTileNode` methods

### Implementing Persistence
1. Add `Codable` conformance to `HexGrid` and `Tile`
2. Create a `GamePersistence` class to save/load
3. Call from `GameScene.didMove()` and app delegate

### Adding Sound Effects
1. Create `SoundManager` class
2. Call from `GameScene.moveInDirection()` and game-over
3. Use `AVAudioPlayer` or `AudioToolbox` framework

## Performance Considerations

### Optimization Strategies

1. **Grid Operations** (O(n) where n=19):
   - All operations process only 19 positions
   - Neighbor finding is O(6) = O(1)
   - No algorithmic bottlenecks at this scale

2. **Node Management**:
   - `HexGridNode` only updates nodes that changed
   - Reuses existing nodes when possible
   - Removes nodes for empty tiles to reduce draw calls

3. **Animation Efficiency**:
   - SpriteKit's `SKAction` runs on GPU
   - Animations are composable and non-blocking
   - Scene continues running during animations

## Testing Strategy

The architecture enables clear unit testing:

```swift
// Test game logic without UI
func testMoveLogic() {
    let grid = HexGrid()
    let moved = grid.move(in: .ne)
    XCTAssertTrue(moved)  // Initial move should always work
}

// Test score calculation
func testScoreTracking() {
    let grid = HexGrid()
    let state = GameState(hexGrid: grid)
    state.move(in: .ne)
    XCTAssertGreaterThan(state.score, 0)
}

// Test game-over detection
func testGameOver() {
    let grid = HexGrid()
    let state = GameState(hexGrid: grid)
    // ... make moves until game over
    XCTAssertTrue(state.isGameOver)
}
```

## Future Architecture Improvements

1. **Entity-Component System**: Use GameplayKit for more complex entities
2. **State Machine**: Implement proper game state management (playing, paused, gameOver)
3. **Input Abstraction**: Create protocol-based input manager for extensibility
4. **Analytics Integration**: Add event tracking without coupling to UI
5. **Dependency Injection**: Constructor injection for better testability
