function varargout = gui(varargin)
% GUI MATLAB code for gui.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui

% Last Modified by GUIDE v2.5 26-Jan-2022 15:39:13

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_OutputFcn, ...
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


% --- Executes just before gui is made visible.
function gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui (see VARARGIN)

% Choose default command line output for gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function numberEqns_Callback(hObject, eventdata, handles)
% hObject    handle to numberEqns (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of numberEqns as text
%        str2double(get(hObject,'String')) returns contents of numberEqns as a double


% --- Executes during object creation, after setting all properties.
function numberEqns_CreateFcn(hObject, eventdata, handles)
% hObject    handle to numberEqns (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in method_menu.
function method_menu_Callback(hObject, eventdata, handles)
% hObject    handle to method_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns method_menu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from method_menu


% --- Executes during object creation, after setting all properties.
function method_menu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to method_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function path_Callback(hObject, eventdata, handles)
% hObject    handle to path (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of path as text
%        str2double(get(hObject,'String')) returns contents of path as a double


% --- Executes during object creation, after setting all properties.
function path_CreateFcn(hObject, eventdata, handles)
% hObject    handle to path (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in browse.
function browse_Callback(hObject, eventdata, handles)
% hObject    handle to browse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname] = uigetfile({'*.txt'},'File Selector');
full_path = strcat(pathname, filename);
set(handles.path, 'String', full_path);
fp = fopen(full_path,'r');
n = fgetl(fp);
N = str2double(n);
set(handles.numberEqns,'String',N);
for i = 1:N 
     handles.fnText(i) = uicontrol('Style', 'text', 'String', sprintf('Equation %d',i), ...
        'Position', [100, 490 - (i-1)*35, 100, 30], 'HorizontalAlignment', 'left','FontWeight','Bold');
     handles.fn(i) = uicontrol('Style', 'edit', ...
        'Position', [210, 490 - (i-1)*35, 200, 30],'FontWeight','Bold');
end
method = fgetl(fp);
if(strcmp(method,'Gaussian Elimination'))
        set(handles.method_menu,'Value',1);
else if(strcmp(method,'Gaussian Jordan'))
        set(handles.method_menu,'Value',2);
    else
        set(handles.method_menu,'Value',3);
    end
end
for i = 1:N
    f = fgetl(fp);
    set(handles.fn(i), 'String', f);
end
guidata(hObject,handles);

% --- Executes on button press in Enter.
function Enter_Callback(hObject, eventdata, handles)
% hObject    handle to Enter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
N = str2double(get(handles.numberEqns, 'String'));
for i = 1:N 
     handles.fnText(i) = uicontrol('Style', 'text', 'String', sprintf('Equation %d',i), ...
        'Position', [100, 490 - (i-1)*35, 100, 30], 'HorizontalAlignment', 'left','FontWeight','Bold');
     handles.fn(i) = uicontrol('Style', 'edit', ...
        'Position', [210, 490 - (i-1)*35, 200, 30],'FontWeight','Bold');
end
 guidata(hObject,handles);


% --- Executes on button press in solve.
function solve_Callback(hObject, eventdata, handles)
% hObject    handle to solve (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
N = str2double(get(handles.numberEqns, 'String'));
variablesNames = '';
for i = 1:N
    variablesNames{1,i} = sprintf('x%d', i);
end
equations = get(handles.fn(1),'String');
for i = 2:N
    y = get(handles.fn(i),'String');
    equations = [equations ',' y];
end
eqns = strsplit(equations,',');
T = eqns.';
Fns = [];
    for i = 1 : N
    S = sym(T{i}); 
    Fns = [Fns;S];
    end
[A,B] = equationsToMatrix(Fns);
method = get(handles.method_menu,'Value');
aug = [A,B];
if rank(A) == rank(aug)
    if rank(A) == size(A,1)
switch(method)
    case 1     %Gauss-Elimination
         tic;
        [output, errorFlag] = gaussianEliminationPivot(A,B);
        execution_time = toc;
        output = double(output');
        set(handles.outputTable,'ColumnName',variablesNames); 
        if(errorFlag == 1)
          set(handles.message,'String','Error! division by zero.');
        end
    case 2     %Gauss-Jordan
        tic;
        [output,errorFlag] = gaussianJordanPivot(A,B);
        execution_time = toc;
        output = double(output');
        set(handles.outputTable,'ColumnName',variablesNames); 
        if(errorFlag == 1)
          set(handles.message,'String','Error! division by zero.');
        end
    case 3     %LU-Decomposition
         tic;
        [output] = LUDecomposition(A,B);
        execution_time = toc;
        output = double(output');
        set(handles.outputTable,'ColumnName',variablesNames); 
        errorFlag = 0;
end        
 set(handles.outputTable, 'Data', output);
 set(handles.executionTime,'String',execution_time); 
 if(errorFlag == 0)
     set(handles.message,'String','No error message');
 end
    else
        set(handles.message,'String','ERROR! Infinite Solution.');
    end 
else 
       set(handles.message,'String','ERROR! No Solution.');
end 
        


% --- Executes on button press in reset.
function reset_Callback(hObject, eventdata, handles)
% hObject    handle to reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
N = str2double(get(handles.numberEqns, 'String'));
for i = 1:N  
     delete(handles.fnText(i));
     delete(handles.fn(i));
     set(handles.numberEqns,'String','');
     set(handles.executionTime,'String','');
     set(handles.message,'String','');
     set(handles.outputTable,'Data','');
     set(handles.path,'String','');
 end
 guidata(hObject,handles);
