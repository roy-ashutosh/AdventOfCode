import AdventOfCode
import ArgumentParser
import Foundation

@main
struct Main: AsyncParsableCommand {
    @Option
    var part: String?

    func run() async throws {
        let solver = try Solver<Day03>(bundle: Bundle.module)
        await solver.solve(day: Day03(), part: Part(value: part))
    }
}