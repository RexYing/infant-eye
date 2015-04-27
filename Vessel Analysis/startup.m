% startup.m
%
% script
% to set up path structure within this directory
%
clear all; %#ok<CLSCR>
close all;

% function handle for adding a directory and its subdirectory
addsubdir = @(dir) addpath(genpath(dir));

%add utility routines
addsubdir('FastMarching_version3b');
addsubdir('measures');
addsubdir('utility');

% add code
addpath vasculature-graph
%addpath javacode/lib

% add data
addpath data

% add java path
% jar file should be compiled with jre in Matlabroot/sys/java/jre and make
% sure there is no version incompatibility
% classes should be public
javaaddpath JVasculature.jar
%javaaddpath javacode/lib/ejml-0.23.jar

clearvars addsubdir

% -------------------------------
% Date : Nov 1, 2014
% Rex Ying
% Duke University
% ------------------------------