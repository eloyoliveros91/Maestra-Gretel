function [ MenuName, Data] = loadBUBMP( opcion )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

MenuName = 'BU .bmp';

if opcion == 2
    
    %     dir_db = './CK+';
    dir_db = uigetdir;
    
    % Obtener los files
    filter = [dir_db '/*.bmp'];
    files = dir(filter);
    fid = 1;
    
    h = waitbar(0,'Loading BU Database, Please wait...');
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
            Iorg = imread( [dir_db '/' fileName] );
            Iorg = imresize(Iorg, [256 256], 'bicubic');
        catch error
            disp(['Error al cargar ' files(i).name ' ' error]);
            continue;
        end
        
        imagenes{i} = im2double( Iorg );
        imagen_gray{i} = imagenes{i};
        if size(Iorg,3)~=1
            imagen_gray{i} = rgb2gray(Iorg);
            imagen_gray{i} = im2double( imagen_gray{i} );
        end
        
        name = files(i).name;
        actores{i} = name(2:5);
        
        clase = files(i).name(7:8);
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
        
        iter = 40:20:226;
        m = length(iter);
        aux = repmat(iter,[m 1]);
        puntos(:,1) = aux(:);
        puntos(:,2) = repmat(iter,[1 m]);
        puntos_car{i} = puntos;
        
        expresion_clase{clases{i}} = expresion{i};
        
        waitbar(fid/n,h,['Loading BU Database: imagen' num2str(fid)]);

        fid = fid+1;
    end
    Data = struct('actor', actores, 'clase', clases, 'expresion', expresion, ...
        'imagen', imagenes, 'imagen_gray', imagen_gray, 'puntos_car', puntos_car);
    
    close(h);
end


end

