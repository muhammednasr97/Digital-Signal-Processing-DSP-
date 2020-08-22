function varargout = task4(varargin)
% TASK4 MATLAB code for task4.fig
%      TASK4, by itself, creates a new TASK4 or raises the existing
%      singleton*.
%
%      H = TASK4 returns the handle to a new TASK4 or the handle to
%      the existing singleton*.
%
%      TASK4('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TASK4.M with the given input arguments.
%
%      TASK4('Property','Value',...) creates a new TASK4 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before task4_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to task4_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help task4

% Last Modified by GUIDE v2.5 23-Apr-2018 16:39:35

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @task4_OpeningFcn, ...
                   'gui_OutputFcn',  @task4_OutputFcn, ...
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


% --- Executes just before task4 is made visible.
function task4_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to task4 (see VARARGIN)

% Choose default command line output for task4

 handles.output = hObject;
% set the sample rate (Hz)
 Fs = 44800;
 % create the recorder
 handles.recorder = audiorecorder(Fs,8,1);
 % assign a timer function to the recorder
 set(handles.recorder,'TimerPeriod',1,'TimerFcn',{@audioTimer,hObject});
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes task4 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = task4_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in browse.
function browse_Callback(hObject, eventdata, handles)
 global fullpathname;
% hObject    handle to browse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename ,pathname]=uigetfile({'*.wav'},'File Selector');
fullpathname=strcat(pathname, filename);
set(handles.address,'string',fullpathname)
guidata(hObject, handles)

%%Function to make equalizing
 function play_equalizer(hObject, handles)
global sound;
global fullpathname;
global Fs;
[uploaded_sgnal,Fs] = audioread(fullpathname);
uploaded_sgnal=uploaded_sgnal.*hanning(length(1/(Fs+1)),'periodic');
handles.Volume=get(handles.volume,'value');
%%Get gains values from sliders
gain1=get(handles.slider1,'value');
gain2=get(handles.slider2,'value');
gain3=get(handles.slider3,'value');
gain4=get(handles.slider4,'value');
gain5=get(handles.slider5,'value');
gain6=get(handles.slider6,'value');
gain7=get(handles.slider7,'value');
gain8=get(handles.slider8,'value');

%%set gain values from sliders in edittext
set(handles.edit1, 'String',gain1);
set(handles.edit2, 'String',gain2);
set(handles.edit3, 'String',gain3);
set(handles.edit4, 'String',gain4);
set(handles.edit5, 'String',gain5);
set(handles.edit6, 'String',gain6);
set(handles.edit7, 'String',gain7);
set(handles.edit8, 'String',gain8);

%%cut off low pass dalama Hz
orde=16;
cut_off=500;
a=fir1(orde,cut_off/(Fs/2),'low');    %Design filter
y1=gain1*filter(a,1,uploaded_sgnal);

%%%bandpass1

f1=501;      % corner frequansy
f2=1000;      % corner frequancy
b1=fir1(orde,[f1/(Fs/2) f2/(Fs/2)],'bandpass');    %Design filter
y2=gain2*filter(b1,1,uploaded_sgnal);
 
%%bandpass2
f3=1001;      % corner frequancy
f4=2000;      % corner frequancy
b2=fir1(orde,[f3/(Fs/2) f4/(Fs/2)],'bandpass');    %Design filter
y3=gain3*filter(b2,1,uploaded_sgnal);

%% %bandpass3
f4=2001;      % corner frequancy
f5=3500;      % corner frequancy
 b3=fir1(orde,[f4/(Fs/2) f5/(Fs/2)],'bandpass');    %Design filter
 y4=gain4*filter(b3,1,uploaded_sgnal);
 
%% %bandpass4
f5=3501;      % corner frequancy
f6=4500;      % corner frequancy
 b4=fir1(orde,[f5/(Fs/2) f6/(Fs/2)],'bandpass');    %Design filter
 y5=sum(gain5*filter(b4,1,uploaded_sgnal));

% %bandpass5
  f7=4501;      % corner frequancy
f8=6000;      % corner frequancy
  b5=fir1(orde,[f7/(Fs/2) f8/(Fs/2)],'bandpass');    %Design filter
  y6=gain6*filter(b5,1,uploaded_sgnal);
% 
% %bandpass6
  f9=6001;      % corner frequancy
f10=7500;      % corner frequancy
  b6=fir1(orde,[f9/(Fs/2) f10/(Fs/2)],'bandpass');    %Design filter
  y7=gain7*filter(b6,1,uploaded_sgnal);

 %highpass
cut_off2=10000;
c=fir1(orde,cut_off2/(22400/2),'high');    %Design filter
y8=gain8*filter(c,1,uploaded_sgnal);
%Get summation after applying equalizer
 uT=y1+y2+y3+y4+y5+y6+y7+y8;
sound = audioplayer(handles.Volume*uT, Fs);
M=abs(fft(uploaded_sgnal));
N=abs(fft(uT));
axes(handles.axes1)
plot(uploaded_sgnal,'k');
xlim([0 230000]);
axes(handles.axes2)
plot(abs(M),'k');
xlim([0 230000]);
axes(handles.axes3)
plot(uT,'c');
xlim([0 230000]);
axes(handles.axes4)
plot(abs(N),'c');
xlim([0 230000]);
guidata(hObject,handles)

% --- Executes on button press in play.
function play_Callback(hObject, eventdata, handles)
% hObject    handle to play (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global sound;
 check= str2double(get(handles.address, 'String'));
if check== 0;
    h=errordlg('PLZ Select sound first, it is good for you :):)','Warning');
    set(h, 'WindowStyle', 'modal');
    uiwait(h);
else
    play_equalizer(hObject, handles);
    play(sound);
    guidata(hObject,handles)
end
  
% --- Executes on button press in pause.
function pause_Callback(hObject, eventdata, handles)
% hObject    handle to pause (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global sound;
  check= str2double(get(handles.address, 'String'));
if check== 0;
    h=errordlg('PLZ Select sound first, it is good for you :):)','Warning');
    set(h, 'WindowStyle', 'modal');
    uiwait(h);

else
    play_equalizer(hObject, handles);
    pause(sound);
    guidata(hObject,handles)
end

% --- Executes on button press in resume.
function resume_Callback(hObject, eventdata, handles)
% hObject    handle to resume (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global sound;
  check= str2double(get(handles.address, 'String'));

if check== 0;
    h=errordlg('PLZ Select sound first, it is good for you :):)','Warning');
    set(h, 'WindowStyle', 'modal');
    uiwait(h);

else
    play_equalizer(hObject, handles);
    resume(sound);
    guidata(hObject,handles)
end
  
  
  
% --- Executes on button press in stop.
function stop_Callback(hObject, eventdata, handles)
% hObject    handle to stop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global sound;
  play_equalizer(hObject, handles);
  stop(sound);
  guidata(hObject,handles)
  
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

% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
global sound;
global live_sound_play;
check= str2double(get(handles.address, 'String'));
check_live= str2double(get(handles.address, 'String'));
if check== 0;
    h=errordlg('PLZ Select sound first, it is good for you :):)','Warning');
    set(h, 'WindowStyle', 'modal');
    uiwait(h);
elseif check_live == 1;
    play(live_sound_play);
    play_equalizer_live(hObject, handles);
else
    play_equalizer(hObject, handles);
    play(sound);
    guidata(hObject,handles)
end
function slider1_CreateFcn(hObject, eventdata, handles)

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function slider2_Callback(hObject, eventdata, handles)
global sound;
global live_sound_play;
check= str2double(get(handles.address, 'String'));
check_live= str2double(get(handles.address, 'String'));
if check== 0;
   h=errordlg('PLZ Select sound first, it is good for you :):)','Warning');
    set(h, 'WindowStyle', 'modal');
    uiwait(h);
elseif check_live == 1;
    play(live_sound_play);
    play_equalizer_live(hObject, handles);
else
    play_equalizer(hObject, handles);
    play(sound);
    guidata(hObject,handles)
end


% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.

function slider3_Callback(hObject, eventdata, handles)
global sound;
global live_sound_play;
check= str2double(get(handles.address, 'String'));
check_live= str2double(get(handles.address, 'String'));
if check== 0;
    h=errordlg('PLZ Select sound first, it is good for you :):)','Warning');
    set(h, 'WindowStyle', 'modal');
    uiwait(h);
elseif check_live == 1;
    play(live_sound_play);
    play_equalizer_live(hObject, handles);
else
    play_equalizer(hObject, handles);
    play(sound);
    guidata(hObject,handles)
end
% --- Executes during object creation, after setting all properties.
function slider3_CreateFcn(hObject, eventdata, handles)

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider4_Callback(hObject, eventdata, handles)
global sound;
global live_sound_play;
check= str2double(get(handles.address, 'String'));
check_live= str2double(get(handles.address, 'String'));
if check== 0;
    h=errordlg('PLZ Select sound first, it is good for you :):)','Warning');
    set(h, 'WindowStyle', 'modal');
    uiwait(h);
elseif check_live == 1;
    play(live_sound_play);
    play_equalizer_live(hObject, handles);
else
    play_equalizer(hObject, handles);
    play(sound);
    guidata(hObject,handles)
end
% --- Executes during object creation, after setting all properties.
function slider4_CreateFcn(hObject, eventdata, handles)

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider5_Callback(hObject, eventdata, handles)

global sound;
global live_sound_play;
check= str2double(get(handles.address, 'String'));
check_live= str2double(get(handles.address, 'String'));
if check== 0;
    h=errordlg('PLZ Select sound first, it is good for you :):)','Warning');
    set(h, 'WindowStyle', 'modal');
    uiwait(h);
elseif check_live == 1;
    play(live_sound_play);
    play_equalizer_live(hObject, handles);
else
    play_equalizer(hObject, handles);
    play(sound);
    guidata(hObject,handles)
end
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
global sound;
global live_sound_play;
check= str2double(get(handles.address, 'String'));
check_live= str2double(get(handles.address, 'String'));
if check== 0;
   h=errordlg('PLZ Select sound first, it is good for you :):)','Warning');
    set(h, 'WindowStyle', 'modal');
    uiwait(h);
elseif check_live == 1;
    play(live_sound_play);
    play_equalizer_live(hObject, handles);
else
    play_equalizer(hObject, handles);
    play(sound);
    guidata(hObject,handles)
end
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
global sound;
global live_sound_play;
check= str2double(get(handles.address, 'String'));
check_live= str2double(get(handles.address, 'String'));
if check== 0;
    h=errordlg('PLZ Select sound first, it is good for you :):)','Warning');
    set(h, 'WindowStyle', 'modal');
    uiwait(h);
elseif check_live == 1;
    play(live_sound_play);
    play_equalizer_live(hObject, handles);
else
    play_equalizer(hObject, handles);
    play(sound);
    guidata(hObject,handles)
end
% --- Executes during object creation, after setting all properties.
function slider7_CreateFcn(hObject, eventdata, handles)

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider8_Callback(hObject, eventdata, handles)

global sound;
global live_sound_play;
check= str2double(get(handles.address, 'String'));
check_live= str2double(get(handles.address, 'String'));
if check== 0;
    h=errordlg('PLZ Select sound first, it is good for you :):)','Warning');
    set(h, 'WindowStyle', 'modal');
    uiwait(h);
elseif check_live == 1;
    play(live_sound_play);
    play_equalizer_live(hObject, handles);
else
    play_equalizer(hObject, handles);
    play(sound);
    guidata(hObject,handles)
end
% --- Executes during object creation, after setting all properties.
function slider8_CreateFcn(hObject, eventdata, handles)

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.





% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
    play_equalizer_live(hObject, handles);
    guidata(hObject,handles)
 function play_equalizer_live(hObject, handles)
global record_object ;
global sound;
global x ;
Fs = 22400;
global live_sound_play;
x = 'on';
 %stop(sound);
check_live= str2double(set(handles.address, 'String',1));
while get(handles.pushbutton13,'enable')== 'on' & x == 'on'   
record_object= audiorecorder(44100,16,1); 
%audiorecorder creates an 8000 Hz, 8-bit, 1-channel audiorecorder object.

%Record your voice for 5 seconds.

disp('Start speaking.');
recordblocking(record_object, 1);
disp('End of Recording.');
%Play back the recording.

%play(recObj);
%Store data in double-precision array, y.
 pause(.01);
live_sound= getaudiodata(record_object);
% w = fft(y);
% 
% %Plot the audio samples.
% 
% plot(handles.axes1,y);
% plot(handles.axes2,abs(w));

%%Get gains values from sliders
handles.Volume=get(handles.volume,'value');
gain1=get(handles.slider1,'value');
gain2=get(handles.slider2,'value');
gain3=get(handles.slider3,'value');
gain4=get(handles.slider4,'value');
gain5=get(handles.slider5,'value');
gain6=get(handles.slider6,'value');
gain7=get(handles.slider7,'value');
gain8=get(handles.slider8,'value');

%%set gain values from sliders in edittext
set(handles.edit1, 'String',gain1);
set(handles.edit2, 'String',gain2);
set(handles.edit3, 'String',gain3);
set(handles.edit4, 'String',gain4);
set(handles.edit5, 'String',gain5);
set(handles.edit6, 'String',gain6);
set(handles.edit7, 'String',gain7);
set(handles.edit8, 'String',gain8);

%%cut off low pass dalama Hz
orde=16;
cut_off=500;
a=fir1(orde,cut_off/(Fs/2),'low');    %Design filter
y1=gain1*filter(a,1,live_sound);

%%%bandpass1

f1=501;      % corner frequansy
f2=1000;      % corner frequancy
b1=fir1(orde,[f1/(Fs/2) f2/(Fs/2)],'bandpass');    %Design filter
y2=gain2*filter(b1,1,live_sound);
 
%%bandpass2
f3=1001;      % corner frequancy
f4=2000;      % corner frequancy
b2=fir1(orde,[f3/(Fs/2) f4/(Fs/2)],'bandpass');    %Design filter
y3=gain3*filter(b2,1,live_sound);

%% %bandpass3
f4=2001;      % corner frequancy
f5=3000;      % corner frequancy
 b3=fir1(orde,[f4/(Fs/2) f5/(Fs/2)],'bandpass');    %Design filter
 y4=gain4*filter(b3,1,live_sound);
 
%% %bandpass4
f5=3001;      % corner frequancy
f6=4500;      % corner frequancy
 b4=fir1(orde,[f5/(Fs/2) f6/(Fs/2)],'bandpass');    %Design filter
 y5=gain5*filter(b4,1,live_sound);

% %bandpass5
  f7=4501;      % corner frequancy
f8=6000;      % corner frequancy
  b5=fir1(orde,[f7/(Fs/2) f8/(Fs/2)],'bandpass');    %Design filter
  y6=gain6*filter(b5,1,live_sound);
% 
% %bandpass6
  f9=6001;      % corner frequancy
f10=7500;      % corner frequancy
  b6=fir1(orde,[f9/(Fs/2) f10/(Fs/2)],'bandpass');    %Design filter
  y7=gain7*filter(b6,1,live_sound);

 %highpass
cut_off2=10000;
c=fir1(orde,cut_off2/(Fs/2),'high');    %Design filter
y8=gain8*filter(c,1,live_sound);
%Get summation after applying equalizer
 uTL=y1+y2+y3+y4+y5+y6+y7+y8;
live_sound_play = audioplayer(handles.Volume*uTL, Fs);
%M=fftshift(abs(fft(live_sound)));
%N=fftshift(abs(fft(uTL)));
axes(handles.axes1)
plot(live_sound,'k');
xlim([0 44000]);
axes(handles.axes2)
%plot(abs(M),'k');
xlim([0 44000]);
axes(handles.axes3)
plot(uTL,'c');
xlim([0 44000]);
axes(handles.axes4)
%plot(abs(N),'c');
xlim([0 44000]);
%play(live_sound_play);

end

play(live_sound_play);
guidata(hObject,handles)

% --- Executes on button press in pushbutton14.
function pushbutton14_Callback(hObject, eventdata, handles)
global x ;
global live_sound_play; 
x = 'of'
  clear ;  
play(live_sound_play);
check= str2double(set(handles.address, 'String',0));
recorder=handles.recorder
stop(recorder)
guidata(hObject,handles)


% --- Executes on button press in pushbutton15.
function pushbutton15_Callback(hObject, eventdata, handles)
global sound;
gain1=set(handles.slider1,'value',0);
gain2=set(handles.slider2,'value',0);
gain3=set(handles.slider3,'value',0);
gain4=set(handles.slider4,'value',0);
gain5=set(handles.slider5,'value',0);
gain6=set(handles.slider6,'value',0);
gain7=set(handles.slider7,'value',0);
gain8=set(handles.slider8,'value',0);
check= str2double(set(handles.address, 'String',0));

stop(sound);
axes(handles.axes1);
plot (0);
axes(handles.axes2);
plot(0);
axes(handles.axes3);
plot(0);
axes(handles.axes4);
plot(0);
% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over slider10.




function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
