% A function taking the input files to make animations of spatial-temporal
% patters
% spatial_mat: the .mat file with spatial profiles in each time frame
% dyn_dat: the .dat file has the time series of averaged x and n
% outfile_name: the path and name of the animation to be saved (*.mp4)
function make_movie(spatial_mat, dyn_dat, outfile_name)
tempStr=strsplit(outfile_name,'/');
dyn_class_name = strrep(tempStr{end},'_',' ');
dyn_class_name = strrep(dyn_class_name,'.mp4','');

disp(['loading data files for generating animation for spatiaotemporal dynamics of ',dyn_class_name])
load(spatial_mat)
dyn = load(dyn_dat);
disp('data loaded!')

disp(['Generating animation for spatiaotemporal dynamics of ',dyn_class_name,'...'])
v = VideoWriter(outfile_name, 'Motion JPEG AVI');
v.FrameRate = 10;
v.Quality = 90;
open(v);
L = para.L;
D = para.D;
for t=[0:20:para.Tf]
    % initializa a new frame and its settings
    clf;
    fig = gcf;
    gcf_format(gcf, 'w', [200 200 800 800])
    
    ca_num = strcat('M',sprintf('%04d',t));
    eval(['M=',ca_num,';']);
    
    % plot the environment    
    if D > 10
        imagesc(dyn(t+1,3).*ones(100,100));
    else
        imagesc(M(:,:,2));
    end
    hold on; 
    
    % plot the cooperator 
    [nz_r, nz_c, ~] = find(M(:,:,1));
    plot(nz_c, nz_r, 'square','Color',[1 .2 .2],'MarkerSize',8)    
    hold on;
    
    %%% title
    t_in_h = t*0.05;
    title(['t = ',sprintf('%3.1f',t_in_h)],'FontSize',38)
    
    gca_format(gca, 1, 30, [0 L 0 L], [0:L/2:L], [0:L/2:L],...
    'x position ($\Delta x$)', 'y position ($\Delta x$)')
    cmp = repmat(linspace(0.9,0,64),3,1)';
    hMap_format(gca, [0 1], cmp, 1, [0:0.2:1])
    
    %%% writing video frames
    frame = getframe(fig);
    writeVideo(v,frame);
end
close(v);
cd(fileparts(matlab.desktop.editor.getActiveFilename))
disp(['Animation ',tempStr{end},' was generated!'])