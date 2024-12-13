import AdventOfCode

struct Day10: AdventDay {
    func part1(input: String) throws -> Int {
        let grid : [[Character]] = input
            .split(separator: "\n")
            .map { Array($0) }
        var result = 0
        var zeroIndexs = [Position]()
        var nineIndexs = [Position]()
        for i in 0..<grid.count {
            for j in 0..<grid.first!.count {
                if grid[i][j] == "0" {
                    zeroIndexs.append(Position(row: i, col: j))
                } else if grid[i][j] == "9" {
                    nineIndexs.append(Position(row: i, col: j))
                }
            }
        }
        for i in 0..<zeroIndexs.count {
            for j in 0..<nineIndexs.count {
                if canReach(from: zeroIndexs[i], to: nineIndexs[j], grid: grid) {
                    result+=1
                }
            }
        }
        return result
    }

    func canReach(from start: Position, to end: Position, grid: [[Character]]) -> Bool {
        let rows = grid.count
        let cols = grid[0].count
        
        // Directions: up, down, left, right
        let directions = [(-1, 0), (1, 0), (0, -1), (0, 1)]
        
        // Queue for BFS
        var queue = [start]
        
        // Set to keep track of visited positions
        var visited = Set<Position>()
        visited.insert(start)
        
        // BFS Loop
        while !queue.isEmpty {
            let currentPosition = queue.removeFirst()
            
            // If we've reached the destination, return true
            if currentPosition.row == end.row && currentPosition.col == end.col {
                return true
            }
            
            // Check all four possible directions
            for (dr, dc) in directions {
                let newRow = currentPosition.row + dr
                let newCol = currentPosition.col + dc
                
                // Check if new position is within bounds and is an increment by 1 in value
                if newRow >= 0, newRow < rows, newCol >= 0, newCol < cols {
                    let currentValue = Int(String(grid[currentPosition.row][currentPosition.col]))
                    let nextValue = Int(String(grid[newRow][newCol]))
                    
                    // Only move to the next cell if it's an increment by 1 (n to n+1)
                    if nextValue == currentValue! + 1 {
                        let newPosition = Position(row: newRow, col: newCol)
                        if !visited.contains(newPosition) {
                            visited.insert(newPosition)
                            queue.append(newPosition)
                        }
                    }
                }
            }
        }
        
        // If no path is found
        return false
    }
    func part2(input: String) throws -> Int {
        let grid : [[Character]] = input
            .split(separator: "\n")
            .map { Array($0) }
        var result = 0
        var zeroIndexs = [Position]()
        var nineIndexs = [Position]()
        for i in 0..<grid.count {
            for j in 0..<grid.first!.count {
                if grid[i][j] == "0" {
                    zeroIndexs.append(Position(row: i, col: j))
                } else if grid[i][j] == "9" {
                    nineIndexs.append(Position(row: i, col: j))
                }
            }
        }
        for i in 0..<zeroIndexs.count {
            var test = 0
            for j in 0..<nineIndexs.count {
                test += possiblePaths(from: zeroIndexs[i], to: nineIndexs[j], grid: grid)
            }
            print(test)
            result+=test

        }
        return result
    }

    func possiblePaths(from start: Position, to end: Position, grid: [[Character]]) -> Int {
        // Directions for moving in the grid (right, left, down, up)
        let directions: [(Int, Int)] = [(0, 1), (0, -1), (1, 0), (-1, 0)]
        
        // Helper function to check if a position is within bounds
        func isValid(_ position: Position) -> Bool {
            return position.row >= 0 && position.row < grid.count &&
                   position.col >= 0 && position.col < grid[0].count
        }
        
        // DFS function to explore paths
        func dfs(_ current: Position, target: Position, currentValue: Int, visited: inout Set<Position>) -> Int {
            // If we've reached the target, return 1 for a valid path
            if current == target {
                return 1
            }
            
            // Mark the current position as visited
            visited.insert(current)
            
            var totalPaths = 0
            
            // Explore all 4 directions (right, left, down, up)
            for direction in directions {
                let newRow = current.row + direction.0
                let newCol = current.col + direction.1
                let newPosition = Position(row: newRow, col: newCol)
                
                if isValid(newPosition) && !visited.contains(newPosition) {
                    // Check if the value in the new cell is greater than currentValue
                    if let currentChar = grid[newRow][newCol].wholeNumberValue,
                       currentChar - currentValue == 1 {
                        // Recursively count the number of valid paths from the new position
                        totalPaths += dfs(newPosition, target: target, currentValue: currentChar, visited: &visited)
                    }
                }
            }
            
            // Unmark the current position for other paths
            visited.remove(current)
            
            return totalPaths
        }
        
        // Initial call to DFS from the starting position with the value of '0'
        var visited: Set<Position> = []
        return dfs(start, target: end, currentValue: 0, visited: &visited)
    }
    struct Position: Hashable {
        let row: Int
        let col: Int
    }
}
