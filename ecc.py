#coding=utf-8
from IPython import embed
import numpy as np

# https://blog.csdn.net/sitebus/article/details/82835492

def 欧拉函数(n):
    if n == 1: return 1
    for i in range(2, int(np.ceil(np.sqrt(n)))):
        if n%i == 0:
            k = 1; n2 = n // i
            while n2 % i == 0:
                k += 1; n2 = n2 // i
            return (i ** k - i ** (k-1)) * 欧拉函数(n2)
    return n - 1

def 快速指数同余(a, k, n):
  if k == 0: return 1
  if k%2 == 0:
    return (快速指数同余(a, k//2, n) ** 2) % n
  else:
    return (a * ((快速指数同余(a, k//2, n) ** 2) % n)) % n

def 模反元素(a, n):
  return 快速指数同余(a, 欧拉函数(n) - 1, n)

def 选椭圆曲线群(p=23, a=1, b=1):
    def 逆元(点):
        x, y = 点
        return (x, p - y)
    def 加(点1, 点2):
        x1, y1 = 点1
        x2, y2 = 点2
        if x1 == x2:
            逆 = 模反元素(2 * y1, p) 
            k = ((3 * x1**2 + a) * 逆) % p
        else:
            逆 = 模反元素(x2 - x1, p) 
            k = ((y2 - y1) * 逆) % p
        x3 = (k ** 2 - x1 - x2) % p
        return (x3, (k * (x1 - x3) - y1) % p)
    def 倍乘(k, 点):
        if k == 1: return 点
        半倍 = 倍乘(k // 2, 点)
        if k % 2 == 1:
            return 加(点, 加(半倍, 半倍))
        else:
            return 加(半倍, 半倍)
    return 逆元, 加, 倍乘

def 阶数(基点, 逆元, 加, 倍乘):
    n = 1
    点 = 基点
    逆点 = 逆元(点)
    while 点 != 逆点:
        点 = 加(点, 基点)
        n += 1
    return n + 1

print('测试群计算')
逆元, 加, 倍乘 = 选椭圆曲线群()
点P = (3, 10)
点Q = (9, 7)
print(加(点P, 点Q))
print(加(点P, 点P))
print(倍乘(2, 点P))
for i in range(1, 30):
    print(倍乘(i, 点P), end=' ')
print()
print('阶 = ', 阶数(点P, 逆元, 加, 倍乘))
print('-' * 10)

print('测试加解密')
逆元, 加, 倍乘 = 选椭圆曲线群(p=29, a=4, b=20)
基点 = (13, 23)
私钥k = 25
公钥 = 倍乘(私钥k, 基点)
明文M = (3, 28)
阶数n = 阶数(点P, 逆元, 加, 倍乘)
r = 6 #r = np.random.choice(range(2, 阶数n))
点C1 = 加(明文M, 倍乘(r, 公钥))
点C2 = 倍乘(r, 基点)
解密明文 = 加(点C1, 逆元(倍乘(私钥k, 点C2)))
print('明文 = ', 明文M)
print('解密明文 = ', 解密明文)
