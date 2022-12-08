/// The interesting file is this one
import Foundation

resolvePartOne(Launcher.example)

func resolvePartOne(_ input: [String]) {
    
    let score = computeWholeSet(rounds: input.stringPairs)
    
    D.log(D.solution, newlines: true)
    print(score)
}

func resolvePartTwo(_ input: [String]) {
    
    // TODO: Solve
    
    D.log(D.solution, newlines: true)
    print()
}


enum Shape {
    // What opponent will play
    static let A = "A" // Rock
    static let B = "B" // Paper
    static let C = "C" // Scissors
    
    // What I will play
    static let X = "X" // Rock (1 pt)
    static let Y = "Y" // Paper (2 pts)
    static let Z = "Z" // Scissors (3 pts)
}

enum OppositionScore {
    static let win = 6
    static let draw = 3
    static let loss = 0
}

func getShapeScore(_ shape: String) -> Int {
    switch shape {
        case Shape.X:
            return 1
        case Shape.Y:
            return 2
        case Shape.Z:
            return 3
        default:
            return 0
    }
}

func getOppositionScore(mine: String, theirs: String) -> Int {
    switch theirs {
        case Shape.A:
            switch mine {
                case Shape.X: return OppositionScore.draw
                case Shape.Y: return OppositionScore.win
                case Shape.Z: return OppositionScore.loss
                default: return 0
            }
        case Shape.B:
            switch mine {
                case Shape.X: return OppositionScore.loss
                case Shape.Y: return OppositionScore.draw
                case Shape.Z: return OppositionScore.win
                default: return 0
            }
        case Shape.C:
            switch mine {
                case Shape.X: return OppositionScore.win
                case Shape.Y: return OppositionScore.loss
                case Shape.Z: return OppositionScore.draw
                default: return 0
            }
        default: return 0
    }
}

func computeRoundPoints(mine: String, theirs: String) -> Int {
    return getShapeScore(mine) + getOppositionScore(mine: mine, theirs: theirs)
}

func computeWholeSet(rounds: [(String, String)]) -> Int {
    return rounds.reduce(0, { $0 + computeRoundPoints(mine: $1.1, theirs: $1.0) })
}
