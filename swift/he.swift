import Foundation

// https://zhuanlan.zhihu.com/p/54484449

let 系数个数d = 16
let 明文系数模t = 7
let 密文系数模q = 874

class 多项式 {
    var 系数: [Int]
    init(系数: [Int]) {
        self.系数 = 系数
    }
    
    func show() -> Void {
        for i in 0..<系数个数d {
            print(系数[i], terminator: " ")
        }
        print()
    }
    
    static func + (left:多项式,right:多项式) -> 多项式 {
        var ret = left.系数
        for i in 0..<系数个数d {
            ret[i] = (ret[i] + right.系数[i]) % 密文系数模q
        }
        return 多项式(系数: ret)
    }

    static func * (left:多项式,right:多项式) -> 多项式 {
        var ret: [Int] = []
        for _ in 0..<系数个数d {
            ret += [0]
        }
        for i in 0..<系数个数d {
            for j in 0..<系数个数d {
                ret[(i + j) % 系数个数d] = (ret[(i + j) % 系数个数d] + left.系数[i] * right.系数[j]) % 密文系数模q
            }
        }
        return 多项式(系数: ret)
    }
    
    static func * (left:多项式,right: Int) -> 多项式 {
        var ret: [Int] = []
        for i in 0..<系数个数d {
            ret += [left.系数[i] * right]
        }
        return 多项式(系数: ret)
    }
}


let 私钥s = 多项式(系数: [-1, 1, 1, 0, -1, 0, 1, 0, 1, -1, 0, -1, -1, -1, 0, 1])
let 公钥生成a = 多项式(系数: [84, -60, -282, 186, 322, -138, 70, 52, 107, -212, -369, 447, -229, -393, -256, 42])
let 噪音e = 多项式(系数: [1, 4, 0, 4, -4, 3, -1, 0, 4, 1, -6, -6, 7, 1, 1, -3])
print(私钥s.系数.count, 公钥生成a.系数.count, 噪音e.系数.count)
(公钥生成a * 私钥s * (-1) + 噪音e).show()
