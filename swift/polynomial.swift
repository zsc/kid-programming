struct 多项式 {
    let 系数: [Int]
}


func 阶(_ 式: 多项式) -> Int {
    let n = 式.系数.count
    for i in 0...n {
        if 式.系数[n-1-i] != 0 {
            return n-1-i
        }
    }
    return 0
}

let 式1 = 多项式(系数: [1,2])
print(式1)
print("阶 = ", 阶(式1))
