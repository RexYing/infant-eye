function varargout = gui(varargin)
% GUI MATLAB code for gui.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui

% Last Modified by GUIDE v2.5 01-Jun-2015 01:34:05

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_OutputFcn, ...
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


% --- Executes just before gui is made visible.
function gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui (see VARARGIN)

% Choose default command line output for gui
handles.output = hObject;
% initialize GUI
set(handles.textFrameSelectionThresh, 'Enable', 'off');

% Update handles structure
guidata(hObject, handles);

% Set constants, update handles structure
setGuiConsts(hObject, handles);



% UIWAIT makes gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(~, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2


% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu3.
function popupmenu3_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu3


% --- Executes during object creation, after setting all properties.
function popupmenu3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function uipushtool4_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to uipushtool4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes during object creation, after setting all properties.
function frameSelectionFeaturePopup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to frameSelectionFeaturePopup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in frameSelectionFeaturePopup.
function frameSelectionFeaturePopup_Callback(hObject, eventdata, handles)
% hObject    handle to frameSelectionFeaturePopup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns frameSelectionFeaturePopup contents as cell array
%        contents{get(hObject,'Value')} returns selected item from frameSelectionFeaturePopup
contents = cellstr(get(hObject,'String'));
switch contents{get(hObject,'Value')}
    case 'Sift Flow'
        set(handles.textFrameSelectionThresh, 'Enable', 'on');
        set(handles.textFrameSelectionThresh, 'String', handles.defaultSiftFlowFeatureThresh);
    case 'Blur Metric'
        set(handles.textFrameSelectionThresh, 'Enable', 'on');
        set(handles.textFrameSelectionThresh, 'String', handles.defaultBlurMetricFeatureThresh);
    case 'None'
        set(handles.textFrameSelectionThresh, 'Enable', 'off');
    otherwise
        set(handles.textFrameSelectionThresh, 'Enable', 'off');
end

% --- Executes on button press in locateEyeRegionButton.
function locateEyeRegionButton_Callback(hObject, eventdata, handles)
switch get(handles.textFrameSelectionThresh, 'Enable')
    case 'on'
        outputDir = uigetdir;
        handles.outputDir = outputDir;
        
        mkdir(outputDir, handles.defaultEyeRegionOutputDir);
        path = fullfile(outputDir, handles.defaultEyeRegionOutputDir);
        
        mkdir(outputDir, handles.defaultSelectedOutputDir);
        selectedFramesPath = fullfile(outputDir, handles.defaultSelectedOutputDir);
        
        contents = cellstr(get(handles.frameSelectionFeaturePopup,'String'));
        criterion = contents{get(handles.frameSelectionFeaturePopup,'Value')};
        thresh = str2double(get(handles.textFrameSelectionThresh, 'String'));
        
        handles.extracted = true;
        handles.extractedNumImgs = ...
            extractEyeRegion(handles.video, path, criterion, thresh, selectedFramesPath);
        
        msgbox(sprintf('Selected eye region images have been written into %s', ...
            selectedFramesPath));
        
        % change display 
        %imshow( readFrame(handles.video), 'Parent', handles.origImg);
        
    otherwise
        msgbox('Please select a frame selection feature criteria');
end
guidata(hObject, handles);


% --- Executes on button press in registerButton.
function registerButton_Callback(hObject, eventdata, handles)
% hObject    handle to registerButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~exist('handles.outputDir', 'var')
    handles.outputDir = uigetdir;
end
outputDir = handles.outputDir;
selectedFramesPath = fullfile(outputDir, handles.defaultSelectedOutputDir);

mkdir(outputDir, handles.defaultRegisteredOutputDir);
mkdir(outputDir, [handles.defaultRegisteredOutputDir, '_filtered']);
registerPath = fullfile(outputDir, handles.defaultRegisteredOutputDir);

if ~handles.extracted
    msgbox('Please locate eye region first');
else
    handles.registeredNumImgs = registerEyeRegion(selectedFramesPath, registerPath);
    msgbox(sprintf('Registered images have been written into %s', registerPath));
    
    % update slider
    handles.showRegistered = true;
    set(handles.movieSlider, 'Value', 1);
    set(handles.movieSlider, 'Min', 1);
    set(handles.movieSlider, 'Max',  handles.registeredNumImgs);
    set(handles.movieSlider, 'SliderStep', [1/(handles.registeredNumImgs-1) , 1/(handles.registeredNumImgs-1)] );
    
    a = dir([registerPath,'/*.png']); % For filtered images
    img = imread([registerPath, '/', a(1).name]);
    imshow(img, 'Parent', handles.origImg);
end
guidata(hObject, handles);

% --- Executes on button press in fuseButton.
function fuseButton_Callback(hObject, eventdata, handles)
if ~exist('handles.outputDir', 'var')
    handles.outputDir = uigetdir;
end
outputDir = handles.outputDir;
registerPath = fullfile(outputDir, handles.defaultRegisteredOutputDir);

mkdir(outputDir, handles.defaultRegisteredOutputDir);
fusePath = fullfile(outputDir, handles.defaultFusedOutputDir);

if ~handles.extracted
    msgbox('Please locate eye region first');
else
    [imgo, imgf] = fuse(registerPath, fusePath);
    msgbox(sprintf('Fused images have been written into %s', fusePath));
    
    imshow(imgo, 'Parent', handles.origImg);
    imshow(imgf, 'Parent', handles.finalImg);
    
    handles.imgf = imgf;
    % update slider
    
%     set(handles.movieSlider, 'Value', 1);
%     set(handles.movieSlider, 'Min', 1);
%     set(handles.movieSlider, 'Max',  handles.registeredNumImgs);
%     set(handles.movieSlider, 'SliderStep', [1/(handles.registeredNumImgs-1) , 1/(handles.registeredNumImgs-1)] );
    
%     a = dir([registerPath,'/*.png']); % For filtered images
%     img = imread([registerPath, '/', a(1).name]);
%     imshow(img, 'Parent', handles.origImg);
end
guidata(hObject, handles);


% --- Executes on button press in segmentButton.
function segmentButton_Callback(hObject, eventdata, handles)

%imgSeg = filter_image(uint8(mat2gray(handles.imgf)*255), option_defaults);
imgf = filter_image(uint8(handles.imgf), option_defaults);
segOpt = dijkstra_seg_defaults;
imgSeg = dijkstra_segmentation(imgf, segOpt);

imshow(imgSeg, 'Parent', handles.finalImg);

% --- Executes on slider movement.

function movieSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to movieSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


function movieSlider_Callback(hObject, eventdata, handles)
if (handles.showRegistered)
    idx = round(get(hObject,'Value'));
    
    registerPath = fullfile(handles.outputDir, handles.defaultRegisteredOutputDir);
    a = dir([registerPath,'/*.png']); % For filtered images
    img = imread([registerPath, '/', a(idx).name]);
    imshow(img, 'Parent', handles.origImg);
else
    handles.currentFrame = round(get(hObject,'Value'));
    handles.video.CurrentTime = (handles.currentFrame - 1) / handles.video.FrameRate;
    imshow(readFrame(handles.video), 'Parent', handles.origImg);
end
guidata(hObject, handles);

% --------------------------------------------------------------------
function openVideo_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to openVideo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[fileName, pathName] = uigetfile('*.mov','Open a video file');
if isequal(fileName,0)
   disp('User selected Cancel')
else
    fullPath = fullfile(pathName, fileName);
   disp(['User selected ', fullPath])
end
handles.video = VideoReader(fullPath);
handles.width = handles.video.Width;
handles.height = handles.video.Height;
handles.nFrames = floor(handles.video.Duration * handles.video.FrameRate);

set(handles.valWidth, 'String', handles.width);
set(handles.valHeight, 'String', handles.height);
set(handles.valNumFrames, 'String', handles.nFrames);
% init slide bar for video frame display
set(handles.movieSlider, 'visible', 'on');
set(handles.movieSlider, 'Value', 1);
set(handles.movieSlider, 'Min', 1);
set(handles.movieSlider, 'Max', handles.nFrames);
set(handles.movieSlider, 'SliderStep', [1/(handles.nFrames-1) , 1/(handles.nFrames-1)] );
set(handles.movieSlider, 'Units','Points');
handles.currentFrame = 1;

imshow( readFrame(handles.video), 'Parent', handles.origImg);
guidata(hObject, handles);


% --- Executes on button press in refreshButton.
function refreshButton_Callback(hObject, eventdata, handles)
% hObject    handle to refreshButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function textFrameSelectionThresh_Callback(hObject, eventdata, handles)
% hObject    handle to textFrameSelectionThresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of textFrameSelectionThresh as text
%        str2double(get(hObject,'String')) returns contents of textFrameSelectionThresh as a double


% --- Executes during object creation, after setting all properties.
function textFrameSelectionThresh_CreateFcn(hObject, eventdata, handles)
% hObject    handle to textFrameSelectionThresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function gotoEditText_Callback(hObject, eventdata, handles)
% hObject    handle to gotoEditText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of gotoEditText as text
%        str2double(get(hObject,'String')) returns contents of gotoEditText as a double


% --- Executes during object creation, after setting all properties.
function gotoEditText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gotoEditText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in gotoButton.
function gotoButton_Callback(hObject, eventdata, handles)
% hObject    handle to gotoButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.currentFrame = str2double(get(handles.gotoEditText,'String'));
handles.video.CurrentTime = (handles.currentFrame - 1) / handles.video.FrameRate;
imshow(readFrame(handles.video), 'Parent', handles.origImg);



