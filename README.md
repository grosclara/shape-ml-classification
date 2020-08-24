
# Pattern recognition

## Objective

This work is an introduction to image classification. The objective of this exercise is to test methods for characterizing shapes in order to be able to classify them.

* From a base of generated images, we first perform a pre-processing thresholding task to generate binary images. 

* The features used to characterize these binary images are determined from the Fourier descriptors calculated for each image.

* Given the large number of features, a Principal Component Analysis (PCA) is performed to find a more convinient basis for the data representation obtained by linear combination of the original basis. It is then possible to perform a dimensionality reduction and thus eliminates redundant information.

* Once this pre-processing is done, unsupervised Machine Learning algorithms are applied: K-means and K-nearest neighbors. A performance validation then allows us to compare the methods. 

* Eventually, we propose as an opening to test our algorithm on another image base with other labels.

The `script.m` file can be run by modifying the different parameters as you wish.

