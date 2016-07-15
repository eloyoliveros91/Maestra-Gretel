function Representar( nombre, database, metodos )
%UNTITLED2 Summary of this function goes here
%   nombre -> nombre del experimento
%   database -> contiene la base de datos con toda la informacion necesaria
%   metodos -> listado de metodos de representacion a realizar

mkdir(['./representaciones/' database.name]);
mkdir(['./experimentos/' database.name]);
rep_exist = dir(['./representaciones/' database.name '/*.mat']);

for m=1:size(metodos,2)
    metodos(m).valores = [];
end

% comprobar que no exista la representacion escogida
% en caso de existir, escoger si repetirla o no
for i=1:size(rep_exist,1)
    file = rep_exist(i).name();
    file = file(1:size(file,2)-4);  
    
    for m=1:size(metodos,2)
        
        if strfind(metodos(m).nombre,file)==1
            choice = questdlg(['El experimento ' metodos(m).nombre ...
                ' ya existe, desea repetirlo?'],...
                'Existe experimentos', ...
                'Si','No','No');
            if strcmp(choice, 'No')
%               cargar los valores que existen
                load(['./representaciones/' database.name '/' ...
                    metodos(m).nombre]);
                metodos(m).valores = M;
            end            
        end
    end
end

data = database.Data;
W = zeros(1, size(data,2));

% representaciones de cada metodo
R = cell(1, size(metodos,2));
for i=1:size(metodos,2)
    R{i} = zeros(1, size(data,2));
end

h = waitbar(0, 'Imágenes representadas: 0');
for i=1:size(data,2)
    V = [];
    
%   aplicar cada metodo a las imagenes y concatenar
    for m=1:size(metodos,2)
        if isempty(metodos(m).valores)
            T = feval(metodos(m).funcion, 2, data(i), metodos(m).args);
        else
            T = metodos(m).valores(:,i)';
        end
        R{m}(1:size(T,2),i) = T;
        V = [V T];
    end
    
    W(1:size(V,2),i) = V';
    waitbar(i/size(data,2), h, [ 'Imágenes representadas: ' int2str(i)]);
end
close(h);

save(['./experimentos/' database.name '/' nombre], 'W', 'metodos');
for i=1:size(metodos,2)
   if isempty(metodos(i).valores)
       M = R{i};
       save(['./representaciones/' database.name '/' metodos(i).nombre], 'M');
   end
end

end

