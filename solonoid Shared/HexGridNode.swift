import SpriteKit

/// Container node that manages visual representation of all hex tiles on the grid
class HexGridNode: SKNode {
    let hexSize: CGFloat
    private var tileNodes: [HexCoordinate: HexTileNode] = [:]
    
    // Hex-to-screen coordinate conversion constants for pointy-top hexagons
    private let hexWidth: CGFloat
    private let hexHeight: CGFloat
    
    init(hexSize: CGFloat = 30) {
        self.hexSize = hexSize
        
        // For pointy-top hexagons:
        // width = size * sqrt(3)
        // height = size * 2
        self.hexWidth = hexSize * sqrt(3)
        self.hexHeight = hexSize * 2
        
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Converts hex coordinates to screen position
    func hexToScreen(_ hex: HexCoordinate) -> CGPoint {
        let x = hexWidth * (3.0 / 2.0 * CGFloat(hex.q))
        let y = hexHeight * (CGFloat(hex.r) + CGFloat(hex.q) / 2.0) / 2.0
        return CGPoint(x: x, y: -y)  // Negate y for SpriteKit coordinate system
    }
    
    /// Updates the grid display with current game state
    func updateGrid(with hexGrid: HexGrid) {
        let tiles = hexGrid.getNonEmptyTiles()
        
        // Update existing tiles
        for (coordinate, tile) in tiles {
            if let tileNode = tileNodes[coordinate] {
                tileNode.value = tile.value
            } else {
                // Create new tile node
                let tileNode = HexTileNode(at: coordinate, size: hexSize, value: tile.value)
                let screenPos = hexToScreen(coordinate)
                tileNode.position = screenPos
                addChild(tileNode)
                tileNodes[coordinate] = tileNode
                tileNode.animateAppear()
            }
        }
        
        // Remove tiles that are now empty
        for coordinate in tileNodes.keys {
            if hexGrid.tiles[coordinate]?.isEmpty ?? true {
                tileNodes[coordinate]?.removeFromParent()
                tileNodes.removeValue(forKey: coordinate)
            }
        }
    }
    
    /// Animates a tile move from one position to another
    func animateTileMove(from: HexCoordinate, to: HexCoordinate) {
        if let tileNode = tileNodes[from] {
            let toScreenPos = hexToScreen(to)
            tileNode.animateMove(to: toScreenPos)
            
            // Update tileNodes after animation
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                tileNode.coordinate = to
                self.tileNodes.removeValue(forKey: from)
                self.tileNodes[to] = tileNode
            }
        }
    }
}
