import AdventOfCode

class Day04: AdventDay {
    var lines = [[Character]]()
    func part1(input: String) throws -> Int {
        lines = input
            .split(separator: "\n")
            .map { Array($0) }
        print(lines)
        var result = 0
        for i in 0..<lines.count {
            for j in 0..<lines[i].count {
                guard lines[i][j] == "X" else {continue}
                result += 1
                if vertical(i: i, j: j) {
                    result+=1
                }
                if horizontal(i: i, j: j) {
                    result+=1
                }
                if verticalNeg(i: i, j: j) {
                    result+=1
                }
                if horizontalNeg(i: i, j: j) {
                    result+=1
                }
                if diagnolSE(i: i, j: j) {
                    result+=1
                }
                if diagnolSW(i: i, j: j) {
                    result+=1
                }
                if diagnolNE(i: i, j: j) {
                    result+=1
                }
                if diagnolNW(i: i, j: j) {
                    result+=1
                }
            }
        }
        return result
    }
    
    func vertical(i: Int, j: Int) -> Bool {
        if i+3 < lines.first!.count {
            return lines[i+1][j] == "M" && lines[i+2][j] == "A" && lines[i+3][j] == "S"
        }
        return false
    }
    func horizontal(i: Int, j: Int) -> Bool {
        if j+3 < lines.count {
            return lines[i][j+1] == "M" && lines[i][j+2] == "A" && lines[i][j+3] == "S"
        }
        return false
    }
    func verticalNeg(i: Int, j: Int) -> Bool {
        if i>=3 {
            return lines[i-1][j] == "M" && lines[i-2][j] == "A" && lines[i-3][j] == "S"
        }
        return false
    }
    func horizontalNeg(i: Int, j: Int) -> Bool {
        if j>=3 {
            return lines[i][j-1] == "M" && lines[i][j-2] == "A" && lines[i][j-3] == "S"
        }
        return false
    }
    
    func diagnolSE(i: Int, j: Int) -> Bool {
        if i+3 < lines.first!.count && j+3 < lines.count {
            return lines[i+1][j+1] == "M" && lines[i+2][j+2] == "A" && lines[i+3][j+3] == "S"
        }
        return false
    }
    func diagnolSW(i: Int, j: Int) -> Bool {
        if i+3 < lines.first!.count && j>=3 {
            return lines[i+1][j-1] == "M" && lines[i+2][j-2] == "A" && lines[i+3][j-3] == "S"
        }
        return false
    }
    
    func diagnolNE(i: Int, j: Int) -> Bool {
        if i>=3 && j+3 < lines.count {
            return lines[i-1][j+1] == "M" && lines[i-2][j+2] == "A" && lines[i-3][j+3] == "S"
        }
        return false
    }
    func diagnolNW(i: Int, j: Int) -> Bool {
        if i>=3 && j>=3 {
            return lines[i-1][j-1] == "M" && lines[i-2][j-2] == "A" && lines[i-3][j-3] == "S"
        }
        return false
    }
    
    
    func part2(input: String) throws -> Int {
        lines = input
            .split(separator: "\n")
            .map { Array($0) }
        print(lines)
        var result = 0
        for i in 1..<lines.count-1 {
            for j in 1..<lines[i].count-1 {
                if lines[i][j] == "A" {
                    if ((lines[i-1][j-1] == "M" && lines[i+1][j+1] == "S") || (lines[i-1][j-1] == "S" && lines[i+1][j+1] == "M")) &&
                        ((lines[i+1][j-1] == "M" && lines[i-1][j+1] == "S") || (lines[i+1][j-1] == "S" && lines[i-1][j+1] == "M")) {
                        result+=1
                    }
                }
            }
        }
        return result
    }
}
