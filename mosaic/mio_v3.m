function varargout = mio_v3(varargin)
% MIO_V3 M-file for mio_v3.fig
%      MIO_V3, by itself, creates a new MIO_V3 or raises the existing
%      singleton*.
%
%      H = MIO_V3 returns the handle to a new MIO_V3 or the handle to
%      the existing singleton*.
%
%      MIO_V3('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MIO_V3.M with the given input arguments.
%
%      MIO_V3('Property','Value',...) creates a new MIO_V3 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before mio_v3_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to mio_v3_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help mio_v3

% Last Modified by GUIDE v2.5 21-Jun-2014 12:16:39

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @mio_v3_OpeningFcn, ...
                   'gui_OutputFcn',  @mio_v3_OutputFcn, ...
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


% --- Executes just before mio_v3 is made visible.
function mio_v3_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to mio_v3 (see VARARGIN)

% Choose default command line output for mio_v3
handles.output = hObject;

addpath('mmread');
addpath('auxfiles');

handles.title = 'MIO: Mosaicing Indirect Ophthalmoscopy 3.0' ;
set(gcf,'Name',handles.title);
dname0 = [pwd,'\'];
handles.dname0 = dname0;

if exist([dname0,'settings.mat'],'file') == 0
    last_dir = [pwd,'\'];
    gui_mode = 0;
    save([dname0,'settings.mat'],'last_dir','gui_mode');
else
    load([dname0,'settings.mat']);
    f = 0;
    if exist('last_dir','var') == 1
        if exist(last_dir,'dir') == 0
            last_dir = [pwd,'\'];
            f = 1;
        end
    else
        last_dir = [pwd,'\'];
        f = 1;
    end        
    if exist('gui_mode','var') == 1
        if ~ismember(gui_mode,[0,1])
            gui_mode = 1;
            f = 1;            
        end
    else
        gui_mode = 1;
        f = 1;
    end    
    if f == 1
        save([dname0,'settings.mat'],'last_dir','gui_mode');
    end
end
handles.last_dir = last_dir;
handles.gui_mode = gui_mode;
if handles.gui_mode == 0
    set(handles.Untitled_3,'Checked','On');
    set(handles.Untitled_4,'Checked','Off');
    set(handles.text23,'String','Video Mode');
elseif handles.gui_mode == 1
    set(handles.Untitled_3,'Checked','Off');
    set(handles.Untitled_4,'Checked','On');
    set(handles.text23,'String','Image Mode');
end

handles.current = zeros(7,9,3);
handles.final_chosen = ones(20,1);
handles.mode = 0;
handles.mosaic_done = 0;

set(handles.axes1,'HandleVisibility','ON');
handles.axes_list(1) = handles.axes1;
handles.text_list(1) = handles.text2;
set(handles.figure1,'CurrentAxes',handles.axes1);
imagesc(handles.current);
axis off;
set(handles.axes1,'HandleVisibility','OFF');
set(handles.axes2,'HandleVisibility','ON');
handles.axes_list(2) = handles.axes2;
handles.text_list(2) = handles.text3;
set(handles.figure1,'CurrentAxes',handles.axes2);
imagesc(handles.current);
axis off;
set(handles.axes2,'HandleVisibility','OFF');
set(handles.axes3,'HandleVisibility','ON');
handles.axes_list(3) = handles.axes3;
handles.text_list(3) = handles.text4;
set(handles.figure1,'CurrentAxes',handles.axes3);
imagesc(handles.current);
axis off;
set(handles.axes3,'HandleVisibility','OFF');
set(handles.axes4,'HandleVisibility','ON');
handles.axes_list(4) = handles.axes4;
handles.text_list(4) = handles.text5;
set(handles.figure1,'CurrentAxes',handles.axes4);
imagesc(handles.current);
axis off;
set(handles.axes4,'HandleVisibility','OFF');
set(handles.axes5,'HandleVisibility','ON');
handles.axes_list(5) = handles.axes5;
handles.text_list(5) = handles.text6;
set(handles.figure1,'CurrentAxes',handles.axes5);
imagesc(handles.current);
axis off;
set(handles.axes5,'HandleVisibility','OFF');
set(handles.axes6,'HandleVisibility','ON');
handles.axes_list(6) = handles.axes6;
handles.text_list(6) = handles.text7;
set(handles.figure1,'CurrentAxes',handles.axes6);
imagesc(handles.current);
axis off;
set(handles.axes6,'HandleVisibility','OFF');
set(handles.axes7,'HandleVisibility','ON');
handles.axes_list(7) = handles.axes7;
handles.text_list(7) = handles.text8;
set(handles.figure1,'CurrentAxes',handles.axes7);
imagesc(handles.current);
axis off;
set(handles.axes7,'HandleVisibility','OFF');
set(handles.axes8,'HandleVisibility','ON');
handles.axes_list(8) = handles.axes8;
handles.text_list(8) = handles.text9;
set(handles.figure1,'CurrentAxes',handles.axes8);
imagesc(handles.current);
axis off;
set(handles.axes8,'HandleVisibility','OFF');
set(handles.axes9,'HandleVisibility','ON');
handles.axes_list(9) = handles.axes9;
handles.text_list(9) = handles.text10;
set(handles.figure1,'CurrentAxes',handles.axes9);
imagesc(handles.current);
axis off;
set(handles.axes9,'HandleVisibility','OFF');
set(handles.axes10,'HandleVisibility','ON');
handles.axes_list(10) = handles.axes10;
handles.text_list(10) = handles.text11;
set(handles.figure1,'CurrentAxes',handles.axes10);
imagesc(handles.current);
axis off;
set(handles.axes10,'HandleVisibility','OFF');
set(handles.axes11,'HandleVisibility','ON');
handles.axes_list(11) = handles.axes11;
handles.text_list(11) = handles.text12;
set(handles.figure1,'CurrentAxes',handles.axes11);
imagesc(handles.current);
axis off;
set(handles.axes11,'HandleVisibility','OFF');
set(handles.axes12,'HandleVisibility','ON');
handles.axes_list(12) = handles.axes12;
handles.text_list(12) = handles.text13;
set(handles.figure1,'CurrentAxes',handles.axes12);
imagesc(handles.current);
axis off;
set(handles.axes12,'HandleVisibility','OFF');
set(handles.axes13,'HandleVisibility','ON');
handles.axes_list(13) = handles.axes13;
handles.text_list(13) = handles.text14;
set(handles.figure1,'CurrentAxes',handles.axes13);
imagesc(handles.current);
axis off;
set(handles.axes13,'HandleVisibility','OFF');
set(handles.axes14,'HandleVisibility','ON');
handles.axes_list(14) = handles.axes14;
handles.text_list(14) = handles.text15;
set(handles.figure1,'CurrentAxes',handles.axes14);
imagesc(handles.current);
axis off;
set(handles.axes14,'HandleVisibility','OFF');
set(handles.axes15,'HandleVisibility','ON');
handles.axes_list(15) = handles.axes15;
handles.text_list(15) = handles.text16;
set(handles.figure1,'CurrentAxes',handles.axes15);
imagesc(handles.current);
axis off;
set(handles.axes15,'HandleVisibility','OFF');
set(handles.axes16,'HandleVisibility','ON');
handles.axes_list(16) = handles.axes16;
handles.text_list(16) = handles.text17;
set(handles.figure1,'CurrentAxes',handles.axes16);
imagesc(handles.current);
axis off;
set(handles.axes16,'HandleVisibility','OFF');
set(handles.axes17,'HandleVisibility','ON');
handles.axes_list(17) = handles.axes17;
handles.text_list(17) = handles.text18;
set(handles.figure1,'CurrentAxes',handles.axes17);
imagesc(handles.current);
axis off;
set(handles.axes17,'HandleVisibility','OFF');
set(handles.axes18,'HandleVisibility','ON');
handles.axes_list(18) = handles.axes18;
handles.text_list(18) = handles.text19;
set(handles.figure1,'CurrentAxes',handles.axes18);
imagesc(handles.current);
axis off;
set(handles.axes18,'HandleVisibility','OFF');
set(handles.axes19,'HandleVisibility','ON');
handles.axes_list(19) = handles.axes19;
handles.text_list(19) = handles.text20;
set(handles.figure1,'CurrentAxes',handles.axes19);
imagesc(handles.current);
axis off;
set(handles.axes19,'HandleVisibility','OFF');
set(handles.axes20,'HandleVisibility','ON');
handles.axes_list(20) = handles.axes20;
handles.text_list(20) = handles.text21;
set(handles.figure1,'CurrentAxes',handles.axes20);
imagesc(handles.current);
axis off;
set(handles.axes20,'HandleVisibility','OFF');
set(handles.axes21,'HandleVisibility','ON');
set(handles.figure1,'CurrentAxes',handles.axes21);
imagesc(handles.current);
axis off;
set(handles.axes21,'HandleVisibility','OFF');

handles.is_frame_selected = false(length(handles.axes_list),1);
handles.is_center_frame = false(length(handles.axes_list),1);
handles.final_frames = [];

drawnow;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes mio_v3 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = mio_v3_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% Maximize window
jFrame = get(handle(handles.figure1),'JavaFrame');
jFrame.setMaximized(true);
drawnow();
guidata(hObject, handles);


% OPEN
% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if handles.gui_mode == 1
    [filename, pathname, filterindex] = uigetfile( ...
           {'*.png;*.PNG;*.jpg;*.JPG;*.jpeg;*.JPEG;*.gif;*.GIF;*.tiff;*.TIFF;*.tif;*.TIF', 'Image Files (*.png, *.jpg, *.gif, *.tiff)';
            '*.png;*.PNG',  'PNGs (*.png)'; ...
            '*.jpg;*.JPG;*.jpeg;*.JPEG','JPEGs (*.jpg;*.jpeg)'; ...
            '*.gif;*.GIF', 'GIFs (*.gif)'; ...
            '*.tiff;*.TIFF;*.tif;*.TIF', 'TIFFs (*.tiff;*.tif)'}, ...
            'Pick a file');

    if (filename ~= 0)
        handles.filename = sprintf('%s%s',pathname,filename);
        handles.pathname = sprintf('%s%s',pathname);
        filename = handles.filename;
        pathname = handles.pathname;

        handles.last_dir = handles.pathname;
        last_dir = handles.pathname;
        save([handles.dname0,'settings.mat'],'-append','last_dir');

        if strfind(filename,'.png')
            ext = '.png';
        elseif strfind(filename,'.PNG')
            ext = '.PNG';
        elseif strfind(filename,'.jpg')
            ext = '.jpg';
        elseif strfind(filename,'.JPG')
            ext = '.JPG';
        elseif strfind(filename,'.jpeg')
            ext = '.jpeg';
        elseif strfind(filename,'.JPEG')
            ext = '.JPEG';
        elseif strfind(filename,'.gif')
            ext = '.gif';
        elseif strfind(filename,'.GIF')
            ext = '.GIF';
        elseif strfind(filename,'.tiff')
            ext = '.tiff';
        elseif strfind(filename,'.TIFF')
            ext = '.TIFF';
        elseif strfind(filename,'.tif')
            ext = '.tif';
        elseif strfind(filename,'.TIF')
            ext = '.TIF';
        end

        set(handles.text1,'Visible','on');
        set(handles.text1,'String','Thinking...');
        set(handles.text1,'String','Images Loaded');

        d = dir([pathname,'\*',ext]);
        handles.lengthdir = length(d);
        handles.imgcurr = 1;
        handles.images = cell(numel(d),1);
        for i = 1:length(d)
            handles.images{i} = imread(strcat(pathname,'\',d(i).name));
        end
        if ~isempty(d)
            handles.current = handles.images{1};
            handles.hsv_curr = rgb2hsv(handles.current);

            set(handles.axes21,'HandleVisibility','ON');
            set(handles.figure1,'CurrentAxes',handles.axes21);
            imagesc(handles.current);
            xlim([1,size(handles.current,2)]);
            ylim([1,size(handles.current,1)]);
            axis off;
            set(handles.axes21,'HandleVisibility','OFF');
            set(handles.text22,'Visible','ON');
            set(handles.text22,'String',strcat(num2str(handles.imgcurr),{' of '},num2str(handles.lengthdir)));

            for i = 1:numel(d)
                set(handles.axes_list(i),'HandleVisibility','ON');
                set(handles.figure1,'CurrentAxes',handles.axes_list(i));
                imagesc(handles.images{i});
                xlim([1,size(handles.images{i},2)]);
                ylim([1,size(handles.images{i},1)]);
                axis off;
                set(handles.axes_list(i),'HandleVisibility','OFF');
                set(handles.text_list(i),'String',num2str(i));
            end        
            blk = zeros(7,9,3);
            for i = numel(d)+1:numel(handles.axes_list)
                set(handles.axes_list(i),'HandleVisibility','ON');
                set(handles.figure1,'CurrentAxes',handles.axes_list(i));
                imagesc(blk);
                xlim([1,size(blk,2)]);
                ylim([1,size(blk,1)]);
                axis off;
                set(handles.axes_list(i),'HandleVisibility','OFF');
                set(handles.text_list(i),'String','0');
            end

            set(handles.pushbutton2,'Enable','off');    
            set(handles.pushbutton5,'Enable','off');
            set(handles.pushbutton6,'Enable','off');
            set(handles.pushbutton7,'Enable','off');
            set(handles.pushbutton8,'Enable','off');

            handles.dname2 = strcat(handles.pathname,'\');        
            handles.mosaic_done = 0;
            handles.is_frame_selected = false(numel(handles.axes_list),1);
            handles.is_center_frame = false(numel(handles.axes_list),1);
            handles.final_frames = [];
            set(handles.pushbutton2,'Enable','on');    
            set(handles.pushbutton5,'Enable','on');
            set(handles.pushbutton6,'Enable','on');
            set(handles.pushbutton9,'Enable','off');    
            set(handles.pushbutton10,'Enable','off');
            set(handles.pushbutton8,'Enable','off');    
            set(handles.pushbutton7,'Enable','off');
            set(handles.Untitled_2,'Enable','off');
            set(handles.Untitled_3,'Enable','off');
            set(handles.Untitled_4,'Enable','off');
        end    

    end
elseif handles.gui_mode == 0
    [filename, pathname, filterindex] = uigetfile( ...
           {'*.avi;*.mpg;*.wmv', 'Video Files (*.avi, *.mpg, *.wmv)';
            '*.avi',  'AVIs (*.avi)'; ...
            '*.mpg;*.mpeg','MPEGs (*.mpg;*.mpeg)'; ...
            '*.wmv', 'WMVs (*.wmv)'}, ...
            'Pick a file');

    if (filename ~= 0)
        handles.filename = sprintf('%s%s',pathname,filename);
        handles.pathname = sprintf('%s%s',pathname);
        pathname = handles.pathname;

        handles.last_dir = handles.pathname;
        last_dir = handles.pathname;
        save([handles.dname0,'settings.mat'],'-append','last_dir');
        
        handles.video_info = mmread_silent(handles.filename,1,[],false,true);    
        handles.l2 = min(round(abs(handles.video_info.nrFramesTotal)/2),2000);
        handles.offset = abs(handles.video_info.nrFramesTotal) - max(2000,handles.l2); %handles.l2;
        handles.offset = min(handles.l2,min(1500,handles.offset));
        handles.s1 = size(handles.video_info.frames(1).cdata);
        handles.frame_nb = 1;
        disp('Video info loaded from file');

        set(handles.text1,'Visible','on');
        set(handles.text1,'String','Thinking...');
        set(handles.text1,'String','Video Loaded');

        d = dir(strcat(pathname,'\*.jpg'));
        handles.lengthdir = length(d);
        handles.imgcurr = 1;
        for i = 1:length(d)
            handles.images{i} = imread(strcat(pathname,'\',d(i).name));
        end
        if ~isempty(d)
            handles.current = handles.images{1};
            set(handles.axes21,'HandleVisibility','ON');
            axes(handles.axes21);
            imagesc(handles.current);
            xlim([1,size(handles.current,2)]);
            ylim([1,size(handles.current,1)]);
            axis off;
            set(handles.axes21,'HandleVisibility','OFF');
            set(handles.text22,'Visible','ON');
            set(handles.text22,'String',strcat(num2str(handles.imgcurr),{' of '},num2str(handles.lengthdir)));
        end

        set(handles.pushbutton5,'Enable','on');
        set(handles.pushbutton6,'Enable','on');
        set(handles.pushbutton9,'Enable','on');    
        set(handles.pushbutton10,'Enable','on');
        set(handles.pushbutton8,'Enable','off');    
        set(handles.pushbutton7,'Enable','off');
        set(handles.pushbutton2,'Enable','off');
        set(handles.Untitled_2,'Enable','off');
        set(handles.Untitled_3,'Enable','off');
        set(handles.Untitled_4,'Enable','off');
    end
end

% Update handles structure
guidata(hObject, handles);


% BEST IMAGES
% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if handles.gui_mode == 1
    for i = 1:length(handles.axes_list)
        set(handles.axes_list(i),'HandleVisibility','ON');
    end
    set(handles.text1,'String','Pick the best images');

    k = 1;
    while k > 0
        [~,~,b] = ginput(1);
        if b > 1
            k = 0;
            for i = 1:length(handles.axes_list)
                set(handles.axes_list(i),'HandleVisibility','OFF');
            end
        else
            g = gca;
            pos = find(handles.axes_list == g);
            if numel(handles.images) >= pos
                Z = handles.images{pos};
                if handles.is_frame_selected(pos) == 0
                    handles.is_frame_selected(pos) = 1;
                    set(handles.figure1,'CurrentAxes',g);
                    s = size(Z);
                    Z(1:round(s(1)/20),:,1) = 255;
                    Z(:,(end-round(s(2)/20):end),1) = 255;
                    Z(:,1:round(s(2)/20),1) = 255;
                    Z((end-round(s(1)/20):end),:,1) = 255;
                    imagesc(Z);
                    axis off;
                    set(handles.axes21,'HandleVisibility','ON');
                    handles.current = handles.images{pos};
                    handles.imgcurr = pos;
                    set(handles.figure1,'CurrentAxes',handles.axes21);
                    imagesc(handles.current);
                    xlim([1,size(handles.current,2)]);
                    ylim([1,size(handles.current,1)]);
                    axis off;
                    set(handles.axes21,'HandleVisibility','OFF');  
                    if handles.mosaic_done == 1
                        set(handles.text22,'String',strcat(num2str(handles.imgcurr),{' of '},num2str(handles.lengthdir-1)));
                    else
                        set(handles.text22,'String',strcat(num2str(handles.imgcurr),{' of '},num2str(handles.lengthdir)));
                    end
                else
                    handles.is_frame_selected(pos) = 0;
                    handles.is_center_frame(pos) = 0;
                    set(handles.figure1,'CurrentAxes',g);
                    imagesc(Z);
                    axis off;
                end                                
            end
        end
    end

    k = 1;
    handles.final_frames = [];
    for i = 1:length(handles.is_frame_selected)
        if handles.is_frame_selected(i) == 1
            handles.final_frames(k) = i;
            k = k + 1;
        end
    end
    if k > 2
        set(handles.pushbutton8,'Enable','on');
        set(handles.text1,'String','Best Images Selected');
    else
        set(handles.pushbutton8,'Enable','off');
    end
    
elseif handles.gui_mode == 0
    if handles.mode == 1
        set(handles.axes21,'HandleVisibility','ON');
        k = 1;
        set(handles.text1,'String','Pick retinal points');
        drawnow();
        while k > 0
            [y1,x1,b] = ginput(1);
            if b > 1
                k = 0;
                set(handles.text1,'String','Frames Selected');
                drawnow();
            else                    
                if x1 >= 1 && x1 <=size(handles.current,1) && y1 >= 1 && y1 <=size(handles.current,2)
                    hold all
                    scatter(y1,x1,'b.');
                    handles.pi = [round(y1),round(x1)];
                    it3 = [0.15,0.15,0.15];
                    bi(k,:) = hsv_interval2_5_2(handles.current,it3,handles.pi);
                    it3 = [0.2,0.2,0.2];
                    bi2(k,:) = hsv_interval2_5_2(handles.current,it3,handles.pi);
                    it3 = [0.3,0.3,0.3];
                    bi3(k,:) = hsv_interval2_5_2(handles.current,it3,handles.pi);
                    handles.dname2 = strcat(handles.pathname,'\');        
                    k = k + 1;
                end
            end
        end
        if size(bi,1) > 1
            handles.bi = mean(bi);
            handles.bi2 = mean(bi2);
            handles.bi3 = mean(bi3);
        else
            handles.bi = bi;
            handles.bi2 = bi2;
            handles.bi3 = bi3;
        end

        if handles.bi(1) < handles.bi(2)
            d = 0;
        else
            d = 1;
        end
        handles.d = d;
    end

    for i = 1:length(handles.axes_list)
        set(handles.axes_list(i),'HandleVisibility','ON');
    end
    set(handles.text1,'String','Pick retinal frames');

    k = 1;
    while k > 0
        [~,~,b] = ginput(1);
        if b > 1
            k = 0;
            for i = 1:length(handles.axes_list)
                set(handles.axes_list(i),'HandleVisibility','ON');
            end
        else
            g = gca;
            pos = find(handles.axes_list == g);
            Z = handles.V{pos}.frames(1).cdata;
            if handles.is_frame_selected(pos) == 0
                handles.is_frame_selected(pos) = 1;
                axes(g);
                Z(1:20,:,1) = 255;
                Z(:,(end-19:end),1) = 255;
                Z(:,1:20,1) = 255;
                Z((end-19:end),:,1) = 255;
                imagesc(Z);
                axis off;
                set(handles.axes21,'HandleVisibility','ON');
                handles.current = handles.V{pos}.frames(1).cdata;
                handles.imgcurr = pos;
                axes(handles.axes21);
                imagesc(handles.current);
                xlim([1,size(handles.current,2)]);
                ylim([1,size(handles.current,1)]);
                axis off;
                set(handles.axes21,'HandleVisibility','OFF');            
                set(handles.text22,'String',strcat(num2str(handles.imgcurr),{' of '},num2str(handles.lengthdir)));
            else
                handles.is_frame_selected(pos) = 0;
                axes(g);
                imagesc(Z);
                axis off;
            end                                
        end
    end

    k = 1;
    for i = 1:length(handles.is_frame_selected)
        if handles.is_frame_selected(i) == 1
            handles.final_frames(k) = i;
            k = k + 1;
        end
    end
    if k > 2
        set(handles.pushbutton7,'Enable','on');
        set(handles.text1,'String','Best Frames Selected');
    else
        set(handles.pushbutton7,'Enable','off');
    end
    
end

% Update handles structure
guidata(hObject, handles);


% NEXT
% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if handles.gui_mode == 1
    if handles.imgcurr == handles.lengthdir
        handles.imgcurr = 1;
        handles.current = handles.images{1};
        set(handles.axes21,'HandleVisibility','ON');
        set(handles.figure1,'CurrentAxes',handles.axes21);
        imagesc(handles.current);
        xlim([1,size(handles.current,2)]);
        ylim([1,size(handles.current,1)]);
        axis off;
        set(handles.axes21,'HandleVisibility','OFF');
    else
        handles.imgcurr = handles.imgcurr + 1;
        handles.current = handles.images{handles.imgcurr};
        set(handles.axes21,'HandleVisibility','ON');
        set(handles.figure1,'CurrentAxes',handles.axes21);
        imagesc(handles.current);
        xlim([1,size(handles.current,2)]);
        ylim([1,size(handles.current,1)]);
        axis off;
        set(handles.axes21,'HandleVisibility','OFF');
    end
    if handles.mosaic_done == 1 && handles.imgcurr == handles.lengthdir
        set(handles.text22,'String','Mosaic');
    elseif handles.mosaic_done == 1
        set(handles.text22,'String',strcat(num2str(handles.imgcurr),{' of '},num2str(handles.lengthdir-1)));
    else
        set(handles.text22,'String',strcat(num2str(handles.imgcurr),{' of '},num2str(handles.lengthdir)));
    end
elseif handles.gui_mode == 0
    if handles.imgcurr == handles.lengthdir
        handles.imgcurr = 1;
        handles.current = handles.images{1};
        set(handles.axes21,'HandleVisibility','ON');
        axes(handles.axes21);
        imagesc(handles.current);
        xlim([1,size(handles.current,2)]);
        ylim([1,size(handles.current,1)]);
        axis off;
        set(handles.axes21,'HandleVisibility','OFF');
    else
        handles.imgcurr = handles.imgcurr + 1;
        handles.current = handles.images{handles.imgcurr};
        set(handles.axes21,'HandleVisibility','ON');
        axes(handles.axes21);
        imagesc(handles.current);
        xlim([1,size(handles.current,2)]);
        ylim([1,size(handles.current,1)]);
        axis off;
        set(handles.axes21,'HandleVisibility','OFF');
    end    
    set(handles.text22,'String',strcat(num2str(handles.imgcurr),{' of '},num2str(handles.lengthdir)));
end    
% Update handles structure
guidata(hObject, handles);


% PREVIOUS
% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if handles.gui_mode == 1
    if handles.imgcurr == 1
        handles.imgcurr = handles.lengthdir;
        handles.current = handles.images{handles.lengthdir};
        set(handles.axes21,'HandleVisibility','ON');
        set(handles.figure1,'CurrentAxes',handles.axes21);
        imagesc(handles.current);
        xlim([1,size(handles.current,2)]);
        ylim([1,size(handles.current,1)]);
        axis off;
        set(handles.axes21,'HandleVisibility','OFF');
    else
        handles.imgcurr = handles.imgcurr - 1;
        handles.current = handles.images{handles.imgcurr};
        set(handles.axes21,'HandleVisibility','ON');
        set(handles.figure1,'CurrentAxes',handles.axes21);
        imagesc(handles.current);
        xlim([1,size(handles.current,2)]);
        ylim([1,size(handles.current,1)]);
        axis off;
        set(handles.axes21,'HandleVisibility','OFF');
    end    
    set(handles.text22,'String',strcat(num2str(handles.imgcurr),{' of '},num2str(handles.lengthdir)));
elseif handles.gui_mode == 0
    if handles.imgcurr == 1
        handles.imgcurr = handles.lengthdir;
        handles.current = handles.images{handles.lengthdir};
        set(handles.axes21,'HandleVisibility','ON');
        axes(handles.axes21);
        imagesc(handles.current);
        xlim([1,size(handles.current,2)]);
        ylim([1,size(handles.current,1)]);
        axis off;
        set(handles.axes21,'HandleVisibility','OFF');
    else
        handles.imgcurr = handles.imgcurr - 1;
        handles.current = handles.images{handles.imgcurr};
        set(handles.axes21,'HandleVisibility','ON');
        axes(handles.axes21);
        imagesc(handles.current);
        xlim([1,size(handles.current,2)]);
        ylim([1,size(handles.current,1)]);
        axis off;
        set(handles.axes21,'HandleVisibility','OFF');
    end    
    set(handles.text22,'String',strcat(num2str(handles.imgcurr),{' of '},num2str(handles.lengthdir)));
end

% Update handles structure
guidata(hObject, handles);


% CREATE MOSAIC
% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if handles.gui_mode == 1
    if ~isempty(handles.final_frames)
        if length(handles.final_frames) == 1
            M = handles.images{handles.final_frames(1)};
            handles.current = M;
            handles.mosaic = M;
            if handles.mosaic_done == 0
                handles.mosaic_done = 1;
                handles.images{end+1} = M;
                handles.lengthdir = handles.lengthdir + 1;
                handles.imgcurr = handles.lengthdir;
            else
                handles.images{end} = M;
                handles.imgcurr = handles.lengthdir;
            end
            set(handles.axes21,'HandleVisibility','ON');
            set(handles.figure1,'CurrentAxes',handles.axes21);
            imagesc(handles.current);
            xlim([1,size(M,2)]);
            ylim([1,size(M,1)]);
            axis off;
            set(handles.axes21,'HandleVisibility','OFF');
            set(handles.text22,'String','Mosaic');
        else                        
            dname3 = mkdir2([handles.dname2,'\mosaic\']);
            f = find(handles.is_center_frame);
            if ~isempty(f)
                imgs = handles.images;
                img1 = handles.images{f};
                imgs(f) = [];
                imgs = [img1;imgs];
            else
                imgs = handles.images;
            end
            [~,~,M] = mosaic_fast5_images(dname3,imgs,handles.final_frames);
            handles.current = M;
            handles.mosaic = M;
            if handles.mosaic_done == 0
                handles.mosaic_done = 1;
                handles.images{end+1} = M;
                handles.lengthdir = handles.lengthdir + 1;
                handles.imgcurr = handles.lengthdir;
            else
                handles.images{end} = M;
                handles.imgcurr = handles.lengthdir;
            end
            set(handles.axes21,'HandleVisibility','ON');
            set(handles.figure1,'CurrentAxes',handles.axes21);
            imagesc(handles.current);
            xlim([1,size(M,2)]);
            ylim([1,size(M,1)]);
            axis off;
            set(handles.axes21,'HandleVisibility','OFF');
            set(handles.text22,'String','Mosaic');
        end
    end
elseif handles.gui_mode == 0
    if ~isempty(handles.final_frames)
        if length(handles.final_frames) == 1
            handles.current = handles.V{handles.final_frames(1)}.frames(1).cdata;
            handles.images = [];
            handles.images{1} = handles.current;
            handles.lengthdir = 1;
            handles.imgcurr = 1;
            set(handles.axes21,'HandleVisibility','ON');
            axes(handles.axes21);
            imagesc(handles.current);
            xlim([1,size(handles.current,2)]);
            ylim([1,size(handles.current,1)]);
            axis off;
            set(handles.axes21,'HandleVisibility','OFF');
            set(handles.text22,'String',strcat(num2str(handles.imgcurr),{' of '},num2str(handles.lengthdir)));
            set(handles.text22,'String','Mosaic');
        else        
            Mm = mosaic_fast2_images(handles.dname2,handles.V,handles.final_frames,handles.bi3,handles.d);
            handles.images = [];
            handles.current = Mm;
            handles.images{1} = Mm;
            handles.lengthdir = 1;
            handles.imgcurr = 1;
            set(handles.axes21,'HandleVisibility','ON');
            axes(handles.axes21);
            imagesc(handles.current);
            xlim([1,size(Mm,2)]);
            ylim([1,size(Mm,1)]);
            axis off;
            set(handles.axes21,'HandleVisibility','OFF');
            set(handles.text22,'String','Mosaic');
        end
    end
end    

% Update handles structure
guidata(hObject, handles);


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_7_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function create_mosaic_Callback(hObject, eventdata, handles)
% hObject    handle to create_mosaic (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function select_frames_1st_half_Callback(hObject, eventdata, handles)
% hObject    handle to select_frames_1st_half (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function select_frames_2nd_half_Callback(hObject, eventdata, handles)
% hObject    handle to select_frames_2nd_half (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function final_frames_Callback(hObject, eventdata, handles)
% hObject    handle to final_frames (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function load_video_Callback(hObject, eventdata, handles)
% hObject    handle to load_video (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pushbutton1_Callback(hObject, eventdata, handles)


% --------------------------------------------------------------------
function previous_frames_Callback(hObject, eventdata, handles)
% hObject    handle to previous_frames (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[pathname] = uigetdir([],'Pick a folder');

if (pathname ~= 0)
    handles.mode = 1;
    handles.pathname = pathname;
    d = dir(pathname);
    sd = min(20,length(d));
    handles.images = [];
    handles.V = [];
    for i = 1:sd
        handles.images{i} = imread(strcat(pathname,'\',d(i+2).name));
        handles.V{i}.frames(1).cdata = handles.images{i};
    end
    handles.lengthdir = length(handles.images);
    handles.imgcurr = 1;
    
    for i = 1:length(handles.axes_list)
        set(handles.axes_list(i),'HandleVisibility','ON');
        set(handles.figure1,'CurrentAxes',handles.axes_list(i));
        imagesc(handles.images{i});
        axis off;
        set(handles.axes_list(i),'HandleVisibility','OFF');
        set(handles.text_list(i),'String',num2str(i));
    end
            
    handles.current = zeros(size(handles.current,1),size(handles.current,2),3);
    set(handles.axes21,'HandleVisibility','ON');
    set(handles.figure1,'CurrentAxes',handles.axes21);
    imagesc(handles.current);
    % axis image;
    axis off;
    set(handles.axes21,'HandleVisibility','OFF');
    drawnow();
    handles.current = handles.images{1};
    set(handles.axes21,'HandleVisibility','ON');
    set(handles.figure1,'CurrentAxes',handles.axes21);    
    imagesc(handles.current);
    % axis image;
    axis off;
    set(handles.axes21,'HandleVisibility','OFF');
    set(handles.text22,'String',strcat(num2str(handles.imgcurr),{' of '},num2str(handles.lengthdir)));

    set(handles.pushbutton2,'Enable','on');    
    set(handles.text1,'Visible','on');
    set(handles.text1,'String','Frames Selected');    
    set(handles.pushbutton5,'Enable','on');
    set(handles.pushbutton6,'Enable','on');
end

% Update handles structure
guidata(hObject, handles);


% % % AUX FUNCTIONS
function dname = mkdir2(dname)

if exist(dname,'dir') == 0
    mkdir(dname);
end


% CENTER FRAME
% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if handles.gui_mode == 1
    for i = 1:length(handles.axes_list)
        set(handles.axes_list(i),'HandleVisibility','ON');
    end
    set(handles.text1,'String','Pick center image');

    % handles.is_frame_selected = false(numel(handles.axes_list),1);
    k = 1;
    while k > 0
        [x,y,b] = ginput(1);
        if b > 1
            k = 0;
            for i = 1:length(handles.axes_list)
                set(handles.axes_list(i),'HandleVisibility','OFF');
            end
        else
            g = gca;
            pos = find(handles.axes_list == g);
            if numel(handles.images) >= pos
                Z = handles.images{pos};
                if handles.is_center_frame(pos) == 0 && handles.is_frame_selected(pos) == 1
                    handles.is_center_frame = false(length(handles.axes_list),1);
                    handles.is_center_frame(pos) = 1;
                    set(handles.figure1,'CurrentAxes',g);
                    s = size(Z);
                    Z(1:round(s(1)/20),:,2) = 255;
                    Z(:,(end-round(s(2)/20):end),2) = 255;
                    Z(:,1:round(s(2)/20),2) = 255;
                    Z((end-round(s(1)/20):end),:,2) = 255;
                    imagesc(Z);
                    axis off;
                    set(handles.axes21,'HandleVisibility','ON');
                    handles.current = handles.images{pos};
                    handles.imgcurr = pos;
                    set(handles.figure1,'CurrentAxes',handles.axes21);
                    imagesc(handles.current);
                    xlim([1,size(handles.current,2)]);
                    ylim([1,size(handles.current,1)]);
                    % axis image;
                    axis off;
                    set(handles.axes21,'HandleVisibility','OFF');  
                    if handles.mosaic_done == 1
                        set(handles.text22,'String',strcat(num2str(handles.imgcurr),{' of '},num2str(handles.lengthdir-1)));
                    else
                        set(handles.text22,'String',strcat(num2str(handles.imgcurr),{' of '},num2str(handles.lengthdir)));
                    end
                    if handles.mosaic_done == 1
                        sm = numel(handles.images)-1;
                    else
                        sm = numel(handles.images);
                    end
                    for i = 1:sm
                        if handles.is_center_frame(i) == 0
                            set(handles.figure1,'CurrentAxes',handles.axes_list(i));
                            Z = handles.images{i};
                            s = size(Z);
                            if handles.is_frame_selected(i) == 1
                                Z(1:round(s(1)/20),:,1) = 255;
                                Z(:,(end-round(s(2)/20):end),1) = 255;
                                Z(:,1:round(s(2)/20),1) = 255;
                                Z((end-round(s(1)/20):end),:,1) = 255;
                            end
                            imagesc(Z);
                            axis off;
                        end
                    end
                elseif handles.is_center_frame(pos) == 1
                    handles.is_center_frame(pos) = 0;
                    if handles.is_frame_selected(pos) == 1
                        set(handles.figure1,'CurrentAxes',g);
                        s = size(Z);
                        Z(1:round(s(1)/20),:,1) = 255;
                        Z(:,(end-round(s(2)/20):end),1) = 255;
                        Z(:,1:round(s(2)/20),1) = 255;
                        Z((end-round(s(1)/20):end),:,1) = 255;
                    end
                    imagesc(Z);
                    axis off;
                end                                
            end
        end
    end
    handles.is_frame_selected(handles.is_center_frame) = 1;

    k = 1;
    handles.final_frames = [];
    for i = 1:length(handles.is_frame_selected)
        if handles.is_frame_selected(i) == 1
            handles.final_frames(k) = i;
            k = k + 1;
        end
    end

    if k > 1
        set(handles.pushbutton7,'Enable','on');
    end
    set(handles.text1,'String','Center Image Selected');

    % Update handles structure
    guidata(hObject, handles);
end


% SELECT FRAMES 1ST HALF
% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.axes21,'HandleVisibility','ON');
k = 1;
set(handles.text1,'String','Pick retinal points');
drawnow();
while k > 0
    [y1,x1,b] = ginput(1);
    if b > 1
        k = 0;
        set(handles.text1,'String','Frames Selected');
        drawnow();
    else                    
        if x1 >= 1 && x1 <=size(handles.current,1) && y1 >= 1 && y1 <=size(handles.current,2)
            hold all
            scatter(y1,x1,'b.');
            handles.pi = [round(y1),round(x1)];
            it3 = [0.15,0.15,0.15];
            bi(k,:) = hsv_interval2_5_2(handles.current,it3,handles.pi);
            it3 = [0.2,0.2,0.2];
            bi2(k,:) = hsv_interval2_5_2(handles.current,it3,handles.pi);
            it3 = [0.3,0.3,0.3];
            bi3(k,:) = hsv_interval2_5_2(handles.current,it3,handles.pi);
            handles.dname2 = strcat(handles.pathname,'\');        
            k = k + 1;
        end
    end
end
if size(bi,1) > 1
    handles.bi = mean(bi);
    handles.bi2 = mean(bi2);
    handles.bi3 = mean(bi3);
else
    handles.bi = bi;
    handles.bi2 = bi2;
    handles.bi3 = bi3;
end

if handles.bi(1) < handles.bi(2)
    d = 0;
else
    d = 1;
end
handles.d = d;

% Outline the optic nerve
set(handles.text1,'String','Select the optic nerve');
drawnow();
for i = 1:4
    [y1(i),x1(i)] = ginput(1);
    drawnow();
    if x1(i) >= 1 && x1(i) <=size(handles.current,1) && y1(i) >= 1 && y1(i) <=size(handles.current,2)
        hold all
        scatter(y1(i),x1(i),'g.');
    end
end

handles.onh = handles.current(round(min(x1)):round(max(x1)),round(min(y1)):round(max(y1)),2);
mkdir2(strcat(handles.pathname,'best_frames_1st\'));
imwrite(handles.onh,strcat(handles.pathname,'best_frames_1st\ohn.png'));
handles.onh = normalize1(imresize(handles.onh,0.25));

set(handles.text1,'String','Thinking...');
drawnow();
handles.pi = [round(y1),round(x1)];
ext = handles.filename;
tic; 
[handles.V,handles.dname2,handles.bi3] = frame_selection_fast7(handles.pathname,'best_frames_1st',...
    handles.video_info,handles.onh,10,handles.l2,20,handles.bi,handles.bi2,handles.bi3,d,ext,0);
t_f = toc;
current = handles.current;

for i = 1:length(handles.axes_list)
    set(handles.axes_list(i),'HandleVisibility','ON');
    axes(handles.axes_list(i));
    imagesc(handles.V{i}.frames(1).cdata);
    xlim([1,size(handles.V{i}.frames(1).cdata,2)]);
    ylim([1,size(handles.V{i}.frames(1).cdata,1)]);
    axis off;
    set(handles.axes_list(i),'HandleVisibility','OFF');
    set(handles.text_list(i),'String',num2str(i));
end

handles.images = [];
handles.lengthdir = length(handles.V);
for i = 1:handles.lengthdir
    handles.images{i} = handles.V{i}.frames(1).cdata;
end
handles.imgcurr = 1;
handles.current = zeros(size(handles.current,1),size(handles.current,2),3);
set(handles.axes21,'HandleVisibility','ON');
axes(handles.axes21);
imagesc(handles.current);
xlim([1,size(handles.current,2)]);
ylim([1,size(handles.current,1)]);
axis off;
set(handles.axes21,'HandleVisibility','OFF');
drawnow();
handles.current = handles.V{1}.frames(1).cdata;
set(handles.axes21,'HandleVisibility','ON');
axes(handles.axes21);
imagesc(handles.current);
xlim([1,size(handles.current,2)]);
ylim([1,size(handles.current,1)]);
axis off;
set(handles.axes21,'HandleVisibility','OFF');
set(handles.text22,'String',strcat(num2str(handles.imgcurr),{' of '},num2str(handles.lengthdir)));

set(handles.pushbutton2,'Enable','on');    
set(handles.text1,'String','Frames Selected');    

% Update handles structure
guidata(hObject, handles);


% SELECT FRAMES 2ND HALF
% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.axes21,'HandleVisibility','ON');
k = 1;
set(handles.text1,'String','Pick retinal points');
drawnow();
while k > 0
    [y1,x1,b] = ginput(1);
    if b > 1
        k = 0;
        set(handles.text1,'String','Frames Selected');
        drawnow();
    else                    
        if x1 >= 1 && x1 <=size(handles.current,1) && y1 >= 1 && y1 <=size(handles.current,2)
            hold all
            scatter(y1,x1,'b.');
            handles.pi = [round(y1),round(x1)];
            it3 = [0.15,0.15,0.15];
            bi(k,:) = hsv_interval2_5_2(handles.current,it3,handles.pi);
            it3 = [0.2,0.2,0.2];
            bi2(k,:) = hsv_interval2_5_2(handles.current,it3,handles.pi);
            it3 = [0.3,0.3,0.3];
            bi3(k,:) = hsv_interval2_5_2(handles.current,it3,handles.pi);
            handles.dname2 = strcat(handles.pathname,'\');        
            k = k + 1;
        end
    end
end
if size(bi,1) > 1
    handles.bi = mean(bi);
    handles.bi2 = mean(bi2);
    handles.bi3 = mean(bi3);
else
    handles.bi = bi;
    handles.bi2 = bi2;
    handles.bi3 = bi3;
end

if handles.bi(1) < handles.bi(2)
    d = 0;
else
    d = 1;
end
handles.d = d;

% Outline the optic nerve
set(handles.text1,'String','Select the optic nerve');
drawnow();
for i = 1:4
    [y1(i),x1(i)] = ginput(1);
    drawnow();
    if x1(i) >= 1 && x1(i) <=size(handles.current,1) && y1(i) >= 1 && y1(i) <=size(handles.current,2)
        hold all
        scatter(y1(i),x1(i),'g.');
    end
end

handles.onh = handles.current(round(min(x1)):round(max(x1)),round(min(y1)):round(max(y1)),2);
mkdir2(strcat(handles.pathname,'best_frames_2nd\'));
imwrite(handles.onh,strcat(handles.pathname,'best_frames_2nd\ohn.png'));
handles.onh = normalize1(imresize(handles.onh,0.25));

set(handles.text1,'String','Thinking...');
drawnow();
handles.pi = [round(y1),round(x1)];
ext = handles.filename;
tic; 
[handles.V,handles.dname2,handles.bi3] = frame_selection_fast7(handles.pathname,'best_frames_2nd',...
    handles.video_info,handles.onh,10,handles.l2,20,handles.bi,handles.bi2,handles.bi3,handles.d,ext,handles.offset);
t_f = toc;
current = handles.current;

for i = 1:length(handles.axes_list)
    set(handles.axes_list(i),'HandleVisibility','ON');
    axes(handles.axes_list(i));
    imagesc(handles.V{i}.frames(1).cdata);
    xlim([1,size(handles.V{i}.frames(1).cdata,2)]);
    ylim([1,size(handles.V{i}.frames(1).cdata,1)]);
    axis off;
    set(handles.axes_list(i),'HandleVisibility','OFF');
    set(handles.text_list(i),'String',num2str(i));
end

handles.images = [];
handles.lengthdir = length(handles.V);
for i = 1:handles.lengthdir
    handles.images{i} = handles.V{i}.frames(1).cdata;
end
handles.imgcurr = 1;
handles.current = zeros(size(handles.current,1),size(handles.current,2),3);
set(handles.axes21,'HandleVisibility','ON');
axes(handles.axes21);
imagesc(handles.current);
xlim([1,size(handles.current,2)]);
ylim([1,size(handles.current,1)]);
axis off;
set(handles.axes21,'HandleVisibility','OFF');
drawnow();
handles.current = handles.V{1}.frames(1).cdata;
set(handles.axes21,'HandleVisibility','ON');
axes(handles.axes21);
imagesc(handles.current);
xlim([1,size(handles.current,2)]);
ylim([1,size(handles.current,1)]);
axis off;
set(handles.axes21,'HandleVisibility','OFF');
set(handles.text22,'String',strcat(num2str(handles.imgcurr),{' of '},num2str(handles.lengthdir)));

set(handles.pushbutton2,'Enable','on');    
set(handles.text1,'String','Frames Selected');    

% Update handles structure
guidata(hObject, handles);


% MODE
% --------------------------------------------------------------------
function Untitled_2_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% VIDEO MODE
% --------------------------------------------------------------------
function Untitled_3_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if handles.gui_mode == 1
    handles.gui_mode = 0;
    set(handles.Untitled_3,'Checked','On');
    set(handles.Untitled_4,'Checked','Off');
    set(handles.text23,'String','Video Mode');
    gui_mode = handles.gui_mode;
    save([handles.dname0,'settings.mat'],'-append','gui_mode');
end
guidata(hObject, handles);


% IMAGE MODE
% --------------------------------------------------------------------
function Untitled_4_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if handles.gui_mode == 0
    handles.gui_mode = 1;
    set(handles.Untitled_4,'Checked','On');
    set(handles.Untitled_3,'Checked','Off');
    set(handles.text23,'String','Image Mode');
    gui_mode = handles.gui_mode;
    save([handles.dname0,'settings.mat'],'-append','gui_mode');
end
guidata(hObject, handles);
