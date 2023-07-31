function varargout = RRR_3_link(varargin)
% RRR_3_LINK MATLAB code for RRR_3_link.fig
%      RRR_3_LINK, by itself, creates a new RRR_3_LINK or raises the existing
%      singleton*.
%
%      H = RRR_3_LINK returns the handle to a new RRR_3_LINK or the handle to
%      the existing singleton*.
%
%      RRR_3_LINK('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RRR_3_LINK.M with the given input arguments.
%
%      RRR_3_LINK('Property','Value',...) creates a new RRR_3_LINK or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before RRR_3_link_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to RRR_3_link_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help RRR_3_link

% Last Modified by GUIDE v2.5 07-Apr-2023 18:14:50

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @RRR_3_link_OpeningFcn, ...
                   'gui_OutputFcn',  @RRR_3_link_OutputFcn, ...
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


% --- Executes just before RRR_3_link is made visible.
function RRR_3_link_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to RRR_3_link (see VARARGIN)

% Choose default command line output for RRR_3_link
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes RRR_3_link wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = RRR_3_link_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in btn_forward.
function btn_forward_Callback(hObject, eventdata, handles)
% hObject    handle to btn_forward (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Th_1 = str2double(handles.Theta_1.String)*pi/180;
Th_2 = str2double(handles.Tehta_2.String)*pi/180;
Th_3 = str2double(handles.Theta_3.String)*pi/180;

L_1 = 1;
L_2 = 1;
L_3 = 1;

L(1)= Link([0  0 L_1 0]);
L(2)=Link([0 0 L_2 0]);
L(3)=Link([0 0 L_3 0]);

Robot = SerialLink(L);
Robot.name = "RRR_Robot";
Robot.plot([Th_1 Th_2 Th_3]);

T = Robot.fkine([Th_1 Th_2 Th_3]);
handles.Pos_x.String = num2str(floor(T.t(1)));
handles.Pos_y.String = num2str(floor(T.t(2)));
handles.Pos_z.String = num2str(floor(T.t(3)));



function Tehta_2_Callback(hObject, eventdata, handles)
% hObject    handle to Tehta_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% Hints: get(hObject,'String') returns contents of Tehta_2 as text
%        str2double(get(hObject,'String')) returns contents of Tehta_2 as a double


% --- Executes during object creation, after setting all properties.
function Tehta_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Tehta_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Theta_1_Callback(hObject, eventdata, handles)
% hObject    handle to Theta_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Theta_1 as text
%        str2double(get(hObject,'String')) returns contents of Theta_1 as a double


% --- Executes during object creation, after setting all properties.
function Theta_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Theta_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Pos_x_Callback(hObject, eventdata, handles)
% hObject    handle to Pos_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Pos_x as text
%        str2double(get(hObject,'String')) returns contents of Pos_x as a double


% --- Executes during object creation, after setting all properties.
function Pos_x_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Pos_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Pos_y_Callback(hObject, eventdata, handles)
% hObject    handle to Pos_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Pos_y as text
%        str2double(get(hObject,'String')) returns contents of Pos_y as a double


% --- Executes during object creation, after setting all properties.
function Pos_y_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Pos_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btn_inverse.
function btn_inverse_Callback(hObject, eventdata, handles)
% hObject    handle to btn_inverse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
px = str2double(handles.Pos_x.String);
py = str2double(handles.Pos_y.String);
pz = str2double(handles.Pos_z.String);

L_1 = 1;
L_2 = 1;
L_3 = 1;

L(1)= Link([0  0 L_1 0]);
L(2)=Link([0 0 L_2 0]);
L(3)=Link([0 0 L_3 0]);

Robot = SerialLink(L);
Robot.name = "RRR_Robot";
T = [1  0 0 px;
    0 1 0 py;
    0 0 1 pz;
    0 0 0 1];

J = Robot.ikine(T,[0 0 0], [1 1 1 0 0 0]) * 180/pi;


handles.Theta_1.String= num2str(floor(J(1)));
handles.Theta_2.String = num2str(floor(J(2)));
handles.Theta_3.String = num2str(floor(J(1)));

Robot.plot(J*pi/180);



function Theta_3_Callback(hObject, eventdata, handles)
% hObject    handle to Theta_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Theta_3 as text
%        str2double(get(hObject,'String')) returns contents of Theta_3 as a double


% --- Executes during object creation, after setting all properties.
function Theta_3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Theta_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Pos_z_Callback(hObject, eventdata, handles)
% hObject    handle to Pos_z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Pos_z as text
%        str2double(get(hObject,'String')) returns contents of Pos_z as a double


% --- Executes during object creation, after setting all properties.
function Pos_z_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Pos_z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
