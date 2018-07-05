%% s_stDownloadFile
%
% Download examples:
%    JSON file from a projects
%    Analysis output file
% 
% TODO:  file from an acquisition
%
%
% See also - s_stDownloadFile

%% Open up the scitran object

st = scitran('stanfordlabs');
% st.verify

%% Download and read a small JSON file

file  = st.search('file',...
    'project label exact','DEMO',...
    'filename','dtiError.json');
fName = st.downloadFile(file{1});
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

% Readable way to get the analysis is
id = idGet(analysis{1},'data type','analysis');

% This gets the information container of the analysis
analysisFiles = st.list('analysis file',id);
stPrint(analysisFiles,'name','');

% Apparently, we need to have a destination for the file.
fName = fullfile(pwd,'lh.pial.obj');
st.downloadFile('lh.pial.obj',...
    'container id',id,...
    'container type','analysis', ...
    'destination',fName);
% exist(fName,'file')

%%
