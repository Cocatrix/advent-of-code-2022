/// The interesting file is this one
import Foundation

resolvePartTwo(Launcher.example)

func resolvePartOne(_ input: [String]) {
    
    guard let stream = input.first else {
        return
    }
    let solution = getFirstIndex(of: stream, minChars: Int.minDistinctChars)

    D.log(D.solution, newlines: true)
    print(solution)
}

func resolvePartTwo(_ input: [String]) {
    
    guard let stream = input.first else {
        return
    }
    let solution = getFirstIndex(of: stream, minChars: Int.bigMinDistinctChars)

    
    D.log(D.solution, newlines: true)
    print(solution)
}

extension String {
    var hasNoSameChars: Bool {
        guard count > 0 else { return true }
        var copy = self
        let first = copy.removeFirst()
        return !copy.contains(first) && copy.hasNoSameChars
    }
}

extension Int {
    static let minDistinctChars: Int = 4 // for Part 1
    static let bigMinDistinctChars: Int = 14 // for Part 2
}

func getFirstIndex(of stream: String, minChars: Int) -> Int {
    var current: String = ""
    for (i, char) in stream.enumerated() {
        if current.count == minChars {
            current.removeFirst()
        }
        current.append(char)
        if current.count == minChars && current.hasNoSameChars {
            return i + 1
        }
    }
    return -1
}
