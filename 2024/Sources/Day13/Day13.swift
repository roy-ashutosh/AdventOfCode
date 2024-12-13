import AdventOfCode
import Foundation

struct Day13: AdventDay {
    func part1(input: String) throws -> Int {
        let machines = input.split(separator: "\n\n")
        var result = 0
        for machine in machines {
            let lines = machine.split(separator: "\n")
            let buttonA = lines[0].split(separator: ":")[1].split(separator: ",").map{$0.dropFirst(3)}
            let a = buttonA[0]
            let d = buttonA[1]
            let buttonB = lines[1].split(separator: ":")[1].split(separator: ",").map{$0.dropFirst(3)}
            let b = buttonB[0]
            let e = buttonB[1]
            let prize = lines[2].split(separator: ":")[1].split(separator: ",").map{$0.dropFirst(3)}
            let c = prize[0]
            let f = prize[1]
            
            let test = solveEquations(A: Int(a)!, B: Int(b)!, C: Int(c)!, D: Int(d)!, E: Int(e)!, F: Int(f)!)
            if (test!.x == floor(test!.x)) && (test!.y == floor(test!.y)) {
                result += Int((test!.x * 3) + (test!.y*1))
            }
        }
        return result
    }

    func part2(input: String) throws -> Int {
        let machines = input.split(separator: "\n\n")
        var result = 0
        for machine in machines {
            let lines = machine.split(separator: "\n")
            let buttonA = lines[0].split(separator: ":")[1].split(separator: ",").map{$0.dropFirst(3)}
            let a = buttonA[0]
            let d = buttonA[1]
            let buttonB = lines[1].split(separator: ":")[1].split(separator: ",").map{$0.dropFirst(3)}
            let b = buttonB[0]
            let e = buttonB[1]
            let prize = lines[2].split(separator: ":")[1].split(separator: ",").map{$0.dropFirst(3)}
            let c = prize[0]
            let f = prize[1]
            
            let test = solveEquations(A: Int(a)!, B: Int(b)!, C: Int(c)!+10000000000000, D: Int(d)!, E: Int(e)!, F: Int(f)!+10000000000000)
            if (test!.x == floor(test!.x)) && (test!.y == floor(test!.y)) {
                result += Int((test!.x * 3) + (test!.y*1))
            }
        }
        return result
    }

    func solveEquations(A: Int, B: Int, C: Int, D: Int, E: Int, F: Int) -> (x: Double, y: Double)? {
        var f1 = 0
        var f2 = 0
        for i in A...(A*D) {
            if i%A == 0 && i%D == 0 {
                f1=i/A
                f2=i/D
                break
            }
        }
        let b: Double = (Double(C*f1)-Double(F*f2))/(Double(B*f1)-Double(E*f2))
        let a: Double = Double(C - (B*Int(b)))/Double(A)
        return (a,b)
    }
}
