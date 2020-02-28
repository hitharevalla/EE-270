feature('jit', 'off');
clear all;
%A=double(rgb2gray(imread('hw2q1_img.jpg')));
%figure(1)
%imagesc(A)
A = loadMNISTImages('train-images.idx3-ubyte');
%A = randn(50000, 1000);
k = 400;
[U,S,V] = svds(A,k);
%%

for q = 1:7
tic;
[U1,S1,V1] = blocksvd_normalAMM(A, q, k, 0, 1200);
toc;
timenormAMM(q) = toc;

%{
tic;
[U2,S2,V2] = blocksvd_sampAMM(A, q, k, 1, 1200);
toc;
timesampAMM(q) = toc;

tic;
[U3,S3,V3] = blocksvd_radmAMM(A, q, k, 1, 1200);
toc;
timeradmAMM(q) = toc;

tic;
[U4,S4,V4] = blocksvd_spnorAMM(A, q, k, 1, 1200);
toc;
timespnorAMM(q) = toc;
%}
tic;
[Ux,Sx,Vx] = blocksvd(A, q, k, 0);
toc;
time(q) = toc;


err1normal(q) = norm_error(U,S,V,U1,S1,V1);
err1(q) = norm_error(U,S,V,Ux,Sx,Vx);
%{
err1samp(q) = norm_error(U,S,V,U2,S2,V2);
err1radm(q) = norm_error(U,S,V,U3,S3,V3);
err1spnor(q) = norm_error(U,S,V,U4,S4,V4);
%}
end

%%
figure()
plot(timenormAMM)
hold on
plot(timesampAMM)
hold on
plot(timeradmAMM)
hold on
plot(timespnorAMM)
hold on
plot(time)
hold off

figure()
plot(err1normal)
hold on
plot(err1samp)
hold on
plot(err1radm)
hold on
plot(err1spnor)
hold on
plot(err1)
hold off

