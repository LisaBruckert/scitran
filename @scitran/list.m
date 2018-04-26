function result = list(obj, returnType, parentID, varargin)
% List Flywheel containers or files inside a parent
%
% Syntax
%   result = scitran.list(returnType, parentID, ...)
%
% The Flywheel objects and files are organized hierarchically
%
%    Group Name
%     Project Name
%      Session Name
%       Acquisition Name
%        file list
%        ...
%
% Or,
%
%     Group Name
%       Collection
%         Session
%           Acquisition
%
% Inputs (required)
%  returnType - project, session, acquisition, file,
%               collectionsession, collectionacquisition
%  parentID   - A Flywheel ID of the parent (group, usually obtained
%               from a search 
%
% Inputs (optional)
%  summary:  - Print a brief summary of the returned objects
%
% Return
%  result:  Cell array of Flywheel objects
%
% Example
%  project      = st.search('project','project label exact','VWFA');
%  sessions     = st.list('session',idGet(project));
%  acquisitions = st.list('acquisition',idGet(sessions{1}));
%
% LMP/BW Vistasoft Team, 2015-16
%
%  See also: scitran.search

% Examples
%{

  st = scitran('stanfordlabs');

  % The struct returned from an elastic search and from an SDK get differ
  % substantially
  project      = st.search('project','project label exact','VWFA');
  sessions     = st.list('session',idGet(project{1}));

  % The group name (not label) is sent for the project
  projects     = st.list('project','wandell');
  sessions     = st.list('session',projects{1}.id);
  acquisitions = st.list('acquisition',sessions{3}.id); 
  files        = st.list('file',acquisitions{1}.id); 

  % The return from search on collections is incomprehensible to me (BW). I
  % Mainly, don't see where the collection id is on the search return
  % collections  = st.search('collection','collection label contains','GearTest');

  % The collection curator is sent, rather than the group name
  collections  = st.list('collection','wandell@stanford.edu');
  sessions     = st.list('collectionsession',collections{1}.id); 
  acquisitions = st.list('collectionacquisition',collections{1}.id); 

%}

%% Parse inputs
p = inputParser;

% Squeeze out spaces and force lower case
returnType = stParamFormat(returnType);
p.addRequired('returnType',@ischar);

p.addRequired('parentID',@ischar);
p.addParameter('summary',true,@islogical);

p.parse(returnType,parentID,varargin{:});

summary = p.Results.summary;

% Get the Flywheel commands
fw = obj.fw;

%%  Call the relevant SDK rouinte
switch returnType
    case 'project'
        % ParentID is a group label
        data = {};
        tmp = fw.getAllProjects;
        cnt = 1;
        for ii=1:numel(tmp)
            if strcmp(tmp{ii}.group,parentID)
                data{cnt} = tmp{ii}; %#ok<AGROW>
                cnt = cnt + 1;
            end
        end
        
    case 'session'
        data = fw.getProjectSessions(parentID);
        
    case 'acquisition'
        % Parent is session
        data = fw.getSessionAcquisitions(parentID);
        
    case 'file'
        % ParentID is acquisition
        acq = fw.getAcquisition(parentID);
        data = acq.files;

    case 'collection'
        % An email address of the curator replaces the groupID/parentID
        data = {};
        tmp = fw.getAllCollections;
        cnt = 1;
        for ii=1:numel(tmp)
            if strcmp(tmp{ii}.curator,parentID)
                data{cnt} = tmp{ii}; %#ok<AGROW>
                cnt = cnt + 1;
            end
        end
        
    case 'collectionsession'
        % Parent is the collection
        data = fw.getCollectionSessions(parentID);
        
    case 'collectionacquisition'
        % Parent is the collection
        data = fw.getCollectionAcquisitions(parentID);
        
    otherwise
        error('Unknown object type %s\n',returnType);
end

%% Formatting data to look like search return, result

% We discovered that sometimes srchResult is already a cell array, so in
% that case we don't do the conversion.  We should ask Jen R about this.
if ~iscell(data)
    result = cell(numel(data),1);
    for ii=1:numel(data)
        result{ii} = data(ii);
    end
else
    result = data;
end

%%

if summary
    fprintf('Returned %d objects (%s)\n',numel(result), returnType);
end


end

