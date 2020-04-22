#coding=utf-8
from IPython import embed
import numpy as np

def 范围(m, n):
  return range(m, n+1)

def 能整除(i, n):
  return n%i == 0

def 因数(n):
  for i in 范围(1, n):
    if 能整除(i,n): yield i

def 公因数(m, n):
  for i in range(1, min(m,n)+1):
    if 能整除(i, n) and 能整除(i, m): yield i

def 最大公因数(m, n):
  return max(公因数(m, n))

def 最小公倍数(m, n):
  return m*n//最大公因数(m,n)

互质 = lambda m, n: 最大公因数(m, n) == 1

def 互质的数(n):
  for i in range(1, n+1):
    if 互质(i, n): yield i

#欧拉函数 = lambda n: len(list(互质的数(n)))
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

def 得到RSA加解密方法(p=61, q=53):
  n = p * q
  phi = 欧拉函数(p) * 欧拉函数(q)
  def 选e(p, q):
    while True:
      e = np.random.choice(range(2, phi))
      if 互质(e, phi): return e

  e = 选e(p, q)
  d = 模反元素(e, phi)
  def 加密(m):
    return 快速指数同余(m, e, n)
  def 解密(c):
    return 快速指数同余(c, d, n)
  return 加密, 解密

加密, 解密 = 得到RSA加解密方法(991, 997)
m = int(input('输入明文：'))
#print('明文: ', m)
print('密文: ', 加密(m))
print('解密后明文: ', 解密(加密(m)))
embed()
