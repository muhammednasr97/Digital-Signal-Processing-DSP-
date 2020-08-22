function varargout = Equalizer(varargin)
% EQUALIZER MATLAB code for Equalizer.fig
%      EQUALIZER, by itself, creates a new EQUALIZER or raises the existing
%      singleton*.
%
%      H = EQUALIZER returns the handle to a new EQUALIZER or the handle to
%      the existing singleton*.
%
%      EQUALIZER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EQUALIZER.M with the given input arguments.
%
%      EQUALIZER('Property','Value',...) creates a new EQUALIZER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Equalizer_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Equalizer_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Equalizer

% Last Modified by GUIDE v2.5 24-Feb-2019 22:49:07

% Begin initialization code - DO NOT EDIT
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
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Equalizer (see VARARGIN)

% Choose default command line output for Equalizer
vol = 2.5;
set(handles.volume,'value',vol);
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Equalizer wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Equalizer_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in browse.
function browse_Callback(hObject, eventdata, handles)
% hObject    handle to browse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,pathname] = uigetfile({'*.wav';'*.mp3'},'File Selector');
handles.fullpathname = strcat(pathname, filename);
set(handles.address, 'String',handles.fullpathname) %showing fullpathname
guidata(hObject,handles)


function play_equalizer(hObject, handles)
global player;
[handles.audio_data,handles.Fs] = audioread(handles.fullpathname);
handles.Volume=get(handles.volume,'value');
%handles.y=handles.y(NewStart:end,:); 
handles.g1=get(handles.slider1,'value');
handles.g2=get(handles.slider2,'value');
handles.g3=get(handles.slider3,'value');
handles.g4=get(handles.slider4,'value');
handles.g5=get(handles.slider5,'value');
handles.g6=get(handles.slider6,'value');
handles.g7=get(handles.slider7,'value');
handles.g8=get(handles.slider8,'value');
handles.g9=get(handles.slider9,'value');
handles.g10=get(handles.slider10,'value');
set(handles.text21, 'String',handles.g1);
set(handles.text22, 'String',handles.g2);
set(handles.text23, 'String',handles.g3);
set(handles.text24, 'String',handles.g4);
set(handles.text25, 'String',handles.g5);
set(handles.text26, 'String',handles.g6);
set(handles.text27, 'String',handles.g7);
set(handles.text28, 'String',handles.g8);
set(handles.text29, 'String',handles.g9);
set(handles.text30, 'String',handles.g10);

cut_off=200; %cut off low pass dalama Hz
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
 plot(handles.audio_data);
 subplot(2,1,2);
 plot(handles.yT);
 play(player);
guidata(hObject,handles)


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
play_equalizer(hObject, handles);

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
play_equalizer(hObject, handles);

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
play_equalizer(hObject, handles);

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
play_equalizer(hObject, handles);

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
play_equalizer(hObject, handles);

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
play_equalizer(hObject, handles);

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
play_equalizer(hObject, handles);

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
play_equalizer(hObject, handles);

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
play_equalizer(hObject, handles);

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
play_equalizer(hObject, handles);

% --- Executes during object creation, after setting all properties.
function slider10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in pop.
function pop_Callback(hObject, eventdata, handles)
% hObject    handle to pop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in reggae.
function reggae_Callback(hObject, eventdata, handles)
% hObject    handle to reggae (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in rock.
function rock_Callback(hObject, eventdata, handles)
% hObject    handle to rock (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in techno.
function techno_Callback(hObject, eventdata, handles)
% hObject    handle to techno (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in party.
function party_Callback(hObject, eventdata, handles)
% hObject    handle to party (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in classical.
function classical_Callback(hObject, eventdata, handles)
% hObject    handle to classical (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


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


% --- Executes on button press in stop.
function stop_Callback(hObject, eventdata, handles)
% hObject    handle to stop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on slider movement.
function volume_Callback(hObject, eventdata, handles)
% hObject    handle to volume (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function volume_CreateFcn(hObject, eventdata, handles)
% hObject    handle to volume (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
