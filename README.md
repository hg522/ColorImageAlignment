# ColorImageAlignment-ROS
Implementation of aligning color channel images into one using SSD and NCC, and Harris corner Detection.

Sergei Mikhailovich Prokudin-Gorskii (1863-1944) was a photographer who, between the years 1909-1915, traveled the Russian empire and took thousands of photos of everything he saw. He used an early color technology that involved recording three exposures of every scene onto a
glass plate using a red, green, and blue filter. Back then, there was no way to print such photos, and they had to be displayed using a special projector. Prokudin-Gorskii left Russia in 1918, following the Russian revolution. His glass plate negatives survived and were purchased by the Library of Congress in 1948. Today, a digitized version of the Prokudin-Gorskii collection is available on- line at  http://www.loc.gov/exhibits/empire/gorskii.html.

The goal of this project was to learn to work with images in Octave by taking the digitized Prokudin-Gorskii glass plate images and automatically producing a color image with as few visual artifacts as possible. 

In order to do this, we extracted the three color channel images, placed them on top of each other, and aligned them so that they formed a single RGB color image. The program divides the image into three equal parts and aligns the second and the third parts (G and R) to the first (B) by calculating the displacement vector that was used to align the parts.


ALIGNING IMAGES

The easiest way to align the parts is to exhaustively search over a window of possible displacements (say [-15,15] pixels), score each one using some image matching metric, and take the displacement with the best score. Sum of Squared Differences (SSD) distance and normalized cross-correlation (NCC) algorithms were used to find the alignment.

Also, the alignment was performed by using feature detection and aligning the images based on the best fit of features. Corners were used as the feature detector and Harris corner detection algorithm used for the same. Then, RANSAC algorithm is run that randomly picks a feature in image 1 (lets say the B channel image) and assumes it aligns with a random feature in image 2 (lets say, the G channel image). The pixel shift is calculated for this alignment. Then the same pixel shift is applied to every feature in image 1, and a corresponding feature in image 2 is searched for within a threshold (a small window). If a feature is found within that window, it is counted as an inlier. This is run several times to pick the best alignment (highest number of outliers). 

