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
if(strcmp(file_name,'B:\DSP_Task3_DWT\ECG.mat'))
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
if(strcmp(file_name,'B:\DSP_Task3_DWT\ult_sig.mat'))
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
if(strcmp(file_name,'B:\DSP_Task3_DWT\MRS.xlsx'))
clc;
signal=xlsread('MRS.xlsx');
axes(handles.axes1) 
plot(signal);
grid on
end


% --- Executes on button press in Comp_Audio.
function Comp_Audio_Callback(hObject, eventdata, handles)
global file_name;
[handles.audio_data,handles.Fs] = audioread('B:\DSP_Task3_DWT\Bach2.wav');
[sig_comp,sig_comp1] = dwt(handles.audio_data,'haar');
Th=0;
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


%convert 

Th=0;
Pos_th=find(abs(sig_comp1)<Th);
Sig_Afterthreshold=sig_comp1;
Sig_Afterthreshold(Pos_th)=0;
Q=8;% 1 byte (value representation)
Max_SigAfter=max(Sig_Afterthreshold);
Min_SigAfter=min(Sig_Afterthreshold);
Sig_Quant=round((-1+2^Q)*(Sig_Afterthreshold-Min_SigAfter)/(Max_SigAfter-Min_SigAfter));
Sig_RLE=rle(Sig_Quant);
Sig_Irle=irle(Sig_RLE);% Inverse Run Length Codising 
sig_comp1=((Max_SigAfter-Min_SigAfter)/(-1+2^Q))*Sig_Irle+Min_SigAfter;
sig_compf = [sig_comp;sig_comp1];
sig_decomp= idwt(sig_comp,sig_comp1,'haar');
axes(handles.axes2) 
plot(sig_compf);
xlim(handles.axes2,[0 300]);
grid on
axes(handles.axes3) 
plot(sig_decomp);
grid on
audiowrite('song_compressed_DWT.wav',sig_decomp,handles.Fs);
function Comp_ECG_Callback(hObject, eventdata, handles)
load ('ECG.mat')
[sig_comp,sig_comp1] = dwt(val,'db4');
Th=0.52;
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


%convert 

Th=0.0052;
Pos_th=find(abs(sig_comp1)<Th);
Sig_Afterthreshold=sig_comp1;
Sig_Afterthreshold(Pos_th)=0;
Q=8;% 1 byte (value representation)
Max_SigAfter=max(Sig_Afterthreshold);
Min_SigAfter=min(Sig_Afterthreshold);
Sig_Quant=round((-1+2^Q)*(Sig_Afterthreshold-Min_SigAfter)/(Max_SigAfter-Min_SigAfter));
Sig_RLE=rle(Sig_Quant);
Sig_Irle=irle(Sig_RLE);% Inverse Run Length Codising 
sig_comp1=((Max_SigAfter-Min_SigAfter)/(-1+2^Q))*Sig_Irle+Min_SigAfter;
sig_compf = [sig_comp;sig_comp1];
sig_decomp= idwt(sig_comp,sig_comp1,'db4');
axes(handles.axes2) 
plot(sig_compf);
xlim(handles.axes2,[0 250]);
grid on
axes(handles.axes3) 
plot(sig_decomp);
grid on
save ECG_Compressed_DWT.mat sig_comp


% --- Executes on button press in Comp_Ultrasound.
function Comp_Ultrasound_Callback(hObject, eventdata, handles)
load ('ult_sig.mat')
sig_comp=dct(ult_sig);
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
sig_decomp=idct(sig_comp);%Décompressed Signal
axes(handles.axes2) 
plot(sig_comp);
grid on
axes(handles.axes3) 
plot(sig_decomp);
grid on
save ult_sig_Compressed_DCT.mat sig_comp


% --- Executes on button press in Comp_MR.
function Comp_MR_Callback(hObject, eventdata, handles)
signal=xlsread('MRS.xlsx');
[sig_comp,sig_comp1] = dwt(signal,'db4');
Th=0.0052;
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


%convert 

Th=0.0052;
Pos_th=find(abs(sig_comp1)<Th);
Sig_Afterthreshold=sig_comp1;
Sig_Afterthreshold(Pos_th)=0;
Q=8;% 1 byte (value representation)
Max_SigAfter=max(Sig_Afterthreshold);
Min_SigAfter=min(Sig_Afterthreshold);
Sig_Quant=round((-1+2^Q)*(Sig_Afterthreshold-Min_SigAfter)/(Max_SigAfter-Min_SigAfter));
Sig_RLE=rle(Sig_Quant);
Sig_Irle=irle(Sig_RLE);% Inverse Run Length Codising 
sig_comp1=((Max_SigAfter-Min_SigAfter)/(-1+2^Q))*Sig_Irle+Min_SigAfter;
sig_compf = [sig_comp;sig_comp1];
sig_decomp= idwt(sig_comp,sig_comp1,'db4');
axes(handles.axes2) 
plot(sig_compf);
xlim(handles.axes2,[0 290]);
grid on
axes(handles.axes3) 
plot(sig_decomp);
grid on
save MR_sig_Compressed_DWT.mat sig_comp