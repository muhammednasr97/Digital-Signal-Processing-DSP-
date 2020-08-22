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


% --- Executes on button press in ECG_Browse.
function ECG_Browse_Callback(hObject, eventdata, handles)
[basename,folder]=uigetfile();
file_name=fullfile(folder,basename);
if(strcmp(file_name,'B:\DSP_Task3_WHT\ECG.mat'))
clc;
load ('ECG.mat')
ECGsignal =val;
axes(handles.axes1) 
plot(ECGsignal);
grid on
end




function Ultrasound_Browse_Callback(hObject, eventdata, handles)
[basename,folder]=uigetfile();
file_name=fullfile(folder,basename);
if(strcmp(file_name,'B:\DSP_Task3_WHT\ult_sig.mat'))
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
if(strcmp(file_name,'B:\DSP_Task3_WHT\MRS.xlsx'))
clc;
signal=xlsread('MRS.xlsx');
axes(handles.axes1) 
plot(signal);
grid on
end


% --- Executes on button press in Comp_Audio.
function Comp_Audio_Callback(hObject, eventdata, handles)
global file_name;
[handles.audio_data,handles.Fs] = audioread('B:\DSP_Task3_WHT\Bach2.wav');

%chosing a block size 
windowSize = 8192;

%changing compression  percentages
samplesHalf = windowSize / 2;

%initializing compressed matrice
DataCompressed = [];


%actual compression
for i=1:windowSize:length(handles.audio_data)-windowSize
    windowWHT = fwht(handles.audio_data(i:i+windowSize-1));
    DataCompressed(i:i+windowSize-1) = ifwht(windowWHT(1:samplesHalf), windowSize);
   
end
axes(handles.axes2) % Select the proper axes
plot(windowWHT)
ylim(handles.axes2,[-0.02 0.02]);
xlim(handles.axes2,[0 45000]);
set(handles.axes2,'XMinorTick','on')
grid on
audiowrite('song_compressed_WHT.wav',DataCompressed,handles.Fs)
[comp_data,handles.Fs] = audioread('B:\DSP_Task3_WHT\song_compressed_WHT.wav');
t=0:1/handles.Fs:(length(comp_data)-1)/handles.Fs;
axes(handles.axes3) 
plot(comp_data)
set(handles.axes3,'XMinorTick','on')
grid on


% --- Executes on button press in Comp_ECG.
function Comp_ECG_Callback(hObject, eventdata, handles)
load ('ECG.mat')
sig_comp=fwht(val);
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
sig_decomp=ifwht(sig_comp);%Décompressed Signal
axes(handles.axes2) 
plot(sig_comp);
ylim(handles.axes2,[-10 10]);
grid on
axes(handles.axes3) 
plot(sig_decomp);
grid on
save ECG_Compressed_WHT.mat sig_comp 


% --- Executes on button press in Comp_Ultrasound.
function Comp_Ultrasound_Callback(hObject, eventdata, handles)
load ('ult_sig.mat')
sig_comp=fwht(ult_sig);
Th=0;%Threshold value
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
sig_decomp= ifwht(sig_comp);%Décompressed Signal
axes(handles.axes2) 
plot(sig_comp);
ylim(handles.axes2,[-0.02 0.02]);
xlim(handles.axes2,[0 30000]);
grid on
axes(handles.axes3) 
plot(sig_decomp);
ylim(handles.axes3,[-1 1]);
xlim(handles.axes3,[0 6000]);
grid on
save ult_sig_Compressed_WHT.mat sig_comp


% --- Executes on button press in Comp_MR.
function Comp_MR_Callback(hObject, eventdata, handles)
signal=xlsread('MRS.xlsx');
sig_comp=fwht(signal);
Th=0.0052;%Threshold value
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
sig_decomp= ifwht(sig_comp);%Décompressed Signal
axes(handles.axes2) 
plot(sig_comp);
grid on
axes(handles.axes3) 
plot(sig_decomp);
grid on
save MRS_sig_Compressed_WHT.xlsx sig_comp