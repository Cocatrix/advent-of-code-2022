/// [Erratum: Exceptional update] You can ignore this file, it's always the same functions
import Foundation

// MARK: API

public enum Launcher {
    
    public static var example: [String] {
        split(entry: parseEntry("example"))
    }
    
    public static var puzzleInput: [String] {
        split(entry: parseEntry("puzzle_input"))
    }
    
}

// MARK: Helpers

private extension Launcher {

    static func parseEntry(_ fileName: String) -> String {
        guard let fileURL: URL = Bundle.main.url(forResource: fileName, withExtension: "txt") else {
            D.log(D.errorFilePath)
            return ""
        }
        let text: String = (try? String(contentsOf: fileURL)) ?? ""
        return text
    }

    static func split(entry: String) -> [String] {
        // Begin updates
        let updatedEntry = entry.replacingOccurrences(of: "\n\n", with: "\n-\n")
        let result = Array(updatedEntry.components(separatedBy: "\n").dropLast()) // Last line is always an empty line
        // End updates
        guard !result.isEmpty else {
            D.log(D.errorEmptyInput)
            return []
        }
        D.log(result, withQuotes: true)
        D.log("\(D.separator)\n")
        return result
    }
    
}
