function [ MenuName, Data] = loadBU_MAT( opcion )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

MenuName = 'BU .mat';

if opcion == 2
    
    %     dir_db = './CK+';
    dir_db = uigetdir;
    
    % Obtener los files
    filter = [dir_db '/*.mat'];
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
            load([dir_db filesep files(i).name]);
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
        
        actores{i} = actor;
        
        clases{i}=clase;
        
        expresion{i} = expr;
        
        
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

