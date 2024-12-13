import AdventOfCode

enum Dir {
    case up, down, left, right
}
struct Visited: Hashable {
    var i: Int
    var j: Int
}

enum MyError: Error {
    case runtimeError
}

struct Day06: AdventDay {
    func part1(input: String) throws -> Int {
        let originalGrid : [[Character]] = input
            .split(separator: "\n")
            .map { Array($0) }

        var pos: Position = .init(i: 0, j: 0, dir: .up)
        for i in 0..<originalGrid.count {
            for j in 0..<originalGrid[i].count {
                if originalGrid[i][j] == "^" {
                    pos = Position(i: i, j: j, dir: .up)
                }
            }
        }

        return Set(try getPath(start: pos, grid: originalGrid).map{Visited(i: $0.i, j: $0.j)}).count
    }
    
    func getPath(start: Position, grid: [[Character]]) throws -> Set<Position> {
        var pos = start
        var visitedIndexes = Set<Position>()
        visitedIndexes.insert(pos)
        while pos.i>=0 && pos.j>=0 && pos.i<grid.count && pos.j<grid.first!.count {
            let next = pos.next
            guard next.i>=0 && next.j>=0 && next.i<grid.count && next.j<grid.first!.count else { break }
            if grid[next.i][next.j] == "#" {
                pos = pos.right90Degree
            } else {
                pos = next
            }
            if visitedIndexes.contains(pos) {
                throw MyError.runtimeError
            }
            visitedIndexes.insert(pos)
        }
        return visitedIndexes
    }

    func part2(input: String) throws -> Int {
        struct Hurdle: Hashable {
            var i: Int
            var j: Int
        }
        var originalGrid : [[Character]] = input
            .split(separator: "\n")
            .map { Array($0) }
        var pos: Position = .init(i: 0, j: 0, dir: .up)
        for i in 0..<originalGrid.count {
            for j in 0..<originalGrid[i].count {
                if originalGrid[i][j] == "^" {
                    pos = Position(i: i, j: j, dir: .up)
                }
            }
        }
        let startPosition = pos
        var result = 0
        for i in 0..<originalGrid.count {
            for j in 0..<originalGrid.first!.count {
                if startPosition.i == i && startPosition.j == j {
                    continue
                }
                if originalGrid[i][j] == "." {
                    originalGrid[i][j] = "#"
                    if hasloop(startPosition: startPosition, grid: originalGrid) {
                        result+=1
                    }
                    originalGrid[i][j] = "."
                }
            }
        }
        return result
    }
    func hasloop(startPosition: Position, grid : [[Character]]) -> Bool {
        var pos = startPosition
        var visitedIndexes = Set<Position>()
        visitedIndexes.insert(pos)
        while pos.i>=0 && pos.j>=0 && pos.i<grid.count && pos.j<grid.first!.count {
            let next = pos.next
            guard next.i>=0 && next.j>=0 && next.i<grid.count && next.j<grid.first!.count else { break }
            if grid[next.i][next.j] == "#" {
                if grid[pos.right90Degree.i][pos.right90Degree.j] == "#" {
                    pos = pos.back
                } else {
                    pos = pos.right90Degree
                }
            } else {
                pos = next
            }
            if visitedIndexes.contains(pos) {
                return true
            }
            visitedIndexes.insert(pos)
        }
        return false
    }
}

struct Position: Hashable {
    var i: Int
    var j: Int
    var dir: Dir
    var right90Degree: Position {
        switch dir {
        case .up:
            Position(i: i, j: j+1, dir: .right)
        case .down:
            Position(i: i, j: j-1, dir: .left)
        case .left:
            Position(i: i-1, j: j, dir: .up)
        case .right:
            Position(i: i+1, j: j, dir: .down)
        }
    }
    var back: Position {
        switch dir {
        case .up:
            Position(i: i, j: j, dir: .down)
        case .down:
            Position(i: i, j: j, dir: .up)
        case .left:
            Position(i: i, j: j, dir: .right)
        case .right:
            Position(i: i, j: j, dir: .left)
        }
    }
    var next: Position {
        switch dir {
        case .up:
            Position(i: i-1, j: j, dir: dir)
        case .down:
            Position(i: i+1, j: j, dir: dir)
        case .left:
            Position(i: i, j: j-1, dir: dir)
        case .right:
            Position(i: i, j: j+1, dir: dir)
        }
    }
}
