function varargout = voice(varargin)
% VOICE MATLAB code for voice.fig
%      VOICE, by itself, creates a new VOICE or raises the existing
%      singleton*.
%
%      H = VOICE returns the handle to a new VOICE or the handle to
%      the existing singleton*.
%
%      VOICE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VOICE.M with the given input arguments.
%
%      VOICE('Property','Value',...) creates a new VOICE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before voice_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to voice_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help voice

% Last Modified by GUIDE v2.5 18-Apr-2019 10:25:34

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @voice_OpeningFcn, ...
                   'gui_OutputFcn',  @voice_OutputFcn, ...
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


% --- Executes just before voice is made visible.
function voice_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to voice (see VARARGIN)

% Choose default command line output for voice
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes voice wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = voice_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
[FileName,PathName] = uigetfile({'*.*'},'Select Audio');
filename = fullfile(PathName,FileName);
msgbox( '  Big O notation is dying, please wait.  ')
%msgbox( '  It may Take some moments, please wait.  ')
[y,Fs] = audioread(filename);
t = (0:length(y)-1)/Fs;
axes(handles.axes1)
plot(t,y)
left = y(:,1); 
right = y(:,2); 
S = (left+right)/2;
%Fs = 8000;
[R, D]= rat(8000/Fs);
S = resample(S, R, D);
L = length(S);
Win = floor(L/10);
Over = floor(Win/2);
%disp(Win)
%nff = max(256,2^nextpow2(Win));
%disp(nff)
axes(handles.axes2)
%S = (8000*L)/44100 ;
%disp(S)
%spectrogram(y,'xaxis');
spectrogram(S,hamming(Win),Over);
%axes(handles.axes2)
SPECT=spectrogram(S,hamming(Win),Over);
%save SPECT
SPECT_MAGNITUDE= 100*log(abs(SPECT));

 M =mean(SPECT_MAGNITUDE);
 %save M
 %M = M + zeros(65537, :);
 PAD_MEAN= padarray(M, size(SPECT_MAGNITUDE(:,1)),0,'post');
 PAD_MEAN=PAD_MEAN(1:end-1 ,1:end-1 );
 disp(size(M))
 disp(size(SPECT_MAGNITUDE(:,1)))
 disp(size(PAD_MEAN))
 disp(size(SPECT_MAGNITUDE))
 MAGNITUDE_ZERO_MEAN = (SPECT_MAGNITUDE-(PAD_MEAN))/std(SPECT_MAGNITUDE);
%  mean(MAGNITUDE)
% var(MAGNITUDE)
% std(MAGNITUDE)
 disp(ceil(std( MAGNITUDE_ZERO_MEAN)))
 disp(ceil(mean( MAGNITUDE_ZERO_MEAN)))
 coeff=fir1(16,450/Fs,'high');
 Filtered_MAG=filter(coeff,1,MAGNITUDE_ZERO_MEAN);
 
[PEAK, LOC] = findpeaks(Filtered_MAG ,Fs, 'MinPeakDistance',0.008);
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%  save LOC.txt
 %msgbox('   SIGNAL NOT FOUND    ')
%  pause(10)
 %save PD5
 %save LOC5
%  disp(PEAK1)
%  %disp(LOC)
%  disp(Fs)

 axes(handles.axes1)
 plot(Filtered_MAG,'--')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
        load PA1;
        close
        load PA2;
        close
        load PA3;
        close
        load PA4;
        close
        load PA5;
        close
        load PD1;
        close
        load PD2;
        close
        load PD3;
        close
        load PD4;
        close
        load PD5;
        close
        PD1 =  padarray(PD1, 1,0,'post');
        PD2 =  padarray(PD2, 1,0,'post');
        PD3 =  padarray(PD3, 2,0,'post'); 
        PD4 =  padarray(PD4, 1,0,'post');
        PD5 =  padarray(PD5, 1,0,'post');
        PA1 =  padarray(PA1, 1,0,'post');
        PA2 =  padarray(PA2, 2,0,'post');
        PA3 =  padarray(PA3, 1,0,'post');
        PA4 =  padarray(PA4, 1,0,'post');
        PA5 =  padarray(PA5, 2,0,'post');
        disp(PD1)
  for i=1:6
  PA(i,:)=[PA1(i) PA2(i) PA3(i) PA4(i) PA5(i)];
  end
  for i=1:6
  PD(i,:)=[PD1(i) PD2(i) PD3(i) PD4(i) PD5(i)];
  end
%    PA = PA1+PA2+PA3+PA4+PA5;
%    PD = PD1+PD2+PD3+PD4+PD5;
%     disp(PA)   
%     disp(PD)
   disp(size(PA))
   disp(size(PD))
   disp(size(PEAK))
CA = normxcorr2(PEAK,PA);
CD = normxcorr2(PEAK,PD); 
disp(mean(mean(CA)))
disp(mean(mean(CD)))
Andra_Mean= mean(mean(CA));
Amr_Mean = mean(mean(CD));
if(Andra_Mean<0.1760  ||  Amr_Mean<0.1713)
    msgbox('   La2 M4 3arf Men Da  ')
 
elseif(Andra_Mean > Amr_Mean)
    msgbox('  De Andra Day Wallahy   ')
   
elseif(Andra_Mean < Amr_Mean)
    msgbox(' Da Amr Diab Wallahy ')
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
