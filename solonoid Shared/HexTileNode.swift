import SpriteKit

/// Visual representation of a single hex tile
class HexTileNode: SKShapeNode {
    let size: CGFloat
    var coordinate: HexCoordinate
    var value: Int {
        didSet {
            updateAppearance()
        }
    }
    
    private let valueLabel = SKLabelNode(fontNamed: "Arial-BoldMT")
    private let backgroundNode = SKShapeNode()
    
    init(at coordinate: HexCoordinate, size: CGFloat, value: Int = 0) {
        self.size = size
        self.coordinate = coordinate
        self.value = value
        
        super.init()
        
        // Create background hexagon with semi-transparent white
        backgroundNode.path = createHexagonPath()
        backgroundNode.fillColor = UIColor(white: 1.0, alpha: 0.2)
        backgroundNode.strokeColor = .clear
        backgroundNode.zPosition = -1
        addChild(backgroundNode)
        
        // Create regular hexagon path
        self.path = createHexagonPath()
        self.fillColor = .blue
        self.strokeColor = .white
        self.lineWidth = 3
        
        // Add value label
        valueLabel.fontName = "Arial-BoldMT"
        valueLabel.fontSize = 20
        valueLabel.position = CGPoint.zero
        addChild(valueLabel)
        
        updateAppearance()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Creates a regular hexagon path with pointy-top orientation
    private func createHexagonPath() -> CGPath {
        let path = UIBezierPath()
        
        // Calculate hexagon vertices for pointy-top orientation
        var angles: [CGFloat] = []
        for i in 0..<6 {
            let angle = CGFloat(i) * .pi / 3.0 + .pi / 6.0
            angles.append(angle)
        }
        
        var isFirst = true
        for angle in angles {
            let x = size * cos(angle)
            let y = size * sin(angle)
            let point = CGPoint(x: x, y: y)
            
            if isFirst {
                path.move(to: point)
                isFirst = false
            } else {
                path.addLine(to: point)
            }
        }
        
        path.close()
        return path.cgPath
    }
    
    /// Updates visual appearance based on value
    private func updateAppearance() {
        if value == 0 {
            fillColor = .blue
            strokeColor = .white
            backgroundNode.fillColor = UIColor(white: 1.0, alpha: 0.2)
            valueLabel.text = ""
        } else {
            fillColor = colorForValue(value)
            strokeColor = .white
            lineWidth = 3
            backgroundNode.fillColor = UIColor(white: 1.0, alpha: 0.2)
            valueLabel.text = "\(value)"
            valueLabel.fontColor = .black
        }
    }
    
    /// Returns color based on tile value
    private func colorForValue(_ value: Int) -> UIColor {
        switch value {
        case 2: return UIColor(red: 0.2, green: 0.4, blue: 1.0, alpha: 1)     // Light blue
        case 4: return UIColor(red: 0.1, green: 0.35, blue: 0.9, alpha: 1)    // Medium blue
        case 8: return UIColor(red: 0.0, green: 0.3, blue: 0.8, alpha: 1)     // Darker blue
        case 16: return UIColor(red: 0.0, green: 0.25, blue: 0.7, alpha: 1)   // Even darker
        case 32: return UIColor(red: 0.0, green: 0.2, blue: 0.6, alpha: 1)    // Deep blue
        case 64: return UIColor(red: 0.0, green: 0.15, blue: 0.5, alpha: 1)   // Very deep blue
        case 128: return UIColor(red: 0.0, green: 0.1, blue: 0.4, alpha: 1)   // Navy
        case 256: return UIColor(red: 0.0, green: 0.08, blue: 0.3, alpha: 1)  // Dark navy
        case 512: return UIColor(red: 0.0, green: 0.05, blue: 0.2, alpha: 1)  // Darker navy
        case 1024: return UIColor(red: 0.0, green: 0.0, blue: 0.1, alpha: 1)  // Almost black
        default:
            if value >= 2048 {
                return UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)     // Dark gray
            }
            return .blue
        }
    }
    
    /// Animates the tile appearing/merging
    func animateAppear(duration: TimeInterval = 0.1) {
        self.setScale(0.1)
        let scaleAction = SKAction.scale(to: 1.0, duration: duration)
        scaleAction.timingMode = .easeOut
        self.run(scaleAction)
    }
    
    /// Animates the tile moving to a new position
    func animateMove(to position: CGPoint, duration: TimeInterval = 0.15) {
        let moveAction = SKAction.move(to: position, duration: duration)
        moveAction.timingMode = .easeInEaseOut
        self.run(moveAction)
    }
}
