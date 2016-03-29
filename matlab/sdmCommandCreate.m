function cmd = sdmCommandCreate(varargin)
% Create the system command for the flywheel database query
%
%   cmd = sdmCommandCreate('url',url, ...
%                          'token', token, ...
%                          'target',{'sessions','acquisitions','files','projects'}, ...
%                          'body', jsonBody);
%
% Example:
%  s.url    = furl;
%  s.token  = token;
%  s.body   = jsonData;
%  s.target = 'session';
%  syscommand = sdmCommandCreate(s);
%  system(syscommand)
%
% LMP/BW Vistasoft team, 2016

%% Parse the inputs
p = inputParser;
p.PartialMatching = false;
p.CaseSensitive   = true;

p.addParameter('token','',@ischar);
p.addParameter('body','',@ischar);

% The url should be secure
vFunc = @(x) isequal(x(1:6),'https:');
p.addParameter('url','https://flywheel.scitran.stanford.edu',vFunc);

% These are the options.  Could do this in reverse order ... check for a
% valid string after finding the target parameter (below)
vStrings = {'sessions','acquisitions','files','projects'};
vFunc = @(x) any(strcmp(x,vStrings));
p.addParameter('target','sessions',vFunc);

% Parse
p.parse(varargin{:});

token  = p.Results.token;
body   = p.Results.body;
target = p.Results.target;
url    = p.Results.url;

% If this is a local instance we need to insert the 'insecure' flag
if strfind(url, 'docker.local') 
    insecureFlag = ' -k ';
else
    insecureFlag = '';
end

%% Build the search command

cmd = sprintf('curl -XGET "%s/api/search/%s" -H "Authorization":"%s" -H "Content-Type:application/json" %s -d ''%s''', url, target, token, insecureFlag, body);

end





