import AdventOfCode

struct Day12: AdventDay {
    func part1(input: String) throws -> Int {
        var orggrid : [[Character]] = input
            .split(separator: "\n")
            .map { Array($0) }
        var grid  = orggrid.map({ line in
            line.map { ch in
                "\(ch)"
            }
        })
        var val = 0
        var result = 0
        for i in 0..<grid.count {
            for j in 0..<grid.first!.count {
                if let test = Int(grid[i][j]) {
//                    print(test)
                } else {
                    var perimeter = 0
                    var visited = Set<Position>()
                    let indices = getSurroundingIndicesWithSameValue(row: i, col: j, targetValue: grid[i][j], visited: &visited)
                    for index in indices {
                        if index.0>0 {
                            if orggrid[index.0-1][index.1] != orggrid[index.0][index.1] {
                                perimeter+=1
                            }
                        } else {
                            perimeter+=1
                        }
                        if index.1>0 {
                            if orggrid[index.0][index.1-1] != orggrid[index.0][index.1] {
                                perimeter+=1
                            }
                        } else {
                            perimeter+=1
                        }
                        if index.0<orggrid.count-1 {
                            if orggrid[index.0+1][index.1] != orggrid[index.0][index.1] {
                                perimeter+=1
                            }
                        } else {
                            perimeter+=1
                        }
                        if index.1<orggrid.first!.count-1 {
                            if orggrid[index.0][index.1+1] != orggrid[index.0][index.1] {
                                perimeter+=1
                            }
                        } else {
                            perimeter+=1
                        }
                    }
                    for index in indices {
                        grid[index.0][index.1] = "\(val)"
                    }
                    val+=1
                    result += indices.count * perimeter
                    print("\(indices.count) * \(perimeter)")
                }
            }
        }
        return result

        func getSurroundingIndicesWithSameValue(row: Int, col: Int, targetValue: String, visited: inout Set<Position>) -> [(Int, Int)] {
            // If the current position is out of bounds or already visited, return empty array
            if row < 0 || row >= grid.count || col < 0 || col >= grid[0].count || visited.contains(Position(i: row, j: col)) {
                return []
            }

            // If the value at the current cell is not equal to the target value, return empty array
            if grid[row][col] != targetValue {
                return []
            }

            // Mark this position as visited
            visited.insert(Position(i: row, j: col))

            // Directions to check: up, down, left, right
            let directions: [(Int, Int)] = [(-1, 0), (1, 0), (0, -1), (0, 1)]

            var result: [(Int, Int)] = [(row, col)] // Start with the current position

            // Recursively check each direction
            for (dr, dc) in directions {
                let newRow = row + dr
                let newCol = col + dc

                // Get the surrounding indices recursively
                result += getSurroundingIndicesWithSameValue(row: newRow, col: newCol, targetValue: targetValue, visited: &visited)
            }

            return result
        }
    }

    struct Position: Hashable {
        let i: Int
        let j: Int
    }

    func test(grid : [[Character]]) {
//        var regions: [Int: ]
        for line in grid {
            for elem in line {
                if elem.isNumber {
                    
                }
            }
        }
    }

    func part2(input: String) throws -> Int {
        var orggrid : [[Character]] = input
            .split(separator: "\n")
            .map { Array($0) }
        var grid  = orggrid.map({ line in
            line.map { ch in
                "\(ch)"
            }
        })
        var val = 0
        var result = 0
        for i in 0..<grid.count {
            for j in 0..<grid.first!.count {
                if let test = Int(grid[i][j]) {
//                    print(test)
                } else {
                    var perimeter = 0
                    var visited = Set<Position>()
                    let indices = getSurroundingIndicesWithSameValue(row: i, col: j, targetValue: grid[i][j], visited: &visited)
                    for index in indices {
                        let tt = numberOfEdges(pos: Position(i: index.0, j: index.1))
                        print("\(index.0),\(index.1) edges = \(tt)")
                        perimeter += tt
                    }
                    for index in indices {
                        grid[index.0][index.1] = "\(val)"
                    }
                    val+=1
                    result += indices.count * perimeter
                    print("\(indices.count) * \(perimeter)")
                }
            }
        }
        return result

        func numberOfEdges(pos: Position) -> Int {
            //has same char in more than 2 direction -> 0 edge
            let neighs = getneigh(pos: pos)
            if neighs.count == 0 {
                return 4
            } else if neighs.count == 1 {
                return 2
            } else if neighs.count == 2 {
                if abs(neighs[0].i - neighs[1].i) == 2 || abs(neighs[0].j - neighs[1].j) == 2 {
                    return 0
                } else {
                    let fourthPos = Position(
                        i: pos.i == neighs[0].i ? neighs[1].i : neighs[0].i,
                        j: pos.j == neighs[0].j ? neighs[1].j : neighs[0].j
                    )
                    return grid[fourthPos.i][fourthPos.j] == grid[pos.i][pos.j] ? 1 : 2
                }
            } else if neighs.count == 3 {
                var add = 0
                if neighs[0].i == neighs[1].i || neighs[0].j == neighs[1].j {
                    let fourthPos1 = Position(
                        i: pos.i == neighs[0].i ? neighs[2].i : neighs[0].i,
                        j: pos.j == neighs[0].j ? neighs[2].j : neighs[0].j
                    )
                    add += grid[fourthPos1.i][fourthPos1.j] == grid[pos.i][pos.j] ? 0 : 1
                    let fourthPos2 = Position(
                        i: pos.i == neighs[1].i ? neighs[2].i : neighs[1].i,
                        j: pos.j == neighs[1].j ? neighs[2].j : neighs[1].j
                    )
                    add += grid[fourthPos2.i][fourthPos2.j] == grid[pos.i][pos.j] ? 0 : 1
                } else if neighs[0].i == neighs[2].i || neighs[0].j == neighs[2].j {
                    let fourthPos1 = Position(
                        i: pos.i == neighs[0].i ? neighs[1].i : neighs[0].i,
                        j: pos.j == neighs[0].j ? neighs[1].j : neighs[0].j
                    )
                    add += grid[fourthPos1.i][fourthPos1.j] == grid[pos.i][pos.j] ? 0 : 1
                    let fourthPos2 = Position(
                        i: pos.i == neighs[2].i ? neighs[1].i : neighs[2].i,
                        j: pos.j == neighs[2].j ? neighs[1].j : neighs[2].j
                    )
                    add += grid[fourthPos2.i][fourthPos2.j] == grid[pos.i][pos.j] ? 0 : 1
                } else {
                    let fourthPos1 = Position(
                        i: pos.i == neighs[1].i ? neighs[0].i : neighs[1].i,
                        j: pos.j == neighs[1].j ? neighs[0].j : neighs[1].j
                    )
                    add += grid[fourthPos1.i][fourthPos1.j] == grid[pos.i][pos.j] ? 0 : 1
                    let fourthPos2 = Position(
                        i: pos.i == neighs[2].i ? neighs[0].i : neighs[2].i,
                        j: pos.j == neighs[2].j ? neighs[0].j : neighs[2].j
                    )
                    add += grid[fourthPos2.i][fourthPos2.j] == grid[pos.i][pos.j] ? 0 : 1
                }
                return add
            } else {
                var add = 0
                for neigh in neighs {
                    if neigh.i == pos.i {
                        if neigh.j > pos.j {
                            add += grid[neigh.i-1][neigh.j] == grid[pos.i][pos.j] ? 0 : 1
                            add += grid[neigh.i+1][neigh.j] == grid[pos.i][pos.j] ? 0 : 1
                        } else {
                            add += grid[neigh.i-1][neigh.j] == grid[pos.i][pos.j] ? 0 : 1
                            add += grid[neigh.i+1][neigh.j] == grid[pos.i][pos.j] ? 0 : 1
                        }
                    }
                }
                return add
            }
        }
        func getneigh(pos: Position) -> [Position] {
            var neighs = [Position]()
            if hasSameChar(firstPos: pos, secondPos: Position(i: pos.i-1, j: pos.j)) {
                neighs.append(Position(i: pos.i-1, j: pos.j))
            }
            if hasSameChar(firstPos: pos, secondPos: Position(i: pos.i+1, j: pos.j)) {
                neighs.append(Position(i: pos.i+1, j: pos.j))
            }
            if hasSameChar(firstPos: pos, secondPos: Position(i: pos.i, j: pos.j-1)) {
                neighs.append(Position(i: pos.i, j: pos.j-1))
            }
            if hasSameChar(firstPos: pos, secondPos: Position(i: pos.i, j: pos.j+1)) {
                neighs.append(Position(i: pos.i, j: pos.j+1))
            }
            return neighs
        }

        func hasSameChar(firstPos: Position, secondPos: Position) -> Bool {
            if secondPos.i < 0 || secondPos.j < 0 || firstPos.i < 0 || firstPos.j < 0{
                return false
            }
            if secondPos.i == grid.count || secondPos.j == grid.count || firstPos.i == grid.count || firstPos.j == grid.count {
                return false
            }
            return grid[firstPos.i][firstPos.j] == grid[secondPos.i][secondPos.j]
        }
        func getSurroundingIndicesWithSameValue(row: Int, col: Int, targetValue: String, visited: inout Set<Position>) -> [(Int, Int)] {
            // If the current position is out of bounds or already visited, return empty array
            if row < 0 || row >= grid.count || col < 0 || col >= grid[0].count || visited.contains(Position(i: row, j: col)) {
                return []
            }

            // If the value at the current cell is not equal to the target value, return empty array
            if grid[row][col] != targetValue {
                return []
            }

            // Mark this position as visited
            visited.insert(Position(i: row, j: col))

            // Directions to check: up, down, left, right
            let directions: [(Int, Int)] = [(-1, 0), (1, 0), (0, -1), (0, 1)]

            var result: [(Int, Int)] = [(row, col)] // Start with the current position

            // Recursively check each direction
            for (dr, dc) in directions {
                let newRow = row + dr
                let newCol = col + dc

                // Get the surrounding indices recursively
                result += getSurroundingIndicesWithSameValue(row: newRow, col: newCol, targetValue: targetValue, visited: &visited)
            }

            return result
        }
    }
}
