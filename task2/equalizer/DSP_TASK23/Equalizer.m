function varargout = Equalizer(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Equalizer_OpeningFcn, ...
                   'gui_OutputFcn',  @Equalizer_OutputFcn, ...
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


% --- Executes just before Equalizer is made visible.
function Equalizer_OpeningFcn(hObject, eventdata, handles, varargin)

vol = 1;
set(handles.volume,'value',vol);
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Equalizer wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Equalizer_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;


% --- Executes on button press in browse.
function browse_Callback(hObject, eventdata, handles)
[filename,pathname] = uigetfile({'*.wav'},'File Selector');
handles.fullpathname = strcat(pathname, filename);
set(handles.address, 'String',handles.fullpathname) %showing fullpathname
guidata(hObject,handles)


function play_equalizer(hObject, handles)
global player;
[handles.audio_data,handles.Fs] = audioread(handles.fullpathname)
handles.Volume=get(handles.volume,'value'); 
handles.g1=10^(get(handles.slider1,'value')/10);
handles.n1=get(handles.slider1,'value');  % n for edit box
handles.g2=10^(get(handles.slider2,'value')/10);
handles.n2=get(handles.slider2,'value');
handles.g3=10^(get(handles.slider3,'value')/10);
handles.n3=get(handles.slider3,'value');
handles.g4=10^(get(handles.slider4,'value')/10);
handles.n4=get(handles.slider4,'value');
handles.g5=10^(get(handles.slider5,'value')/10);
handles.n5=get(handles.slider5,'value');
handles.g6=10^(get(handles.slider6,'value')/10);
handles.n6=get(handles.slider6,'value');
handles.g7=10^(get(handles.slider7,'value')/10);
handles.n7=get(handles.slider7,'value');
handles.g8=10^(get(handles.slider8,'value')/10);
handles.n8=get(handles.slider8,'value');
handles.g9=10^(get(handles.slider9,'value')/10);
handles.n9=get(handles.slider9,'value');
handles.g10=10^(get(handles.slider10,'value')/10);
handles.n10=get(handles.slider10,'value');
set(handles.text21, 'String',handles.n1); % n for edit box
set(handles.text22, 'String',handles.n2);
set(handles.text23, 'String',handles.n3);
set(handles.text24, 'String',handles.n4);
set(handles.text25, 'String',handles.n5);
set(handles.text26, 'String',handles.n6);
set(handles.text27, 'String',handles.n7);
set(handles.text28, 'String',handles.n8);
set(handles.text29, 'String',handles.n9);
set(handles.text30, 'String',handles.n10);

cut_off=200; 
order=16;
a=fir1(order,cut_off/(handles.Fs/2),'low');
y1=handles.g1*filter(a,1,handles.audio_data);

% %bandpass1
f1=201;
f2=400;
b1=fir1(order,[f1/(handles.Fs/2) f2/(handles.Fs/2)],'bandpass');
y2=handles.g2*filter(b1,1,handles.audio_data);
% 
% %bandpass2
f3=401;
f4=800;
b2=fir1(order,[f3/(handles.Fs/2) f4/(handles.Fs/2)],'bandpass');
y3=handles.g3*filter(b2,1,handles.audio_data);
% 
% %bandpass3
f4=801;
f5=1500;
b3=fir1(order,[f4/(handles.Fs/2) f5/(handles.Fs/2)],'bandpass');
y4=handles.g4*filter(b3,1,handles.audio_data);
% 
% %bandpass4
f5=1501;
f6=3000;
b4=fir1(order,[f5/(handles.Fs/2) f6/(handles.Fs/2)],'bandpass');
y5=handles.g5*filter(b4,1,handles.audio_data);
% 
% %bandpass5
f7=3001;
f8=5000;
b5=fir1(order,[f7/(handles.Fs/2) f8/(handles.Fs/2)],'bandpass');
y6=handles.g6*filter(b5,1,handles.audio_data);
% 
% %bandpass6
f9=5001;
f10=7000;
b6=fir1(order,[f9/(handles.Fs/2) f10/(handles.Fs/2)],'bandpass');
y7=handles.g7*filter(b6,1,handles.audio_data);
% 
% %bandpass7
f11=7001;
f12=10000;
b7=fir1(order,[f11/(handles.Fs/2) f12/(handles.Fs/2)],'bandpass');
y8=handles.g8*filter(b7,1,handles.audio_data);
% 
 % %bandpass8
f13=10001;
f14=15000;
b8=fir1(order,[f13/(handles.Fs/2) f14/(handles.Fs/2)],'bandpass');
y9=handles.g9*filter(b8,1,handles.audio_data);
% 
 %highpass
cut_off2=15000;
c=fir1(order,cut_off2/(handles.Fs/2),'high');
y10=handles.g10*filter(c,1,handles.audio_data);
%handles.yT=y1+y2+y3+y4+y5+y6+y7;
handles.yT=y1+y2+y3+y4+y5+y6+y7+y8+y9+y10;
player = audioplayer(handles.Volume*handles.yT, handles.Fs);
subplot(2,1,1);
plot(handles.y);
subplot(2,1,2);
plot(handles.yT);
 %play(player);
guidata(hObject,handles)


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
%play_equalizer(hObject, handles);

% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
%play_equalizer(hObject, handles);


function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider3_Callback(hObject, eventdata, handles)
%play_equalizer(hObject, handles);

% --- Executes during object creation, after setting all properties.
function slider3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider4_Callback(hObject, eventdata, handles)
%play_equalizer(hObject, handles);

% --- Executes during object creation, after setting all properties.
function slider4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider5_Callback(hObject, eventdata, handles)
%play_equalizer(hObject, handles);

% --- Executes during object creation, after setting all properties.
function slider5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider6_Callback(hObject, eventdata, handles)
%play_equalizer(hObject, handles);

% --- Executes during object creation, after setting all properties.
function slider6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider7_Callback(hObject, eventdata, handles)
%play_equalizer(hObject, handles);

% --- Executes during object creation, after setting all properties.
function slider7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider8_Callback(hObject, eventdata, handles)
%play_equalizer(hObject, handles);

% --- Executes during object creation, after setting all properties.
function slider8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider9_Callback(hObject, eventdata, handles)
%play_equalizer(hObject, handles);

% --- Executes during object creation, after setting all properties.
function slider9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider10_Callback(hObject, eventdata, handles)
%play_equalizer(hObject, handles);

% --- Executes during object creation, after setting all properties.
function slider10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in play.
function play_Callback(hObject, eventdata, handles)
global player;
play_equalizer(hObject, handles); 
play(player);
guidata(hObject,handles)


% --- Executes on button press in pause.
function pause_Callback(hObject, eventdata, handles)
global player;
pause(player);
guidata(hObject,handles)


% --- Executes on button press in resume.
function resume_Callback(hObject, eventdata, handles)
global player; 
resume(player);
guidata(hObject,handles)





% --- Executes on slider movement.
function volume_Callback(hObject, eventdata, handles)



% --- Executes during object creation, after setting all properties.
function volume_CreateFcn(hObject, eventdata, handles)


% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)
g1 = -1.5;
g2 = 3.9;
g3 = 5.4;
g4 = 4.5;
g5 =  0.9;
g6 = -1.5;
g7 = -1.8;
g8= -2.1;
g9 = -2.1;
g10 = -0.3;
set(handles.slider3,'value',g1);
set(handles.slider4,'value',g2);
set(handles.slider5,'value',g3);
set(handles.slider7,'value',g4);
set(handles.slider8,'value',g5);
set(handles.slider9,'value',g6);
set(handles.slider10,'value',g7);
set(handles.slider11,'value',g8);
set(handles.slider6,'value',g9);
set(handles.slider12,'value',g10);
set(handles.text16, 'String',g1);
set(handles.text19, 'String',g2);
set(handles.text20, 'String',g3);
set(handles.text21, 'String',g4);
set(handles.text22, 'String',g5);
set(handles.text23, 'String',g6);
set(handles.text24, 'String',g7);
set(handles.text25, 'String',g8);
set(handles.text26, 'String',g9);
set(handles.text27, 'String',g10);
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
