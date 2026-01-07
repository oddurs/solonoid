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
    
    init(at coordinate: HexCoordinate, size: CGFloat, value: Int = 0) {
        self.size = size
        self.coordinate = coordinate
        self.value = value
        
        super.init()
        
        // Create regular hexagon path
        self.path = createHexagonPath()
        self.fillColor = .clear
        self.strokeColor = .gray
        self.lineWidth = 1
        
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
            fillColor = UIColor(white: 0.95, alpha: 1)
            strokeColor = .lightGray
            valueLabel.text = ""
        } else {
            fillColor = colorForValue(value)
            strokeColor = .darkGray
            lineWidth = 2
            valueLabel.text = "\(value)"
            valueLabel.fontColor = value > 4 ? .white : .black
        }
    }
    
    /// Returns color based on tile value
    private func colorForValue(_ value: Int) -> UIColor {
        switch value {
        case 2: return UIColor(red: 0.93, green: 0.89, blue: 0.85, alpha: 1)
        case 4: return UIColor(red: 0.93, green: 0.88, blue: 0.78, alpha: 1)
        case 8: return UIColor(red: 0.95, green: 0.78, blue: 0.65, alpha: 1)
        case 16: return UIColor(red: 0.96, green: 0.70, blue: 0.50, alpha: 1)
        case 32: return UIColor(red: 0.96, green: 0.58, blue: 0.39, alpha: 1)
        case 64: return UIColor(red: 0.97, green: 0.49, blue: 0.25, alpha: 1)
        case 128: return UIColor(red: 0.93, green: 0.88, blue: 0.45, alpha: 1)
        case 256: return UIColor(red: 0.93, green: 0.86, blue: 0.28, alpha: 1)
        case 512: return UIColor(red: 0.93, green: 0.84, blue: 0.12, alpha: 1)
        case 1024: return UIColor(red: 0.93, green: 0.84, blue: 0.0, alpha: 1)
        default:
            if value >= 2048 {
                return UIColor(red: 0.50, green: 0.13, blue: 0.52, alpha: 1)
            }
            return .gray
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
