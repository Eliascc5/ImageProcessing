# -*- coding: utf-8 -*-
"""
Created on Thu Oct 21 14:36:39 2021

@author: correa
"""
import cv2 as cv
import numpy as np
import os
import shutil


#Cropping into Imagettes
def crop_Img_BySide(img ,  _width ,_height):
    
    # img : IMAGE TO BE CUT
    # _height : desired height
    # _width : desired width
    
    h , w , c = img.shape
    
    limitHeight = int(h/_height)
    limitWidth = int(w/_width)
    
    coordHeight = [x *_height  for x in list(range(0,limitHeight,1))]
    
    coordWidth = [x * _width  for x in list(range(0,limitWidth,1))]
    
    imgC=img.copy()
    
    print("Axis Height  :",coordHeight)
    print("Axis Width :",coordWidth)
    
    
    imagettes = []

    for i in range(len(coordWidth)-1):
        for j in range(len(coordHeight)-1):

            imagettes.append(imgC[coordHeight[j]:coordHeight[j+1],coordWidth[i]:coordWidth[i+1]])

    return imagettes
    

######################################################################################################

#Cropping into Imagettes
def crop_Img(img , cut_X , cut_Y ):
    
    # img : IMAGE TO BE CUT
    # cut_X : NUMBER OF X-AXIS CUTS
    # cut_Y : NUMBER OF Y-AXIS CUTS
    
    h , w , c = img.shape

    coordHeight = [x * int(h/cut_X) for x in list(range(0,cut_X+1,1))]
    coordWidth = [x * int(w/cut_Y) for x in list(range(0,cut_Y+1,1))]
    
    imgC=img.copy()
    
    print("Axis Height  :",coordHeight)
    print("Axis Width :",coordWidth)
    
    
    imagettes = []

    for i in range(len(coordWidth)-1):
        for j in range(len(coordHeight)-1):

            imagettes.append(imgC[coordHeight[j]:coordHeight[j+1],coordWidth[i]:coordWidth[i+1]])

    return imagettes
    

######################################################################################################



def thumbnailGeneration(img, path,cut_X = 2, cut_Y = 2):

    #print("Shape of image",img.shape)
    
    img_Name = os.path.splitext(path)[0]
    
    imagettes = crop_Img(img, cut_X, cut_Y)

    print("Number of thumbnails generated: ", len(imagettes))
    
    print("Shape of thumbnails generated: ", imagettes[0].shape)
    
    cwd = os.getcwd()
    
    new_directory = os.path.join(cwd, rf'Imagettes_{img_Name}')
    
    if os.path.exists(new_directory):

        shutil.rmtree(new_directory, ignore_errors=True)
        
    else:
        os.makedirs(new_directory)

    cwd = os.getcwd() + f'\Imagettes_{img_Name}'
    
    for i ,img in enumerate(imagettes):
        cv.imwrite(os.path.join(cwd , f'{img_Name}_{i}.jpg'), img)
    
######################################################################################################

def thumbnailGenerationBySize (img, path, _width = 128, _height = 128):
    
    #print("Shape of image",img.shape)
    
    img_Name = os.path.splitext(path)[0]
    

    imagettes = crop_Img_BySide(img, _width, _height)
    
    print("Number of thumbnails generated: ", len(imagettes))
    
    print("Shape of thumbnails generated: ", imagettes[0].shape)
    
    cwd = os.getcwd()
    
    new_directory = os.path.join(cwd, rf'Imagettes_{img_Name}')
    
    if os.path.exists(new_directory):

        shutil.rmtree(new_directory, ignore_errors=True)
        
    else:
        os.makedirs(new_directory)

    cwd = os.getcwd() + f'\Imagettes_{img_Name}'
    
    for i ,img in enumerate(imagettes):
        cv.imwrite(os.path.join(cwd , f'{img_Name}_{i}.jpg'), img)
    