clear all;
A=double(rgb2gray(imread('hw2q1_img.jpg')));


%%
tic;
[U,S,V] = blocksvd(A, 2, 100, 0, 100);
toc;

%%

A1 = U*S*V';
imagesc(A1)

%%multiplication needs to be the rate determining step i.e. qk must be
%%large which will make the construction of K the slowest step. That is the
%%case when the effect of AMM will be visible.