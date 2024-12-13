import AdventOfCode

struct Day03: AdventDay {
    func part1(input: String) throws -> Int {
        var result = 0
        for i in 0..<input.count-3 {
            if input[i] == "m" && input[i+1] == "u" && input[i+2] == "l" && input[i+3] == "(" {
                var j = i+4
                var firstNum = 0
                while Character(input[j]).isNumber {
                    firstNum = firstNum*10 + Int(input[j])!
                    j+=1
                }
                guard firstNum > 0 else {
                    continue
                }
                guard input[j] == "," else {
                    continue
                }
                j+=1
                var secondNum = 0
                while Character(input[j]).isNumber {
                    secondNum = secondNum*10 + Int(input[j])!
                    j+=1
                }
                guard secondNum > 0 else {
                    continue
                }
                guard input[j] == ")" else {
                    continue
                }
                result+=firstNum*secondNum
            }
        }
        return result
    }
    
    func part2(input: String) throws -> Int {
        var result = 0
        var enabled = true
        for i in 0..<input.count-7 {
            let startIndex = input.index(input.startIndex, offsetBy: i)
            let doendIndex = input.index(input.startIndex, offsetBy: i+3)
            let dontendIndex = input.index(input.startIndex, offsetBy: i+6)
            
            if String(input[startIndex...doendIndex]) == "do()" {
                enabled = true
                continue
            } else if String(input[startIndex...dontendIndex]) == "don't()" {
                enabled = false
                continue
            }
            
            if input[i] == "m" && input[i+1] == "u" && input[i+2] == "l" && input[i+3] == "(" {
                guard enabled else {
                    print("dont")
                    continue
                }
                var j = i+4
                var firstNum = 0
                while Character(input[j]).isNumber {
                    firstNum = firstNum*10 + Int(input[j])!
                    j+=1
                }
                guard firstNum > 0 else {
                    continue
                }
                guard input[j] == "," else {
                    continue
                }
                j+=1
                var secondNum = 0
                while Character(input[j]).isNumber {
                    secondNum = secondNum*10 + Int(input[j])!
                    j+=1
                }
                guard secondNum > 0 else {
                    continue
                }
                guard input[j] == ")" else {
                    continue
                }
                result+=firstNum*secondNum
            }
        }
        return result
    }
}

extension String {
    subscript(i: Int) -> String {
        return String(self[index(startIndex, offsetBy: i)])
    }
}
