classdef scitran < handle
    % Scitran object to interact with a scitran database
    %
    %   st = scitran('scitran','action',{'},'verify',...)
    %
    % Required
    %  'instance' -  String denoting the site to authorize
    %
    % Parameter/Value
    %  'actions'  - {'create', 'refresh', 'remove'}
    %
    % Methods include:
    %   auth    - Authorize interaction with database
    %   search  - Search
    %   docker  - Run a docker container (Gear)
    %   browser - Browse to a page in the Flywheel instance
    %   get     - Get a file
    %   put     - Put a file
    %
    % LMP/BW Scitran Team, 2016
    
    properties (SetAccess = private, GetAccess = public)  

    url = '';
    instance = 'scitran';
    
    % Perhaps scitran should be a subclass of the @flywheel.  For now, we
    % are storing it as an object within the scitran object.
    fw = [];    % A flywheel SDK class.
    
    end    % Data stuff (public)

    properties (SetAccess = private, GetAccess = private)
        % Don't let people see the API token
        token = '';
    end    

    % Methods (public)
    methods
        
        function obj = scitran(instance,varargin)
            % Creates the object and authorizes the instance The url and
            % the token are stored in the object. 
            %
            % To set up the software environment for creating a scitran
            % client object and obtaining authorization, see the scitran
            % client wiki page
            % 
            %   <https://github.com/scitran/client>
            %
            % Example:
            %   st = scitran('scitran','action','refresh');
            %   st = scitran('vistalab','verify',true);

            p = inputParser;
            p.KeepUnmatched = true;
            p.addRequired('instance', @ischar);
            p.parse(instance,varargin{:});
            
            authAPIKey(obj,instance,varargin{:});
            
            % Create the Flywheel SDK object
            % Flywheel uses a ':' where we have a space ' ' in the token.
            % Let's change that.
            obj.fw = Flywheel(obj.showToken);
            
        end
        
        function val = showToken(obj)
            % If you really need to see it, use this.
            % The get.token syntax doesn't run now because get() is a
            % command to get a file from the site.  Maybe that should be
            % changed. 
            val = obj.token;
        end
    end
    
    methods (Static)
        
        function val = listInstances
            % Show the instances you have saved
            stDir = fullfile(getenv('HOME'), '.stclient');
            tokenFile = fullfile(stDir, 'st_tokens');
            val = jsonread(tokenFile);
            
            % TODO Make a nicer print out of this
            disp(val)
        end
            
    end   

end