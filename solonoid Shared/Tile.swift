import Foundation

/// Represents a tile on the hex grid
struct Tile: Equatable {
    var value: Int  // 0 represents empty
    var isMergedThisTurn: Bool = false
    
    var isEmpty: Bool { value == 0 }
    
    init(value: Int = 0) {
        self.value = value
        self.isMergedThisTurn = false
    }
    
    /// Create an empty tile
    static var empty: Tile {
        Tile(value: 0)
    }
    
    /// Create a new spawned tile (2 or 4)
    static func newSpawn() -> Tile {
        let value = Int.random(in: 0..<10) < 9 ? 2 : 4
        return Tile(value: value)
    }
}
