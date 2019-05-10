%% initialization
% reset the environment
clear all; clc;
% goes to the folder the current script is in
% and add this path into searching path for future use
cd(fileparts(matlab.desktop.editor.getActiveFilename))
addpath(fullfile(pwd));

%%
spatial_mat = './input/movies/propagating_wave.mat';
dyn_dat = './input/movies/propagating_wave_dyn.dat';
outfile_name = './output/propagating_wave.avi';
make_movie(spatial_mat, dyn_dat, outfile_name);
%%
spatial_mat = './input/movies/moving_clusters.mat';
dyn_dat = './input/movies/moving_clusters_dyn.dat';
outfile_name = './output/moving_clusters.avi';
make_movie(spatial_mat, dyn_dat, outfile_name);
%%
spatial_mat = './input/movies/flickering.mat';
dyn_dat = './input/movies/flickering_dyn.dat';
outfile_name = './output/flickering.avi';
make_movie(spatial_mat, dyn_dat, outfile_name);
