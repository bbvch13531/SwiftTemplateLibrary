// https://github.com/raywenderlich/swift-algorithm-club/blob/master/Linked%20List/LinkedList.swift

public final class DoubleLinkedList<T> {
    
    public class Node<T> {
        var next: Node<T>?
        var prev: Node<T>?
        var data: T
        init(data: T) {
            self.data = data
        }
    }
    private var _count: Int = 0
    private(set) var head: Node<T>? = nil
    public var last: Node<T>? {
        guard var node = head else {
            return nil
        }
        while let next = node.next {
            node = next
        }
        return node
    }

    public var isEmpty: Bool {
        return head == nil
    }

    public var count: Int {
        return _count
    }
    
    // Dafult initializer
    public init() {}

    // Subscript function
    //
    // - Parameter index: Integer data of the requested index.
    public subscript(index: Int) -> T {
        let node = self.node(at: index)
        return node.data
    }
    
    // Function to return the node at index. Crashes if index is out of bounds (0...self.count)
    //
    // - Parameter index: Integer data of the node's index to be returned
    // - Returns: Node
    public func node(at index: Int) -> Node<T> {
        assert(head != nil, "List is empty")
        assert(index >= 0, "index must be greater equal to 0")

        if index == 0 {
            return head!
        } else {
            var node = head!.next
            for _ in 1..<index {
                node = node?.next
                if node == nil {
                    break
                }
            }

            assert(node != nil, "index is out of bounds.")
            return node!
        }
    }

    // Append a data to the end of the list
    //
    // - Parameter index: The data to be appended.
    public func append(_ data: T) {
        let newNode = Node(data: data)
        append(newNode)
    }
    
    // Append a copy of a Node to the end of the list.
    //
    // - Parameter node: The node containing the data to be appended.
    public func append(_ node: Node<T>) {
        let newNode = node
        if let lastNode = last {
            newNode.prev = lastNode
            lastNode.next = newNode
        } else {
            head = newNode
        }
    }

    // Append a copy of a DoubleLinkedList to the end of the list.
    //
    // - Parameter list: The list to be copied and appended.
    public func append(_ list: DoubleLinkedList) {
        var nodeToCopy = list.head
        while let node = nodeToCopy {
            append(node.data)
            nodeToCopy = node.next
        }
    }
    
    // Insert a data at a index. Crashes if the index is out of bounds(0...self.count)
    //
    // - Parameters:
    //   - data: The data data to be inserted
    //   - index: Integer data of the index to be inserted at
    public func insert(_ data: T, at index: Int) {
        let newNode = Node(data: data)
        insert(newNode, at: index)
    }

    // Insert a copy of a Node. Crashes if the index is out of bounds(0...self.count)
    //
    // - Parameters:
    //   - node: The node containing the data to be inserted
    //   - index: Integer data of the index to be inserted at
    public func insert(_ newNode: Node<T>, at index: Int) {
        if index == 0 {
            newNode.next = head
            head?.prev = newNode
            head = newNode
        } else {
            let prev = node(at: index - 1)
            let next = prev.next

            newNode.prev = prev
            newNode.next = next

            next?.prev = newNode
            prev.next = newNode
        }
    }

    // Insert a copy of a List. Crashes if the index is out of bounds(0...self.count)
    //
    // - Parameters:
    //   - list: The list to be copied and inserted
    //   - index: Integer data of the index to be inserted at
    public func insert(_ list: DoubleLinkedList, at index: Int) {
        guard !list.isEmpty else { return }

        if index == 0 {
            list.last?.next = head
            head = list.head
        } else {
            let prev = node(at: index - 1)
            let next = prev.next

            prev.next = list.head
            next?.prev = list.last

            list.head?.prev = prev
            list.last?.next = next
        }
    }

    // Function to remove all from the list
    public func removeAll() {
        head = nil
    }

    // Function to remove a specific node.
    //
    // - Parameter node: The node to be deleted
    // - Returns: The data contained in the deleted node.
    @discardableResult public func remove(node: Node<T>) -> T {
        let prev = node.prev
        let next = node.next
        
        if let prev = prev {
            prev.next = next
        } else {
            head = next
        }
        next?.prev = prev
        
        node.prev = nil
        node.next = nil
        return node.data
    }

    // Function to remove the last node in the list. Crashed if the list is empty
    //
    // - Returns: The data value contained in the deleted node.
    @discardableResult public func removeLast() -> T {
        assert(!isEmpty)
        return remove(node: last!)
    }

    // Function to remove a node at a specific index.  Crashed if the list is empty
    //
    // - Returns: The data value contained in the deleted node.
    @discardableResult public func remove(at index: Int) -> T {
        let node = self.node(at:index)
        return remove(node: node)
    }
}

//: End of the base class declarations & beginning of extension's decalarations:

// Mark: - Extension to enable the standard conversion of a list to string
extension DoubleLinkedList: CustomStringConvertible, CustomDebugStringConvertible {
    public var description: String {
        var d = "["
        var node = head
        while let n = node {
            d = d + String(describing: n.data)
            node = n.next
            if node != nil {
                d = d + ","
            }
        }
        return d + "]"
    }

    public var debugDescription: String {
        var d = "["
        var node = head
        while let n = node {
            d = d + String(describing: n.data)
            node = n.next
            if node != nil {
                d = d + ","
            }
        }
        return d + "]"
    }
}

// MARK: - Extension to add a 'reverse' function to the list
extension DoubleLinkedList {
    public func reverse() {
        var node = head
        while let curNode = node {
            node = curNode.next
            swap(&curNode.next, &curNode.prev)
            head = curNode
        }
    }
}

// MARK: - Extension with an implementation of 'map' & 'filter' functions
extension DoubleLinkedList {
    public func map<U>(transform: (T) -> U) -> DoubleLinkedList<U> {
        let result = DoubleLinkedList<U>()
        var node = head
        while let nd = node {
            result.append(transform(nd.data))
            node = nd.next
        }
        return result
    }

    public func filter(predicate: (T) -> Bool) -> DoubleLinkedList<T> {
        let result = DoubleLinkedList<T>()
        var node = head
        while let nd = node {
            if predicate(nd.data) {
                result.append(nd.data)
            }
            node = nd.next
        }
        return result
    }
}

// MARK: - Extension to enable initialization from an array.
extension DoubleLinkedList {
    convenience init(array: Array<T>) {
        self.init()
        array.forEach{ append($0) }
    }
}

// MARK: - Collection Index
// Custom index type that contains a reference to the node at index 'tag'

public struct DoubleLinkedListIndex<T>: Comparable {
    fileprivate let node: DoubleLinkedList<T>.Node<T>?
    fileprivate let tag: Int

    public static func==<T>(lhs: DoubleLinkedListIndex<T>, rhs: DoubleLinkedListIndex<T>) -> Bool {
        return (lhs.tag == rhs.tag)
    }

    public static func < <T>(lhs: DoubleLinkedListIndex<T>, rhs: DoubleLinkedListIndex<T>) -> Bool {
        return (lhs.tag < rhs.tag)
    }
}

// MARK: - Collection
extension DoubleLinkedList: Collection {
    public typealias Index = DoubleLinkedListIndex<T>

    // The position of the first element in a nonempty collection.
    //
    // If the collection is emptym 'startIndex' is equal to 'endIndex'.
    // - Complexity: O(1)
    public var startIndex: Index {
        get {
            return DoubleLinkedListIndex<T>(node: head, tag: 0)
        }
    }

    // The collection's "past the end" position---that is, the position one
    // greater than the last valid subscript argument.
    // - Complexity: O(n), where n is the number of elements in the list. This can be improved by keeping a reference
    //   to the last node in the collection.
    public var endIndex: Index {
        get {
            if let h = self.head {
                return DoubleLinkedListIndex<T>(node: h, tag: count)
            } else {
                return DoubleLinkedListIndex<T>(node: nil, tag: startIndex.tag)
            }
        }
    }

    public subscript(position: Index) -> T {
        get {
            return position.node!.data
        }
    }

    public func index(after idx: Index) -> Index {
        return DoubleLinkedListIndex<T>(node: idx.node?.next, tag: idx.tag + 1)
    }
}