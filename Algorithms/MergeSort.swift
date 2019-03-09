// https://github.com/raywenderlich/swift-algorithm-club/blob/master/Merge%20Sort/MergeSort.swift
// - Complexity: O(n log n)

// Recursively sort
// - Parameter array: the array to be sorted, containing elements that conform to the Comparable protocol
// - Returns : a sorted array.
public func MergeSort<T: Comparable>(_ array: [T]) -> [T] {
    guard array.count > 1 else { return array }

    let mid = array.count / 2

    // Split into two parts
    let left = MergeSort(Array(array[0..<mid]))
    let right = MergeSort(Array(array[mid..<array.count]))

    // Then merge sorted parts
    return merge(leftPile: left, rightPile: right)
}

private func merge<T: Comparable>(leftPile: [T], rightPile: [T]) -> [T] {
    var left = 0
    var right = 0
    var orderedPile: [T] = []

    // When array size is too small, resize it.
    if orderedPile.capacity < leftPile.count + rightPile.count {
        orderedPile.reserveCapacity(leftPile.count + rightPile.count)
    }

    while true {
        guard left < leftPile.endIndex else {
            // End of leftPile
            orderedPile.append(contentsOf: rightPile[right..<rightPile.endIndex])
            break
        }
        guard right < rightPile.endIndex else {
            // End of rightPile
            orderedPile.append(contentsOf: leftPile[left..<leftPile.endIndex])
            break
        }
        // Append smaller one.
        if(leftPile[left] < rightPile[right]) {
            orderedPile.append(leftPile[left])
            left = left + 1
        } else {
            orderedPile.append(rightPile[right])
            right = right + 1
        }
    }
    return orderedPile
}

