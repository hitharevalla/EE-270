feature('jit', 'off');
clear all;
%A=double(rgb2gray(imread('hw2q1_img.jpg')));
%figure(1)
%imagesc(A)
%A = loadMNISTImages('train-images.idx3-ubyte');
%A = randn(50000, 1000);
A = 10 + (20-10)*rand(80000,1500);
k = 100;
[U,S,V] = svds(A,k);
%%
m = 1600;
for q = 1:12
q
tic;
[U1,S1,V1] = blocksvd_normalAMM(A, q, k, 1, m);
toc;
timenormAMM(q) = toc;


tic;
[U2,S2,V2] = blocksvd_sampAMM(A, q, k, 1, m);
toc;
timesampAMM(q) = toc;

tic;
[U3,S3,V3] = blocksvd_radmAMM(A, q, k, 1, m);
toc;
timeradmAMM(q) = toc;

tic;
[U4,S4,V4] = blocksvd_spnorAMM(A, q, k, 1, m);
toc;
timespnorAMM(q) = toc;

tic;
[Ux,Sx,Vx] = blocksvd(A, q, k, 1);
toc;
time(q) = toc;


err1normal(q) = norm_error(U,S,V,U1,S1,V1);
err1(q) = norm_error(U,S,V,Ux,Sx,Vx);

err1samp(q) = norm_error(U,S,V,U2,S2,V2);
err1radm(q) = norm_error(U,S,V,U3,S3,V3);
err1spnor(q) = norm_error(U,S,V,U4,S4,V4);

err2normal(q) = vec_error(A,U,U1);
err2(q) = vec_error(A,U,Ux);

err2samp(q) = vec_error(A,U,U2);
err2radm(q) = vec_error(A,U,U3);
err2spnor(q) = vec_error(A,U,U4);
end

%%
figure()
plot(timenormAMM,'DisplayName','Normal')
hold on
plot(timesampAMM,'DisplayName','Uniform Sampling')
hold on
plot(timeradmAMM,'DisplayName','Rademacher')
hold on
plot(timespnorAMM,'DisplayName','Count Sketch')
hold on
plot(time, 'DisplayName', 'No AMM');
hold off
legend

figure()
plot(err1normal,'DisplayName','Normal')
hold on
plot(err1samp,'DisplayName','Uniform Sampling')
hold on
plot(err1radm,'DisplayName','Rademacher')
hold on
plot(err1spnor,'DisplayName','Count Sketch')
hold on
plot(err1)
hold off
legend

figure()
plot(err2normal,'DisplayName','Normal')
hold on
plot(err2samp,'DisplayName','Uniform Sampling')
hold on
plot(err2radm,'DisplayName','Rademacher')
hold on
plot(err2spnor,'DisplayName','Count Sketch')
hold on
plot(err2)
hold off
legend
