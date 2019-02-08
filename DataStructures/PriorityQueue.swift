// Copyright (c) 2015-2017 David Kopec

public struct PriorityQueue<T: Comparable> {
    fileprivate var heap = [T]()
    private let ordered: (T, T) -> Bool
    
    public init(asending: Bool = false, startingValues: [T] = []){
        if asending{
            ordered = {$0 > $1}
        } else {
            ordered = {$0 < $1}
        }

        heap = startingValues
        var i = heap.count / 2 - 1
        while i >= 0{
            sink(i)
            i -= 1
        }
    }
    
    // MARK: count
    // Number of elements in heap
    public var count: Int { return heap.count }


    public var isEmpty: Bool { return heap.isEmpty }

    // MARK: push
    public mutating func push(_ element: T) {
        heap.append(element)
        swim(heap.count - 1)
    }

    // MARK: pop
    // If heap is empty, return nil
    public mutating func pop() -> T? {
        if heap.isEmpty { return nil }
        if heap.count == 1 { return heap.removeFirst() }

        // Consider compatibility with Swift2

        heap.swapAt(0,heap.count - 1)
        let temp = heap.removeLast()
        sink(0)
        return temp
    }

    // MARK: remove
    public mutating func remove(_ item: T) {
        if let index = heap.index(of: item) {
            heap.swapAt(index, heap.count - 1)
            heap.removeLast()
            swim(index)
            sink(index)
        }
    }

    // MARK: removeAll
    public mutating func removeAll(_ item: T) {
        var lastCount = heap.count
        remove(item)
        while(heap.count > lastCount) {
            lastCount = heap.count
            remove(item)
        }
    }

    // MARK: peek
    // If heap is empty, return nil
    public func peek() -> T? {
        return heap.first
    }

    // MARK: clear
    public mutating func clear() {
        heap.removeAll(keepingCapacity: false)
    }

    // MARK: sink
    private mutating func sink(_ index: Int) {
        var index = index
        while 2 * index + 1 < heap.count{
            var j = 2 * index + 1
            if j < (heap.count - 1) && ordered(heap[j], heap[j + 1]) { j += 1 }
            if !ordered(heap[index], heap[j]) { break }

            heap.swapAt(index,j)
            index = j
        }
    }

    // MARK: swim
    private mutating func swim(_ index: Int) {
        var index = index
        while index > 0 && ordered(heap[(index - 1) / 2], heap[index]) {
            heap.swapAt((index - 1) / 2, index)
            index = (index - 1) / 2
        }
    }
}
// MARK: - GeneratorType
extension PriorityQueue: IteratorProtocol {
    public typealias Element = T
    mutating public func next() -> Element? { return pop() }
}

// MARK: - SequenceType
extension PriorityQueue: Sequence {
    public typealias Iterator = PriorityQueue
    public func makeIterator() -> Iterator { return self }
}

// MARKL - CollectionType
extension PriorityQueue: Collection {
    public typealias Index = Int

    public var startIndex: Int {return heap.startIndex}
    public var endIndex: Int {return heap.endIndex}

    public subscript(i:Int) -> T { return heap[i] }

    public func index(after i: PriorityQueue.Index) -> PriorityQueue.Index {
        return heap.index(after: i)
    }
}

extension PriorityQueue: CustomStringConvertible, CustomDebugStringConvertible {
    public var description: String { return heap.description }
    public var debugDescription: String { return heap.debugDescription }
}