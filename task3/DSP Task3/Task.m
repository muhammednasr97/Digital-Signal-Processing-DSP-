function varargout = Task(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Task_OpeningFcn, ...
                   'gui_OutputFcn',  @Task_OutputFcn, ...
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



function Task_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;

guidata(hObject, handles);





function varargout = Task_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;


% --- Executes on button press in Audio_Browse.
function Audio_Browse_Callback(hObject, eventdata, handles)
global file_name;
[filename,pathname] = uigetfile({'*.wav'},'Select an Audio File');
handles.fullpathname = strcat(pathname, filename);
[handles.audio_data,handles.Fs] = audioread(handles.fullpathname);
t=0:1/handles.Fs:(length(handles.audio_data)-1)/handles.Fs;
axes(handles.axes1) 
plot(handles.audio_data)
set(handles.axes1,'XMinorTick','on')
grid on
function ECG_Browse_Callback(hObject, eventdata, handles)
[basename,folder]=uigetfile();
file_name=fullfile(folder,basename);
if(strcmp(file_name,'B:\DSP Task3\ECG.mat'))
clc;
load ('ECG.mat')
ECGsignal =val;
Fs = 360;
t = (0:length(ECGsignal)-1)/Fs; 
axes(handles.axes1) 
plot(t,ECGsignal);
grid on
end


% --- Executes on button press in Ultrasound_Browse.
function Ultrasound_Browse_Callback(hObject, eventdata, handles)
[basename,folder]=uigetfile();
file_name=fullfile(folder,basename);
if(strcmp(file_name,'B:\DSP Task3\ult_sig.mat'))
clc;
load ('ult_sig.mat')
axes(handles.axes1) 
plot(ult_sig);
grid on
end


% --- Executes on button press in MR_Browse.
function MR_Browse_Callback(hObject, eventdata, handles)
[basename,folder]=uigetfile();
file_name=fullfile(folder,basename);
if(strcmp(file_name,'B:\DSP Task3\MRS.xlsx'))
clc;
signal=xlsread('MRS.xlsx');
axes(handles.axes1) 
plot(signal);
grid on
end


% --- Executes on button press in Comp_Audio.
function Comp_Audio_Callback(hObject, eventdata, handles)
global file_name;
[handles.audio_data,handles.Fs] = audioread('B:\DSP Task3\Bach2.wav');

%chosing a block size 
windowSize = 8192;

%changing compression  percentages
samplesHalf = windowSize / 2;

%initializing compressed matrice
DataCompressed = [];


%actual compression
for i=1:windowSize:length(handles.audio_data)-windowSize
    windowDCT = dct(handles.audio_data(i:i+windowSize-1));
    DataCompressed(i:i+windowSize-1) = idct(windowDCT(1:samplesHalf), windowSize);
   
end
axes(handles.axes2) % Select the proper axes
plot(windowDCT)
ylim(handles.axes2,[-1 1]);
xlim(handles.axes2,[0 4500]);
set(handles.axes2,'XMinorTick','on')
grid on
audiowrite('song_compressed_DCT.wav',DataCompressed,handles.Fs)
[comp_data,handles.Fs] = audioread('B:\DSP Task3\song_compressed_DCT.wav');
t=0:1/handles.Fs:(length(comp_data)-1)/handles.Fs;
axes(handles.axes3) 
plot(comp_data)
set(handles.axes3,'XMinorTick','on')
grid on
function Comp_ECG_Callback(hObject, eventdata, handles)
load ('ECG.mat')
save ECG_origin.mat val
ECGsignal = val;
Fs = 360;
t = (0:length(ECGsignal)-1)/Fs;
sig_comp=dct(val);
Th=0.52;%Threshold value
Pos_th=find(abs(sig_comp)<Th);
Sig_Afterthreshold=sig_comp;
Sig_Afterthreshold(Pos_th)=0;
Q=8;% 1 byte (value representation)
Max_SigAfter=max(Sig_Afterthreshold);
Min_SigAfter=min(Sig_Afterthreshold);
Sig_Quant=round((-1+2^Q)*(Sig_Afterthreshold-Min_SigAfter)/(Max_SigAfter-Min_SigAfter));
Sig_RLE=rle(Sig_Quant);
Sig_Irle=irle(Sig_RLE);% Inverse Run Length Codising 
sig_comp=((Max_SigAfter-Min_SigAfter)/(-1+2^Q))*Sig_Irle+Min_SigAfter;% Inverse Quantization
sig_decomp=idct(sig_comp);%Décompressed Signal
axes(handles.axes2) 
plot(t,sig_comp);
ylim(handles.axes2,[-500 500]);
grid on
axes(handles.axes3) 
plot(t,sig_decomp);
grid on
save ECG_Compressed_DCT.mat sig_comp
sig_compressed=dir('ECG_Compressed_DCT.mat')
original_b=dir(('ECG_origin.mat'))
comp_ratio=((original_b.bytes-sig_compressed.bytes)/original_b.bytes)*100
set(handles.edit1,'String',comp_ratio)


% --- Executes on button press in Comp_Ultrasound.
function Comp_Ultrasound_Callback(hObject, eventdata, handles)
load ('ult_sig.mat')
save ULT_origin.mat ult_sig
sig_comp=dct(ult_sig);
Th=0.0052;%Threshold value
Pos_th=find(abs(sig_comp)<Th);
Sig_Afterthreshold=sig_comp;
Sig_Afterthreshold(Pos_th)=0;
Q=6;% 1 byte (value representation)
Max_SigAfter=max(Sig_Afterthreshold);
Min_SigAfter=min(Sig_Afterthreshold);
Sig_Quant=round((-1+2^Q)*(Sig_Afterthreshold-Min_SigAfter)/(Max_SigAfter-Min_SigAfter));
Sig_RLE=rle(Sig_Quant);
Sig_Irle=irle(Sig_RLE);% Inverse Run Length Codising 
sig_comp=((Max_SigAfter-Min_SigAfter)/(-1+2^Q))*Sig_Irle+Min_SigAfter;% Inverse Quantization
sig_decomp=idct(sig_comp);%Décompressed Signal
axes(handles.axes2) 
plot(sig_comp);
grid on
axes(handles.axes3) 
plot(sig_decomp);
grid on
save ULS_Compressed_DCT.mat sig_comp
sig_compressed=dir('ULS_Compressed_DCT.mat')
original_b=dir(('ULS_origin.mat'))
comp_ratio=((original_b.bytes-sig_compressed.bytes)/original_b.bytes)*100
set(handles.edit1,'String',comp_ratio)


% --- Executes on button press in Comp_MR.
function Comp_MR_Callback(hObject, eventdata, handles)
signal=xlsread('MRS.xlsx');
save MRS_sig_Compressed_DCT_origin.xlsx signal

sig_comp=dct(signal);
Th=0.0052;%Threshold value
Pos_th=find(abs(sig_comp)<Th);
Sig_Afterthreshold=sig_comp;
Sig_Afterthreshold(Pos_th)=0;
Q=6;% 1 byte (value representation)
Max_SigAfter=max(Sig_Afterthreshold);
Min_SigAfter=min(Sig_Afterthreshold);
Sig_Quant=round((-1+2^Q)*(Sig_Afterthreshold-Min_SigAfter)/(Max_SigAfter-Min_SigAfter));
Sig_RLE=rle(Sig_Quant);
Sig_Irle=irle(Sig_RLE);% Inverse Run Length Codising 
sig_comp=((Max_SigAfter-Min_SigAfter)/(-1+2^Q))*Sig_Irle+Min_SigAfter;% Inverse Quantization
sig_decomp=idct(sig_comp);%Décompressed Signal
axes(handles.axes2) 
plot(sig_comp);
grid on
axes(handles.axes3) 
plot(sig_decomp);
grid on
save MRS_sig_Compressed_DCT.xlsx sig_decomp
original=dir('MRS_sig_Compressed_DCT.xlsx')
original1=dir(('MRS_sig_Compressed_DCT_origin.xlsx'))
comp_ratio=((original1.bytes-original.bytes)/original1.bytes)*100
set(handles.edit1,'String',comp_ratio)



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
