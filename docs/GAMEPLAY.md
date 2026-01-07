# Gameplay Guide

## Objective

Combine tiles by sliding and merging them on a hexagonal grid. The goal is to keep playing as long as possible and achieve the highest score.

## How to Play

### Controls

Swipe in any of 6 directions to move all tiles:

```
        NW    NE
         ↖ ↗
    W ← [HEX] → E
         ↙ ↘
        SW    SE
```

- **Right (E)**: Swipe to the right
- **Upper-Right (NE)**: Swipe diagonally up-right
- **Upper-Left (NW)**: Swipe diagonally up-left
- **Left (W)**: Swipe to the left
- **Lower-Left (SW)**: Swipe diagonally down-left
- **Lower-Right (SE)**: Swipe diagonally down-right

### Basic Rules

1. **Movement**: All tiles slide in the direction you swipe until they hit the edge or another tile
2. **Merging**: When two tiles with the **same value** touch, they merge into one tile worth their sum
   - 2 + 2 = 4
   - 4 + 4 = 8
   - 8 + 8 = 16
   - And so on...
3. **New Tiles**: After each move, a new tile spawns at a random empty position
   - 90% chance it's a **2**
   - 10% chance it's a **4**
4. **Scoring**: Your score is the sum of all tiles on the board
5. **Game Over**: When no valid moves remain (all tiles are stuck), the game ends

## Strategy Tips

### Early Game (Score 0-100)
- Keep tiles organized and don't let them scatter too much
- Try to build rows of matching values
- Leave empty space to maneuver around high-value tiles

### Mid Game (Score 100-1000)
- Focus on creating chains of merges
- Plan multiple moves ahead when possible
- Try to keep the grid organized with empty space

### Late Game (Score 1000+)
- Space management becomes critical
- Each move should have a purpose
- Think carefully before swiping

### General Tips
1. **Plan Ahead**: Think about what tiles will appear after your move
2. **Corner Strategy**: Work towards corners to consolidate high-value tiles
3. **Avoid Blocking**: Don't trap tiles where you can't merge them
4. **Use Empty Space**: Maintain empty spots to give yourself more options
5. **Watch the Pattern**: The 3-4-5-4-3 hexagon shape creates natural channels

## Game Over

The game ends when no moves are possible. This happens when:
- The board is full of tiles
- No two adjacent tiles have the same value
- No tiles can move in any direction

When the game ends, you'll see your final score. You can tap **Restart** to begin a new game.

## Scoring Examples

### Simple Merge
```
Move right:
[2][2] → [4]
Score increases by 4
```

### Chain Merge
```
Move left:
[2][ ][2][ ][2] → [4][ ][2]
Then move right:
[4][2] → [2][4] (no merge)
```

### Building Larger Numbers
```
Merge 2→4→8→16→32→64→128→256→512→1024→2048
```

## Hex Grid Layout

The playable area is a hexagon with 19 tiles arranged as:

```
       3 tiles
      4 tiles
     5 tiles  (widest row)
      4 tiles
       3 tiles
```

This unique layout creates interesting strategic possibilities different from square-grid puzzle games:
- 6 directions instead of 4
- More ways to approach tile combinations
- Curved edges that affect movement
- Symmetrical gameplay from any angle

## Accessibility

- **Font Size**: Score display is large and readable
- **Color Coding**: Tiles use distinct colors by value
- **Touch Input**: No complex controls, just simple swipes
- **Feedback**: Clear visual feedback for all moves

## Frequently Asked Questions

**Q: Why did my move do nothing?**
A: You likely swiped towards a direction where tiles were already blocked and couldn't move. A move only counts if the board state changes.

**Q: Can I undo a move?**
A: No, each move is permanent. Plan carefully!

**Q: What's the maximum tile value?**
A: Theoretically unlimited! As you merge higher values, you can keep going.

**Q: Does the game get faster?**
A: No, the speed remains constant. It gets harder as more high-value tiles appear and board space fills up.

**Q: Can two different values merge?**
A: No, only tiles with identical values can merge. A 2 can only merge with another 2, not with a 4.
