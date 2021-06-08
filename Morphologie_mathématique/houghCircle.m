close all 
clear all 
clc


I = imread('img/BLOCKN.tif');

[BW]=edge(I,'canny',0.7);

[xi,yi] = find(BW);






