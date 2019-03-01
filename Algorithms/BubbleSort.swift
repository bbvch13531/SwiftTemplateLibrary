public func BubbleSort<T: Comparable>(_ array: [T]) -> [T] {
    var arr = array
    guard arr.count > 1 else { return arr }

    for i in 0..<arr.count {
        for j in 1..<arr.count - i {
            if arr[j] > arr[j+1] {
                let tmp = arr[j] 
                arr[j+1] = arr[j]
                arr[j] = tmp
            }        
        }
    }

    return arr
}