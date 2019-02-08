public struct Queue<T>: ExpressibleByArrayLiteral {
    public private(set) var elements: Array<T> = []
    public mutating func push(value: T){
        self.elements.append(value)
    }
    public mutating func pop() -> T {
        return self.elements.removeFirst()
    }
    public func isEmpty() -> Bool {
        return self.elements.isEmpty
    }
    public var size: Int {
        return self.elements.count
    }
    public mutating func back() -> T {
        return self.elements.last!
    }
    public mutating func front() -> T {
        return self.elements.first!
    }
    public init(arrayLiteral elements: T...){
        self.elements = elements
    }
}

extension Queue: CustomStringConvertible, CustomDebugStringConvertible {
    public var description: String {
        return self.elements.description
    }
    public var debugDescription: String {
        return self.elements.debugDescription
    }
    
}