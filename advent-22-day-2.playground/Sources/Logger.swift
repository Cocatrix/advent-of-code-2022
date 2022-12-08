/// You can ignore this file, it's always the same functions
import Foundation

public enum D {
    
    public static let errorFilePath = "Error - file path"
    public static let errorEmptyInput = "Error - empty input"
    public static let errorGeneric = "Error - generic"
    
    public static let separator = "-----------------"
    public static let solution = "\n\(separator)\nSolution:"
    
    public static func log(_ string: String,
                           newlines: Bool = false,
                           _ debug: Bool = true) {
        let loggedString = newlines ? "\n\(string)\n" : string
        debug
            ? _ = fputs(loggedString, stderr)
            : print(loggedString)
    }

    public static func log(_ int: Int,
                           _ debug: Bool = true) {
        log("\(int)", newlines: true, debug)
    }

    public static func log(_ strings: [String],
                           withQuotes: Bool = false,
                           _ debug: Bool = true) {
        logArray("strings", debug)
        let quote: String = withQuotes ? "\"" : ""
        strings.forEach { log("\(quote)\($0)\(quote) ", debug) }
        logNewline(debug)
    }

    public static func log(_ stringArrays: [[String]],
                           _ debug: Bool = true) {
        logArray("string arrays", debug)
        stringArrays.forEach { log("\($0) ", debug) }
        logNewline(debug)
    }

    public static func log(_ ints: [Int],
                           _ debug: Bool = true) {
        logArray("ints", debug)
        ints.forEach { log("\($0) ", debug) }
        logNewline(debug)
    }

    public static func log(_ intArrays: [[Int]],
                           _ debug: Bool = true) {
        logArray("int arrays", debug)
        intArrays.forEach { log($0, debug)}
        logNewline(debug)
    }
    
}

// MARK: Helpers

private extension D {
    
    static func logArray(_ string: String,
                         _ d: Bool) {
        if d { log("Array of \(string):\n") }
    }
    
    static func logNewline(_ d: Bool) {
        if d { log("\n") }
    }
}

