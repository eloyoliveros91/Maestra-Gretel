function [ MenuName, Data] = loadCK( opcion ) 
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

MenuName = 'CK+';

if opcion == 2

%     dir_db = './CK+';
    dir_db = uigetdir;
    
    % Obtener los files
    filter = [dir_db '/*.mat'];
    files = dir(filter);
    fid = 1;
    
    h = waitbar(0,'Loading CK+ Database, Please wait...');
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
            load([dir_db filesep files(i).name]);
        catch error
            disp(['Error al cargar ' files(i).name ' ' error]);
            continue;
        end
        
        actores{i} = actor;
        clases{i} = clase;
        
        imagenes{i} = im2double( imagen );
        imagen_gray{i} = imagenes{i};
        if size(imagen,3)~=1
            imagen_gray{i} = rgb2gray(imagen);
            imagen_gray{i} = im2double( imagen_gray{i} );
        end
        
        puntos = uint32(puntos);
        puntos_car{i} = puntos;
        
        fid = fid+1;
        switch clase
            case 1
                expresion{i} = 'Angry';
            case 2
                expresion{i} = 'Contempt';
            case 3
                expresion{i} = 'Disgust';
            case 4
                expresion{i} = 'Fear';
            case 5
                expresion{i} = 'Happy';
            case 6
                expresion{i} = 'Sadness';
            otherwise
                expresion{i} = 'Surprise';
        end
        expresion_clase{clase} = expresion{i};
        
        waitbar(fid/n,h,['Loading CK+ Database: imagen' num2str(fid)]);
        
    end
    Data = struct('actor', actores, 'clase', clases, 'expresion', expresion, ...
        'imagen', imagenes, 'imagen_gray', imagen_gray, 'puntos_car', puntos_car);
    
    close(h);
end


end

