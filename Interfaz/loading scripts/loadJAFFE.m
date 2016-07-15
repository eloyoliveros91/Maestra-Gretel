function [ MenuName, Data] = loadJAFFE( opcion )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

MenuName = 'JAFFE';

if opcion == 2
    
    dir_db = uigetdir;
    
    % Obtener los files
    filter = [dir_db '/*.tiff'];
    files = dir(filter);
    fid = 1;
    
    h = waitbar(0,'Loading JAFFE Database, Please wait...');
    n = length(files);
    actores = cell(1,n);
    clases = cell(1,n);
    expresion = cell(1,n);
    imagenes = cell(1,n);
    puntos_car = cell(1,n);
    imagen_gray = cell(1,n);
    expresion_clase = cell(1,7);
    
    for i=1:n
        
        try
            % Cargar imagen _i_ desde _pathName_
            fileName = files(i).name;
            imgFace = imread([ dir_db '/' fileName ]);
            
        catch error
            disp(['Error al cargar ' files(i).name]);
            disp(error);
            continue;
        end
        
        
        imagenes{i} = im2double( imgFace );
        imagen_gray{i} = imagenes{i};
        %     I = imresize(I, [128,128]);
        clase = files(i).name(4:5);
        switch clase
            case 'AN'
                expresion{i} = 'Anger';
                clases{i}=1;
            case 'DI'
                expresion{i} = 'Disgust';
                clases{i}=2;
            case 'FE'
                expresion{i} = 'Fear';
                clases{i}=3;
            case 'HA'
                expresion{i} = 'Happy';
                clases{i}=4;
            case 'SU'
                expresion{i} = 'Surprise';
                clases{i}=5;
            case 'NE'
                expresion{i} = 'Neutral';
                clases{i}=6;
            case 'SA'
                expresion{i} = 'Sadness';
                clases{i}=7;
        end
        
        sujeto = files(i).name(1:2);
        actores{i} = sujeto;
        %imshow(I);
        
        %     100 puntos centrados en el rostro
        puntos = 40:20:226;
        puntos_c = zeros(size(puntos,2)*size(puntos,2),2);
        ind = 1;
        
        for x=1:size(puntos,2)
            for j=1:size(puntos,2)
                puntos_c(ind,1) = puntos(x);
                puntos_c(ind,2) = puntos(j);            
                ind = ind+1;
            end
        end
        puntos_car{i} = puntos_c;
        expresion_clase{clases{i}} = expresion{i};
        
        waitbar(i/n,h,['Loading JAFFE Database: imagen' num2str(i)]);
        
    end
    Data = struct('actor', actores, 'clase', clases, 'expresion', expresion, ...
        'imagen', imagenes, 'imagen_gray', imagen_gray, 'puntos_car', puntos_car);
    
    close(h);
    
    
end
end

