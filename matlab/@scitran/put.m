function [status, result] = put(obj,upType,stData,varargin)
% Attach a file to the permalink location
%
%      st.put(upType,stdata,'id',id)
%
% Inputs:
%  upType: Type of upload.  Analysis, File, ...
%  stData: Matlab struct containing the fields for the upload
%
% Outputs:
%  status:  Boolean indicating success (0) or failure (~=0)
%  result:  The output of the verbose curl command
%
% We need to make sure the struct for the stData are described properly
% here.
%
% Example:
%    st.put('analysis',stData,'id',collection{1}.id);
%    st.put('file',stData);
%
% LMP/BW Vistasoft Team, 2015-16


%% Parse inputs
p = inputParser;
p.addRequired('upType',@ischar);

% Should have a vFunc here with more detail
p.addRequired('stData',@isstruct);
p.addParameter('id','',@ischar);

p.parse(upType,stData,varargin{:});

upType = p.Results.upType;
stData = p.Results.stData;
id     = p.Results.id;

% Format upType
upType(lower(upType) == ' ') = [];

%% Do relevant upload
switch  lower(upType)
    case {'analysis', 'sessionanalysis', 'collectionanalysis'}

        % Analysis upload to a collection or session.
        % In this case, the id needed to be set

        % Construct the command to upload input and output files of any
        % length % TODO: These should exist.
        inAnalysis = '';
        for ii = 1:numel(stData.inputs)
            inAnalysis = strcat(inAnalysis, sprintf(' -F "file%s=@%s" ', num2str(ii), stData.inputs{ii}.name));
        end

        outAnalysis = '';
        for ii = 1:numel(stData.outputs)
            outAnalysis = strcat(outAnalysis, sprintf(' -F "file%s=@%s" ', num2str(ii + numel(stData.inputs)), stData.outputs{ii}.name));
        end

        % We have to pad the json struct or savejson will not give us a list
        if length(stData.inputs) == 1
            stData.inputs{end+1}.name = '';
        end
        if length(stData.outputs) == 1
            stData.outputs{end+1}.name = '';
        end

        % Remove full the full path, leaving only the file name, from input
        % and output name fields.
        for ii = 1:numel(stData.inputs)
            [~, f, e] = fileparts(stData.inputs{ii}.name);
            stData.inputs{ii}.name = [f, e];
        end
        for ii = 1:numel(stData.outputs)
            [~, f, e] = fileparts(stData.outputs{ii}.name);
            stData.outputs{ii}.name = [f, e];
        end

        % Jsonify the payload (assuming it is necessary)
        if isstruct(stData)
            stData = savejson('',stData);
            % Escape the " or the cmd will fail.
            stData = strrep(stData, '"', '\"');
        end

        % Set the target for the analysis upload (collection or session)
        if strfind(upType, 'collection')
            target = 'collections';
        elseif strfind(upType, 'session')
            target = 'sessions';
        else
            error('No analysis target was specified. Options are: (1) Session Analysis (2) Collection Analysis')
        end

        curlCmd = sprintf('curl %s %s -F "metadata=%s" %s/api/%s/%s/analyses -H "Authorization":"%s"', inAnalysis, outAnalysis, stData, obj.url, target, id, obj.token );

        %% Execute the curl command with all the fields

        stCurlRun(curlCmd);

   case {'files','file'}

        % Not checked.  Do with LMP.

        % Handle permalinks which may have '?user='
        pLink = strsplit(pLink, '?');
        pLink = pLink{1};

        % Build the url from the permalink by removing the endpart
        url = fileparts(pLink);

        % Get the URL with the file name appended to it
        [~,n,e] = fileparts(fName);
        urlAndName = fullfile(url,[n,e]);


        %% Generate MD5 checksum

        % MAC
        if ismac
            md5_cmd = sprintf('md5 %s',fName);
            [md5_status, md5_result] = system(md5_cmd);
            checkSum = md5_result(end-32:end-1);

        % Linux
        elseif (isunix && ~ismac)
            md5_cmd = sprintf('md5sum %s',fName);
            [md5_status, md5_result] = system(md5_cmd);
            checkSum = md5_result(1:32);

        % Other/Unknown
        else
            error('Unsupported system.\n');
        end

        % Check that it worked
        if md5_status
            error('System checksum command failed');
        end


        %% Build and execute the curl command

        curl_cmd = sprintf('/usr/bin/curl -v -X PUT --data-binary @%s -H "Content-MD5:%s" -H "Content-Type:application/octet-stream" -H "Authorization:%s" "%s?flavor=attachment"\n', fName, checkSum, token, urlAndName);

        % Execute the command
        fprintf('Sending... ');
        [status, result] = stCurlRun(curl_cmd);

        % Let the user know if it worked
        if status
            warning('Upload failed');
            disp(result)
        else
            fprintf('File sucessfully uploaded.\n');
        end

     otherwise
        error('Unknown upload type %s\n',upType);
end

end
