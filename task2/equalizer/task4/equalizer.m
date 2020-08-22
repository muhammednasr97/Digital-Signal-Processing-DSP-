function varargout = equalizer(varargin)
% EQUALIZER MATLAB code for equalizer.fig
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
%      applied to the GUI before equalizer_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to equalizer_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help equalizer

% Last Modified by GUIDE v2.5 05-Apr-2018 09:13:02

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @equalizer_OpeningFcn, ...
                   'gui_OutputFcn',  @equalizer_OutputFcn, ...
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


% --- Executes just before equalizer is made visible.
function equalizer_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to equalizer (see VARARGIN)

% Choose default command line output for equalizer
c_draw(hObject, eventdata, handles);

handles.p=[];   % Array holds poles in complex formula
handles.z=[];   % Array holds zeros in complex formula
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes equalizer wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = equalizer_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in BrosweButton.
function BrosweButton_Callback(hObject, eventdata, handles)
% hObject    handle to BrosweButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename pathname] = uigetfile({'*.wav '}, 'File Selector');
handles.fullpathname = strcat (pathname,filename);
set(handles.Address,'String' ,handles.fullpathname)
guidata(hObject, handles)

function Play_equalizer (hObject, handles)
global player;
global A;
global rT;
global Num Den;

[handles.y,handles.Fs] = audioread(handles.fullpathname);
% Mono = (handles.y(:,1)+handles.y(:,2))/2;
time = 0:1/handles.Fs:(length(handles.y)-1)/handles.Fs;
handles.Volume=get(handles.VolumeSlider,'value');
%handles.y=handles.y(NewStart:end,:); 
handles.g1=get(handles.slider1,'value');
handles.g2=get(handles.slider7,'value');
handles.g3=get(handles.slider9,'value');
handles.g4=get(handles.slider2,'value');
handles.g5=get(handles.slider3,'value');
 handles.g6=get(handles.slider4,'value');
 handles.g7=get(handles.slider10,'value');
 handles.g8=get(handles.slider8,'value');
 handles.g9=get(handles.slider5,'value');
handles.g10=get(handles.slider6,'value');

set(handles.text24, 'String',handles.g1);
set(handles.text22, 'String',handles.g2);
set(handles.text21, 'String',handles.g3);
set(handles.text29, 'String',handles.g4);
set(handles.text28, 'String',handles.g5);
set(handles.text27, 'String',handles.g6);
set(handles.text30, 'String',handles.g7);
set(handles.text34, 'String',handles.g8);
set(handles.text33, 'String',handles.g9);
set(handles.text32, 'String',handles.g10);
 
cut_off=2204; %cut off low pass dalama Hz
orde=16;
a=fir1(orde,cut_off/(handles.Fs/2),'low');
y1=handles.g1*filter(a,1,handles.y);
x1=handles.g1*a;
[Num,Den]=freqz(x1,1);
s1=freqz(x1,1);
r1=handles.g1*filter(a,1,fft(A));

% %bandpass1
f1=2205;
f2=4409;
b1=fir1(orde,[f1/(handles.Fs/2) f2/(handles.Fs/2)],'bandpass');
x2=handles.g2*b1;
y2=handles.g2*filter(b1,1,handles.y);
[Num1,Den1]=freqz(x2,1)
s2=freqz(x2,1);
r2=handles.g2*filter(b1,1,fft(A));
% 
% %bandpass2
f3=4410;
f4=6614;
b2=fir1(orde,[f3/(handles.Fs/2) f4/(handles.Fs/2)],'bandpass');
y3=handles.g3*filter(b2,1,handles.y);
x3=handles.g3*b2;
[Num2,Den2]=freqz(x3,1)
s3=freqz(x3,1);
r3=handles.g3*filter(b2,1,fft(A));
% %bandpass3
 f4=6615;
f5=8819;
 b3=fir1(orde,[f4/(handles.Fs/2) f5/(handles.Fs/2)],'bandpass');
 y4=handles.g4*filter(b3,1,handles.y);
 x4=handles.g4*b3;
[Num3,Den3]=freqz(x4,1)
s4=freqz(x4,1);
 r4=handles.g4*filter(b3,1,fft(A));
% 
% %bandpass4
 f5=8820;
f6=11024;
 b4=fir1(orde,[f5/(handles.Fs/2) f6/(handles.Fs/2)],'bandpass');
 y5=handles.g5*filter(b4,1,handles.y);
 x5=handles.g5*b4;
[Num4,Den4]=freqz(x5,1)
s5=freqz(x5,1);
 r5=handles.g5*filter(b4,1,fft(A));
% 
% %bandpass5
  f7=11025;
f8=13229;
  b5=fir1(orde,[f7/(handles.Fs/2) f8/(handles.Fs/2)],'bandpass');
  y6=handles.g6*filter(b5,1,handles.y);
  x6=handles.g6*b5;
[Num5,Den5]=freqz(x6,1)
s6=freqz(x6,1);
  r6=handles.g6*filter(b5,1,fft(A));
% 
% %bandpass6
  f9=13230;
f10=15434;
  b6=fir1(orde,[f9/(handles.Fs/2) f10/(handles.Fs/2)],'bandpass');
  y7=handles.g7*filter(b6,1,handles.y);
  x7=handles.g7*b6;
[Num6,Den6]=freqz(x7,1)
s7=freqz(x6,1);
 r7=handles.g7*filter(b6,1,fft(A));
% 
% %bandpass7
  f11=15435;
f12=17639;
  b7=fir1(orde,[f11/(handles.Fs/2) f12/(handles.Fs/2)],'bandpass');
  y8=handles.g8*filter(b7,1,handles.y);
  x8=handles.g8*b7;
[Num7,Den7]=freqz(x8,1)
s8=freqz(x8,1);
r8=handles.g8*filter(b7,1,fft(A));% 
 % %bandpass8
  f13=17640;
f14=19844;
  b8=fir1(orde,[f13/(handles.Fs/2) f14/(handles.Fs/2)],'bandpass');
  y9=handles.g9*filter(b8,1,handles.y);
  x9=handles.g9*b8;
[Num8,Den8]=freqz(x9,1)
s9=freqz(x9,1);
  r9=handles.g9*filter(b8,1,fft(A));
% 
 %highpass
cut_off2=19845;
c=fir1(orde,cut_off2/(handles.Fs/2),'high');
y10=handles.g10*filter(c,1,handles.y);
x10=handles.g10*c;
[Num9,Den9]=freqz(x10,1)
s10=freqz(x10,1);
r10=handles.g1*filter(c,1,fft(A));
 handles.yT=y1+y2+y3+y4+y5+y6+y7+y8+y9+y10;
 sT=s1+s2+s3+s4+s4+s5+s6+s7+s8+s9+s10;
 rT=r1+r2+r3+r4+r5+r6+r7+r8+r9+r10;
player = audioplayer(handles.Volume*handles.yT, handles.Fs);
 axes(handles.axes16);
%   plot(Mono);
 plot(time,handles.y);
 axes(handles.axes4);
 plot(unwrap(angle(fft(handles.y))));
 axes(handles.axes5);
 plot(abs(fft(handles.y)));
 axes(handles.axes2)
 plot(handles.yT);
axes(handles.axes3);
 plot(unwrap(angle(fft(handles.yT))));
 axes(handles.axes6)
plot(abs(fft(handles.yT)));
axes(handles.Plot_H_Axes);
plot(abs(sT));
% axes(handles.axes18)
% plot(unwrap(angle(sT)));

guidata(hObject,handles)
% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


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
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
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
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


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
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


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
function slider9_Callback(hObject, eventdata, handles)
% hObject    handle to slider9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


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
% hObject    handle to slider10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider7_Callback(hObject, eventdata, handles)
% hObject    handle to slider7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


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
function slider5_Callback(hObject, eventdata, handles)
% hObject    handle to slider5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


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
% hObject    handle to slider6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


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
function slider8_Callback(hObject, eventdata, handles)
% hObject    handle to slider8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in PlayButton.
function PlayButton_Callback(hObject, eventdata, handles)
% hObject    handle to PlayButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global player ;
Play_equalizer(hObject, handles);
play(player);
guidata(hObject, handles)

% --- Executes on button press in PauseButton.
function PauseButton_Callback(hObject, eventdata, handles)
% hObject    handle to PauseButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global player ;
Play_equalizer(hObject, handles);
pause(player);
guidata(hObject, handles)

% --- Executes on button press in ResumeButton.
function ResumeButton_Callback(hObject, eventdata, handles)
% hObject    handle to ResumeButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global player ;
Play_equalizer(hObject, handles);
resume(player);
guidata(hObject, handles)

% --- Executes on button press in StopButton.
function StopButton_Callback(hObject, eventdata, handles)
% hObject    handle to StopButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global player ;
Play_equalizer(hObject, handles);
stop(player);
guidata(hObject, handles)

% --- Executes on slider movement.
function VolumeSlider_Callback(hObject, eventdata, handles)
% hObject    handle to VolumeSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function VolumeSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to VolumeSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in Record.
function Record_Callback(hObject, eventdata, handles)
% hObject    handle to Record (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global A
global rT
freq_plot(hObject, eventdata, handles);


handles=guidata(hObject);
handles.stop = 0;
guidata(hObject,handles);
 recObj= audiorecorder;
     

 recordblocking(recObj,0.1);
 x = getaudiodata(recObj);
A=[0];
while 1

    recObj = audiorecorder;
    disp('Recording')
  
    recordblocking(recObj,0.1);
    
    y = getaudiodata(recObj);
       A=[y.'];
     
axes(handles.axes1)
plot(A)
% axes(handles.axes11)
%     plot(abs(rT));
     %calculate signal fft
      axes(handles.axes8)
handles.A_fft=fft(A);
plot(abs(fft(A)))
%plot the original signal in freq domain

axes(handles.axes12)
plot(unwrap(angle(handles.A_fft)))
if handles.stop
    break;
end

end
Play_equalizer(hObject, handles);
% --- Executes on button press in StopRecord.
function StopRecord_Callback(hObject, eventdata, handles)
% hObject    handle to StopRecord (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

 handles.stop = 1;
return ;
% --- Executes on button press in AddPoles.
function AddPoles_Callback(hObject, eventdata, handles)
% hObject    handle to AddPoles (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%click to add a pole point in the unit circle
[x,y]=ginput(1);

%push a point   to the poles array 
handles.p(length(handles.p)+1)=x+1j*y;

%plot the freq response and its effect in the original signal
freq_plot(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);
brush on

% --- Executes on button press in AddZeros.
function AddZeros_Callback(hObject, eventdata, handles)
% hObject    handle to AddZeros (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[x,y]=ginput(1);

%push a point and its conjugate to the zeros array 
handles.z(length(handles.z)+1)=x+1j*y;


% Update handles structure
guidata(hObject, handles);

%plot the freq response and its effect in the original signal
freq_plot(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);
brush on


function c_draw(hObject, eventdata, handles)
%draw unit circle
circle_1 = exp(1i*(0:63)*2*pi/64); 
 axes(handles.axes9)
plot(real(circle_1),imag(circle_1),'.');

axis([-2 2 -2 2]); 
axis('equal'); 
hold on
plot( [0 0], [1.2 -1.2], '-')
plot( [1.2 -1.2], [0 0], '-')
xlim([-1.2 1.2])
ylim([-1.2 1.2])
hold off;
% Update handles structure
guidata(hObject, handles);


function freq_plot(hObject, eventdata, handles)
global A
%clear the unit circuit axes
cla(handles.axes4,'reset');
axes(handles.axes4)
c_draw(hObject, eventdata, handles);
hold on

%plot poles and zeros markers
plot_p=plot(real(handles.p),imag(handles.p),'X');
plot_z=plot(real(handles.z),imag(handles.z),'O');
set(plot_p,'markersize',7,'linewidth',3);
set(plot_z,'markersize',7,'linewidth',3);
hold off;
%Get the transfer function coeffecients
[b,a]=zp2tf(handles.z',handles.p,1);

%Get the frequency response 
[h,w] = freqz(b,a,length(fft(A)));

%plot the frequency response mag 
axes(handles.axes13)
plot(w/pi,20*log10(abs(h)))
xlabel('Normalized Frequency')
ylabel('Magnitude ')
grid on;

%plot the frequency response phase
axes(handles.axes14)
plot(w/pi,20*log10(angle(h)))
xlabel('Normalized Frequency ')
ylabel('Phase ')
grid on;

%apply the filter in the orignial signal
filter=h'.*fft(A);
%axes(handles.axes11)
%plot(real(ifft(filter)))


%plot the filtered signal in time and freq domains
axes(handles.axes12)
plot(abs(filter))


  
% Update handles structure
guidata(hObject, handles);



% --- Executes on button press in movepole.
function movepole_Callback(hObject, eventdata, handles)
[x,y]=ginput(1);

%search for the selected zero from the zero array and remove it
temp=find(real(handles.p <(x+0.1)) & real(handles.p>(x-0.1)) );
handles.p(find(real(handles.p <(x+0.1)) & real(handles.p>(x-0.1)) ))=[];


h= impoint.empty;
h= impoint
position = getPosition(h)
x=position(1);
y=position(2);
handles.p(length(handles.p)+1)=x+1j*y;

freq_plot(hObject, eventdata, handles);
guidata(hObject, handles);
% hObject    handle to movepole (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in movezero.
function movezero_Callback(hObject, eventdata, handles)
[x,y]=ginput(1);

%search for the selected zero from the zero array and remove it
temp=find((real(handles.z <(x+0.1)) & real(handles.z>(x-0.1))));
handles.z(find((real(handles.z <(x+0.1)) & real(handles.z>(x-0.1)))))=[];


h= impoint.empty;
h= impoint
position = getPosition(h)
x=position(1);
y=position(2);
handles.z(length(handles.z)+1)=x+1j*y;

freq_plot(hObject, eventdata, handles);
guidata(hObject, handles);


% --- Executes on button press in plot_H.
function plot_H_Callback(hObject, eventdata, handles)
% hObject    handle to plot_H (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
