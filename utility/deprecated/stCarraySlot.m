function [val, oType] = stCarraySlot(carray, slot1, slot2)
% Extract values of a field from a cell array of search or list return
%
% Find a better name
%
% Syntax
%  [val, oType] = stCarraySlot(objects, slot1, [slot2])
%
% Description
%  Extract the values from a specific slot in a cell array of objects,
%  returned by a scitran.search or a scitran.list method.
%
%  The slot1 and field refers to the first and second struct entries.
%  So, what is printed is a loop over ii for
%
%     objects{ii}.slot1.slot2
%
% Inputs:
%   result -  A cell array returned from the search or list method
%   slot1   - Main slot1
%   slot2  -  Field within the slot1
%
% Optional Key/vals
%   None
%
% Return
%   val - The cell array of extracted values
%
% HINT:  Print out one of the returned objects to see the
%        possibilities for that object. 
%
% Example
%   st = scitran('stanfordlabs');
%   projects = st.search('project');
%   stCarraySlot(projects,'project','label');
%
% See examples in the source code
%
% BW, Vistasoft Team, 2017

% Examples:
%
% st = scitran('stanfordlabs');
%{
  % All project labels
  projects = st.search('project');
  val = stCarraySlot(projects,'project','label');
%}
%{
  % Limited to make the example short.
  projects = st.search('project');
  id = st.objectParse(projects{1})
  sessions = st.search('session',...
      'project id',id, ...
      'limit',10);

  val = stCarraySlot(sessions,'session','label');

  stCarraySlot(sessions,'subject','code');
%}
%{
  % List example 
  projects = st.list('project','wandell');
  stCarraySlot(projects,'label')

  % Print metadata
  project = st.search('project','project label exact','VWFA');
  info = st.infoGet(project{1});

  id = st.objectParse(project{1});
  sessions = st.list('session',id);   % Parent id
  stCarraySlot(sessions,'subject','code');

  [val, oType] =   stCarraySlot(sessions,'subject','code');

%}

%% Parse
if notDefined('carray'), error('cell array is required'); end
if notDefined('slot1'), error('Main slot is required'); end
if notDefined('slot2'), slot2 = ''; end

% Return the values we print out
val = cell(length(carray),1);

%% Start printing

if isempty(slot2)
    for ii=1:length(carray)
        val{ii} = carray{ii}.(slot1);
    end
else
    for ii=1:length(carray)
        val{ii} = carray{ii}.(slot1).(slot2);
    end
end

% Not sure this is a good idea.  Means we have to update
% stObjectParse.
if nargout > 1
    [~,oType] = stObjectParse(carray{1});
end

