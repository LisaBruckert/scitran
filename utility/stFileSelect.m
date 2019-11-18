function selectedFiles = stFileSelect(files,slot,matchVal,varargin)
% Select files from a cell array of files based on a parameter
%
%   *** See if you really need this, or you can just use stSelect ***
%
% Synopsis
%   selectedFiles = stFileSelect(files,slot,matchVal,varargin)
%
% Inputs
%  files    - cell array of files from a scitran.list
%  slot     - the slot that must be matched
%  matchVal - String that the slot must match
%
% Optional key/value pairs
%    info field name, the info field value
%
% Returns
%  selectedFiles - The files that matched
%
%
% ZL/Wandell Vistasoft 2018
%
% See also
%   stPrint

% Examples:
%{
  stFileSelect(files,'type','archive','asset','car');
%}
%{
  stFileSelect(files,'name',filename);
%}

%% Parse inputs
p = inputParser;

p.addRequired('files',@iscell);
p.addRequired('slot',@ischar);
p.addRequired('matchVal',@ischar);
p.addParameter('infoval','',@ischar);

p.parse(files,slot,matchVal); %,varargin{:});
matchVal = stParamFormat(matchVal);

%%  Check if the file type and the critical info field matches the requirements

cnt = 1;
selectedFiles = {};
for jj = 1:length(files)
    % Force the slot value to lower case and no spaces.
    try
        slotVal = stParamFormat(files{jj}.(slot));
    catch
        % If it doesn't exist, set it to empty.
        slotVal = '';
    end
    
    % See if the slot value matches
    if isequal(slotVal,matchVal)
        if isempty(varargin)
            % No info fields to check.
            selectedFiles{cnt} = files{jj}; %#ok<AGROW>
            cnt = cnt + 1;
        else
            % There is also an info field specified.  Check that.
            try
                % Does the info field match?  This must be exact.
                if isequal(files{jj}.info.(varargin{1}),varargin{2})
                    selectedFiles{cnt} = files{jj}; %#ok<AGROW>
                    cnt = cnt + 1;
                end
            catch
                % Did not match
                disp('Seems to be a bad info field name %s\n',varargin{1});
            end
        end
    end
end