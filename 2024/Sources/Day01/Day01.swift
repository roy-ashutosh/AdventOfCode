import AdventOfCode

struct Day01: AdventDay {
    func part1(input: String) throws -> Int {
        let lines = input.split(separator: "\n").map { line in
            line.split(separator: " ")
                .map { Int($0)! }
        }
        let left = lines.map { $0[0] }.sorted()
        let right = lines.map { $0[1] }.sorted()
        return zip(left, right)
            .map { abs($0 - $1) }
            .reduce(0, +)
    }
    
    func part2(input: String) throws -> Int {
        let lines = input.split(separator: "\n").map { line in
            line.split(separator: " ")
                .map { Int($0)! }
        }
        let left = lines.map { $0[0] }.sorted()
        let right = lines.map { $0[1] }.sorted()
        return left.reduce(0) { sum, leftValue in
            let matchingCount = right.count(where: { $0 == leftValue })
            return sum + leftValue * matchingCount
        }
    }
}
