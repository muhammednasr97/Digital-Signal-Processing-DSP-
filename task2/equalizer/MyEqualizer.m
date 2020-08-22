function varargout = MyEqualizer(varargin)
% MYEQUALIZER M-file for MyEqualizer.fig
%      MYEQUALIZER, by itself, creates a new MYEQUALIZER or raises the existing
%      singleton*.
%
%      H = MYEQUALIZER returns the handle to a new MYEQUALIZER or the handle to
%      the existing singleton*.
%
%      MYEQUALIZER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MYEQUALIZER.M with the given input arguments.
%
%      MYEQUALIZER('Property','Value',...) creates a new MYEQUALIZER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MyEqualizer_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MyEqualizer_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES
% Edit the above text to modify the response to help MyEqualizer
% Last Modified by GUIDE v2.5 12-Oct-2008 20:30:20
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MyEqualizer_OpeningFcn, ...
                   'gui_OutputFcn',  @MyEqualizer_OutputFcn, ...
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
% --- Executes just before MyEqualizer is made visible.
function MyEqualizer_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MyEqualizer (see VARARGIN)
global stop C Fs;
stop=1;
Fs=44100;
C=zeros(1,5);
set(handles.C1_var,'min',-20);
set(handles.C1_var,'max',20);
set(handles.C1_var,'value',0);
set(handles.C1_var,'SliderStep',[0.025,0.05]);
set(handles.C1_val,'string',num2str(0));
set(handles.C2_var,'min',-20);
set(handles.C2_var,'max',20);
set(handles.C2_var,'value',0);
set(handles.C2_var,'SliderStep',[0.025,0.05]);
set(handles.C2_val,'string',num2str(0));
set(handles.C3_var,'min',-20);
set(handles.C3_var,'max',20);
set(handles.C3_var,'value',0);
set(handles.C3_var,'SliderStep',[0.025,0.05]);
set(handles.C3_val,'string',num2str(0));
set(handles.C4_var,'min',-20);
set(handles.C4_var,'max',20);
set(handles.C4_var,'value',0);
set(handles.C4_var,'SliderStep',[0.025,0.05]);
set(handles.C4_val,'string',num2str(0));
set(handles.C5_var,'min',-20);
set(handles.C5_var,'max',20);
set(handles.C5_var,'value',0);
set(handles.C5_var,'SliderStep',[0.025,0.05]);
set(handles.C5_val,'string',num2str(0));
equalizer_plot();
% Choose default command line output for MyEqualizer
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);
% UIWAIT makes MyEqualizer wait for user response (see UIRESUME)
% uiwait(handles.figure1);
% --- Outputs from this function are returned to the command line.
function varargout = MyEqualizer_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Get default command line output from handles structure
varargout{1} = handles.output;
% --- Executes on slider movement.
function C1_var_Callback(hObject, eventdata, handles)
% hObject    handle to C1_var (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global C;
C(1)=get(hObject,'value');
set(handles.C1_val,'string',num2str(C(1)));
% --- Executes during object creation, after setting all properties.
function C1_var_CreateFcn(hObject, eventdata, handles)
% hObject    handle to C1_var (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
% --- Executes on slider movement.
function C2_var_Callback(hObject, eventdata, handles)
% hObject    handle to C2_var (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global C;
C(2)=get(hObject,'value');
set(handles.C2_val,'string',num2str(C(2)));
% --- Executes during object creation, after setting all properties.
function C2_var_CreateFcn(hObject, eventdata, handles)
% hObject    handle to C2_var (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
% --- Executes on slider movement.
function C3_var_Callback(hObject, eventdata, handles)
% hObject    handle to C3_var (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global C;
C(3)=get(hObject,'value');
set(handles.C3_val,'string',num2str(C(3)));
% --- Executes during object creation, after setting all properties.
function C3_var_CreateFcn(hObject, eventdata, handles)
% hObject    handle to C3_var (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
% --- Executes on slider movement.
function C4_var_Callback(hObject, eventdata, handles)
% hObject    handle to C4_var (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global C;
C(4)=get(hObject,'value');
set(handles.C4_val,'string',num2str(C(4)));
% --- Executes during object creation, after setting all properties.
function C4_var_CreateFcn(hObject, eventdata, handles)
% hObject    handle to C4_var (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
% --- Executes on slider movement.
function C5_var_Callback(hObject, eventdata, handles)
% hObject    handle to C5_var (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global C;
C(5)=get(hObject,'value');
set(handles.C5_val,'string',num2str(C(5)));
% --- Executes during object creation, after setting all properties.
function C5_var_CreateFcn(hObject, eventdata, handles)
% hObject    handle to C5_var (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
% --- Executes on button press in plot_H.
function plot_H_Callback(hObject, eventdata, handles)
% hObject    handle to plot_H (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global C Fs;
equalizer_plot();
function equalizer_plot()
global C Fs;
[a,b]=coef();
H=0;
for i=1:5
    H=H+10^(C(i)/20)*abs(freqz(b{i},a{i},1024));
end
plot(1e-3*Fs*[0:1023]/2048,20*log10(H));
xlabel('Frequency [kHz]');
ylabel('Magnitude [dB]');
title('Caracteristica egalizorului audio');
axis([0 1e-3*Fs/2 -21 21]);
grid on;
function [a,b]=coef()
global Fs;
%Filtrul 1
Rp1=0.5;
Rs1=30;
Fp1=4.1e3/(Fs/2);                     
Fs1=4.5e3/(Fs/2);                     
n1=cheb1ord(Fp1,Fs1,Rp1,Rs1);
[b1,a1]=cheby1(n1,Rp1,Fp1,'low');
%Filtrul 2
Rp2=0.5;
Rs2=30;
Fp2=1e3*[4.25,8.75]/(Fs/2);                   
Fs2=1e3*[3.9,9.35]/(Fs/2);
n2=cheb1ord(Fp2,Fs2,Rp2,Rs2);
[b2,a2]=cheby1(n2,Rp2,Fp2);
%Filtrul 3
Rp3=0.5;
Rs3=30;
Fp3=1e3*[8.95,13.25]/(Fs/2);                   
Fs3=1e3*[8.35,13.65]/(Fs/2);
n3=cheb1ord(Fp3,Fs3,Rp3,Rs3);
[b3,a3]=cheby1(n3,Rp3,Fp3);
%Filtrul 4
Rp4=0.5;
Rs4=30;
Fp4=1e3*[13.4,16.8]/(Fs/2);
Fs4=1e3*[13,17.5]/(Fs/2);
n4=cheb1ord(Fp4,Fs4,Rp4,Rs4);
[b4,a4]=cheby1(n4,Rp4,Fp4);
%Filtrul 5
Rp5=0.5;
Rs5=30;
Fp5=1e3*17/(Fs/2);                  
Fs5=1e3*17.4/(Fs/2);
n5=cheb1ord(Fp4,Fs4,Rp4,Rs4);
[b5,a5]=cheby1(n5,Rp5,Fp5,'high');
a={a1,a2,a3,a4,a5};
b={b1,b2,b3,b4,b5};
% --- Executes on button press in reset_H.
function reset_H_Callback(hObject, eventdata, handles)
% hObject    handle to reset_H (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Fs C;
C=zeros(1,5);
Fs=44100;
set(handles.C1_val,'string',num2str(0));
set(handles.C2_val,'string',num2str(0));
set(handles.C3_val,'string',num2str(0));
set(handles.C4_val,'string',num2str(0));
set(handles.C5_val,'string',num2str(0));
set(handles.C1_var,'value',0);
set(handles.C2_var,'value',0);
set(handles.C3_var,'value',0);
set(handles.C4_var,'value',0);
set(handles.C5_var,'value',0);
equalizer_plot();
function C1_val_Callback(hObject, eventdata, handles)
% hObject    handle to C1_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global C;
C(1)=str2num(get(hObject,'string'));
minn=get(handles.C1_var,'min');
maxx=get(handles.C1_var,'max');
if(C(1)<minn || C(1)>maxx)
    C(1)=get(handles.C1_var,'value');
    set(hObject,'string',num2str(0));
else
    set(handles.C1_var,'value',C(1));
end
% Hints: get(hObject,'String') returns contents of C1_val as text
%        str2double(get(hObject,'String')) returns contents of C1_val as a double
% --- Executes during object creation, after setting all properties.
function C1_val_CreateFcn(hObject, eventdata, handles)
% hObject    handle to C1_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function C2_val_Callback(hObject, eventdata, handles)
% hObject    handle to C2_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of C2_val as text
%        str2double(get(hObject,'String')) returns contents of C2_val as a double
global C;
C(2)=str2num(get(hObject,'string'));
minn=get(handles.C2_var,'min');
maxx=get(handles.C2_var,'max');
if(C(2)<minn || C(2)>maxx)
    C(2)=get(handles.C2_var,'value');
    set(hObject,'string',num2str(0));
else
    set(handles.C2_var,'value',C(2));
end
% --- Executes during object creation, after setting all properties.
function C2_val_CreateFcn(hObject, eventdata, handles)
% hObject    handle to C2_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function C3_val_Callback(hObject, eventdata, handles)
% hObject    handle to C3_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of C3_val as text
%        str2double(get(hObject,'String')) returns contents of C3_val as a double
global C;
C(3)=str2num(get(hObject,'string'));
minn=get(handles.C3_var,'min');
maxx=get(handles.C3_var,'max');
if(C(3)<minn || C(3)>maxx)
    C(3)=get(handles.C3_var,'value');
    set(hObject,'string',num2str(0));
else
    set(handles.C3_var,'value',C(3));
end
% --- Executes during object creation, after setting all properties.
function C3_val_CreateFcn(hObject, eventdata, handles)
% hObject    handle to C3_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function C4_val_Callback(hObject, eventdata, handles)
% hObject    handle to C4_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of C4_val as text
%        str2double(get(hObject,'String')) returns contents of C4_val as a double
global C;
C(4)=str2num(get(hObject,'string'));
minn=get(handles.C4_var,'min');
maxx=get(handles.C4_var,'max');
if(C(4)<minn || C(4)>maxx)
    C(4)=get(handles.C4_var,'value');
    set(hObject,'string',num2str(0));
else
    set(handles.C4_var,'value',C(4));
end
% --- Executes during object creation, after setting all properties.
function C4_val_CreateFcn(hObject, eventdata, handles)
% hObject    handle to C4_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function C5_val_Callback(hObject, eventdata, handles)
% hObject    handle to C5_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of C5_val as text
%        str2double(get(hObject,'String')) returns contents of C5_val as a double
global C;
C(5)=str2num(get(hObject,'string'));
minn=get(handles.C5_var,'min');
maxx=get(handles.C5_var,'max');
if(C(5)<minn || C(5)>maxx)
    C(5)=get(handles.C5_var,'value');
    set(hObject,'string',num2str(0));
else
    set(handles.C5_var,'value',C(5));
end
% --- Executes during object creation, after setting all properties.
function C5_val_CreateFcn(hObject, eventdata, handles)
% hObject    handle to C5_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
% --- Executes on button press in load.
function load_Callback(hObject, eventdata, handles)
% hObject    handle to load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global file_name;
file_name=uigetfile('*wav','Alegeti un fisier de tip .wav');
% --- Executes on button press in play.
function play_Callback(hObject, eventdata, handles)
% hObject    handle to play (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global stop file_name C;
stop=1;
equalizer_play();
function equalizer_play()
global stop file_name C;
[x,Fs]=audioread(file_name);
[a,b]=coef();
l_bucata=2*Fs;
Nb=round(length(x)/l_bucata);
y=0;
for i=1:floor(Nb)
    bucata=x((i-1)*l_bucata+1:i*l_bucata);
    for k=1:5
        y=y+filter(10^(C(k)/20)*b{k},a{k},bucata);
        if(stop==0)
            break;
        end     
    end
    audioplay(y,Fs,'async');
    y=0;
    if(stop==0)
        break;
    end   
end
% --- Executes on button press in stop.
function stop_Callback(hObject, eventdata, handles)
% hObject    handle to stop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global stop;
stop=0;
