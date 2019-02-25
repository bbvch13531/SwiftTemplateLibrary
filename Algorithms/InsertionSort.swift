// https://github.com/raywenderlich/swift-algorithm-club/blob/master/Insertion%20Sort/InsertionSort.swift
// Insertion Sort Algorithm
// - Cimplexity: O(n^2)

// Performs the Insertion sort algorithm to a given array
//
// - Parameter array: the array to be sorted, containing elements that conform to the Comparable protocol

public func insertionSort<T: Comparable>(_ array: [T]) -> [T] {
    guard array.count > 1 else { return array }

    var arr = array
    for x in 1..<arr.count {
        var y = x
        let tmp = arr[y]
        while y > 0 && tmp < arr[y - 1] {
            arr[y] = arr[y - 1]
            y = y - 1
        }
        arr[y] = tmp
    }
    return arr
}

// Performs the Insertion sort algorithm to a given array
//
// - Parameters:
//   - array: the array of elements to be sorted
//   - isOrderedBefore: 
public func insertionSort<T>(_ array: [T], _ isOrderedBefore: (T, T) -> Bool) -> [T] {
    guard array.count > 1 else { return array }

    var arr = array
    for x in 1..<arr.count {
        var y = x
        let tmp = arr[y]
        while y > 0 && isOrderedBefore(tmp, arr[y - 1]) {
            arr[y] = arr[y - 1]
            y = y - 1
        }
        arr[y] = tmp
    }
    return arr
}