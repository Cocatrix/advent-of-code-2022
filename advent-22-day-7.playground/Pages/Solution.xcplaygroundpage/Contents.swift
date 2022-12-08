/// The interesting file is this one
import Foundation

resolvePartOne(Launcher.example)

func resolvePartOne(_ input: [String]) {
    
    let tree = parse(Array(input.dropFirst()))
    let validSums: [Int] = coverWithLimit(tree, validSizes: [])
    let totalSum = validSums.reduce(0, { $0 + $1 })
    
    D.log(D.solution, newlines: true)
    print(totalSum)
}

func resolvePartTwo(_ input: [String]) {
    
    // TODO: Solve
    
    D.log(D.solution, newlines: true)
    print()
}

// MARK: - Special parsing

func parse(_ lines: [String]) -> Tree {
    let rootTree: Tree = Tree(root: "/", parent: nil)
    var currentTree: Tree = rootTree
    for line in lines.strings {
        let firstWord: String = line[0]
        switch firstWord {
            case cmd.dollar:
                guard line[1] == cmd.cd else { continue } // case "ls"
                let thirdWord: String = line[2]
                switch thirdWord {
                    case cmd.goBack:
                        currentTree = currentTree.parent ?? rootTree
                    default:
                        currentTree = currentTree.childTrees.first(where: { $0.root == thirdWord })!
                }
            case cmd.dir:
                currentTree.add(Tree(root: line[1], parent: currentTree))
            default:
                guard let size = Int(firstWord) else { continue }
                currentTree.add(size)
        }
    }
    return rootTree
}

// MARK: - Objects

extension Tree: CustomDebugStringConvertible {
    var debugDescription: String {
        var desc: String = "\"\(root)\"["
        for tree in childTrees {
            desc.append("\(tree) ")
        }
        for file in childFiles {
            desc.append("\(file) ")
        }
        if desc.last == " " { _ = desc.removeLast() }
        desc.append("]")
        return desc
    }
}

class Tree {
    let root: String
    let parent: Tree?
    var childTrees: [Tree]
    var childFiles: [Int]
    
    var computedSize: Int?
    
    var leafSize: Int {
        childFiles.reduce(0, { $0 + $1 })
    }
    
    var isLeaf: Bool {
        childTrees.isEmpty
    }
    
    init(root: String, parent: Tree?) {
        self.root = root
        self.parent = parent
        self.childTrees = []
        self.childFiles = []
    }
    
    func add(_ childTree: Tree) {
        childTrees.append(childTree)
    }
    
    func add(_ childFile: Int) {
        childFiles.append(childFile)
    }
}

enum cmd {
    static let dollar = "$"
    static let dir = "dir"
    static let goBack = ".."
    static let cd = "cd"
    static let ls = "ls"
}

extension Int {
    static let limit = 100000
    static let overLimit = -1
}

// MARK: - Solution

func coverWithLimit(_ tree: Tree, validSizes: [Int]) -> [Int] {
    // DFS - computing leaf sizes then aborting size if exceeding limit
    
    var newSizes: [Int] = validSizes
    // If leaf, just compute or put Int.overLimit
    guard !tree.isLeaf else {
        let leafSize = tree.leafSize
        let isOverLimit = leafSize > Int.limit
        let size = isOverLimit ? Int.overLimit : leafSize
        tree.computedSize = size
        if isOverLimit {
        } else {
            newSizes.append(size)
        }
        return newSizes
    }
    
    // Else cover all children
    for childTree in tree.childTrees {
        if childTree.computedSize == nil {
            newSizes = coverWithLimit(childTree, validSizes: newSizes)
        }
    }
    var size = tree.leafSize
    if size > Int.limit {
        tree.computedSize = Int.overLimit
        return newSizes
    }
    // Add each child tree sum to leaf size
    for childTree in tree.childTrees {
        let childTreeSum: Int = childTree.computedSize!
        if childTreeSum == Int.overLimit {
            tree.computedSize = Int.overLimit
            return newSizes
        } else {
            size += childTreeSum
            if size > Int.limit {
                tree.computedSize = Int.overLimit
                return newSizes
            }
        }
    }
    
    // If we arrive here, tree size is valid
    tree.computedSize = size
    newSizes.append(size)
    return newSizes
}
