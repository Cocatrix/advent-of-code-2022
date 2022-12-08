/// The interesting file is this one
import Foundation

resolvePartOne(Launcher.example)

func resolvePartOne(_ input: [String]) {
    
    let size: Int = input.count
    let forest = parse(input, size: size)
    let hMatrix = createHMatrix(size: size)
    
    let visibleMatrix = computeVisibleTrees(
        forest,
        size: size,
        step: 0,
        maxs: createMaxs(size: size),
        ongoingMatrix: hMatrix
    )
    let nbVisibleTrees = visibleMatrix.nbVisibleTrees
    
    D.log(D.solution, newlines: true)
    print(nbVisibleTrees)
}

func resolvePartTwo(_ input: [String]) {
    
    // TODO: Solve
    
    D.log(D.solution, newlines: true)
    print()
}

func parse(_ input: [String], size: Int) -> [[Int]] {
    var matrix: [[Int]] = []
    for stringLine in input {
        var intLine: [Int] = []
        for char in stringLine {
            intLine.append(Int(String(char)) ?? 0)
        }
        matrix.append(intLine)
    }
    return matrix
}

extension String {
    static let hidden = "H"
    static let visible = "V"
}

func createHMatrix(size: Int) -> [[String]] {
    return [[String]](
        repeating: [String](repeating: String.hidden, count: size),
        count: size
    )
}

typealias Maxs = (lefts: [Int], rights: [Int], tops: [Int], bottoms: [Int])

/// -1 so that a "0" tree on border is visible
func createMaxs(size: Int) -> Maxs {
    return (
        [Int](repeating: -1, count: size),
        [Int](repeating: -1, count: size),
        [Int](repeating: -1, count: size),
        [Int](repeating: -1, count: size)
    )
}

/// Recursive terminal function with `ongoingMatrix` as accumulator
func computeVisibleTrees(
    _ forest: [[Int]],
    size: Int,
    step: Int,
    maxs: Maxs,
    ongoingMatrix: [[String]]
) -> [[String]] {
    guard step < size else {
        return ongoingMatrix
    }
    var resultMatrix = ongoingMatrix
    var (lefts, rights, tops, bottoms) = maxs
    var currentTree: Int
    var currentMax: Int
    
    for i in 0..<size {
        // Check from left
        currentTree = forest[i][step]
        currentMax = lefts[i]
        if currentTree > currentMax {
            lefts[i] = currentTree
            resultMatrix[i][step] = String.visible
        }
        
        // Check from right
        currentTree = forest[i][size-step-1]
        currentMax = rights[i]
        if currentTree > currentMax {
            rights[i] = currentTree
            resultMatrix[i][size-step-1] = String.visible
        }
        
        // Check from top
        currentTree = forest[step][i]
        currentMax = tops[i]
        if currentTree > currentMax {
            tops[i] = currentTree
            resultMatrix[step][i] = String.visible
        }
        
        // Check from bottom
        currentTree = forest[size-step-1][i]
        currentMax = bottoms[i]
        if currentTree > currentMax {
            bottoms[i] = currentTree
            resultMatrix[size-step-1][i] = String.visible
        }
    }
    return computeVisibleTrees(
        forest,
        size: size,
        step: step+1,
        maxs: (lefts, rights, tops, bottoms),
        ongoingMatrix: resultMatrix
    )
}

extension Array where Element == [String] {
    var nbVisibleTrees: Int {
        reduce(0, { $0 + $1.nbVisibleTrees })
    }
}

extension Array where Element == String {
    var nbVisibleTrees: Int {
        filter { $0 == String.visible }.count
    }
}
