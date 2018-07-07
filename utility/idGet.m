function [id, dataType] = idGet(data,datatype,varargin)
% Return the id of a Flywheel data object
%
% Syntax
%   [id, dataType] = idGet(data, ...)
%
% Brief desription
%   Return the id from different Flywheel container and object types.
%   This routine needs to be handle non-search cell arrays, say the
%   stuff we get back from a scitran.list.
%
% Input
%   data: A struct with Flywheel information either in search or SDK
%         format
%
% Optional key/value inputs
%   "data type" - One of the possible data types
%s
% Return:
%   id:   If data is a single struct, the return is a string.  
%         If data is a cell array of data, id is a cell array of strings.
%
% BW, Vistalab 2017

% Examples
%{
% Checking for the search type containers
group = 'wandell';
projects = st.search('project',...
    'group name',group,...
    'summary',true);
idGet(projects{1})
idGet(projects)
%}
%{
sessions = st.search('session','project label exact','VWFA');
idGet(sessions{1})
idGet(sessions)
%}
%{
acquisitions = st.search('acquisition',...
   'project label exact','VWFA',...
   'session label exact',sessions{1}.session.label);
idGet(acquisitions{1})
idGet(acquisitions)
%}
%{
files = st.search('file',...
   'project label exact','VWFA',...
   'session label exact',sessions{1}.session.label,...
   'acquisition label exact',acquisitions{1}.acquisition.label);
idGet(files{1})
idGet(files)
%}
%{
% Checking for the SDK type containers
projects = st.list('project','wandell');
projID = idGet(projects{1});
idGet(projects)
sessions = st.list('session',projID);
id = idGet(sessions)
acquisitions = st.list('acquisition',id{1});
id = idGet(acquisitions)
id = idGet(acquisitions{1})
%}
%{
% We need to add the collection tests when that is fixed in Flywheel
%}
%%
p = inputParser;
varargin = stParamFormat(varargin);

p.addRequired('data',@(x)(isa(x,'flywheel.model.SearchResponse')));
validTypes = {'project','session','acquisition','file','collection','analysis'};
p.addRequired('datatype',@(x)(ismember(x,validTypes)));

p.parse(data,datatype,varargin{:});
dataType = p.Results.datatype;

%% Determine if is struct or cell array of structs

nData = numel(data);
if nData > 1, id = cell(nData,1); end

if strcmp(dataType,'none')
    % We find the finest resolution in the list and return the id for
    % that dataType
    if     ~isempty(data.file), dataType        = 'file';
    elseif ~isempty(data.acquisition), dataType = 'acquisition';
    elseif ~isempty(data.session), dataType     = 'session';
    elseif ~isempty(data.project), dataType     = 'project';
    elseif ~isempty(data.collection), dataType  = 'collection';
    elseif ~isempty(data.analysis), dataType    = 'analysis';
    else
        error('Cannot identify dataType.  Use "data type" key/value parameter.');
    end
    fprintf('Inferring data type "%s"\n',dataType);
end


%% Read the id values

if isequal(dataType,'file')
    error('Files do not have an id. They have a parentID and a name.');
else   
    if nData == 1
        id = data.(dataType).id;
    else
        for ii=1:nData
            id{ii} = data(ii).(dataType).id;
        end
    end
end


end


