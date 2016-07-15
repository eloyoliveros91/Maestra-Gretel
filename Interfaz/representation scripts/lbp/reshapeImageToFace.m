%% Ajustar imagen al rostro
function [ If, puntos_new ] = reshapeImageToFace( I, puntos, fact )
%reshapeImageToFace Recortar la imagen centrada en el rostro
%
% param I [in] imagen de entrada
% param puntos [in] puntos del track
% return If [out] Imagen fnal


xmin = min(puntos(:,1));
ymin = min(puntos(:,2)); 
xmax = max(puntos(:,1));
ymax = max(puntos(:,2));

w = xmax - xmin + 1;
h = ymax - ymin + 1;


%DESCOMENTAR PARA CK DATABASE
% % % ymin = ymin-h/4; 
% % % h = h + h/4;


% xmid = fix(w/2)+1;
% ymid = fix(h/2)+1;
% wfin = w + (h>w)*double(h-w); 
% hfin = h + (w>h)*double(w-h);

fin = max([w,h]);
vs = cell(2,1);

iter = 1:fin; 
xc = fix(mod(fin,w)/2);
yc = fix(mod(fin,h)/2);

vs{1} = iter + ymin - yc;
vs{2} = iter + xmin - xc;


multip = ones(size(puntos))*double(diag([xmin-xc ymin-yc]));
puntos_new = double(puntos) - multip; 
B = I(vs{:});


% % up   = min(puntos(:,2)); 
% % down = max(puntos(:,2));
% % left = min(puntos(:,1));
% % right = max(puntos(:,1));
% % 
% % w = down - up + 1;
% % h = right - left + 1;
% % 
% % vs = cell(2,1);
% % mn = [up - h/3, left];
% % mx = [down, right];
% % 
% % 
% % for k=1:2
% % vs{k}= (mn(k):mx(k))';
% % end
% % 
% % Iw = I(vs{:});
% % [n,m] = size(Iw);
% % B = zeros(64,64);


% % % %llevandolo a 64 conservando la relacion de aspecto
% % % if h<n 
% % % asp = 64*m/n;
% % % Iw = imresize(Iw, [64 asp], 'bicubic');
% % % [n,m] = size(Iw);
% % % im = fix(mod(64,m)/2)+1;
% % % in = 1;
% % % 
% % % else
% % % asp = 64*n/m;
% % % Iw = imresize(Iw, [asp 64], 'bicubic');
% % % [n,m] = size(Iw);
% % % in = fix(mod(64,n)/2)+1;
% % % im = 1;
% % % end
% % % 
% % % % [n,m] = size(Iw);
% % % for i=in:n+in-1
% % %    for j=im:m+im-1
% % %    B(i,j)= Iw(i-in+1,j-im+1);      
% % %    end
% % % end

[w,h] = size(B);
B = imresize(B, [fact fact], 'bicubic');
If = B;
d = w/fact;
puntos_new = puntos_new./d;

% % % imshow(If);
% % % figure(1); imshow(B,[])
% % % hold on; 
% % % plot(puntos_new(:,1),puntos_new(:,2),'o'); 
% % % hold off


end

