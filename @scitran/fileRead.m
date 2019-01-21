function [data, dname] = fileRead(st,fileInfo,varargin)
% Read scitran data from a file into a Matlab variable
%
%   [data, destinationFile] = st.fileRead(fileInfo, ...);
%
% Inputs:
%    fileInfo - An object returned by a search, FileEntry, or filename.
%               Additional parameters are required for filename or
%               FileEntry.
%
% Optional key/value parameter
%    'destination'  - Full path to file destination
%    'save'         - Delete or not destination file (logical)
%    'containertype'- Required for filename or FileEntry
%    'containerid'  - Required for filename or FileEntry
%
% See also: s_stRead, scitran.downloadFile
%
% BW/SCITRAN Team, 2017

% Programming todo
%   We need to add some of the read functions into scitran.  For now, I am
%   just adding vistasoft to the path.  Bit niftiRead, objRead are part of
%   vistasoft, not scitran.

% Examples:
%{
  % Read a JSON file
  st = scitran('stanfordlabs');
  file = st.search('file',...
      'project label contains','SOC', ...
      'filename','SOC-ECoG-toolboxes.json',...
      'summary',true);
  data = st.fileRead(file{1});
  disp(data)
%}
%{
  % Read a nifti file.
  st = scitran('stanfordlabs');
  file = st.search('file',...
                   'project label exact','ADNI: T1',...
                   'subject code',4256,...
                   'filetype','nifti',...
                   'summary',true);
  data = st.fileRead(file{1});   % Requires vistasoft niftiRead on path
%}

%% Parse input parameters

p = inputParser;
varargin = stParamFormat(varargin);

p.addRequired('st',@(x)(isa(x,'scitran')));
vFunc = @(x)(isa(x,'flywheel.model.SearchResponse') || ...
             isa(x,'flywheel.model.FileEntry') || ...
             ischar(x));
p.addRequired('fileInfo',vFunc);

p.addParameter('destination',[],@ischar);
p.addParameter('save',false,@islogical);
p.addParameter('containerid','',@ischar);
p.addParameter('containertype','',@ischar);
p.addParameter('filetype','',@ischar);

p.parse(st, fileInfo, varargin{:});

save          = p.Results.save;
containerType = p.Results.containertype;
containerID   = p.Results.containerid;
destination   = p.Results.destination;
forcedFileType = p.Results.filetype;

% The only reason you would have two outputs is to save the file.
if nargout > 1, save = true; end

%% Get the file name, container id and container type

% Returns are:
[containerID, containerType, fileContainerType, fname, fileType] = ...
    st.objectParse(fileInfo,containerType,containerID);

% The user is over-riding the Flywheel file type and demanding that we
% use this file type.  This happens for specific kinds of Matlab data,
% such as a recipe.
if ~isempty(forcedFileType)
    fileType = forcedFileType;
end

% Create destination from file name.  Might need the extension for
% filetype
if isempty(destination),  dname = fullfile(tempdir,fname); 
else,                     dname = destination;
end

%% Download the file
if strcmp(containerType,'fileentry')
    fileInfo.download(dname);
else
    % Probably no longer needed.
    warning('file download called.  I think it should be deprecated.');
    st.fileDownload(fname,...
        'container type',fileContainerType,...
        'container id', containerID,...
        'destination',dname);
end

%% When we read the file, it should be one of these file types

% Not all file types are coordinated with Flywheel.  They label json as
% sourcecode and they ignore obj.
fileTypes = {'matlabdata','nifti','json','source code','obj','recipe'};
fileType = ieParamFormat(fileType);  % Remove spaces, force lower case
try
    validatestring(fileType,fileTypes);
catch
    [~,~,ext] = fileparts(fileInfo.file.name);
    switch ext
        case '.obj'
            fileType = 'obj';
        case '.json'
            fileType = 'source code';
        otherwise
            error('Unknown file type %s\n',fileInfo.file.type);
    end
end

%% Load the file data

% This code depends on having certain
switch ieParamFormat(fileType)
    case {'matlabdata'}        
        data   = load(dname);
        
        % If there is only a single variable loaded, we set data to that
        % variable.
        fnames = fieldnames(data);
        if length(fnames) == 1, data = data.(fnames{1}); end
        
    case 'nifti'
        if isempty(which('niftiRead'))
            fprintf('File has been downloaded to\n\t%s\n',dname);
            fprintf('But no *niftiRead* method is on your path.  Add vistasoft\n');
            error('No niftiRead method.');
        else
            data = niftiRead(dname);
        end
        
    case 'obj'
        % Not sure what to do.  This is a text file, I think.
        if isempty(which('objRead'))
            fprintf('File has been downloaded to\n\t%s\n',dname);
            fprintf('But no *objRead* method is on your path.  Add vistasoft\n');
            error('No objRead method.');
        else
            data = objRead(dname);
        end

        % case 'csv'
        % Read as text
        % Could be a csv file.
        % fprintf('CSV read Not yet implemented %s\n',fileType);
        % fprintf('Download name %s\n',dname);
        % data = textscan(dname);
    case {'json','sourcecode'}
        
        % Use JSONio stuff.  This is always on the scitran path
        data = jsonread(dname);
        
    case {'recipe'}
        % Read the json data into a struct and convert it to an iset3d
        % recipe we use for rendering.  The repository iset3d must be
        % on your path!
        data = jsonread(dname);
        fds = fieldnames(data);
        try  
            thisR = recipe;
        catch
            error('No *recipe* method found. Make sure iset3d is on your path!');
        end
        % assign the struct to a recipe class
        for dd = 1:length(fds)
            thisR.(fds{dd})= data.(fds{dd});
        end
        data = thisR;
        
    otherwise
        error('Unknown file type %s\n,  Download name %s\n',fileType,dname);
end

%% File management

% If the destination file name is not returned, and save is false,
% delete the downloaded file.
if ~save, delete(dname); end

end





