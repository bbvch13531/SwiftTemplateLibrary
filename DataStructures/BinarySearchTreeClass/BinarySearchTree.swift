// https://github.com/raywenderlich/swift-algorithm-club/blob/master/Binary%20Search%20Tree/Solution%201/BinarySearchTree.playground/Sources/BinarySearchTree.swift

/*
    Binary search tree as a class
*/

public class BinarySearchTree<T: Comparable> {
    fileprivate(set) public var value: T
    fileprivate(set) public var parent: BinarySearchTree?
    fileprivate(set) public var left: BinarySearchTree?
    fileprivate(set) public var right: BinarySearchTree?
    
    public init(value: T) {
        self.value = value        
    }

    public convenience init(array: [T]) {
        precondition(array.count > 0)
        self.init(value: array.first!)
        for v in array.dropFirst() {
            insert(value: v)
        }
    }

    public var isRoot: Bool {
        return parent == nil
    }

    public var isLeaf: Bool {
        return left == nil && right == nil
    }

    public var isLeftChild: Bool {
        guard let left = parent?.left else {
            return false
        }
        return left == self        
    }

    public var isRightChild: Bool {
        guard let right = parent?.right else {
            return false
        }
        return right == self
    }

    public var hasLeftChild: Bool {
        return left != nil
    }

    public var hasRightChild: Bool {
        return right != nil
    }

    public var hasAnyChild: Bool {
        return hasLeftChild || hasRightChild
    }

    public var hasBothChildren: Bool {
        return hasLeftChild && hasRightChild
    }

    public var count: Int {
        return (left?.count ?? 0) + 1 + (right?.count ?? 0)
    }
}

// MARK: - Adding item
extension BinarySearchTree {
    /*
        Insert new element in tree.
    */

    public func insert(value: T) {
        if value < self.value {
            if let left = left {
                left.insert(value: value)
            } else {
                left = BinarySearchTree(value: value)                
                left?.parent = self
            }
        } else {
            if let right = right {
                right.insert(value: value)
            } else {
                right = BinarySearchTree(value: value)
                right?.parent = self
            }
        }
    }
}

// MARK: - Deleting item
extension BinarySearchTree {
    /*
        Insert new element in tree.
    */
    @discardableResult public func remove() -> BinarySearchTree? {
        let replacement: BinarySearchTree?

        if let right = right {
            replacement = right.minimum()            
        } else if let left = left {
            replacement = left.maximum()
        } else {
            replacement = nil
        }
        replacement?.remove()

        // Place the replacement to current node's position
        replacement?.right = right
        replacement?.left = left
        right?.parent = replacement
        left?.parent = replacement

        // Connect replacement to current node's parent
        reconnectParentTo(node: replacement)

        // Clean up current node
        parent = nil
        left = nil
        right = nil

        return replacement
    }

    private func reconnectParentTo(node: BinarySearchTree?) {
        if let parent = parent {
            if isLeftChild {
                parent.left = node
            } else {
                parent.right = node
            }
        }
        node?.parent = parent
    }
}

// MARK: - Searching
extension BinarySearchTree {
    /*
        Find the "highest" node with the specified value.
        Performance: runs in O(h) time, h is the height of the tree.
    */
    public func search(value: T) -> BinarySearchTree? {
        var node: BinarySearchTree? = self
        while let n = node {
            if value < n.value {
                node = n.left
            } else if value > n.value {
                node = n.right
            } else {
                return node
            }
        }
        return nil
    }

    public func contains(value: T) -> Bool {
        return search(value: value) != nil
    }

    /*
        Returns the leftmost descendent. 
        Performance: O(h) time
    */
    public func minimum() -> BinarySearchTree {
        var node = self
        while let next = node.left {
            node = next
        }
        return node
    }

    /*
        Returns the righttmost descendent. 
        Performance: O(h) time
    */
    public func maximum() -> BinarySearchTree {
        var node = self
        while let next = node.right {
            node = next
        }
        return node
    }

    /*
        Calculates the depth of this node, i.e. the distance to the root.
        Depth of the root is 0
        Performance: O(h) time
    */
    public func depth() -> Int {
        var node = self
        var edges = 0
        while let parent = node.parent {
            node = parent
            edges += 1
        }
        return edges
    }

    /*
        Calculates the height of this node, i.e. the distance to the lowest leaf.
        Since this looks at all children of this node, 
        Performance: O(n) time
    */
    public func height() -> Int {
        if isLeaf {
            return 0
        } else {
            return 1 + max(left?.height() ?? 0, right?.height() ?? 0)
        }
    }

    /*
        Make issue and working...
    
    public func predecessor() -> BinarySearchTree? {

    }
    public func successor() -> BinarySearchTree? {

    }
    */
}

// MARK: - Traversal
extension BinarySearchTree {
    /*
        InOrder traverse
    */
    public func traverseInOrder(process: (T) -> Void) {
        left?.traverseInOrder(process: process)
        process(value)
        right?.traverseInOrder(process: process)
    }

    /*
        PreOrder traverse
    */
    public func traversePreOrder(process: (T) -> Void) {
        process(value)
        left?.traversePreOrder(process: process)
        right?.traversePreOrder(process: process)
    }

    /*
        PostOrder traverse
    */
    public func traversePostOrder(process: (T) -> Void) {
        left?.traversePostOrder(process: process)
        right?.traversePostOrder(process: process)
        process(value)
    }

    /*
        Performs an in-order traversal and collects the results in an array.
    */
    public func map(formula: (T) -> T) -> [T] {
        var a = [T]()
        if let left = left {
            a += left.map(formula: formula)
        }
        a.append(formula(value))
        if let right = right {
            a += right.map(formula: formula)
        }
        return a
    }
}

// MARK: - Debugging
extension BinarySearchTree: CustomStringConvertible, CustomDebugStringConvertible {
    public var description: String {
        var s = ""
        if let left = left {
            s += "(\(left.description)) <-"
        }
        s += "\(value)"
        if let right = right {
            s += "(\(right.description)) <-"
        }
        return s
    }

    public var debugDescription: String {
        var s = ""
        if let left = left {
            s += "(\(left.description)) <-"
        }
        s += "\(value)"
        if let right = right {
            s += "(\(right.description)) <-"
        }
        return s
    }
}

// MARK: - override "=="
extension BinarySearchTree: Equatable  {
    public static func == (lhs: BinarySearchTree, rhs: BinarySearchTree) -> Bool {
        return 
            lhs.parent == rhs.parent &&
            lhs.value == rhs.value &&
            lhs.left == rhs.left &&
            lhs.right == lhs.right
    }
}