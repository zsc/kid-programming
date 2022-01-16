# author: xiaomogugu

```
>>> def f(x):
...   for i in range(2, int(x**0.5)+1):
...     if x%i==0:return 'no'
...   return 'yes'
... 
>>> for i in range(101):
...   print(f(i))
```
