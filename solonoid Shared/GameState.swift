import Foundation

/// Tracks game state and score
class GameState {
    private(set) var score: Int = 0
    private(set) var moveCount: Int = 0
    private(set) var isGameOver: Bool = false
    
    private var hexGrid: HexGrid
    
    init(hexGrid: HexGrid) {
        self.hexGrid = hexGrid
    }
    
    /// Processes a move in the given direction
    /// Returns true if the move was valid (grid changed)
    func move(in direction: Direction) -> Bool {
        let hadMoveBefore = hexGrid.hasValidMoves()
        let moved = hexGrid.move(in: direction)
        
        if moved {
            updateScore()
            moveCount += 1
        }
        
        // Check if game is over
        if !hexGrid.hasValidMoves() {
            isGameOver = true
        }
        
        return moved
    }
    
    /// Updates score based on current grid state
    private func updateScore() {
        let nonEmptyTiles = hexGrid.getNonEmptyTiles()
        score = nonEmptyTiles.values.reduce(0) { $0 + $1.value }
    }
    
    /// Resets the game
    func reset() {
        score = 0
        moveCount = 0
        isGameOver = false
        hexGrid.reset()
    }
    
    /// Returns reference to the hex grid
    func getHexGrid() -> HexGrid {
        hexGrid
    }
}
