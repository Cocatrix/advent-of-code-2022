/// You can ignore this file, it's always the same functions
import Foundation

// MARK: Parse string

/// Keep lines with `separator: " "` to update the separator easily
public extension String {
    
    var parsingStrings: [String] {
        return split(separator: " ").map { String($0) }
    }

    var parsingInts: [Int] {
        return split(separator: " ").compactMap { Int($0) }
    }

    var parsingTwoInts: (Int, Int) {
        let splitString = split(separator: " ").map { String($0) }
        guard splitString.count > 1 else { return (0, 0) }
        return (Int(splitString[0])!, Int(splitString[1])!)
    }

    var parsingTwoStrings: (String, String) {
        let splitString = split(separator: " ").map { String($0) }
        guard splitString.count > 1 else { return ("", "") }
        return (splitString[0], splitString[1])
    }

    var parsingIntAndString: (Int, String) {
        let splitString = split(separator: " ").map { String($0) }
        guard splitString.count > 1 else { return (0, "") }
        return (Int(splitString[0])!, splitString[1])
    }
    
    var parsingStringAndInt: (String, Int) {
        let splitString = split(separator: " ").map { String($0) }
        guard splitString.count > 1 else { return ("", 0) }
        return (splitString[0], Int(splitString[1])!)
    }
}

// MARK: Parse array string

public extension Array where Element == String {

    var strings: [[String]] {
        return map { $0.parsingStrings }
    }

    var ints: [[Int]] {
        return map { $0.parsingInts }
    }

    var intPairs: [(Int, Int)] {
        return map { $0.parsingTwoInts }
    }

    var stringPairs: [(String, String)] {
        return map { $0.parsingTwoStrings }
    }

    var intAndStringArrays: [(Int, String)] {
        return map { $0.parsingIntAndString }
    }

    var stringAndIntArrays: [(String, Int)] {
        return map { $0.parsingStringAndInt }
    }

}
