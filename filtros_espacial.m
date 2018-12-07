%Leo la imagen
I = imread('img/positive/2.jpg');
%Transformo a escala de grises
I_G = rgb2gray(I);
	
I_ruido = imnoise(I_G,'salt & pepper');
%Se crea el kernel de tipo media
	
%Creo kernel 3x3 tipo media
kernel_media =  fspecial('average',[3,3]);
%Defino el valor sigma del kernel gaussiano y creo el kernel:

%Defino sigma
sigma = 1;
%Creo kernel 3x3 tipo Gaussiano
kernel_gaussiano =  fspecial('gaussian',[3,3],sigma);
%Se le aplican los kernel a la imagen con ruido mediante convolución:
	
%creo el laplaciano
kernel_lapacian = fspecial('laplacian',0.5)  
  
I_media = filter2(kernel_media, I_ruido)/255;
I_gauss = filter2(kernel_gaussiano, I_ruido)/255;
I_lapacian = filter2(kernel_lapacian, I_ruido)/255;
I_lapacian = I_ruido + I_lapacian;

%Por último, muestro las imágenes:	
subplot(3,2,1), imshow(I), title('Imagen');
subplot(3,2,2), imshow(I_ruido), title('Con Ruido');
subplot(3,2,3), imshow(I_media), title('Suavizado Media');
subplot(3,2,4), imshow(I_gauss), title('Suavizado Gaussiano');
subplot(3,2,5), imshow(I_lapacian), title('Suavizado Laplaciano');

