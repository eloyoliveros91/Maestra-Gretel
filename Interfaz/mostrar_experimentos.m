function varargout = mostrar_experimentos(varargin)
% MOSTRAR_EXPERIMENTOS MATLAB code for mostrar_experimentos.fig
%      MOSTRAR_EXPERIMENTOS, by itself, creates a new MOSTRAR_EXPERIMENTOS or raises the existing
%      singleton*.
%
%      H = MOSTRAR_EXPERIMENTOS returns the handle to a new MOSTRAR_EXPERIMENTOS or the handle to
%      the existing singleton*.
%
%      MOSTRAR_EXPERIMENTOS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MOSTRAR_EXPERIMENTOS.M with the given input arguments.
%
%      MOSTRAR_EXPERIMENTOS('Property','Value',...) creates a new MOSTRAR_EXPERIMENTOS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before mostrar_experimentos_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to mostrar_experimentos_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help mostrar_experimentos

% Last Modified by GUIDE v2.5 27-Apr-2016 01:02:04

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @mostrar_experimentos_OpeningFcn, ...
                   'gui_OutputFcn',  @mostrar_experimentos_OutputFcn, ...
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


% --- Executes just before mostrar_experimentos is made visible.
function mostrar_experimentos_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to mostrar_experimentos (see VARARGIN)

% Choose default command line output for mostrar_experimentos
handles.output = hObject;
db = dir('./experimentos');
for i=3:size(db,1) 
    nombre = db(i).name;
    handles.exp_database = uimenu(handles.database, 'Label', nombre, ...
        'Callback', {@baseDatos_Callback, ['./experimentos/' nombre]});
end
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes mostrar_experimentos wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = mostrar_experimentos_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox2.
function listbox2_Callback(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox2
if strcmp(get(handles.figure1,'SelectionType'),'open')
   index_selected = get(handles.listbox2,'Value');
   exp = get(handles.listbox2, 'String');
   load([handles.directorio '/' exp{index_selected}]);
   set(handles.tabla, 'Visible', 'on');
   set(handles.tabla2, 'Visible', 'on');
   
   data = cell(size(metodos,2),1);
   row_name = cell(1, size(metodos,2));
   
   for i=1:size(metodos,2)
       data{i,1} = metodos(i).funcion;
       data(i,2:size(metodos(i).args,1)+1) = metodos(i).args()';
       row_name{i} = ['Método ' int2str(i)];
   end
   
   col_name = {'Función'};
   for i=2:size(data,2)
      col_name{i} = ['Arg ' int2str(i-1)]; 
   end
   
   set(handles.tabla, 'Data', data, 'ColumnName', col_name, ...
       'RowName', row_name);
   
   set(handles.tabla2, 'Data', W);
   
   
end

guidata(hObject, handles);



% --- Executes during object creation, after setting all properties.
function listbox2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function database_Callback(hObject, eventdata, handles)
% hObject    handle to database (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

function baseDatos_Callback(hObject, eventdata, directorio)
    handles = guidata(hObject);
    experiments = dir(directorio);
    experiments(1) =[];
    experiments(1) =[];
    set(handles.listbox2,'String',{experiments.name},...
        'Value',1)
    handles.directorio = directorio;
    guidata(hObject, handles);
