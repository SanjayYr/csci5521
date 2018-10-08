clc;
clear;
in_training = dlmread('SPECT_train.txt', '\t');
in_test = dlmread('SPECT_test.txt', '\t');
in_validation = dlmread('SPECT_valid.txt', '\t');

[p1, p2, pc1, pc2] = Bayes_Learning(in_training, in_validation);

Bayes_Testing(in_test, p1, p2, pc1, pc2);