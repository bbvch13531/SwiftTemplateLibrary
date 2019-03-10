// https://github.com/raywenderlich/swift-algorithm-club/blob/master/Binary%20Search%20Tree/Solution%202/BinarySearchTree.swift
/*
  Binary search tree using value types
  The tree is immutable. Any insertions or deletions will create a new tree.
*/

public enum BinarySearchTree<T: Comparable> {
    case empty
    case leaf(T)
    indirect case node(BinarySearchTree, T, BinarySearchTree)

    /*
        Number of nodes in current subtree.
        Performance: O(n)
    */
    public var count: Int {
        switch self {
            case .empty: return 0
            case .leaf: return 1
            case let .node(left, _, right): return left.count + 1 + right.count
        }
    }

    /*
        Calculates the height of this node, i.e. the distance to the lowest leaf.
        Since this looks at all children of this node.
        Return -1 when tree is empty.
        Performance: O(n) time
    */
    public var height: Int {
        switch self {
            case .empty: return -1
            case .leaf: return 0
            case let .node(left, _, right): return 1 + max(left.height, right.height)
        }
    }

    /*
        Inserts a new element into the tree.
        Performance: O(h) time, h is the height of the tree.
    */
    public func insert(newValue: T) -> BinarySearchTree {
        switch self {
            case .empty: 
                return .leaf(newValue)
            case .leaf(let value):
                if newValue < value {
                    return .node(.leaf(newValue), value, .empty)
                } else {
                    return .node(.empty, value, .leaf(newValue))
                }
            case .node(let left, let value, let right):
            // Is "case let .node(left, y, right):"" possible?
               if newValue < value {
                   return .node(left.insert(newValue), value, right)
               } else {
                   return .node(left, value, right.insert(newValue))
               }
        }
    }

    /*
        Finds the "highest" node with the specified value.
        Performance: runs in O(h) time, h is the height of the tree.
    */
    public func search(x: T) -> BinarySearchTree? {
        switch self {
            case .empty:
                return nil
            case .leaf(let y):
                return (x == y) ? self : nil
            case let .node(left, y, right):
                if x < y {
                    return left.search(x)
                } else if x > y {
                    return right.search(x)
                } else {
                    return self
                }
        }
    }

    public func contains(x: T) -> Bool {
        return search(x) != nil
    }

    /*
        Returns the leftmost descendent.
        Performance: O(h) time.        
    */
    public func minumum() -> BinarySearchTree {
        var node = self
        var prev = node
        while case let .node(next, _, _) = node {
            prev = node
            node = next
        }
        if case .leaf = node {
            return node
        }
        return prev
    }

    /*
        Returns the rightmost descendent.
        Performance: O(h) time.        
    */
    public func maximum() -> BinarySearchTree {
        var node = self
        var prev = node
        while case let .node(_, _, next) = node {
            prev = node
            node = next
        }
        if case .leaf = node {
            return node
        }
        return prev
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