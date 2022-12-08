/// The interesting file is this one
import Foundation

resolvePartTwo(Launcher.example)

func resolvePartOne(_ input: [String]) {
    
    let max = findMax(parseMatrix(input))
    
    D.log(D.solution, newlines: true)
    print(max)
}

func resolvePartTwo(_ input: [String]) {
    
    let max = findMaxes(parseMatrix(input))
    
    D.log(D.solution, newlines: true)
    print(max)
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

func findMaxes(_ matrix: [[Int]]) -> Int {
    var max1: Int = 0
    var max2: Int = 0
    var max3: Int = 0
    var currentLineSum: Int = 0
    for line in matrix {
        currentLineSum = line.reduce(0, { $0 + $1 })
        if currentLineSum > max3 {
            max3 = currentLineSum
            if max3 > max2 { // Swap
                let tmp = max2
                max2 = max3
                max3 = tmp
            }
            if max2 > max1 { // Swap
                let tmp = max1
                max1 = max2
                max2 = tmp
            }
        }
    }
    return max1 + max2 + max3
}
