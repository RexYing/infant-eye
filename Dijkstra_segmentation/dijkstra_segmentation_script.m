
% Dijkstra segmentation script
%
% Sample segmentation of a VIO frame.
%
%CODE FOR THE PAPER
%"Exploratory Dijkstra forest based automatic vessel segmentation: applications in video indirect ophthalmoscopy (VIO)",
%R. Estrada, C. Tomasi, M. T. Cabrera, D.K. Wallace, S.F. Freedman, S. Farsiu
%Biomedical Optics Express, 3(2), pp. 327-339. Feb. 2012. 
%COPYRIGHT 2012, DUKE UNIVERSITY 
%Please contact Rolando Estrada who developed the code under the supervision of Prof. Carlo Tomasi and Prof. Sina Farsiu if you have questions about the code and dataset.
%restrada@cs.duke.edu
clear all
close all

opt = option_defaults;
opt_d = dijkstra_seg_defaults;

disp(' ');
disp('Reading image...');
I_f = imread('frame.png');
K_f = imread('frame_mask.png');
K_f = K_f./max(max(K_f));
disp('Read image.');

disp(' ');
disp('Pre-processing image...');
I_f2 = preprocess_frame(I_f,opt);
I_c = I_f2.*repmat(K_f,[1,1,3]);
disp('Pre-processed image.');

disp(' ');
disp('Filtering image...');
G_f = filter_image(I_c,opt);
disp('Filtered image.');

disp(' ');
disp('Segmenting image...');
Dj_f = dijkstra_segmentation(G_f,opt_d);
disp('Segmented image');

disp(' ');
disp('Displaying images...');
figure; imshow(I_f)
figure; imshow(Dj_f);
disp('Displayed images');
