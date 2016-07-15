function [ R ] = WaveletsGaborPtos( opcion, Data, args )
%UNTITLED Summary of this function goes here
%   opcion indica si es la primera vez que se llama, para decirle a la
%   interfaz los parametros del metodo, sino realizar la caracterizacion
%   
%   Data contiene toda la informacion sobre el objeto a representar
%   args son todos los parametros necesarios del metodo

% param M ancho de la señal
% param N alto de la señal
% param U cantidad de orientaciones 
% param V cantidad de scalas 


if opcion == 1
    dlg.prompt = {'Ancho de la señal:','Alto de la señal:', ...
        'Total de orientaciones: ', 'Total de escalas:', ...
        'Dimensión del cuadro (F):'};
    dlg.dlg_title = 'Entrada para Wavelets Gabor';
    dlg.num_lines = 1;
    dlg.def = {'25','25', '8', '4', '9'};
    
    R = dlg;       
else
        
    GW = getGabor(str2double(args{1}),str2double(args{2}),...
        str2double(args{3}),str2double(args{4}));
    
    % el valor de la mascara tambien es una variable a tener en cuenta
    mask = ones(str2double(args{5}),str2double(args{5}));
    imagen = Data.imagen_gray;
    puntos = Data.puntos_car;
    R = [];
    for k=1:length(GW)
        IG = imfilter(imagen, GW{k}, 'symmetric' );
        IG = sqrt(real(IG).^2 + imag(IG).^2);
        ind = (puntos(:,2)-1).*size(IG,2) + puntos(:,1);
        IG =  IG';
        IG = imfilter(IG,mask);
        IGs = IG(ind);
        R = [R IGs'];        %#ok<*AGROW>
    end
    
end    
end

