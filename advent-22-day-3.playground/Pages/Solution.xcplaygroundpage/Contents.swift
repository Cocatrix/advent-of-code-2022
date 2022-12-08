/// The interesting file is this one
import Foundation

resolvePartTwo(Launcher.example)

func resolvePartOne(_ input: [String]) {
    
    let splitBags: [(lhs: String, rhs: String)] = splitBags(input)
    let priorities: [Int] = splitBags.map { getPriority($0) }
    let sum: Int = priorities.reduce(0, { $0 + $1 })
    
    D.log(D.solution, newlines: true)
    print(sum)
}

func resolvePartTwo(_ input: [String]) {
    
    let splitGroups: [(String, String, String)] = splitGroups(input)
    let priorities: [Int] = splitGroups.map { getPriority($0) }
    let sum: Int = priorities.reduce(0, { $0 + $1 })
    
    
    D.log(D.solution, newlines: true)
    print(sum)
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

func splitGroups(_ allBags: [String]) -> [(String, String, String)] {
    var result: [(String, String, String)] = []
    var b1: String = ""
    var b2: String = ""
    var b3: String = ""
    for bag in allBags {
        if b1 == "" {
            b1 = bag
        } else if b2 == "" {
            b2 = bag
        } else {
            b3 = bag
            result.append((b1, b2, b3))
            b1 = ""
            b2 = ""
            b3 = ""
        }
    }
    return result
}

func findCommonChar(lhs: String, rhs: String) -> Character? {
    return lhs.first(where: { rhs.contains($0) })
}

func findCommonChar(b1: String, b2: String, b3: String) -> Character? {
    return b1.first(where: { b2.contains($0) && b3.contains($0) })
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

func getPriority(_ bags: (String, String, String)) -> Int {
    guard let commonChar = findCommonChar(b1: bags.0, b2: bags.1, b3: bags.2) else {
        return 0
    }
    return commonChar.priority
}
