k = lambda x: (lambda y: x)
s = lambda x: (lambda y: (lambda z: x(z)(y(z)))
i = s(k)(k)

print(i(42))
