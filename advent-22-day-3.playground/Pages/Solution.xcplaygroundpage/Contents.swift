/// The interesting file is this one
import Foundation

resolvePartOne(Launcher.example)

func resolvePartOne(_ input: [String]) {
    
    let splitBags: [(lhs: String, rhs: String)] = splitBags(input)
    let priorities: [Int] = splitBags.map { getPriority($0) }
    let sum: Int = priorities.reduce(0, { $0 + $1 })
    
    D.log(D.solution, newlines: true)
    print(sum)
}

func resolvePartTwo(_ input: [String]) {
    
    // TODO: Solve
    
    D.log(D.solution, newlines: true)
    print()
}

extension Character {
    var priority: Int {
        guard let asciiValue = asciiValue else {
            return 0
        }
        let priority: UInt8 = asciiValue > 95
            ? asciiValue - 96 // a=97 -96=1
            : asciiValue - 38 // A=65 -38=27
        return Int(priority)
    }
}

func splitHalf(bag: String) -> (String, String) {
    let halfIndex = bag.count / 2
    let leftSide = bag.prefix(halfIndex)
    let rightSide = bag.suffix(halfIndex)
    return (String(leftSide), String(rightSide))
}

func findCommonChar(lhs: String, rhs: String) -> Character? {
    return lhs.first(where: { rhs.contains($0) })
}

func splitBags(_ allBags: [String]) -> [(String, String)] {
    return allBags.map { splitHalf(bag: $0) }
}

func getPriority(_ splitBag: (String, String)) -> Int {
    guard let commonChar = findCommonChar(lhs: splitBag.0, rhs: splitBag.1) else {
        return 0
    }
    return commonChar.priority
}
