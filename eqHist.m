%  Ejemplo de ejecucion:                                               %
%----------------------------------------------------------------------%
% >> I=imread('fig2_09a.bmp');                                         %
% >> E = ecualiza(I);                                                  % 
%______________________________________________________________________%
% Con funciones de matlab
% >> J = histeq(I);
% >> figure, imshow(I), figure, imshow(J)
%______________________________________________________________________%

% Devuelve el nº de filas y columnas en  variables de salida separadas 

Ient = imread('img/negative/1.jpg');

[filas,columnas] = size(Ient);

Isal = zeros(filas,columnas);
histo = zeros(1,256);

% Calculo del histograma 
histo=imhist(Ient);

% Convierte la variable Ient en una variable de doble precision  
Ient = double (Ient);

% Calculo del numero de pixels de la imagen 
total_pixels = filas * columnas;

% Asignacion de  un vector fila de  255 elementos  todos ellos nulos a 
% la variable probabilidad                                             
probabilidad = zeros (1,256);

% Calcula la probabilidad de que se  presenten cada uno de los niveles 
% de gris                                                              
for k=1:256
    probabilidad(k)=histo(k)/total_pixels;
end

% Asignacion de  un vector fila de 255  elementos  todos ellos nulos a 
% la variable acumulada                                                
acumulada = zeros(1,256);

% La probabilidad acumulada que tiene el pixel 0 es la probabilidad de 0                                                        
acumulada(1) = probabilidad(1);

% Calculo de la acumulada(k) como la suma de la acumulada anterior mas %
% la probabilidad de nivel de gris que existe en k. No empieza en 1 ya %
% que la acumulada del primer pixel es igual a la probabilida de este  %
for k = 2:256
    acumulada(k) = acumulada(k-1) + probabilidad(k);
end

% Ecualizador va a contener la transformacion del nivel de gris        %
ecualizador= zeros(1,256);

for k=1:256
    ecualizador(k) = acumulada(k)*256;
end

%Sustitucion de los niveles de gris en base a ecualizador
for i=1:filas
    for j=1:columnas
        k = Ient(i,j);
        Isal(i,j)=ecualizador(k+1);
    end
end

Ient = uint8(Ient);
Isal = uint8(Isal);

%Representacion Grafica
subplot(2,2,1);imshow(Ient);title('Imagen Original');
subplot(2,2,2);imhist(Ient);title('Histo.Im.Orig');
subplot(2,2,3);imshow(Isal);title('Imagen Ecualiz.');
subplot(2,2,4);imhist(Isal);title('Histo.Im.Ecualiz.');
