// https://github.com/PacktPublishing/Swift-Data-Structure-and-Algorithms

public struct Stack<T> {
    private var elements = [T]()
    public init(){}
    public init<S: Sequence>(_ s: S) where S.Iterator.Element == T {
        self.elements = Array(s.reversed())
    } 
    public mutating func push(value: T){
        self.elements.append(value)
    }

    public mutating func pop() -> T {
        return self.elements.popLast()!
    }

    public func isEmpty() -> Bool {
        return self.elements.isEmpty
    }

    public func top() -> T {
        return self.elements.last!
    }

    public var size: Int {
        return self.elements.count
    }
}

extension Stack: CustomStringConvertible, CustomDebugStringConvertible {
    public var description: String {
        return self.elements.description
    }
    public var debugDescription: String {
        return self.elements.debugDescription
    }
    
}