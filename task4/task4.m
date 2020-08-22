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

% Last Modified by GUIDE v2.5 18-Apr-2019 13:34:50

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


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName,PathName] = uigetfile({'*.*'},'Select Audio');
filename = fullfile(PathName,FileName);
[y,Fs] = audioread(filename);   
left = y(:,1); 
right = y(:,2); 
S = (left+right)/2;
%Fs = 8000;
[R,D] = rat(8000/Fs);
S = resample(S, R, D);
L = length(S);
Win = floor(L/10);
Over = floor(Win/2);
axes(handles.axes2)
spectrogram(S,hamming(Win),Over);
SPECT=spectrogram(S,hamming(Win),Over);
SPECT_MAGNITUDE= 100*log(abs(SPECT));
M = mean(SPECT_MAGNITUDE);
PAD_MEAN = padarray(M, size(SPECT_MAGNITUDE(:,1)),0,'post');
PAD_MEAN =PAD_MEAN(1:end-1 ,1:end-1 );
disp(size(M))
disp(size(SPECT_MAGNITUDE(:,1)))
disp(size(PAD_MEAN))
disp(size(SPECT_MAGNITUDE))
MAGNITUDE_ZERO_MEAN = (SPECT_MAGNITUDE-(PAD_MEAN))/std(SPECT_MAGNITUDE);
disp(ceil(std( MAGNITUDE_ZERO_MEAN)))
disp(ceil(mean( MAGNITUDE_ZERO_MEAN)))
coeff=fir1(16,450/Fs,'high');
Filtered_MAG=filter(coeff,1,MAGNITUDE_ZERO_MEAN);
 
[PEAK, LOC] = findpeaks(Filtered_MAG ,Fs, 'MinPeakDistance',0.008);

amr1 = audioread('1D.wav');
amr2 = audioread('2D.wav');
amr3 = audioread('3D.wav');
amr4 = audioread('4D.wav');
amr5 = audioread('5D.wav');
adele1 = audioread('1A.wav');
adele2 = audioread('2A.wav');
adele3 = audioread('3A.wav');
adele4 = audioread('4A.wav');
adele5 = audioread('5A.wav');

PD1 =  padarray(amr1, 1,0,'post');
PD2 =  padarray(amr2, 1,0,'post');
PD3 =  padarray(amr3, 2,0,'post'); 
PD4 =  padarray(amr4, 1,0,'post');
PD5 =  padarray(amr5, 1,0,'post');
PA1 =  padarray(adele1, 1,0,'post');
PA2 =  padarray(adele2, 2,0,'post');
PA3 =  padarray(adele3, 1,0,'post');
PA4 =  padarray(adele4, 1,0,'post');
PA5 =  padarray(adele5, 2,0,'post');
disp(PD1)
for i=1:6
PA(i,:)=[PA1(i) PA2(i) PA3(i) PA4(i) PA5(i)];
end
for i=1:6
PD(i,:)=[PD1(i) PD2(i) PD3(i) PD4(i) PD5(i)];
end

disp(size(PA))
disp(size(PD))
disp(size(PEAK))
CA = normxcorr2(PEAK,PA);
CD = normxcorr2(PEAK,PD); 
disp(mean(mean(CA)))
disp(mean(mean(CD)))
Adele_Mean= mean(mean(CA));
Amr_Mean = mean(mean(CD));
if(Adele_Mean<0.1760  ||  Amr_Mean<0.1713)
    set(handles.text2,'String','Unknown');
elseif(Adele_Mean > Amr_Mean)
    set(handles.text2,'String','Adele singer');
elseif(Adele_Mean < Amr_Mean)
    set(handles.text2,'String','Amr singer');
end



function edit_Callback(hObject, eventdata, handles)
% hObject    handle to edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit as text
%        str2double(get(hObject,'String')) returns contents of edit as a double


% --- Executes during object creation, after setting all properties.
function edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
