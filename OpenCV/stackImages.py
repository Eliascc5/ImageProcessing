import cv2 as cv 
import matplotlib.pyplot as plt
import numpy as np 



def stackImages(imgArray,scale):

    rows = len(imgArray)
    cols = len(imgArray[0])

    for x in range(0,rows):
        for y in range(0,cols):
            imgArray[x][y] = cv.resize(imgArray[x][y], dsize=(0, 0), fx=scale, fy=scale)

    
    return cv.vconcat([cv.hconcat(h) for h in imgArray])




img = cv.imread('ind.jpeg')
imgHSV = cv.cvtColor(img, cv.COLOR_BGR2HSV)


imgStacked = stackImages([[img, img, img, img],
                       [imgHSV, imgHSV, imgHSV, imgHSV]],1.5)



cv.imshow("Stacked images", imgStacked)

cv.waitKey(0)
cv.destroyAllWindows()
