# -*- coding: utf-8 -*-
"""
Created on Thu Oct 21 14:58:43 2021

@author: correa
"""

import cv2 as cv
import numpy as np
import matplotlib.pyplot as plt
import os



######################################################################################################

#Plot histogram of the GRAY image

def plotHist(img, thr = None):
    
    #img : Image BGR format
    
    if len(img.shape) == 3:
        imgGray = cv.cvtColor(img, cv.COLOR_BGR2GRAY)
        
    elif len(img.shape) > 3:
        print(f'Your images has {len(img.shape)} dimentions')
        exit(0)
        
    else:
        imgGray = img
        
    plt.figure(figsize=(7,7))
    plt.hist(imgGray.ravel(),256,[0,256])
    plt.title('Distribution de pixels en niveaux de gris')
    plt.ylabel('Pixels')
    plt.xlabel('Niveaux de gris')
    
    plt.axvline(x=thr,c='r')
    
    plt.savefig("hist.png")
    plt.show()
 

######################################################################################################

def masksGeneration(folder_path):
    
    
    cwd = os.getcwd() +'/Imagettes_Acier_605MT26T_x100/Acier_605MT26T_x100_0.jpg'
    
    #cwd1= os.getcwd() +'/Imagettes_Acier_605MT26T_x100/'
    
    cwd1= os.getcwd() +'/img_aug/'
    
    os.chdir(cwd1)
    
    listMask = []
    
    namefile = []
    
    files=os.listdir()
    
    for file in files:
        
        namefile.append(file.split('.')[0])
        
        img = cv.imread(file)
        imgGray = cv.cvtColor(img, cv.COLOR_BGR2GRAY)
        ret,th = cv.threshold(imgGray,198,255,cv.THRESH_BINARY)
        
        kernel = cv.getStructuringElement(cv.MORPH_ELLIPSE,(1,1))

        opening = cv.morphologyEx(th, cv.MORPH_OPEN, kernel)
    
        contours, hierarchy = cv.findContours(opening,cv.RETR_TREE ,cv.CHAIN_APPROX_SIMPLE) 
    
        countValid = []
        for i , count in enumerate(contours):
            area = cv.contourArea(count)
            if area > 100:
              countValid.append(count)
        
        maskk = np.zeros(img.shape[:2], np.uint8)

        cv.fillPoly(maskk, pts = countValid, color=(255,255,255))
        
        listMask.append(maskk)

    return listMask , namefile
    
    

#######################################################################################################

def scaleExtractor(img):
    
    
    h,w,c = img.shape
    #We take just the label
    cropped_image = img[h-128:h, w-256:w]
    
    img = cropped_image.copy()
    
    gray = cv.cvtColor(cropped_image,cv.COLOR_BGR2GRAY)

    ret, thresh = cv.threshold(gray, 254, 255, cv.THRESH_BINARY)
    
    contours, hierarchy = cv.findContours(thresh, cv.RETR_EXTERNAL, cv.CHAIN_APPROX_SIMPLE)
    # filter noisy detection
    contours = [c for c in contours if cv.contourArea(c) > 100]
    
    # sort from by (y, x)
    contours.sort(key=lambda c: (cv.boundingRect(c)[1], cv.boundingRect(c)[0]))
    # work on the segment
    
    cv.rectangle(cropped_image, cv.boundingRect(contours[-1]), (0,255,0), 2)

    x,y,w,h = cv.boundingRect(contours[-1])
    
    
    #print(x,y,w,h) # x,y: (39 152) w,h: [304 21]
    
    #Note: Remember that the Y coordinate in OpenCV, starts from the bottom of the image to the top of the image.
    
    imgCrop2 = img[y:y+h, x : x+w]
        
    cv.imshow("Detection",img)
    
    cv.imshow("Final CROP",imgCrop2)
    
    gray = cv.cvtColor(imgCrop2,cv.COLOR_BGR2GRAY)
    
    kernel_size = 5
    blur_gray = cv.GaussianBlur(gray,(kernel_size, kernel_size),0)
    
    low_threshold = 50
    high_threshold = 150
    edges = cv.Canny(blur_gray, low_threshold, high_threshold)
    
    rho = 1  # distance resolution in pixels of the Hough grid
    theta = np.pi /2  # angular resolution in radians of the Hough grid
    threshold = 15  # minimum number of votes (intersections in Hough grid cell)
    min_line_length = 50  # minimum number of pixels making up a line
    max_line_gap = 15  # maximum gap in pixels between connectable line segments
    
    line_image = imgCrop2.copy()  # creating a blank to draw lines on
    
    # Run Hough on edge detected image
    # Output "lines" is an array containing endpoints of detected line segments
    lines = cv.HoughLinesP(edges, rho, theta, threshold, np.array([]),
                        min_line_length, max_line_gap)

    #points = []
    dist = []
    for line in lines:
        for x1, y1, x2, y2 in line:
            #points.append(((x1 + 0.0, y1 + 0.0), (x2 + 0.0, y2 + 0.0)))
            cv.line(line_image, (x1, y1), (x2, y2), (255, 0, 0), 2)
            dist.append(abs(x2-x1))
      
    print(f"Scale ----> {max(dist)} pixels = 100 *µm")


    cv.imshow("edges",edges)   
    cv.imshow("lines",line_image)
  

    cv.waitKey(0)
    cv.destroyAllWindows() 

######################################################################################################
