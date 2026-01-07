import Foundation

/// Represents the 6 cardinal directions on a hex grid in pointy-top orientation.
enum Direction: CaseIterable {
    case ne  // Northeast
    case e   // East
    case se  // Southeast
    case sw  // Southwest
    case w   // West
    case nw  // Northwest
    
    /// Axial coordinate offset for this direction
    var offset: (q: Int, r: Int) {
        switch self {
        case .ne:
            return (1, -1)
        case .e:
            return (1, 0)
        case .se:
            return (0, 1)
        case .sw:
            return (-1, 1)
        case .w:
            return (-1, 0)
        case .nw:
            return (0, -1)
        }
    }
    
    var qOffset: Int { offset.q }
    var rOffset: Int { offset.r }
    
    /// Returns the opposite direction
    var opposite: Direction {
        switch self {
        case .ne:
            return .sw
        case .e:
            return .w
        case .se:
            return .nw
        case .sw:
            return .ne
        case .w:
            return .e
        case .nw:
            return .se
        }
    }
}
