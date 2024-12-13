import AdventOfCode

class Day05: AdventDay {
    func part1(input: String) throws -> Int {
        var map = [Int: [Int]]()
        let parts = input
            .split(separator: "\n\n")
        let rules = parts[0].split(separator: "\n")
        let updates = parts[1].split(separator: "\n")
        for rule in rules {
            let left = Int(rule.split(separator: "|")[0])!
            let right = Int(rule.split(separator: "|")[1])!
            if let deps = map[left] {
                map[left] = deps + [right]
            } else {
                map[left] = [right]
            }
        }
        var result = 0
        for update in updates {
            let updateArr = update.split(separator: ",").map { Int($0)! }
            var isCorrect = true
            for i in 0..<updateArr.count-1 {
                for j in i+1..<updateArr.count {
                    guard let rul = map[updateArr[i]] else {
                        isCorrect = false
                        break
                    }
                    if !rul.contains(updateArr[j]) {
                        isCorrect = false
                        break
                    }
                }
            }
            if isCorrect {
                result += updateArr[updateArr.count/2]
            }
        }
        return result
    }

    func part2(input: String) throws -> Int {
        var map = [Int: [Int]]()
        let parts = input
            .split(separator: "\n\n")
        let rules = parts[0].split(separator: "\n")
        let updates = parts[1].split(separator: "\n")
        for rule in rules {
            let left = Int(rule.split(separator: "|")[0])!
            let right = Int(rule.split(separator: "|")[1])!
            if let deps = map[left] {
                map[left] = deps + [right]
            } else {
                map[left] = [right]
            }
        }
        var incorrectUpdates = [[Int]]()
        var result = 0
        for update in updates {
            let updateArr = update.split(separator: ",").map { Int($0)! }
            var isCorrect = true
            for i in 0..<updateArr.count-1 {
                for j in i+1..<updateArr.count {
                    guard let rul = map[updateArr[i]] else {
                        isCorrect = false
                        break
                    }
                    if !rul.contains(updateArr[j]) {
                        isCorrect = false
                        break
                    }
                }
            }
            if !isCorrect {
                incorrectUpdates.append(updateArr)
            }
        }
        for incorrectUpdate in incorrectUpdates {
            var incorrectUpdate = incorrectUpdate
            for i in 0..<incorrectUpdate.count-1 {
                for j in i+1..<incorrectUpdate.count {
                    if let rul = map[incorrectUpdate[i]] {
                        if !rul.contains(incorrectUpdate[j]) {
                            let temp = incorrectUpdate[incorrectUpdate.count-1]
                            for k in (i+1...incorrectUpdate.count-1).reversed() {
                                incorrectUpdate[k] = incorrectUpdate[k-1]
                            }
                            incorrectUpdate[i] = temp
                        }
                    } else {
                        let temp = incorrectUpdate[j]
                        for k in j...i+1 {
                            incorrectUpdate[k] = incorrectUpdate[k-1]
                        }
                        incorrectUpdate[i] = temp
                    }
                }
            }
            result += incorrectUpdate[incorrectUpdate.count/2]
        }
        return result
    }
}
