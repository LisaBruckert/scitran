function dt = dr_fwReadDtFromAnalysisTable(serverName, t, measurement)
% This function will take a filtered table obtained from dr_fwCheckJobs
% and it will create a result datatable out of it. 

% Example inputs to make it work
%{
clear all; clc; 
serverName     = 'stanfordlabs';
% collectionName = 'ComputationalReproducibility';  % 'tmpCollection', 'ComputationalReproducibility', 'FWmatlabAPI_test'
collectionName = 'HCP_Depression';%  'WH_042_volume_test';
% measurement    = 'volume';  % 
measurement    = 'fa';

% GET ALL ANALYSIS FROM COLLECTION
JL = dr_fwCheckJobs(serverName, collectionName);
height(JL)
% FILTER
state       = 'complete';  % 'cancelled', 'pending', 'complete', 'running', 'failed'
% gearName    = 'afq-pipeline-3'; gearVersion = '3.0.0_rc4';
gearName    = 'afq-pipeline'; gearVersion = '3.0.7';
dateFrom  = '04-Feb-2019 00:00:00';
labelContains = 'v3.0.7:';
state='complete'
t = JL(JL.state==state & JL.gearName==gearName & ...
       JL.gearVersion==gearVersion & JL.JobCreated>dateFrom & ...
       contains(string(JL.label), labelContains),:);
height(t)



labelContains = 'v02b:v3.0.7';
state='complete'
t = JL(JL.state==state & JL.gearName==gearName & ...
       JL.gearVersion==gearVersion & ...
       contains(string(JL.label), labelContains),:);
height(t)




dt = dr_fwReadDtFromAnalysisTable(serverName, t, measurement);
save(fullfile(stRootPath,'local','tmp', ...
              sprintf('AllV01_HCP_Depression_%s.mat',measurement)), 'dt')


% VISUALIZE RESULTS
subplot(2,1,1)
% plot(dt{dt.Struct=='LeftArcuate' & dt.TRT=='TEST','Val'}'); hold on;
% plot(dt{dt.Struct=='RightArcuate' & dt.TRT=='TEST','Val'}')
plot(dt{dt.Struct=='LeftArcuate','Val'}'); hold on;
plot(dt{dt.Struct=='RightArcuate','Val'}')
title('LeftRightArcuate'); xlabel('Profile divisions'); ylabel('FA')

leg1 = strcat(string(dt.Struct(dt.Struct=='LeftArcuate')), "-", ...
              dt.SubjID(dt.Struct=='LeftArcuate'), "-", ...
              string(dt.TRT(dt.Struct=='LeftArcuate')), "-", ...
              string(dt.AcquMD.scanbValue(dt.Struct=='LeftArcuate')));
leg2 = strcat(string(dt.Struct(dt.Struct=='RightArcuate')), "-", ...
              dt.SubjID(dt.Struct=='RightArcuate'), "-", ...
              string(dt.TRT(dt.Struct=='RightArcuate')), "-", ...
              string(dt.AcquMD.scanbValue(dt.Struct=='RightArcuate')));
legend([leg1;leg2])
subplot(2,1,2)
dt=dtxfom;
plot(dt{dt.Struct=='LeftArcuate' & dt.TRT=='TEST','Val'}'); hold on;
plot(dt{dt.Struct=='RightArcuate' & dt.TRT=='TEST','Val'}')
title('LeftRightArcuate'); xlabel('Profile divisions'); ylabel('FA')

leg1 = strcat(string(dt.Struct(dt.Struct=='LeftArcuate')), "-", ...
              dt.SubjID(dt.Struct=='LeftArcuate'), "-", ...
              string(dt.TRT(dt.Struct=='LeftArcuate')), "-", ...
              string(dt.AcquMD.scanbValue(dt.Struct=='LeftArcuate')));
leg2 = strcat(string(dt.Struct(dt.Struct=='RightArcuate')), "-", ...
              dt.SubjID(dt.Struct=='RightArcuate'), "-", ...
              string(dt.TRT(dt.Struct=='RightArcuate')), "-", ...
              string(dt.AcquMD.scanbValue(dt.Struct=='RightArcuate')));
legend([leg1;leg2])
%}



%% Connect to the server and verify the connection
st = scitran(serverName);
st.verify


%% Create the table that we will later populate. 
% This version will be different from the one we already had. 
% This version will include the gearName, gearVersion and measurement columns
% Then we will use other functions to expand afq-pipeline values from the ones
% in freesurfer or others. 
TableElements = {'SubjID','TRT','Proj','SubjectMD','AcquMD','AnalysisMD', 'measurement', 'Struct', 'Val', 'UseIt'};
dt            = array2table(NaN(0,length(TableElements)));
dt.Properties.VariableNames = TableElements;

% The profiles sometimes throw some NaN, sometimes in the borders. 
% If it is less than maxNaNsToClean, substitute, otherwise make everything NaN
% and UseIt=false
doNanSubstitution = 1;
maxNaNsToClean = 5;
interpMethod = 'spline'; % For NaN substitution using the repnan.m method, default is 'linear'


% What is each columns on the datatable?
%{
'SubjID'     : string with the name of the subject. It is usually unique by project,
               but not in the entire collection
'TRT'        : 'TRAIN': only this session for this subject, 'TEST': this is first
                session but the subject has more, 'RETEST': first repeated
                session, 'RETEST2': other sessions, consequtively
'Proj'       : string with the name of the project
'SubjectMD'  : a datatable with all the subject information on FW.
'AcquMD'     : a datatable with all the acquisition information on FW, columns 
               will vary between T1w and DWI, for example
'AnalysisMD' : a datatable with all the analysis information on FW, columns 
               will vary between gears. 
               Unique analysis = gearName+gearVersion+configParams
'measurement': string with the name of the measurement, for example 'fa', 'md',
               'volume', 'ct', 'T1relaxationTime', ...
'Struct'     : Name of the structure in the case of afq, name of segmentation 
               in the case of FS: 'LeftArcuate', 'aseg', ... 
'Val'        : a value is the combination of subject + acqu + analysis
               a datatable with the actual values.csv downloaded from FW. This
               will be usuarlly a vector. In the case of afq, asociated to a
               structure, in the case of FS, can be the aseg values vector...
'UseIt'      : true/false variable. If all elements of the Val vector are NaN,
               it will be false. It can be useful to include or discard subjects
               with other criteria as well. 
%}


%% Find all the analyses created with the GEAR(and version) and display them for verification
%  This was originally a crawler in dr_readCollection. Now it will fetch the
%  exact analysis and result we want. 
%  Should be MUCH faster

tic
for ns=1:height(t)
    tic
    thisSession    = st.fw.getSession(t.Analysis(ns).parent.id);
    thisCollection = string(t(ns,:).collection);
    thisAnalysis   = st.fw.getAnalysis(t.Analysis(ns).id);
    % Get info for the project the session belong to
    thisProject    = st.fw.getProject(thisSession.project);
    fprintf('(%d) Working in session: %s >> %s (%s)\n', ns, thisProject.label, thisSession.subject.code, thisSession.label)
    % Obtain AcquMD
    acquMD = dr_fwObtainAcquMD(st, thisSession, thisAnalysis, thisCollection);
    VALUES = dr_fwObtainValues(st, thisAnalysis, measurement);
    
    % Now that we have everything, we can start appending it to our big
    % table that will be the output of this query. 
    % FC: make this into an independent function as well       
    Structures = VALUES.Properties.VariableNames;
    for fg=1:length(Structures)
        Structure = string(regexprep(Structures{fg},'{|}| |_',''));
        % This version is afq centered, so when the data is extracted, the
        % profiles are extracted as a column. When the function is created,
        % I think this should be given as an option. For example, we
        % wouldn't want this for Freesurfer. I am going to leave this
        % working, and then refactor it to allow FS in a more natural way.
        % Right now, we use the datatable in this form to filter structures
        % but usually then we create a flat datatable. Continue thinking
        % about the best way to analyze this. 
        T            = array2table(NaN(1,length(TableElements)));
        T.Properties.VariableNames = TableElements;
        T.SubjID     = string(thisSession.subject.code);
        T.Proj       = categorical(string(thisProject.label));
        T.TRT        = categorical(string(thisSession.label));
        T.SubjectMD  = struct2table(st.fw.getSession(idGet(thisSession)).subject.struct, 'AsArray', true);
        % T.SubjectMD.info      = struct2table(T.SubjectMD.info, 'AsArray', true);
        % Temporary hack so that all have the same info, I need to use the old
        % method to create the expanded info table:
        T.SubjectMD.info      = struct2table(struct('ReadEng_AgeAdj',999));
        % T.SubjectMD.info      = [];
        if iscell(T.SubjectMD.age)
             T.SubjectMD.AGE       = 99;
        else
            T.SubjectMD.AGE       = T.SubjectMD.age / (365*24*60*60);
        end
        T.SubjectMD.age       = [];
        % if isempty(T.SubjectMD.sex)
%            T.SubjectMD.GENDER    = [];
        % else
          %   T.SubjectMD.GENDER    = categorical(T.SubjectMD.sex);
        % end
        T.SubjectMD.sex       = [];
        T.SubjectMD.tags      = [];
        T.SubjectMD.files     = [];
        T.SubjectMD.infoExists= [];
        T.AcquMD     = acquMD;
        T.AnalysisMD = struct2table(thisAnalysis.job.config.config, 'AsArray', true);
        T.measurement= string(measurement);
        T.Struct     = categorical(string(Structure));

        % And now, assign the value vectors
        % But, if there are more than 5 NaN-s, convert all to NaN, otherwise
        % fix it
        T.UseIt = true;
        T.Val   = VALUES{:,Structures{fg}}';
        if doNanSubstitution
            if sum(isnan(T.Val),2) > 0 & sum(isnan(T.Val),2) <= maxNaNsToClean
                % For PCA we need to remove the NaN-s, I use this utility called repnan, which
                % has several options for NaN substitution. 
                % There are other options to do PCA without NaN substitution (TODO) 
                % disp(['WH:' shells{kk} ' ' Structure{fg} ' ' subNamesTRAIN{ii} ': There are ' num2str(NaNSubjects{ii,fg}) ' NaN-s that will be substituted with repnan ' interpMethod ' method'])
                T.Val = repnan(T.Val', interpMethod)';  % default in repnan is 'linear'
            end
            if sum(isnan(T.Val),2) > maxNaNsToClean
                T.Val = NaN(size(T.Val));
                T.UseIt = false;
            end
        end
        % Add all the structs for this analysis for this session
        if height(dt) == 0
            dt = T;
        else
            dt = [dt; T];
        end
    end   
    toc
end
toc




            
        


%% Fix problems that we might have observed when reading this dt
% dr_fwFileInfoWrite('stanfordlabs', 'tmpCollection')

