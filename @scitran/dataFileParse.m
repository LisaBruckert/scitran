function [fname, containerType, containerID, fileType] = ...
    dataFileParse(st,fileInfo,containerType,containerID)
% Parse file information at front of various functions
%
% Might be obsolete, in need of deprecation, to be replaced by objectParse
%
% Syntax:
%  [fname, containerType, containerID, fileType] = ...
%           stFileParse(fileInfo,containerType,containerID)
%
% Brief Description
%   Flywheel codes stores file information as a FileEntry, a search
%   response, or as a filename plus container type and id.  We have to
%   sort this out at the front end of various methods.  Hopefully,
%   this will vanish as a hack before too long, if Justin E. does the
%   right set of things.  For example, maybe files will get an id.  Or
%   maybe FileEntry will have a container type and container id.  Or
%   ...
%
%   This whole routine stinks.  Just trying to clean up the look of
%   the code at the front end of various other routines by hiding it
%   here.
%
% Inputs
%
% Optional key/value
%
% Returns
%
% Wandell, Vistasoft 2018
%

disp('dataFileParse is deprecated')

%% If the person does not have the container type and id, they won't send it

% But it is weird to send it and then just get it back.  And it is
% weird to not send it in only for the search response case.  This
% whole routine stinks.
if notDefined('fileInfo'), error('File information required'); end
if notDefined('containerType'), containerType = ''; end
if notDefined('containerID'),   containerID = ''; end

%% Do your best to parse

if ischar(fileInfo)
    % Set up the download variables
    fname = fileInfo;
    if isempty(containerType) || isempty(containerID)
        error('If file is a string, you must specify container information');
    end
    % We need to search for the file type
    if nargout > 3
        srch = st.search('file','file name exact',fname, ...
            'acquisition id',containerID);
        fileType = srch{1}.file.type;
    end
elseif isa(fileInfo,'flywheel.model.FileEntry')
    % A file entry is not much more than the file name at this point.  We
    % need to specify container type and id.  Not sure why it is so
    % limited.
    fname    = fileInfo.name;
    if isempty(containerType) || isempty(containerID)
        error('If file is a FileEntry, you must specify container information');
    end
    if nargout > 3
        fileType = fileInfo.type;
    end
elseif isa(fileInfo,'flywheel.model.SearchResponse')
    % A Flywheel search object has a lot of information about the file.
    fname         = fileInfo.file.name;
    containerType = fileInfo.parent.type;
    containerID   = fileInfo.parent.id;
    if nargout > 3
        fileType      = fileInfo.file.type;
    end
end

end