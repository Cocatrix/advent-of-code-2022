/// The interesting file is this one
import Foundation

resolvePartOne(Launcher.example)

func resolvePartOne(_ input: [String]) {
    
    let max = findMax(parseMatrix(input))
    
    D.log(D.solution, newlines: true)
    print(max)
}

func resolvePartTwo(_ input: [String]) {
    
    // TODO: Solve
    
    D.log(D.solution, newlines: true)
    print()
}

func parseMatrix(_ input: [String]) -> [[Int]] {
    var matrix: [[Int]] = []
    var i: Int = 0
    var iExists: Bool = false
    for elt in input {
        if elt == "-" {
            i += 1
            iExists = false
        } else if iExists {
            Int(elt).map { matrix[i].append($0) }
        } else {
            Int(elt).map { matrix.append([$0]) }
            iExists = true
        }
    }
    return matrix

}

func findMax(_ matrix: [[Int]]) -> Int {
    var max: Int = 0
    var currentLineSum: Int = 0
    for line in matrix {
        currentLineSum = line.reduce(0, { $0 + $1 })
        if currentLineSum > max {
            max = currentLineSum
        }
    }
    return max
}
