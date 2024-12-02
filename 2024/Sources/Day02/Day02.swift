import AdventOfCode

struct Day02: AdventDay {
    func part1(input: String) throws -> Int {
        let lines = input.split(separator: "\n").map { line in
            line.split(separator: " ")
                .map { Int($0)! }
        }
        var result = 0
        for line in lines {
            if isValid(line: line) {
                result += 1
            }
        }
        return result
    }

    func part2(input: String) throws -> Int {
        let lines = input.split(separator: "\n").map { line in
            line.split(separator: " ")
                .map { Int($0)! }
        }
        var result = 0
        for line in lines {
            for i in 0..<line.count {
                if isValid(line: removeElement(at: i, from: line)) {
                    result += 1
                    break
                }
            }
        }
        return result
    }

    private func isValid(line: [Int]) -> Bool {
        return isCorrectDiff(line: line)  && iscorrectOrder(line: line)
    }

    private func isCorrectDiff(line: [Int]) -> Bool {
        for i in 0..<line.count-1 {
            if abs(line[i]-line[i+1]) > 3 {
                return false
            }
        }
        return true
    }

    private func iscorrectOrder(line: [Int]) -> Bool {
        let isIncreasing = line[1]-line[0] > 0
        for i in 0..<line.count-1 {
            if isIncreasing {
                if line[i]>=line[i+1] {
                    return false
                }
            } else {
                if line[i]<=line[i+1] {
                    return false
                }
            }
        }
        return true
    }

    private func removeElement(at index: Int, from array: [Int]) -> [Int] {
        guard index >= 0 && index < array.count else {
            return array
        }
        let newArray = array.prefix(index) + array.suffix(from: index + 1)
        return Array(newArray)
    }

}
