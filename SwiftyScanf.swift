@discardableResult
func scanf(_ format: String, _ arg: UnsafeMutableRawPointer...) -> Int {
    print(format)
    var buf = readLine()
    while(true){
        // buf나 format의 stream을 다 읽으면 break;

        for i in 0..<format.count {

            // i에서 %를 찾는다.
            // 숫자가 있으면 숫자를 찾는다. (%3d 와 같은 경우)
            // 숫자만큼 width를 읽는다.

            /*
                i : integer
                d or u : decimal digit 'u' for unsigned
                o : octal integer
                x : hexadecimal integer
                f, e, g, a : floating point number
                c : character
                s : string
                p : pointer address
                [character] : scanset
                [^character] : negated scanset
                n : count
                % : character '%' 
            */
            var fc = format[i]

            if(fc == '%')

        }
    }
    return 0
}
var N = 10, K = 20, M = 30;

scanf("%d %d", &N, &K, &M)
// scanf("%d %d", &N, &K)
// 10 20
// N = 10
// K = 20