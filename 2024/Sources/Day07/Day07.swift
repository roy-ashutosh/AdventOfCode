import AdventOfCode

struct Day07: AdventDay {
func part1(input: String) throws -> Double {
    solve(input: input, useConcat: false)
}
func part2(input: String) throws -> Double {
    solve(input: input, useConcat: true)
}
func solve(input: String, useConcat: Bool) -> Double {
    let lines = input
        .split(separator: "\n")
    var result: Double = 0
    for line in lines {
        let parts = line.split(separator: ":")
        let expectedOutput = Double(parts[0])!
        let vals = parts[1].split(separator: " ").map{Double($0)!}
        if canCalibrate(vals: vals, to: expectedOutput, useConcat: useConcat) {
            result+=expectedOutput
        }
    }
    return result
}
func canCalibrate(vals: [Double], to output: Double, useConcat: Bool) -> Bool {
    if vals.count == 1 {
        return vals.first == output
    }
    var mulArr = [Double]()
    mulArr.append(vals[0]*vals[1])
    if vals.count>2 {
        mulArr.append(contentsOf: vals[2...vals.count-1])
    }
    var addArr = [Double]()
    addArr.append(vals[0]+vals[1])
    if vals.count>2 {
        addArr.append(contentsOf: vals[2...vals.count-1])
    }
    if useConcat {
        var joinArr = [Double]()
        let join = String(format: "%.0f", vals[0])+String(format: "%.0f", vals[1])
        joinArr.append(Double(join)!)
        if vals.count>2 {
            joinArr.append(contentsOf: vals[2...vals.count-1])
        }
        return canCalibrate(vals: addArr, to: output, useConcat: useConcat) || canCalibrate(vals: mulArr, to: output, useConcat: useConcat) || canCalibrate(vals: joinArr, to: output, useConcat: useConcat)
    } else {
        return canCalibrate(vals: addArr, to: output, useConcat: useConcat) || canCalibrate(vals: mulArr, to: output, useConcat: useConcat)
    }
}
}
