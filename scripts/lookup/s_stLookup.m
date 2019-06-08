%% s_stLookup
%
% Experimenting with lookup for data at the beginning.
% Then lookup with Gears at the end
%
% BW Scitran Team, 2019
%
% See also
%

%%
st = scitran('stanfordlabs');

%% Lookup your group
myGroup = st.lookup('wandell');
disp(myGroup)

%% Search for a project
project = st.search('project',...
    'group id','wandell',...
    'project label exact','Weston Havens',...
    'summary',true);
stPrint(project,'project','label');

%% Lookup a project
projectLabel = 'Weston Havens';
lookupString = fullfile(myGroup.id,projectLabel);
project = st.lookup(lookupString);

%% Look up the first session

thisSession  = project.sessions.findFirst();
subjectLabel = thisSession.subject.label;
sessionLabel = thisSession.label;
lookupString = fullfile(myGroup.id,projectLabel,subjectLabel,sessionLabel);

sameSession = st.lookup(lookupString);

% The age slot and others differ

%% Look up the subject for this first session

subjectCode = thisSession.subject.code; 
lookupString = fullfile(myGroup.id,projectLabel,subjectCode);
subject = st.lookup(lookupString);
disp(subject)

%% Find a few projects by searching

projects = st.search('project',...
    'group id','wandell',...
    'limit', 5, ...
    'summary',true);
pLabels = stPrint(projects,'project','label');

%% Use the returned search data to look up one of the projects
pLabel = pLabels{5};
lookupString = fullfile(myGroup.id,pLabel);
project = st.lookup(lookupString);

%% Now find the data for a subject in a project
thisSession  = project.sessions.findFirst();
subject      = thisSession.subject.code; 
lookupString = fullfile(myGroup.id,pLabel,subject);

thisSubject = st.lookup(lookupString);
disp(thisSubject)

%% Now, lookup a session

sLabel       = thisSession.label;
lookupString = fullfile(myGroup.id,pLabel,subject,sLabel);
thisSession2 = st.lookup(lookupString);

assert(isequal(thisSession.id,thisSession2.id))

%% Next level - findFirst illustrated

thisAcquisition = thisSession.acquisitions.findFirst;
aLabel = thisAcquisition.label;
lookupString = fullfile(myGroup.id,pLabel,subject,sLabel,aLabel);
thisAcquisition2 = st.lookup(lookupString);
assert(isequal(thisAcquisition2.id,thisAcquisition.id))

%% Next level - the file

thisFile = thisAcquisition.files{1};
fLabel = thisFile.name;
lookupString = fullfile(myGroup.id,pLabels{1},subject,sLabel,aLabel)
lookupString = sprintf('%s/files/%s',lookupString,fLabel);
thisFile2 = st.lookup(lookupString);

%% Look up all Gears.  This uses the 'name' field, not the label field.

[gears, gNames] = st.gears;
idx = strcmp(gNames,'mriqc');
gName = gears{idx}.gear.name;

%%  Find the gear named 'mriqc'

str = fullfile('gears',gName);
thisGear = st.lookup(str);
disp(thisGear)
thisGear.gear

%%  Find with a label
project = st.lookup('wandell/VWFA');
thisSession = project.sessions.find('label=20151127_1332');
disp(thisSession{1})

%%
