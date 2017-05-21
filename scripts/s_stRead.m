% s_stRead
%
% Test the data reading methods
%
% BW

%% Open the scitran client

st = scitran('action', 'create', 'instance', 'scitran');

%%  Get an example nifti file

% From the VWFA project
sessions = st.search('sessions', ...
    'project label','VWFA');

files = st.search('files', ...
    'session id',sessions{1}.id, ...
    'file type','nifti');

[data, destination] = st.read(files{1},'fileType','nifti');

%%
niftiView(data);
delete(destination);
% if ismac
%    % There is an mriCro app for Mac and we could use that for some
%    % glamorous visualization of the NIFTI data.
%    % https://itunes.apple.com/us/app/mricro/id942363246?ls=1&mt=12
% end


%% Matlab data

% From the showdes (logothetis) project
files = st.search('files',...
    'project label contains','showdes', ...
    'file name','e11au1_roidef.mat');

[data, destination] = st.read(files{1},'fileType','mat');
delete(destination);

%% OBJ files for visualization

