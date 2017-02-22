# MachineLearning_Comp1

The first in-class Kaggle competition for our class involves a clustering challenge:
You are provided with a data set created from 12000 hand written digits (from '0' - '9'). You are only provided information extracted based on the images of the handwritten digits. The underlying label of which digit each of the handwritten digit is is not provided to you. Your task in this competition is to cluster/classify (based on very weak supervision) these data points into 10 clusters such that each cluster corresponds to one of the digits from '0' to '9'. Seed labels of a few data points (30 of them, 3 for each digit) are provided. 
Here is what you are provided with
The Features describing the image of handwritten digits: For each handwritten digit, a 103 dimensional feature vector is extracted based on the image of the hand written digit. This is provided to you in the features.csv file. The file has 12000 lines (one for each hand written digit) in the comma separated values format. 
A similarity graph: a graph connecting the 12000 data points is provided in the adjacency matrix form in the file adjacency.csv consisting of the adjacency matrix in comma separated value format. Two nodes are connected in this graph if the corresponding noisy image of the digits are similar enough (dissimilarity smaller than a fixed threshold).
3 labeled points for each of the 10 classes: To help you identify your 10 clusters with the right digit from '0'-'9' we provide 3 example data-points for each digit in the data set in the file seed.csv. The file consists of 10 lines, one for each digit from '0'-'9'. Each line has 3 numbers providing the line number or index of 3 data point belonging to that class. The line numbering starts from 1 (not 0).

Task: For each handwritten digit, predict what the corresponding label from '0' to '9' is. The competition will be hosted on in-class-Kaggle.
