I = imread('img/negative/2.jpg');
G = rgb2gray(I);
J = histeq(G);
figure, imshow(G), figure, imshow(J)