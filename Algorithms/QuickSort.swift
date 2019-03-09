// https://github.com/bbvch13531/SSU-cse-algorithm/blob/master/quickSort/main.cpp
public func QuickSort<T: Comparable>(_ array: [T], lo: Int, hi: Int) -> [T] {
    var arr = array
    var pi: Int = 0
    var smallerArr = [T](), biggerArr =  [T]()
    if lo < hi {
        pi = partition(&arr, lo: lo, hi: hi);

        smallerArr = QuickSort(arr, lo: lo, hi: pi - 1)
        biggerArr = QuickSort(arr, lo: pi + 1, hi: hi)

        smallerArr.append(arr[pi])
        smallerArr.append(contentsOf: biggerArr)
        
        return smallerArr
    } else if lo == hi {    
        return [arr[lo]]
    }    
    return [T]()
}

func partition<T: Comparable>(_ array: inout [T], lo: Int, hi: Int) -> Int {
    var pivot = array[hi]
    
    var i = lo
    for j in lo..<hi {
        if(array[j] <= pivot) {
            // (array[j], array[i]) = (array[i], array[j])
            array.swapAt(i,j)
            i += 1
        }
    }
    // (array[i], array[hi]) = (array[hi], array[i])
    array.swapAt(i,hi)    
    return i
}