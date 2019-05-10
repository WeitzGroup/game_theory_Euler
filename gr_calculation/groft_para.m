%%%%%% This function calculates g(r) of spatial profiles

function groft_para(L, x0, n0, D, rs, Ti, Tf)
%%%%%% create a worker pool and prepare raw data for calculation
PaceParalleltoolbox_r2016b('cores',4);
M_all = read_file(L, x0, n0, D, rs, Ti, Tf);

%%%%%% would like to save file per [bin_s] calculation
%%%%%% rather than save one time after calculation is done
%%%%%% such that at least some results would be returned if code
%%%%%% is terminated unexpectedly
bin_s = 100;
n_bin = ceil((Tf-Ti+1)/bin_s);

gr_C = [];
gr_N = [];
gr_CN = [];

for bin = 0:n_bin-1
    if(bin < n_bin - 1)
        j_max = bin_s;
    else
        j_max = (Tf-Ti+1) - bin_s*(n_bin-1);
    end
    
    %%%%%% define a small chunk of matrix to store information
    %%%%%% to avoid unclassfied variables in parfor loop
    gr_C_slice = zeros(L/2, j_max);
    gr_N_slice = zeros(L/2, j_max);
    gr_CN_slice = zeros(L/2, j_max);
    parfor j = 0:j_max-1
        t = Ti + bin*bin_s + j;
        disp(t)
        M = M_all{t+1};
        gr_temp1 = raddist(M(:,:,1), M(:,:,1), 1, 1);
        gr_C_slice(:,j+1) = gr_temp1(:,2);
        if(D<10)
            gr_temp2 = raddist(M(:,:,2), M(:,:,2), 1, 0);
            gr_N_slice(:,j+1) = gr_temp2(:,2);
            gr_temp3 = raddist(M(:,:,1), M(:,:,2), 1, 0);
            gr_CN_slice(:,j+1) = gr_temp3(:,2);
        end
    end
    gr_C = [gr_C, gr_C_slice];
    if(D<10)
        gr_N = [gr_N, gr_N_slice];
        gr_CN = [gr_CN, gr_CN_slice];
    end
    
    %%%%%% save calculation results
    if(D < 10)
        fn_w = ['outfile/D',sprintf('%0.1f',D),'_x',num2str(x0),'_n',num2str(n0),...
            '_rs',num2str(rs),'_gr.mat'];
        save(fn_w, 'gr_C');
        save(fn_w, 'gr_N', '-append');
        save(fn_w, 'gr_CN', '-append');
    else
        fn_w = ['outfile/DInf_x',num2str(x0),'_n',num2str(n0),...
            '_rs',num2str(rs),'_gr.mat'];
        save(fn_w, 'gr_C');
    end
end


% function for calculating radial distribution
% deltax is the length of edge of the grid
% auto is the index for calculating auto-correlation(1) or cross-correlation(0)
function gr = raddist(M1, M2, deltax, auto)
if size(M1) ~= size(M2)
    disp(sprintf('Size of the two input matrix need to match.'))
    return;
    
else
    [l, w] = size(M1);                      % diemnsion of the matrix
    range = min(l,w)/2;                     % maximum range taken into consideration
    gr = zeros(ceil(range),2);              % the matrix storing data of g(r)
    gr(:,1) = deltax*[0:1:ceil(range)-1];	% the first column is the distance r
    Mtemp = zeros(l, w);
    
    [mesh_x, mesh_y] = meshgrid(floor(-l/2)+1:floor(-l/2)+l, ...
        floor(-w/2)+1:floor(-w/2)+w);
    mesh_r = sqrt(mesh_x.^2+mesh_y.^2);
    
    Mbig = [M2, M2, M2; M2, M2, M2; M2, M2, M2];
    Mbig = Mbig(mod(floor(-l/2)+1,l):mod(floor(-l/2)+1,l)+2*l-1, ...
        mod(floor(-w/2)+1,w):mod(floor(-w/2)+1,w)+2*w-1);
    
    Mcorr = xcorr2(Mbig,  M1);
    Mcorr = Mcorr(l+1:2*l, w+1:2*w);
    
    for k = 1:ceil(range)
        logicM = (k-1)<=mesh_r & mesh_r<k;
        area(k) = nnz(logicM);
        gr(k, 2) = sum(Mcorr(logicM));
    end
    
    N1 = sum(sum(M1));
    N2 = sum(sum(M2));
    Vol = l*w*deltax^2;
    switch auto
        case 1
            a = find(M1<0);
            if isempty(a)
                gr(1,2) = sum(sum(M1.*(M1-1)));
            else
                disp('Error: negative value in matrix!')
            end
            gr(:,2) = gr(:,2)./((N1-1)*(N2/Vol)*deltax^2.*area');
        case 0
            gr(:,2) = gr(:,2)./(N1*(N2/Vol)*deltax^2.*area');
    end
end


function M_all = read_file(L, x0, n0, D, rs, Ti, Tf)
formatString = [repmat('%f ',1,L)];
formatString(end) = [];

%%%%%% read in spatial profiles of cooperators
if(D<10)
    fn_x = ['outfile/x_D',sprintf('%0.1f',D),'_x',num2str(x0),'_n',num2str(n0),...
        '_rs',num2str(rs),'_s.dat'];
else
    fn_x = ['outfile/x_DInf_x',num2str(x0),'_n',num2str(n0),...
        '_rs',num2str(rs),'_s.dat'];
end
fid = fopen(fn_x);
t = 0;
while (~feof(fid))
    mat_num = ['M',sprintf('%04d',t)];
    mat_temp = textscan(fid,formatString,100,'CommentStyle','#','delimiter','\t');
    eval([mat_num,'(:,:,1)=cell2mat(mat_temp);'])
    t=t+1;
end
fclose(fid);
clearvars fn fid t;

%%%%%% read in spatial profiles of environment
if(D<10)
    fn_n = ['outfile/n_D',sprintf('%0.1f',D),'_x',num2str(x0),'_n',num2str(n0),...
        '_rs',num2str(rs),'_s.dat'];
    fid = fopen(fn_n);
    t = 0;
    while (~feof(fid))
        mat_num = ['M',sprintf('%04d',t)];
        mat_temp = textscan(fid,formatString,100,'CommentStyle','#','delimiter','\t');
        eval([mat_num,'(:,:,2)=cell2mat(mat_temp);'])
        t=t+1;
    end
    fclose(fid);
    clearvars fn fid t;
end

%%%%%% read in dynamics
if(D<10)
    fn_dyn = ['outfile/dyn_D',sprintf('%0.1f',D),'_x',num2str(x0),'_n',num2str(n0),...
        '_rs',num2str(rs),'_s.dat'];
else
    fn_dyn = ['outfile/dyn_DInf_x',num2str(x0),'_n',num2str(n0),...
        '_rs',num2str(rs),'_s.dat'];
end
dyn = load(fn_dyn);

%%%%%% create a structure to store parameter information
para.L = L;
para.x0 = x0;
para.n0 = n0;
para.D = D;
para.rs = rs;
para.Ti = Ti;
para.Tf = Tf;


%%%%%% save all about information in MATLAB format for future use
if(D<10)
    fn_mat = ['outfile/D',sprintf('%0.1f',D),'_x',num2str(x0),'_n',num2str(n0),...
        '_rs',num2str(rs),'_s.mat'];
else
    fn_mat = ['outfile/DInf_x',num2str(x0),'_n',num2str(n0),...
        '_rs',num2str(rs),'_s.mat'];
end
clearvars -except M* para fn_mat
save(fn_mat);

%%%%%% store matrix in cells for more convenient manipulation in parfor
%%%%%% loop (running variable name is bad in this situation)
for t=para.Ti:para.Tf
    mat_num = ['M',sprintf('%04d',t)];
    M_all{t+1} = eval(mat_num);
end
