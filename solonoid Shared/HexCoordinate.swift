import Foundation

/// Represents a position on a hexagonal grid using axial coordinates (q, r).
/// This uses the pointy-top hexagon orientation.
struct HexCoordinate: Hashable, Equatable {
    let q: Int
    let r: Int
    
    /// All 19 valid positions in the 3-4-5-4-3 hexagon grid pattern
    static let allPositions: [HexCoordinate] = {
        var positions: [HexCoordinate] = []
        
        // Layer 0 (3 tiles) - bottom row
        positions.append(HexCoordinate(q: -1, r: 2))
        positions.append(HexCoordinate(q: 0, r: 2))
        positions.append(HexCoordinate(q: 1, r: 2))
        
        // Layer 1 (4 tiles)
        positions.append(HexCoordinate(q: -2, r: 1))
        positions.append(HexCoordinate(q: -1, r: 1))
        positions.append(HexCoordinate(q: 0, r: 1))
        positions.append(HexCoordinate(q: 1, r: 1))
        
        // Layer 2 (5 tiles) - middle row
        positions.append(HexCoordinate(q: -2, r: 0))
        positions.append(HexCoordinate(q: -1, r: 0))
        positions.append(HexCoordinate(q: 0, r: 0))
        positions.append(HexCoordinate(q: 1, r: 0))
        positions.append(HexCoordinate(q: 2, r: 0))
        
        // Layer 3 (4 tiles)
        positions.append(HexCoordinate(q: -2, r: -1))
        positions.append(HexCoordinate(q: -1, r: -1))
        positions.append(HexCoordinate(q: 0, r: -1))
        positions.append(HexCoordinate(q: 1, r: -1))
        
        // Layer 4 (3 tiles) - top row
        positions.append(HexCoordinate(q: -1, r: -2))
        positions.append(HexCoordinate(q: 0, r: -2))
        positions.append(HexCoordinate(q: 1, r: -2))
        
        return positions
    }()
    
    /// Returns the distance between two hexagon coordinates
    func distance(to other: HexCoordinate) -> Int {
        (abs(q - other.q) + abs(r - other.r) + abs((q + r) - (other.q + other.r))) / 2
    }
    
    /// Returns all 6 neighboring hex coordinates
    func neighbors() -> [HexCoordinate] {
        let directions = Direction.allCases
        return directions.compactMap { direction in
            let neighbor = HexCoordinate(q: q + direction.qOffset, r: r + direction.rOffset)
            return HexCoordinate.allPositions.contains(neighbor) ? neighbor : nil
        }
    }
    
    /// Returns the neighbor in a specific direction, if it exists on the grid
    func neighbor(in direction: Direction) -> HexCoordinate? {
        let candidate = HexCoordinate(q: q + direction.qOffset, r: r + direction.rOffset)
        return HexCoordinate.allPositions.contains(candidate) ? candidate : nil
    }
}
