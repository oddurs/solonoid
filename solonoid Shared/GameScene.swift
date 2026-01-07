//
//  GameScene.swift
//  solonoid Shared
//
//  Created by Oddur Sigurdsson on 1/6/26.
//

import SpriteKit

class GameScene: SKScene {
    private var gameState: GameState?
    private var hexGridNode: HexGridNode?
    private var scoreLabel: SKLabelNode?
    private var gameOverOverlay: SKNode?
    private var lastSwipeStart: CGPoint?
    private let minimumSwipeDistance: CGFloat = 30
    
    class func newGameScene() -> GameScene {
        let scene = GameScene()
        scene.scaleMode = .aspectFill
        return scene
    }
    
    override func didMove(to view: SKView) {
        // Set background
        backgroundColor = .black
        
        // Initialize game state and hex grid
        let hexGrid = HexGrid()
        let gameState = GameState(hexGrid: hexGrid)
        self.gameState = gameState
        
        // Create and add hex grid node
        let hexGridNode = HexGridNode(hexSize: 50)
        hexGridNode.position = CGPoint(x: size.width / 2, y: size.height / 2)
        addChild(hexGridNode)
        self.hexGridNode = hexGridNode
        
        // Update initial grid display
        hexGridNode.updateGrid(with: hexGrid)
        
        // Add score label
        let scoreLabel = SKLabelNode(fontNamed: "Arial")
        scoreLabel.fontSize = 32
        scoreLabel.fontColor = .yellow
        scoreLabel.position = CGPoint(x: size.width / 2, y: size.height - 60)
        scoreLabel.text = "Score: 0"
        addChild(scoreLabel)
        self.scoreLabel = scoreLabel
    }
    
    /// Maps swipe angle to hex direction
    /// Hex directions are 60° apart: E (0°), NE (60°), NW (120°), W (180°), SW (240°), SE (300°)
    private func directionFromAngle(_ angle: CGFloat) -> Direction {
        let degrees = (angle * 180 / .pi) + 180  // Convert to 0-360
        let normalized = fmod(degrees + 30, 360)  // Normalize to 0-360 with 30° offset for better zones
        
        switch normalized {
        case 0..<60:
            return .e
        case 60..<120:
            return .ne
        case 120..<180:
            return .nw
        case 180..<240:
            return .w
        case 240..<300:
            return .sw
        default:
            return .se
        }
    }
    
    private func moveInDirection(_ direction: Direction) {
        guard let gameState = gameState, let hexGridNode = hexGridNode else { return }
        
        let moved = gameState.move(in: direction)
        
        if moved {
            // Update visual display
            let hexGrid = gameState.getHexGrid()
            hexGridNode.updateGrid(with: hexGrid)
            
            // Update score
            scoreLabel?.text = "Score: \(gameState.score)"
            
            // Check for game over
            if gameState.isGameOver {
                showGameOverOverlay()
            }
        }
    }
    
    private func showGameOverOverlay() {
        let overlay = SKNode()
        overlay.zPosition = 100
        
        // Semi-transparent background
        let bg = SKShapeNode(rectOf: size)
        bg.fillColor = UIColor(white: 0, alpha: 0.5)
        bg.strokeColor = .clear
        overlay.addChild(bg)
        
        // Game Over text
        let gameOverText = SKLabelNode(fontNamed: "Arial-BoldMT")
        gameOverText.fontSize = 48
        gameOverText.fontColor = .white
        gameOverText.text = "Game Over"
        gameOverText.position = CGPoint(x: size.width / 2, y: size.height / 2 + 50)
        overlay.addChild(gameOverText)
        
        // Final score
        let scoreText = SKLabelNode(fontNamed: "Arial")
        scoreText.fontSize = 24
        scoreText.fontColor = .white
        scoreText.text = "Final Score: \(gameState?.score ?? 0)"
        scoreText.position = CGPoint(x: size.width / 2, y: size.height / 2)
        overlay.addChild(scoreText)
        
        // Restart button
        let restartButton = SKShapeNode(rectOf: CGSize(width: 150, height: 50), cornerRadius: 5)
        restartButton.fillColor = .blue
        restartButton.strokeColor = .darkGray
        restartButton.position = CGPoint(x: size.width / 2, y: size.height / 2 - 50)
        restartButton.name = "restartButton"
        overlay.addChild(restartButton)
        
        let restartText = SKLabelNode(fontNamed: "Arial")
        restartText.fontSize = 18
        restartText.fontColor = .white
        restartText.text = "Restart"
        restartText.position = restartButton.position
        overlay.addChild(restartText)
        
        addChild(overlay)
        gameOverOverlay = overlay
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        
        let location = touch.location(in: self)
        
        // Check if restart button was tapped
        if let overlay = gameOverOverlay {
            let nodes = nodes(at: location)
            if nodes.contains(where: { $0.name == "restartButton" }) {
                restartGame()
                return
            }
        }
        
        lastSwipeStart = location
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Optional: could provide haptic feedback or other feedback
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first, let start = lastSwipeStart else { return }
        
        let end = touch.location(in: self)
        let delta = CGPoint(x: end.x - start.x, y: end.y - start.y)
        let distance = sqrt(delta.x * delta.x + delta.y * delta.y)
        
        // Only process if swipe distance is significant
        if distance > minimumSwipeDistance {
            let angle = atan2(delta.y, delta.x)
            let direction = directionFromAngle(angle)
            moveInDirection(direction)
        }
        
        lastSwipeStart = nil
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        lastSwipeStart = nil
    }
    
    private func restartGame() {
        gameOverOverlay?.removeFromParent()
        gameOverOverlay = nil
        
        gameState?.reset()
        scoreLabel?.text = "Score: 0"
        
        if let gameState = gameState, let hexGridNode = hexGridNode {
            hexGridNode.updateGrid(with: gameState.getHexGrid())
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}

