pkg load image; %Se carga el paquete image

img = imread('img/contraste.jpg');  %Se carga la imagen en img
%img = imread('img/poca_luz.jpg');

%Negativo
neg = 255 - img;  %Se aplica la resta(por defecto elemento a elemento)
                  % del valor maximo menos el valor del pixel a toda la matriz 
imwrite(neg,'out/negativo.jpg');  %Se guarda la imagen

%Transfomacion logaritmica
%c = input('Introduce un valor de C para la transformacion logaritmica (ex. 0.1): ');
c = 0.1;
g = rgb2gray(img);  %convertimos la imagen original a escala de grises
[M,N]=size(g);  %determinamos el tamaño de la matriz g
        for x = 1:M %Recorrido de la matriz
            for y = 1:N
                m=double(g(x,y));
                z(x,y)=c.*log10(1+m); %Aplicamos la formula
            end
        end
imwrite(z,'out/logarimica.jpg');  %Se guarda la imagen

%Transfomacion gama
gam = imadjust(img,[0,1],[1,0]); %Utilizaremos la funcion de ajuste de matlab
                                 %En la que implenta la transformacion gama.
imwrite(gam,'out/gama.jpg');

%Estiramiento de contraste
%imhist(img);
%max(max(img));
%imhist(imagen_sal);
contraste = imadjust(img);  %Utilizaremos la funcion implementada de matlab pero
                            %sin parametros ya que se trata de un estiramiento de contraste
imwrite(contraste,'out/contraste.jpg');

%Rebanadas de nivel de intensidad
image = img(:,:,1); %se toma el plano de las intensidades
rmin = 100;         %nivel inferior del rango
rmax = 180;         %nivel superior del rango
[r,c]= size(image); %obtiene el tamaño de la matriz
s = zeros(r,c);     %Se crea una matriz Zero del mismo tamaño
for i = 1:r
    for j = 1:c
       % Si el valor del pixel se encuetra en el rago le da el valor de 0
        if (rmin < image(i,j)&& image(i,j) < rmax)  
            s(i,j) = 0;
        else
       % Si no le asigna el valor de la imagen original
            s(i,j) = image(i,j);
        end
    end
end
imwrite(s,'out/nivel_intensidad.jpg');  %se guarda la imagen

%Rebanadas de plano de bits
image = img(:,:,1); %se toma el plano de las intensidades
nbit = 8;           %Se elige el numero de bit del que se requiere el plano
rmin = 0;           %El nivel inferior del rango siempre es 0
rmax = 2**(nbit-1); %Se determina el nivel superior del rango
[r,c]= size(image); %obtiene el tamaño de la matriz
s = zeros(r,c);     %Se crea una matriz Zero del mismo tamaño
for i = 1:r
    for j = 1:c
       % Si el valor del pixel se encuetra en el rago le da el valor de 0
        if (rmin < image(i,j)&& image(i,j) < rmax)  
            s(i,j) = 0;
        else
       % Si no le asigna el valor de la imagen original
            s(i,j) = image(i,j);
        end
    end
end
imwrite(s,'out/plano_bit.jpg');  %se guarda la imagen
