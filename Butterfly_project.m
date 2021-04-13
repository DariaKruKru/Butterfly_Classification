function varargout = Butterfly_project(varargin)
% BUTTERFLY_PROJECT MATLAB code for Butterfly_project.fig
%      BUTTERFLY_PROJECT, by itself, creates a new BUTTERFLY_PROJECT or raises the existing
%      singleton*.
%
%      H = BUTTERFLY_PROJECT returns the handle to a new BUTTERFLY_PROJECT or the handle to
%      the existing singleton*.
%
%      BUTTERFLY_PROJECT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BUTTERFLY_PROJECT.M with the given input arguments.
%
%      BUTTERFLY_PROJECT('Property','Value',...) creates a new BUTTERFLY_PROJECT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Butterfly_project_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Butterfly_project_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Butterfly_project

% Last Modified by GUIDE v2.5 26-Oct-2017 00:53:25

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Butterfly_project_OpeningFcn, ...
                   'gui_OutputFcn',  @Butterfly_project_OutputFcn, ...
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


% --- Executes just before Butterfly_project is made visible.
function Butterfly_project_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Butterfly_project (see VARARGIN)

% Choose default command line output for Butterfly_project
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Butterfly_project wait for user response (see UIRESUME)
% uiwait(handles.figure1);

set(handles.text5, 'String', 'The number should between 717 and 832, because 86% dataset images will be training data which is 716 images. For example, if the number you enter is 717, it means 716 images are trainging data and 1 image will be a test image.','FontSize',12);
set(handles.text6, 'String', 'Please enter the number of images that you want to test:','FontSize',14);
set(handles.text7, 'String', 'Please select the path of your dataset images (output_seg):','FontSize',14);
set(handles.text9, 'String', 'Butterfly Classification','FontSize',20);
% --- Outputs from this function are returned to the command line.
function varargout = Butterfly_project_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



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


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

TestandTrainData = str2double(get(handles.edit1,'String'));

% classify

load('my_features_labels.mat');

totalNumberSampels = length (allLabels);
ratio = 0.86; % the ration of allimages will be training data

%Get training data
numbTrSamples = ceil (totalNumberSampels * ratio);
X_tr = allFts (1 : numbTrSamples, : );
Y_tr = allLabels (1 : numbTrSamples)';

%create classification model
Mdl = fitcknn(X_tr, Y_tr,'NumNeighbors',5,'Standardize',1);

save ('my_mdl.mat', 'Mdl');

% accuracy

load ('ListImgsName_rand.mat');
load ('my_mdl.mat');

numbTestSamples = TestandTrainData - numbTrSamples;
accuracy =  0;

number_type = zeros (1, 10); % for calculate the accuracy of each type
number_result = zeros (1, 10);% for calculate the accuracy of each type

%start to compare
for number = numbTrSamples+1 : TestandTrainData

    X = allFts (number, :);
    result = predict(Mdl, X);
    
    number_type(1, allLabels (number)) = number_type(1, allLabels (number)) +1;
    
    if (result == allLabels (number))
        accuracy = accuracy +1;
        number_result(1,allLabels (number))=number_result(1,allLabels (number))+1;
    end
end

RES_type = number_result./number_type;
accuracy = (accuracy/ numbTestSamples)*100;
textLabel3 = sprintf('Accuracy = %.2f%%', accuracy);
set(handles.text2, 'String', textLabel3,'FontSize',14);

TypeName={'Danaus plexippus' 'Heliconius charitonius' 'Heliconius erato' 'Junonia coenia' 'Lycaena phlaeas' 'Nymphalis antiopa' 'Papilio cresphontes' 'Pieris rapae' 'Vanessa atalanta' 'Vanessa cardui'};

%show results
axes(handles.axes1);
%DataImgPath = get(handles.edit2,'String');
%Img_show=imread(strcat(ListImgs_rand(number).folder,'/',ListImgs_rand(number).name));
Img_show=imread(strcat(handles.DataImgPath,'/',ListImgs_rand(number).name));
imshow(Img_show); 
str1=strcat({'Finded type:'},num2str(result),{' ('},TypeName(1,result),{')'});
str2=strcat({'Correct type:'},num2str(allLabels (number)),{' ('},TypeName(1,allLabels (number)),{')'});
title([str1;str2],'FontSize',14);    



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


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.DataImgPath=uigetdir('','Please select the path of your dataset images');
guidata(hObject, handles);
set(handles.text8, 'String', handles.DataImgPath,'FontSize',14);
