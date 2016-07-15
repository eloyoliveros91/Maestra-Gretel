function [ vector_caract ] = vectorLbpForPoint( data, varargin )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here


I = data.I;
points = uint32(data.puntos);
sizeI = 128;
[I, points]  = reshapeImageToFace(I, points, sizeI);
% figure; imshow(I);

vs = cell(2,1);
hist_lbp = [];

mapping = getmapping(8,'u2');
Ilbp = Lbp(I,2,8,mapping,'i'); 
bins = mapping.num;

figure(1); imshow(Ilbp,[])
hold on; 
plot(points(:,1)-2,points(:,2)-2,'o'); 
hold off


size_img = size(Ilbp);
size_wndx = 7;
size_wndy = 7;


%ventana deslizante
for i=1:1:size_img-size_wndx
    for j=1:1:size_img-size_wndy
        
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
vector_caract = hist_lbp(:);


end

