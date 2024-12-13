import AdventOfCode
import Foundation

struct Day09: AdventDay {
    func part1(input: String) throws -> Double {
        var block = buildBlock(input: String(input.dropLast()))
        var result: Double = 0
        var end = block.count-1
        var start = 0
        while start<end {
            while block[start].isFile {
                start+=1
            }
            while !block[end].isFile {
                end-=1
            }
            if start<end {
                let temp = block[start]
                block[start] = block[end]
                block[end] = temp
                start+=1
                end-=1
            }
        }
        end = Int(block.firstIndex(where: {!$0.isFile})!)
        for i in 0..<end {
            result += Double(i * (block[i].val!))
        }
        return result
    }

    func buildBlock(input: String) -> [Block] {
        var block = [Block]()
        var isFile = true
        var id = 0
        for char in input {
            for _ in 0..<Int(String(char))! {
                block.append(Block(isFile: isFile, val: isFile ? id : nil))
            }
            if isFile {
                id+=1
            }
            isFile = !isFile
        }
        return block
    }
    func part2(input: String) throws -> Double {
        var segments = buildSegments(input: String(input.dropLast()))
        var i = segments.count-1
        while i > 0{
            if segments[i].isFile && !segments[i].isMoved {
                for j in 0..<i {
                    let segmenti = segments[i]
                    let segmentj = segments[j]
                    if !segmentj.isFile && segmentj.length>=segmenti.length {
                        segments[i].isFile = false
                        segments[i].fileId = 0
                        segments[j].length -= segmenti.length
                        segments.insert(Segment(isFile: true, length: segmenti.length, fileId: segmenti.fileId, isMoved: true), at: j)
                        i+=1
                        break
                    }
                }
            }
            i-=1
        }
        var result: Double = 0
        var ind = 0
        for segment in segments {
            for _ in 0..<segment.length {
                if segment.isFile {
                    result += Double(ind * segment.fileId!)
                }
                ind+=1
            }
        }
        return result
    }
    func buildSegments(input: String) -> [Segment] {
        var segment = [Segment]()
        var isFile = true
        var id = 0
        for char in input {
            if char != "0" {
                segment.append(Segment(isFile: isFile, length: Int(String(char))!, fileId: isFile ? id : nil))
            }
            if isFile {
                id+=1
            }
            isFile = !isFile
        }
        return segment
    }
}
struct Segment {
    var isFile: Bool
    var length: Int
    var fileId: Int?
    var isMoved = false
}

struct Block {
    let isFile: Bool
    let val: Int?
}

extension [Segment] {
    var stringFormat: String {
        var str = ""
        for i in 0..<self.count {
            for _ in 0..<self[i].length {
                if let fileId = self[i].fileId {
                    str.append("\(fileId)")
                } else {
                    str.append(".")
                }
            }
        }
        return str
    }
}
