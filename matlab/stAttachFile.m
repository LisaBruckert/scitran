function [status, result] = stAttachFile(varargin)
% Upload a file as an attachment to a given target 
%  ('project', 'session', 'acquisition') within a SciTran DB.
%
%      stAttachFile(varargin)
%
% The arguments can all be passed parameter/value pairs.  Or, they can be
% passed as the slots in a structure.
%
% REQUIRED INPUTS: 
%   
%   fName:   [type=char] Full path to the file on disk to attach/put/upload
%   target:  [type=char, valid='projects', 'sessions', 'acquisitions'] 
%            The type of scitran document where we store the attachment.
%            Individual files are 'acquisitions'.  The collection of files
%            during an scanner experience is a 'session'.  A group
%            of sessions can be a 'project'.
%            TODO:  Check that we can attach to a collection, which is a
%            group of sessions that are chosen by the user 
%   id:      [type=char] Database ID of the target - 
%   url:     [type=char] URL for the online scitran database
%   token:   [type=char] Authorization token for upload
% 
% OUTPUTS:
%   
%   status:  Boolean indicating success (0) or failure (~=0)
%   result:  The output of the verbose curl command.
% 
% Example:
%  Attach a file using the slots in a structure
%
%   [A.token, A.url] = stAuth('instance', 'scitran');
%   A.fName = '/Users/lmperry/test.txt';
%   A.target = 'session';
%   A.id    = '8277393993jd78djd7393k';
% 
%   [status, result] = stAttachFile(A);
% 
% 
% LMP/BW Vistasoft Team, 2015-16
% 


%% Parse inputs

% Allowed targets
targets = {'sessions', 'acquisitions', 'projects','collections'};

p = inputParser;
p.addParameter('fName', '', @(x) ischar(x) && exist(x, 'file'));
p.addParameter('target', '', @(x) ischar(x) && ismember(x, targets));
p.addParameter('id', '', @ischar);
p.addParameter('url', '', @ischar);
p.addParameter('token', '', @ischar);

p.parse(varargin{:});

args = p.Results;

% Make sure none of the args are empty
params = fieldnames(args);
for i = 1:numel(params)
    if isempty(args.(params{i}))
        error('%s cannot be empty!\n', params{i})
    end
end


%% Configure library paths for curl command to work properly

curENV = configure_curl();


%% Build and execute the curl command

curl_cmd = sprintf('curl -F "file=@%s" %s/api/%s/%s/files -H "Authorization:%s"',...
    args.fName, args.url, args.target, args.id, args.token);

% Execute the command
fprintf('Sending... ');
[status, result] = system(curl_cmd);

% Let the user know if it worked
if status ~= 0
    warning('Upload failed');
    disp(result)
else
    fprintf('File sucessfully uploaded.\n');
end


%% Reset library paths

unconfigure_curl(curENV);


return














