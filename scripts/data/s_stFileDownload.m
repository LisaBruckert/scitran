%% s_stFileDownload
%
% Download examples:
%    JSON file from a projects
%    Analysis output file
%
% See also
%  

%% Open up the scitran object

st = scitran('stanfordlabs');
st.verify;

%% Download and read a small JSON file

file  = st.search('file',...
    'project label exact','DEMO',...
    'filename','dtiError.json');
fName = st.fileDownload(file{1});
s = jsonread(fName);
disp(s)

% Clean up
delete(fName);

%% Download an obj file from the FreeSurfer recon -all analysis

analysis = st.search('analysis',...
    'project label exact', 'Brain Beats',...
    'session label exact','20180319_1232', ...
    'summary',true);

fprintf('** Analysis:\nlabel: %s\nid: %s\n', ...
    analysis{1}.analysis.label,analysis{1}.analysis.id);

%% 
fName = fullfile(stRootPath,'local','lh.pial.obj');
st.fileDownload('lh.pial.obj',...
    'container id',analysis{1}.analysis.id,...
    'container type','analysis', ...
    'destination',fName);

if exist(fName,'file'), fprintf('File downloaded to %s\n',fName); end

fprintf('Deleting %s\n',fName)
delete(fName);

%%
