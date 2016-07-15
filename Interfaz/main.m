function varargout = main(varargin)
% MAIN MATLAB code for main.fig
%      MAIN, by itself, creates a new MAIN or raises the existing
%      singleton*.
%
%      H = MAIN returns the handle to a new MAIN or the handle to
%      the existing singleton*.
%
%      MAIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAIN.M with the given input arguments.
%
%      MAIN('Property','Value',...) creates a new MAIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before main_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to main_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help main

% Last Modified by GUIDE v2.5 26-Apr-2016 18:34:42

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @main_OpeningFcn, ...
                   'gui_OutputFcn',  @main_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before main is made visible.
function main_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to main (see VARARGIN)

% Choose default command line output for main
handles.output = hObject;
addpath(genpath(pwd));

% leer funciones para cargar base de datos
loading_scripts = dir('./loading scripts/*.m');
set(handles.loadDB, 'Children', []);
for i=1:size(loading_scripts,1) 
    nombre = loading_scripts(i).name;
    nombre = nombre(1:size(nombre,2)-2); %eliminar la extension
    menu = feval(nombre,1);
    
    handles.loadDBMenu = uimenu(handles.loadDB, 'Label', menu, ...
        'Callback', {@loadDB_Callback, nombre});
end

% leer metodos de representacion

rep_scripts = dir('./representation scripts/*.m');
strings = cell(1,size(rep_scripts,1));
for i=1:size(rep_scripts,1)    
    strings{i} = rep_scripts(i).name;    
end
set(handles.repmets_pu, 'String', strings);

handles.experimento = [];

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes main wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = main_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --------------------------------------------------------------------
function archivo_Callback(hObject, eventdata, handles)
% hObject    handle to archivo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function loadDB_Callback(hObject, eventdata, handleFunction)
% hObject    handle to loadDB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    handles = guidata(hObject);
    [name, Data] = feval(handleFunction, 2);
    DB.name = name;
    DB.Data = Data;
    handles.database = DB;
    handles.indice_actual=1;    
    handles.mostrar_puntos=0;
    guidata(hObject, handles);    
    mostrar_imagenes(handles);
    
function mostrar_imagenes(handles)
    
    H = [handles.siguiente, handles.anterior, handles.frame,...
        handles.Actor, handles.Expresion, handles.Clase, ...
        handles.imagenes];
    
    set(H, 'Visible', 'on');


    imshow(handles.database.Data(handles.indice_actual).imagen);

    set(handles.Actor, 'String', ...
        ['Actor: ' handles.database.Data(handles.indice_actual).actor]);
    set(handles.Expresion, 'String', ...
        ['Expresion: ' handles.database.Data(handles.indice_actual).expresion]);
    set(handles.Clase, 'String', ...
        ['Clase: ' num2str(handles.database.Data(handles.indice_actual).clase)]);
    set(handles.imagenes, 'String', ...
        [int2str(handles.indice_actual) '/' int2str(size(handles.database.Data,2))]);
    if handles.mostrar_puntos == 1
        hold on
        puntos = handles.database.Data(handles.indice_actual).puntos_car;
        for t=1:size(puntos,1)        
            plot(puntos(t,1),puntos(t,2),'*y');
        end
        hold off
    end

        
        


% --- Executes on button press in anterior.
function anterior_Callback(hObject, eventdata, handles)
% hObject    handle to anterior (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    if handles.indice_actual > 1
        handles.indice_actual=handles.indice_actual-1;
    else 
        handles.indice_actual=size(handles.database.Data,2);
    end
    guidata(hObject, handles);
    mostrar_imagenes(handles);
    
% --- Executes on button press in siguiente.
function siguiente_Callback(hObject, eventdata, handles)
% hObject    handle to siguiente (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    if handles.indice_actual < size(handles.database.Data,2)
        handles.indice_actual=handles.indice_actual+1;
    else handles.indice_actual = 1;
    end
    guidata(hObject, handles);
    mostrar_imagenes(handles);


% --------------------------------------------------------------------
function Opciones_Callback(hObject, eventdata, handles)
% hObject    handle to Opciones (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function puntos_Callback(hObject, eventdata, handles)
% hObject    handle to puntos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    handles.mostrar_puntos = 1-handles.mostrar_puntos;
    guidata(hObject,handles);
    mostrar_imagenes(handles);


% --- Executes on selection change in repmets.
function repmets_Callback(hObject, eventdata, handles)
% hObject    handle to repmets (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns repmets contents as cell array
%        contents{get(hObject,'Value')} returns selected item from repmets


% --- Executes during object creation, after setting all properties.
function repmets_CreateFcn(hObject, eventdata, handles)
% hObject    handle to repmets (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in repmets_button.
function repmets_button_Callback(hObject, eventdata, handles)
% hObject    handle to repmets_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

lista = get(handles.repmets_pu,'String');
funcion = lista{get(handles.repmets_pu, 'Value')};
funcion = funcion(1:size(funcion,2)-2); %eliminar la extension

exp.funcion = funcion; 

dlg = feval(funcion, 1);
exp.args = [];
if ~isempty(dlg)
exp.args = inputdlg(dlg.prompt,dlg.dlg_title,dlg.num_lines,dlg.def);
end

list = get(handles.listado, 'String');
new = funcion;
for i=1:size(exp.args,1)
   new = [new '_' exp.args{i}]; 
end

exp.nombre=new;

if iscell(list)
    set(handles.listado, 'String', [list; new]);
else
    set(handles.listado, 'String', {new});
end

handles.experimento = [handles.experimento exp];

guidata(hObject, handles);



% --- Executes on selection change in loadBD_pu.
function loadBD_pu_Callback(hObject, eventdata, handles)
% hObject    handle to loadBD_pu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns loadBD_pu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from loadBD_pu


% --- Executes during object creation, after setting all properties.
function loadBD_pu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to loadBD_pu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in repmets_pu.
function repmets_pu_Callback(hObject, eventdata, handles)
% hObject    handle to repmets_pu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns repmets_pu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from repmets_pu


% --- Executes during object creation, after setting all properties.
function repmets_pu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to repmets_pu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on selection change in selrasg_pu.
function selrasg_pu_Callback(hObject, eventdata, handles)
% hObject    handle to selrasg_pu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns selrasg_pu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from selrasg_pu


% --- Executes during object creation, after setting all properties.
function selrasg_pu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to selrasg_pu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listado.
function listado_Callback(hObject, eventdata, handles)
% hObject    handle to listado (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listado contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listado


% --- Executes during object creation, after setting all properties.
function listado_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listado (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listado.
function listbox3_Callback(hObject, eventdata, handles)
% hObject    handle to listado (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listado contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listado


% --- Executes during object creation, after setting all properties.
function listbox3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listado (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in eliminar_met.
function eliminar_met_Callback(hObject, eventdata, handles)
% hObject    handle to eliminar_met (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
seleccionado = get(handles.listado, 'Value');
list = get(handles.listado, 'String');
list(seleccionado) = [];
set(handles.listado, 'String', list);
set(handles.listado, 'Value', seleccionado-1);
handles.experimento(seleccionado) = [];
guidata(hObject, handles);


% --- Executes on button press in comenzar.
function comenzar_Callback(hObject, eventdata, handles)
% hObject    handle to comenzar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
nombre = inputdlg('Nombre del experimento: ', 'Nombre', 1, {date});
Representar(nombre{1}, handles.database, handles.experimento);


% --------------------------------------------------------------------
function mostrar_Callback(hObject, eventdata, handles)
% hObject    handle to mostrar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
mostrar_experimentos;
