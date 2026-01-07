import Foundation

/// Manages the hex grid game logic for a 2048-like game on a 19-tile hex grid
class HexGrid {
    private(set) var tiles: [HexCoordinate: Tile] = [:]
    
    init() {
        // Initialize all positions with empty tiles
        for position in HexCoordinate.allPositions {
            tiles[position] = Tile.empty
        }
        
        // Spawn two initial tiles
        spawnNewTile()
        spawnNewTile()
    }
    
    /// Returns all non-empty tiles
    func getNonEmptyTiles() -> [HexCoordinate: Tile] {
        tiles.filter { !$0.value.isEmpty }
    }
    
    /// Spawns a new tile at a random empty position
    func spawnNewTile() {
        let emptyPositions = HexCoordinate.allPositions.filter { tiles[$0]?.isEmpty ?? true }
        guard let randomPosition = emptyPositions.randomElement() else { return }
        tiles[randomPosition] = Tile.newSpawn()
    }
    
    /// Attempts to move all tiles in a given direction
    /// Returns true if the grid changed, false otherwise
    @discardableResult
    func move(in direction: Direction) -> Bool {
        let oldGrid = tiles
        var newGrid = tiles
        
        // Reset merged flags
        for position in HexCoordinate.allPositions {
            newGrid[position]?.isMergedThisTurn = false
        }
        
        // For each position, try to move the tile in the given direction
        for position in HexCoordinate.allPositions {
            guard !newGrid[position]!.isEmpty else { continue }
            
            // Find the furthest position this tile can move
            var currentPosition = position
            var nextPosition = currentPosition.neighbor(in: direction)
            
            // Keep moving while the next position is empty
            while let next = nextPosition, newGrid[next]!.isEmpty {
                currentPosition = next
                nextPosition = currentPosition.neighbor(in: direction)
            }
            
            // Try to merge if there's a non-empty tile ahead
            if let next = nextPosition,
               !newGrid[next]!.isEmpty,
               newGrid[next]!.value == newGrid[currentPosition]!.value,
               !newGrid[next]!.isMergedThisTurn {
                // Merge
                let mergedValue = newGrid[next]!.value * 2
                newGrid[next] = Tile(value: mergedValue)
                newGrid[next]!.isMergedThisTurn = true
                newGrid[currentPosition] = Tile.empty
            } else if currentPosition != position {
                // Just move
                newGrid[currentPosition] = newGrid[position]!
                newGrid[position] = Tile.empty
            }
        }
        
        tiles = newGrid
        
        // If grid changed, spawn a new tile
        if tiles != oldGrid {
            spawnNewTile()
            return true
        }
        
        return false
    }
    
    /// Checks if any moves are possible
    func hasValidMoves() -> Bool {
        for direction in Direction.allCases {
            let oldGrid = tiles
            _ = move(in: direction)
            let hasMoved = tiles != oldGrid
            tiles = oldGrid
            
            if hasMoved {
                return true
            }
        }
        return false
    }
    
    /// Resets the grid to a new game
    func reset() {
        for position in HexCoordinate.allPositions {
            tiles[position] = Tile.empty
        }
        spawnNewTile()
        spawnNewTile()
    }
}
