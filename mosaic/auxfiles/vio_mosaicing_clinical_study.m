function varargout = vio_mosaicing_clinical_study(varargin)
% VIO_MOSAICING_CLINICAL_STUDY M-file for vio_mosaicing_clinical_study.fig
%      VIO_MOSAICING_CLINICAL_STUDY, by itself, creates a new VIO_MOSAICING_CLINICAL_STUDY or raises the existing
%      singleton*.
%
%      H = VIO_MOSAICING_CLINICAL_STUDY returns the handle to a new VIO_MOSAICING_CLINICAL_STUDY or the handle to
%      the existing singleton*.
%
%      VIO_MOSAICING_CLINICAL_STUDY('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIO_MOSAICING_CLINICAL_STUDY.M with the given input arguments.
%
%      VIO_MOSAICING_CLINICAL_STUDY('Property','Value',...) creates a new VIO_MOSAICING_CLINICAL_STUDY or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vio_mosaicing_clinical_study_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vio_mosaicing_clinical_study_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vio_mosaicing_clinical_study

% Last Modified by GUIDE v2.5 15-Mar-2011 19:54:58

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vio_mosaicing_clinical_study_OpeningFcn, ...
                   'gui_OutputFcn',  @vio_mosaicing_clinical_study_OutputFcn, ...
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


% --- Executes just before vio_mosaicing_clinical_study is made visible.
function vio_mosaicing_clinical_study_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vio_mosaicing_clinical_study (see VARARGIN)

% Choose default command line output for vio_mosaicing_clinical_study
handles.output = hObject;

addpath('mmread');

handles.current = zeros(7,9,3);
handles.final_chosen = ones(20,1);
handles.mode = 0;

set(handles.axes1,'HandleVisibility','ON');
handles.axes_list(1) = handles.axes1;
handles.text_list(1) = handles.text2;
axes(handles.axes1);
imagesc(handles.current);
axis off;
set(handles.axes1,'HandleVisibility','OFF');
set(handles.axes2,'HandleVisibility','ON');
handles.axes_list(2) = handles.axes2;
handles.text_list(2) = handles.text3;
axes(handles.axes2);
imagesc(handles.current);
axis off;
set(handles.axes2,'HandleVisibility','OFF');
set(handles.axes3,'HandleVisibility','ON');
handles.axes_list(3) = handles.axes3;
handles.text_list(3) = handles.text4;
axes(handles.axes3);
imagesc(handles.current);
axis off;
set(handles.axes3,'HandleVisibility','OFF');
set(handles.axes4,'HandleVisibility','ON');
handles.axes_list(4) = handles.axes4;
handles.text_list(4) = handles.text5;
axes(handles.axes4);
imagesc(handles.current);
axis off;
set(handles.axes4,'HandleVisibility','OFF');
set(handles.axes5,'HandleVisibility','ON');
handles.axes_list(5) = handles.axes5;
handles.text_list(5) = handles.text6;
axes(handles.axes5);
imagesc(handles.current);
axis off;
set(handles.axes5,'HandleVisibility','OFF');
set(handles.axes6,'HandleVisibility','ON');
handles.axes_list(6) = handles.axes6;
handles.text_list(6) = handles.text7;
axes(handles.axes6);
imagesc(handles.current);
axis off;
set(handles.axes6,'HandleVisibility','OFF');
set(handles.axes7,'HandleVisibility','ON');
handles.axes_list(7) = handles.axes7;
handles.text_list(7) = handles.text8;
axes(handles.axes7);
imagesc(handles.current);
axis off;
set(handles.axes7,'HandleVisibility','OFF');
set(handles.axes8,'HandleVisibility','ON');
handles.axes_list(8) = handles.axes8;
handles.text_list(8) = handles.text9;
axes(handles.axes8);
imagesc(handles.current);
axis off;
set(handles.axes8,'HandleVisibility','OFF');
set(handles.axes9,'HandleVisibility','ON');
handles.axes_list(9) = handles.axes9;
handles.text_list(9) = handles.text10;
axes(handles.axes9);
imagesc(handles.current);
axis off;
set(handles.axes9,'HandleVisibility','OFF');
set(handles.axes10,'HandleVisibility','ON');
handles.axes_list(10) = handles.axes10;
handles.text_list(10) = handles.text11;
axes(handles.axes10);
imagesc(handles.current);
axis off;
set(handles.axes10,'HandleVisibility','OFF');
set(handles.axes11,'HandleVisibility','ON');
handles.axes_list(11) = handles.axes11;
handles.text_list(11) = handles.text12;
axes(handles.axes11);
imagesc(handles.current);
axis off;
set(handles.axes11,'HandleVisibility','OFF');
set(handles.axes12,'HandleVisibility','ON');
handles.axes_list(12) = handles.axes12;
handles.text_list(12) = handles.text13;
axes(handles.axes12);
imagesc(handles.current);
axis off;
set(handles.axes12,'HandleVisibility','OFF');
set(handles.axes13,'HandleVisibility','ON');
handles.axes_list(13) = handles.axes13;
handles.text_list(13) = handles.text14;
axes(handles.axes13);
imagesc(handles.current);
axis off;
set(handles.axes13,'HandleVisibility','OFF');
set(handles.axes14,'HandleVisibility','ON');
handles.axes_list(14) = handles.axes14;
handles.text_list(14) = handles.text15;
axes(handles.axes14);
imagesc(handles.current);
axis off;
set(handles.axes14,'HandleVisibility','OFF');
set(handles.axes15,'HandleVisibility','ON');
handles.axes_list(15) = handles.axes15;
handles.text_list(15) = handles.text16;
axes(handles.axes15);
imagesc(handles.current);
axis off;
set(handles.axes15,'HandleVisibility','OFF');
set(handles.axes16,'HandleVisibility','ON');
handles.axes_list(16) = handles.axes16;
handles.text_list(16) = handles.text17;
axes(handles.axes16);
imagesc(handles.current);
axis off;
set(handles.axes16,'HandleVisibility','OFF');
set(handles.axes17,'HandleVisibility','ON');
handles.axes_list(17) = handles.axes17;
handles.text_list(17) = handles.text18;
axes(handles.axes17);
imagesc(handles.current);
axis off;
set(handles.axes17,'HandleVisibility','OFF');
set(handles.axes18,'HandleVisibility','ON');
handles.axes_list(18) = handles.axes18;
handles.text_list(18) = handles.text19;
axes(handles.axes18);
imagesc(handles.current);
axis off;
set(handles.axes18,'HandleVisibility','OFF');
set(handles.axes19,'HandleVisibility','ON');
handles.axes_list(19) = handles.axes19;
handles.text_list(19) = handles.text20;
axes(handles.axes19);
imagesc(handles.current);
axis off;
set(handles.axes19,'HandleVisibility','OFF');
set(handles.axes20,'HandleVisibility','ON');
handles.axes_list(20) = handles.axes20;
handles.text_list(20) = handles.text21;
axes(handles.axes20);
imagesc(handles.current);
axis off;
set(handles.axes20,'HandleVisibility','OFF');
set(handles.axes21,'HandleVisibility','ON');
% handles.axes_list(21) = handles.axes21;
handles.axes21
axes(handles.axes21);
imagesc(handles.current);
axis off;
set(handles.axes21,'HandleVisibility','OFF');

handles.is_frame_selected = zeros(length(handles.axes_list),1);
handles.final_frames = [];

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vio_mosaicing_clinical_study wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vio_mosaicing_clinical_study_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% LOAD VIDEO
% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname, filterindex] = uigetfile( ...
       {'*.avi;*.mpg;*.wmv', 'Video Files (*.avi, *.mpg, *.wmv)';
        '*.avi',  'AVIs (*.avi)'; ...
        '*.mpg;*.mpeg','MPEGs (*.mpg;*.mpeg)'; ...
        '*.wmv', 'WMVs (*.wmv)'}, ...
        'Pick a file');

if (filename ~= 0)
    handles.filename = sprintf('%s%s',pathname,filename);
    handles.pathname = sprintf('%s%s',pathname);
    filename = handles.filename;
    pathname = handles.pathname;
    save filenames filename pathname

    handles.video_info = mmread_silent(handles.filename,1,[],false,true);    
%     handles.l2 = round(abs(handles.video_info.nrFramesTotal)/2);
    handles.l2 = min(round(abs(handles.video_info.nrFramesTotal)/2),2000);
%     handles.offset = round(abs(handles.video_info.nrFramesTotal)/2);
    handles.offset = abs(handles.video_info.nrFramesTotal) - max(2000,handles.l2); %handles.l2;
    handles.offset = min(handles.l2,min(1500,handles.offset));
%     handles.offset
%     handles.offset = 10;
    
%     handles.video_info = mmread_silent(filename,1:min(500,l2),[],false,true);
    handles.s1 = size(handles.video_info.frames(1).cdata);
%     l1 = length(handles.video_info.frames);
%     handles.video = zeros(s1(1),s1(2),s1(3),round(handles.l2/2),'uint8');
%     handles.video_list = zeros(round(handles.l2/2),1);
%     handles.video_list(1) = 1;
%     handles.video(:,:,:,1) = handles.video_info.frames(1).cdata;
%     for i = 1:l1
%         handles.video(:,:,:,i) = handles.video_info.frames(i).cdata;
%     end        
%     handles.video_info = mmreader(filename);
%     handles.video = read(handles.video_info);
%     handles.current = handles.video(:,:,:,1);
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
    set(handles.pushbutton3,'Enable','on');
    set(handles.pushbutton4,'Enable','on');
end

% Update handles structure
guidata(hObject, handles);


% BEST FRAMES
% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
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
    [x,y,b] = ginput(1);
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
if k > 1
    set(handles.pushbutton7,'Enable','on');
end
set(handles.text1,'String','Best Frames Selected');

% Update handles structure
guidata(hObject, handles);



% SELECT FRAMES 1ST HALF
% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.axes21,'HandleVisibility','ON');
% [y1,x1] = ginput(1);
% hold all
% scatter(y1,x1,'b.');

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
%             it3 = [0.05,0.4,0.4];
            it3 = [0.15,0.15,0.15];
            bi(k,:) = hsv_interval2_5_2(handles.current,it3,handles.pi);
%             it3 = [0.1,0.4,0.4];
            it3 = [0.2,0.2,0.2];
            bi2(k,:) = hsv_interval2_5_2(handles.current,it3,handles.pi);
%             it3 = [0.2,0.4,0.4];
            it3 = [0.3,0.3,0.3];
            bi3(k,:) = hsv_interval2_5_2(handles.current,it3,handles.pi);
%             it3 = 0.15;        
%             bi(k,:) = hsv_interval2_5(handles.current,it3,handles.pi);
%             it3 = 0.2;        
%             bi2(k,:) = hsv_interval2_5(handles.current,it3,handles.pi);
%             it3 = 0.3;        
%             bi3(k,:) = hsv_interval2_5(handles.current,it3,handles.pi);
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
% set(handles.text1,'String','Frames Selected');

handles.onh = handles.current(round(min(x1)):round(max(x1)),round(min(y1)):round(max(y1)),2);
mkdir(strcat(handles.pathname,'best_frames_1st\'));
imwrite(handles.onh,strcat(handles.pathname,'best_frames_1st\ohn.png'));
handles.onh = normalize1(imresize(handles.onh,0.25));
% handles.current = handles.ohn;
% set(handles.axes21,'HandleVisibility','ON');
% axes(handles.axes21);
% imagesc(handles.onh); colormap gray
% xlim([1,size(handles.onh,2)]);
% ylim([1,size(handles.onh,1)]);
% axis off;
% set(handles.axes21,'HandleVisibility','OFF');


tic
% if x1 >= 1 && x1 <=size(handles.current,1) && y1 >= 1 && y1 <=size(handles.current,2)
        set(handles.text1,'String','Thinking...');
        drawnow();
        handles.pi = [round(y1),round(x1)];
%         ext = '.wmv';
%         ext = '.avi';
        ext = handles.filename;
        tic; 
%         [handles.V,handles.dname2,handles.bi3] = frame_selection_fast5(handles.current,handles.pathname,'best_frames',...
%             handles.video_info,10,handles.l2,20,handles.pi,1,ext);
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

    %     handles.images_hand = handles.images;
    %     handles.images = handles.V;
    %     handles.imgcurr = 1;
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
% end
toc

% Update handles structure
guidata(hObject, handles);


% SELECT FRAMES 2ND HALF
% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% set(handles.axes21,'HandleVisibility','ON');
% % [y1,x1] = ginput(1);
% % hold all
% % scatter(y1,x1,'b.');
% 
% k = 1;
% set(handles.text1,'String','Pick retinal points');
% drawnow();
% while k > 0
%     [y1,x1,b] = ginput(1);
%     if b > 1
%         k = 0;
%         set(handles.text1,'String','Frames Selected');
%         drawnow();
%     else                    
%         if x1 >= 1 && x1 <=size(handles.current,1) && y1 >= 1 && y1 <=size(handles.current,2)
%             hold all
%             scatter(y1,x1,'b.');
%             handles.pi = [round(y1),round(x1)];
%             it3 = 0.15;        
%             bi(k,:) = hsv_interval2_5(handles.current,it3,handles.pi);
%             it3 = 0.2;        
%             bi2(k,:) = hsv_interval2_5(handles.current,it3,handles.pi);
%             it3 = 0.3;        
%             bi3(k,:) = hsv_interval2_5(handles.current,it3,handles.pi);
%             handles.dname2 = strcat(handles.pathname,'\');        
%             k = k + 1;
%         end
%     end
% end
% if size(bi,1) > 1
%     handles.bi = mean(bi);
%     handles.bi2 = mean(bi2);
%     handles.bi3 = mean(bi3);
% else
%     handles.bi = bi;
%     handles.bi2 = bi2;
%     handles.bi3 = bi3;
% end

set(handles.axes21,'HandleVisibility','ON');
% [y1,x1] = ginput(1);
% hold all
% scatter(y1,x1,'b.');

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
%             it3 = [0.05,0.4,0.4];
            it3 = [0.15,0.15,0.15];
            bi(k,:) = hsv_interval2_5_2(handles.current,it3,handles.pi);
%             it3 = [0.1,0.4,0.4];
            it3 = [0.2,0.2,0.2];
            bi2(k,:) = hsv_interval2_5_2(handles.current,it3,handles.pi);
%             it3 = [0.2,0.4,0.4];
            it3 = [0.3,0.3,0.3];
            bi3(k,:) = hsv_interval2_5_2(handles.current,it3,handles.pi);
%             it3 = 0.15;        
%             bi(k,:) = hsv_interval2_5(handles.current,it3,handles.pi);
%             it3 = 0.2;        
%             bi2(k,:) = hsv_interval2_5(handles.current,it3,handles.pi);
%             it3 = 0.3;        
%             bi3(k,:) = hsv_interval2_5(handles.current,it3,handles.pi);
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
mkdir(strcat(handles.pathname,'best_frames_2nd\'));
imwrite(handles.onh,strcat(handles.pathname,'best_frames_2nd\ohn.png'));
handles.onh = normalize1(imresize(handles.onh,0.25));

tic
% if x1 >= 1 && x1 <=size(handles.current,1) && y1 >= 1 && y1 <=size(handles.current,2)
        set(handles.text1,'String','Thinking...');
        drawnow();
        handles.pi = [round(y1),round(x1)];
%         ext = '.wmv';
%         ext = '.avi';
        ext = handles.filename;
        tic; 
%         [handles.V,handles.dname2,handles.bi3] = frame_selection_fast5(handles.current,handles.pathname,'best_frames',...
%             handles.video_info,10,handles.l2,20,handles.pi,1,ext);
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

    %     handles.images_hand = handles.images;
    %     handles.images = handles.V;
    %     handles.imgcurr = 1;
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
% end
toc

% Update handles structure
guidata(hObject, handles);


% NEXT
% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
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

% Update handles structure
guidata(hObject, handles);


% PREVIOUS
% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
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

% Update handles structure
guidata(hObject, handles);


% CREATE MOSAIC
% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

tic;
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
        
        dname3 = handles.dname2;
        [Mm,Mgb,M,Mg,Mc] = mosaic_fast2_images(handles.dname2,handles.V,handles.final_frames,handles.bi3,handles.d);
%         handles.current = zeros(max(size(handles.current,1),size(Mm,1)),max(size(handles.current,2),size(Mm,1)),3);
%         handles.current = zeros(size(handles.current,1),size(handles.current,2),3);
%         set(handles.axes21,'HandleVisibility','ON');
%         axes(handles.axes21);
%         xlim([1,2]);
%         ylim([1,2]);
%         handles.current = zeros(7,9,3);
%         imagesc(handles.current);
%         axis off;
%         set(handles.axes21,'HandleVisibility','OFF');
%         drawnow();
        handles.images = [];
        handles.current = Mm;
        handles.images{1} = Mm;
%         handles.images{2} = Mgb;
%         handles.images{3} = M;
%         handles.images{4} = Mg;
%         handles.images{5} = Mc;
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
%         set(handles.text22,'String',strcat(num2str(handles.imgcurr),{' of '},num2str(handles.lengthdir)));
    end
end
toc

% Update handles structure
guidata(hObject, handles);


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_4_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_4 (see GCBO)
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
[filename, pathname, filterindex] = uigetfile( ...
       {'*.avi;*.mpg;*.wmv', 'Video Files (*.avi, *.mpg, *.wmv)';
        '*.avi',  'AVIs (*.avi)'; ...
        '*.mpg;*.mpeg','MPEGs (*.mpg;*.mpeg)'; ...
        '*.wmv', 'WMVs (*.wmv)'}, ...
        'Pick a file');

if (filename ~= 0)
    handles.filename = sprintf('%s%s',pathname,filename);
    handles.pathname = sprintf('%s%s',pathname);
    filename = handles.filename;
    pathname = handles.pathname;
    save filenames filename pathname

    handles.video_info = mmread_silent(handles.filename,1,[],false,true);    
%     handles.l2 = round(abs(handles.video_info.nrFramesTotal)/2);
    handles.l2 = min(round(abs(handles.video_info.nrFramesTotal)/2),2000);
%     handles.offset = round(abs(handles.video_info.nrFramesTotal)/2);
    handles.offset = abs(handles.video_info.nrFramesTotal) - max(2000,handles.l2); %handles.l2;
    handles.offset = min(handles.l2,min(1500,handles.offset));
    handles.offset
%     handles.offset = 10;
    
%     handles.video_info = mmread_silent(filename,1:min(500,l2),[],false,true);
    handles.s1 = size(handles.video_info.frames(1).cdata);
%     l1 = length(handles.video_info.frames);
%     handles.video = zeros(s1(1),s1(2),s1(3),round(handles.l2/2),'uint8');
%     handles.video_list = zeros(round(handles.l2/2),1);
%     handles.video_list(1) = 1;
%     handles.video(:,:,:,1) = handles.video_info.frames(1).cdata;
%     for i = 1:l1
%         handles.video(:,:,:,i) = handles.video_info.frames(i).cdata;
%     end        
%     handles.video_info = mmreader(filename);
%     handles.video = read(handles.video_info);
%     handles.current = handles.video(:,:,:,1);
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
    set(handles.pushbutton3,'Enable','on');
    set(handles.pushbutton4,'Enable','on');
end

% Update handles structure
guidata(hObject, handles);


% [filename, pathname, filterindex] = uigetfile( ...
%        {'*.avi;*.mpg;*.wmv', 'Video Files (*.avi, *.mpg, *.wmv)';
%         '*.avi',  'AVIs (*.avi)'; ...
%         '*.mpg;*.mpeg','MPEGs (*.mpg;*.mpeg)'; ...
%         '*.wmv', 'WMVs (*.wmv)'}, ...
%         'Pick a file');
% 
% if (filename ~= 0)
%     handles.filename = sprintf('%s%s',pathname,filename);
%     handles.pathname = sprintf('%s%s',pathname);
%     filename = handles.filename;
%     pathname = handles.pathname;
%     save filenames filename pathname
% 
%     handles.video_info = mmread_silent(handles.filename,1,[],false,true);    
% %     handles.l2 = round(abs(handles.video_info.nrFramesTotal)/2);
%     handles.l2 = min(round(abs(handles.video_info.nrFramesTotal)/2),2000);
% %     handles.offset = round(abs(handles.video_info.nrFramesTotal)/2);
%     handles.offset = abs(handles.video_info.nrFramesTotal) - max(2000,handles.l2); %handles.l2;
%     handles.offset = min(handles.l2,min(1500,handles.offset));
%     handles.offset
% %     handles.offset = 10;
%     
% %     handles.video_info = mmread_silent(filename,1:min(500,l2),[],false,true);
%     handles.s1 = size(handles.video_info.frames(1).cdata);
% %     l1 = length(handles.video_info.frames);
% %     handles.video = zeros(s1(1),s1(2),s1(3),round(handles.l2/2),'uint8');
% %     handles.video_list = zeros(round(handles.l2/2),1);
% %     handles.video_list(1) = 1;
% %     handles.video(:,:,:,1) = handles.video_info.frames(1).cdata;
% %     for i = 1:l1
% %         handles.video(:,:,:,i) = handles.video_info.frames(i).cdata;
% %     end        
% %     handles.video_info = mmreader(filename);
% %     handles.video = read(handles.video_info);
% %     handles.current = handles.video(:,:,:,1);
%     handles.frame_nb = 1;
%     disp('Video info loaded from file');
%     
%     set(handles.text1,'Visible','on');
%     set(handles.text1,'String','Thinking...');
%     set(handles.text1,'String','Video Loaded');
%     
%     d = dir(strcat(pathname,'\*.jpg'));
%     handles.lengthdir = length(d);
%     handles.imgcurr = 1;
%     for i = 1:length(d)
%         handles.images{i} = imread(strcat(pathname,'\',d(i).name));
%     end
%     if ~isempty(d)
%         handles.current = handles.images{1};
%         set(handles.axes21,'HandleVisibility','ON');
%         axes(handles.axes21);
%         imagesc(handles.current);
%         axis off;
%         set(handles.axes21,'HandleVisibility','OFF');
%         set(handles.text22,'Visible','ON');
%         set(handles.text22,'String',strcat(num2str(handles.imgcurr),{' of '},num2str(handles.lengthdir)));
%     end
%         
%     set(handles.pushbutton5,'Enable','on');
%     set(handles.pushbutton6,'Enable','on');
%     set(handles.pushbutton3,'Enable','on');
%     set(handles.pushbutton4,'Enable','on');
% end
% 
% % Update handles structure
% guidata(hObject, handles);


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
        axes(handles.axes_list(i));
        imagesc(handles.images{i});
        axis off;
        set(handles.axes_list(i),'HandleVisibility','OFF');
        set(handles.text_list(i),'String',num2str(i));
    end
            
    handles.current = zeros(size(handles.current,1),size(handles.current,2),3);
    set(handles.axes21,'HandleVisibility','ON');
    axes(handles.axes21);
    imagesc(handles.current);
    axis off;
    set(handles.axes21,'HandleVisibility','OFF');
    drawnow();
    handles.current = handles.images{1};
    set(handles.axes21,'HandleVisibility','ON');
    axes(handles.axes21);
    imagesc(handles.current);
    axis off;
    set(handles.axes21,'HandleVisibility','OFF');
    set(handles.text22,'String',strcat(num2str(handles.imgcurr),{' of '},num2str(handles.lengthdir)));

    set(handles.pushbutton2,'Enable','on');    
    set(handles.text1,'Visible','on');
    set(handles.text1,'String','Frames Selected');    
    set(handles.pushbutton5,'Enable','on');
    set(handles.pushbutton6,'Enable','on');
    set(handles.pushbutton3,'Enable','on');
    set(handles.pushbutton4,'Enable','on');
end

% Update handles structure
guidata(hObject, handles);

