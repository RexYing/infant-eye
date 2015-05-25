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
handles.defaultBlurMetricFeatureThresh = 3.3;

handles.defaultEyeRegionOutputDir = 'eyeregion';

guidata(hObject, handles);