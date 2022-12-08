/// The interesting file is this one
import Foundation

resolvePartOne(Launcher.example)

func resolvePartOne(_ input: [String]) {
    
    let pairs: [SectionPair] = parseSectionPairs(input)
    let containedArray: [Bool] = pairs.map { getWhetherOneSectionIsFullyContainedInOther($0) }
    let containedCount: Int = containedArray.filter { $0 }.count
    
    D.log(D.solution, newlines: true)
    print(containedCount)
}

func resolvePartTwo(_ input: [String]) {
    
    // TODO: Solve
    
    D.log(D.solution, newlines: true)
    print()
}

typealias Section = (begin: Int, end: Int)
typealias SectionPair = (lhs: Section, rhs: Section)

func parseSectionPairs(_ input: [String]) -> [SectionPair] {
    return input
        .map { $0.parsingTwoStrings }
        .map { ($0.0.parsingTwoInts, $0.1.parsingTwoInts) }
}

func getWhetherOneSectionIsFullyContainedInOther(_ pair: SectionPair) -> Bool {
    let rhsIncludedInLhs = (pair.lhs.begin <= pair.rhs.begin) && (pair.lhs.end >= pair.rhs.end)
    let lhsIncludedInRhs = (pair.rhs.begin <= pair.lhs.begin) && (pair.rhs.end >= pair.lhs.end)
    return rhsIncludedInLhs || lhsIncludedInRhs
}
