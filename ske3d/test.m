%% test connection points
close all; clear all; clc;

A = zeros(5,10);
A(2,1) = 1; A(5,10) = 1;

points = [2,1;5,10];

B = connect(A, 2,1,5,10);

imshow(B)
%%

a = [1,1];
b = [-1,-1];

theta = abs(acos(dot(a,b)/(norm(a) * norm(b))))
