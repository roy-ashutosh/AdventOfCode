import AdventOfCode

struct Day08: AdventDay {
func part1(input: String) throws -> Int {
    let grid : [[Character]] = input
        .split(separator: "\n")
        .map { Array($0) }
    var dict = [Character: [Position]]()
    for i in 0..<grid.count {
        for j in 0..<grid.first!.count {
            if grid[i][j] != "." {
                if let _ = dict[grid[i][j]] {
                    dict[grid[i][j]]!.append(Position(i: i, j: j))
                } else {
                    dict[grid[i][j]] = [Position(i: i, j: j)]
                }
            }
        }
    }
    var resultPos = Set<Position>()
    for charPos in dict {
        let positions = charPos.value
        for i in 0..<positions.count-1 {
            for j in i+1..<positions.count {
                let firstAD = Position(
                    i: positions[i].i - (positions[j].i - positions[i].i),
                    j: positions[i].j - (positions[j].j - positions[i].j)
                )
                let secondAD = Position(
                    i: positions[j].i + (positions[j].i - positions[i].i),
                    j: positions[j].j + (positions[j].j - positions[i].j)
                )
                if firstAD.i>=0 && firstAD.i<grid.count && firstAD.j>=0 && firstAD.j<grid.count {
                    resultPos.insert(firstAD)
                }
                if secondAD.i>=0 && secondAD.i<grid.count && secondAD.j>=0 && secondAD.j<grid.count {
                    resultPos.insert(secondAD)
                }
            }
        }
    }
    return resultPos.count
}

    struct Position: Hashable {
        let i: Int
        let j: Int
    }
    func areCollinear(p1: Position, p2: Position, p3: Position) -> Bool {
        let lhs = (p2.j - p1.j) * (p3.i - p2.i)
        let rhs = (p3.j - p2.j) * (p2.i - p1.i)
        return lhs == rhs
    }
    func part2(input: String) throws -> Int {
        var grid : [[Character]] = input
            .split(separator: "\n")
            .map { Array($0) }
        var result = 0
        var dict = [Character: [Position]]()
        for i in 0..<grid.count {
            for j in 0..<grid.first!.count {
                if grid[i][j] != "." {
                    if let pos = dict[grid[i][j]] {
                        dict[grid[i][j]]!.append(Position(i: i, j: j))
                    } else {
                        dict[grid[i][j]] = [Position(i: i, j: j)]
                    }
                }
            }
        }
        var resultPos = Set<Position>()
        for charPos in dict {
            let char = charPos.key
            let positions = charPos.value
            for i in 0..<positions.count-1 {
                for j in i+1..<positions.count {
                    for gridi in 0..<grid.count {
                        for gridj in 0..<grid.first!.count {
                            if areCollinear(p1: positions[i], p2: positions[j], p3: Position(i: gridi, j: gridj)) {
                                resultPos.insert(Position(i: gridi, j: gridj))
                            }
                        }
                    }
                }
            }
        }
        return resultPos.count
    }
}
