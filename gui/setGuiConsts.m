function [ ] = setGuiConsts( hObject, handles )
%SETGUICONSTS Set GUI constants
% Constants are set in the given GUI handle
% New handles data is saved to hObject using guidata
%
% Params:
%   hObject: handle to GUI figure
%   handle: GUI handle
%

handles.defaultSiftFlowFeatureThresh = 12;
handles.defaultBlurMetricFeatureThresh = 0.33;

handles.extracted = true;
handles.showRegistered = false;
%handles.outputDir = 'data/gui_test';

handles.defaultEyeRegionOutputDir = 'eyeregion';
handles.defaultSelectedOutputDir = 'selected_frames';
handles.defaultRegisteredOutputDir = 'registered_frames';
handles.defaultFusedOutputDir = 'fused';

guidata(hObject, handles);