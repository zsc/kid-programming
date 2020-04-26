import Foundation

func 互质(m: Int, n: Int) -> Bool {
    if n == 0 || m == 0 || m == n {
        return false
    }
    if n == 1 || m == 1 {
        return true
    }
    if m > n {
        return 互质(m: m % n, n: n)
    } else {
        return 互质(m: n, n: m)
    }
}

func 欧拉函数(m: Int) -> Int {
    var cnt: Int = 0
    for i in 1...m {
        if 互质(m: i, n: m) {
            cnt += 1
        }
    }
    return cnt
}

func 欧拉函数快(m: Int, i0: Int = 2) -> Int {
    if m == 1 {
        return 1
    }
    let limit = Int(floor(sqrt(Double(m))))
    if limit < i0 {
        return m - 1
    }
    for i in i0...limit {
        if m%i == 0 {
            var m2 = m / i
            while m2%i == 0 {
                m2 = m2 / i
            }
            return (m / m2 - m / m2 / i) * 欧拉函数快(m: m2, i0: i+1)
        }
    }
    return m - 1
}

print(互质(m: 7, n: 8))
print(欧拉函数(m: 37 * 31))
print(欧拉函数快(m: 37 * 31))
