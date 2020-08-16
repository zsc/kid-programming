import cv2
import numpy as np
import matplotlib.pyplot as plt
from collections import Counter
%matplotlib inline

img = 255 - np.zeros((400, 400, 3)).astype('uint8')

def draw_point(img, pt, size, color):
    cv2.circle(img, pt, size, color, thickness=-1)
    
n = 1000
r = 200
x0, y0 = 200, 200
for i in range(n //4*30):
    theta = i * 2 * np.pi / n
    pt = (x0 + r * np.cos(theta), y0 + r * np.sin(theta))
    pt = (int(pt[0]), int(pt[1]))
    draw_point(img, pt, 1, (255, 0, 255))
    r *= 0.9995

plt.imshow(img)
plt.savefig('/tmp/t.jpg')
