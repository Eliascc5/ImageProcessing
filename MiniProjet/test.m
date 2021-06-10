clear all 
close all
clc


image7 = imread('colindata/01.png');

originCoord = [0 0];
[size_x,size_y]=size(image7);

image7 = rgb2gray(image7);
a=edge(image7,'canny');
figure(1),imshow(a);

figure(2),plot(sum(a));

[peaks,loc] = findpeaks(sum(a),"MinPeakHeight",100);

maxPeak=max(peaks);
for i = 1:length(peaks)
  peaks(i)=maxPeak;
endfor


image71 = imcrop(image7,[0 0 loc(1) peaks(1)]);
image72 = imcrop(image7,[loc(2) 0 loc(3)-loc(2) peaks(2)]);
image73 = imcrop(image7,[loc(4) 0 size_x-loc(4) peaks(4)]);

figure(3),imshow(image71)
figure(4),imshow(image72)
figure(5),imshow(image73)

###########################################

a=edge(imrotate(image71,90),'canny');
figure(10),imshow(a);
figure(11),plot(sum(a));

[size_yh,size_xh]=size(imrotate(image71,90));

[peaks_h,loc_h] = findpeaks(sum(a),"MinPeakHeight",20);

maxPeak_h=max(peaks_h);
for i = 1:length(peaks_h)
  peaks_h(i)= maxPeak_h;
endfor

figure(49),imshow(imrotate(image71,90))
image71_1h = imcrop(imrotate(image71,90),[0 0 loc_h(1) peaks_h(1)]);
figure(50),imshow(image71_1h)
image71_2h = imcrop(imrotate(image71,90),[loc_h(2) 0 size_xh-loc_h(2) peaks_h(2)]);
figure(51),imshow(image71_2h)
