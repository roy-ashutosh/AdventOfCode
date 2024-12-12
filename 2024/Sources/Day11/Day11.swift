import AdventOfCode

struct Day11: AdventDay {
    func part1(input: String) throws -> Int {
        var stones = input.dropLast().split(separator: " ").map {Int($0)!}
        for _ in 1...25 {
            stones = blink(stones: stones)
        }
        return stones.count
    }
    
    func part2(input: String) throws -> Int {
        var stoneMap: [Int:Int] = Dictionary(uniqueKeysWithValues: input.dropLast().split(separator: " ").map { (Int($0)!, 1) })
        for _ in 1...75 {
            var updatedStoneMap = [Int: Int]()
            for stones in stoneMap {
                let newStones = blink(stones: [stones.key])
                for newStone in newStones {
                    if let val = updatedStoneMap[newStone] {
                        updatedStoneMap[newStone] = val+(1*stones.value)
                    } else {
                        updatedStoneMap[newStone] = (1*stones.value)
                    }
                }
            }
            stoneMap = updatedStoneMap
        }
        return stoneMap.reduce(0) { $0 + $1.value }
    }
    
    func blink(stones: [Int]) -> [Int] {
        var stones = stones
        var i = 0
        var len = stones.count
        while i < len {
            if stones[i] == 0 {
                stones[i] = 1
            } else if String(stones[i]).count % 2 == 0 {
                let firstHalf = String(stones[i]).prefix(String(stones[i]).count / 2)
                let secondHalf = String(stones[i]).suffix(String(stones[i]).count / 2)
                stones[i] = Int(firstHalf)!
                stones.insert(Int(secondHalf)!, at: i+1)
                i+=1
            } else {
                stones[i]*=2024
            }
            i+=1
            len = stones.count
        }
        return stones
    }
}
