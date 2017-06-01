%% s_stToolboxes
%
%  Many scripts or functions need custom toolboxes to run.  We use the
%  @scitran.toolbox method to install these custom toolboxes.
%
%  The idea is this: We store a JSON file on the scitran site that defines
%  how to get the toolboxes.  Typically from github. The scitran toolbox
%  function reads this JSON file and then executes the downloads and adds
%  the toolbox to the path.
%
%  A key purpose of this method is to help reproduciblility of the scripts
%  and the ability to run them at other sites.
%
% BW Scitran Team, 2017

%% Illustrates use of scitran toolbox method

% Open a scitran object
st = scitran('action', 'create', 'instance', 'scitran');

% Find the toolboxes file for a
tbxFile = st.search('files',...
    'project label','Diffusion Noise Analysis',...
    'file name','toolboxes.json');

% This will check for the toolboxes and install if necessary.
st.toolbox(tbxFile{1});

%% Alternatively, get the tbx and install separately

% Build toolbox object from the file, but don't install
tbx = st.toolbox(tbxFile{1},'install',false);

% Install the toolboxes when ready.
tbx.install;

%%
