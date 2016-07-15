function [ R ] = vectorLBP( opcion, Data, args )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

if opcion == 1
    R = [];
    return;
end

I = Data.imagen_gray;
points = Data.puntos_car;

% I = data.I;
% points = uint32(data.puntos);
sizeI = 64;
I = reshapeImageToFace(I, points, sizeI);
% figure; imshow(I);

I = padarray(I,[2 2],'symmetric','both');

vs = cell(2,1);
hist_lbp = [];

mapping = getmapping(8,'u2');
Ilbp = Lbp(I,2,8,mapping,'i');
bins = mapping.num;

size_img = size(Ilbp);
size_wndx = 8;
size_wndy = 8;

%ventana deslizante
for i=1:size_wndx:size_img-size_wndx+1
    for j=1:size_wndy:size_img-size_wndy+1
        
        mn = [i,j];
        mx = [i+size_wndx-1,j+size_wndy-1];
        
        for k=1:2
            vs{k}= (mn(k):mx(k))';
        end
        
        %obtener la ventana
        Iwnd = Ilbp(vs{:});
        hist_lbp = [hist_lbp hist(Iwnd(:),0:(bins-1))];
        
        %h = [h Lbp(Iwnd,2,8,mapping,'h')]; %LBP histogram in (8,1) neighborhood
        %using uniform patterns
        %figure(1), stem(hist_lbp);
        
    end
end

%resultado histograma...
R = hist_lbp(:)';


end

