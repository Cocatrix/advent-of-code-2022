/// The interesting file is this one
import Foundation

resolvePartTwo(Launcher.example)

func resolvePartOne(_ input: [String]) {
    
    let (crates, moves) = parse(input)
    let solvedCrates = apply(moves: moves, to: crates)
    let solution: String = solvedCrates
        .map { $0.first }
        .reduce("", { "\($0)\($1)" })
    
    D.log(D.solution, newlines: true)
    print(solution)
}

func resolvePartTwo(_ input: [String]) {
    
    let (crates, moves) = parse(input)
    let solvedCrates = apply2(moves: moves, to: crates)
    let solution: String = solvedCrates
        .map { $0.first }
        .reduce("", { "\($0)\($1)" })
    
    D.log(D.solution, newlines: true)
    print(solution)
}

// MARK: - Special parsing

typealias Move = (move: Int, from: Int, to: Int)

extension String {
    static let zero: String = "0"
}

class Stack {
    private var elements: [String] = []
    var isEmpty: Bool { elements.isEmpty }
    var first: String { elements.last ?? String.zero }
    
    func add(_ element: String) {
        guard element != String.zero else { return }
        elements.append(element)
    }
    func removeLast() -> String { elements.removeLast() }
}

extension Stack: CustomDebugStringConvertible {
    var debugDescription: String {
        elements.debugDescription
    }
}

extension String {
    func parseCrates() -> [String] {
        var remainingString: String = String(dropFirst())
        var result: [String] = []
        while true {
            guard !remainingString.isEmpty else {
                return result
            }
            let firstChar = String(remainingString.removeFirst())
            result.append(firstChar == " " ? String.zero : firstChar)
            guard remainingString.count >= 2 else {
                return result
            }
            remainingString.removeFirst(3)
        }
    }
}

extension Array where Element == String {
    func fillWithZeros(upTo size: Int) -> [String] {
        var copy = self
        while copy.count < size {
            copy.append(String.zero)
        }
        return copy
    }
}

func parseSize(in line: String) -> Int {
    return line.parsingInts.last ?? 0
}

func parseCrates(in lines: [String], size: Int) -> [Stack] {
    // Matrix, each letter being filled inside when matching the number below (same column)
    let matrix: [[String]] = lines
        .map { $0.parseCrates() }
        .map { $0.fillWithZeros(upTo: size) }
    var stacks: [Stack] = []
    let nbLines: Int = lines.count
    for i in 0..<size {
        let stack = Stack()
        for j in 0..<nbLines {
            stack.add(matrix[nbLines-j-1][i])
        }
        stacks.append(stack)
    }
    return stacks
}

func parseMoves(in lines: [String]) -> [Move] {
    return lines
        .map { line in
            line.parsingStrings.compactMap { Int($0) }
        }
        .compactMap { line in
            guard line.count >= 2 else { return nil }
            return (line[0], line[1], line[2])
        }
}

func parse(_ input: [String]) -> ([Stack], [Move]) {
    guard let firstMoveLineIndex: Int = input.firstIndex(where: { $0.prefix(4) == "move" }) else {
        D.log(D.errorGeneric)
        return ([], [])
    }
    let size: Int = parseSize(in: input[firstMoveLineIndex - 2])
    
    let cratesStrings = Array(input.prefix(firstMoveLineIndex - 2))
    let crates = parseCrates(in: cratesStrings, size: size)
    let movesStrings = Array(input.suffix(from: firstMoveLineIndex))
    let moves = parseMoves(in: movesStrings)
    return (crates, moves)
}

// MARK: - Solution

extension Array where Element == Stack {
    mutating func apply(move: Move) {
        for _ in 1...move.move {
            self[move.to - 1].add(self[move.from - 1].removeLast())
        }
    }
    
    mutating func apply2(move: Move) {
        var removedCrates: [String] = []
        for _ in 1...move.move {
            removedCrates.append(self[move.from - 1].removeLast())
        }
        for crate in removedCrates.reversed() {
            self[move.to - 1].add(crate)
        }
        
    }
}

func apply(moves: [Move], to crateStack: [Stack]) -> [Stack] {
    var crates = crateStack
    moves.forEach { crates.apply(move: $0) }
    return crates
}

func apply2(moves: [Move], to crateStack: [Stack]) -> [Stack] {
    var crates = crateStack
    moves.forEach { crates.apply2(move: $0) }
    return crates
}
