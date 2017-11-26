## Creating and uploading an FTM file
The toolboxes object (in this case called tbx) contains two types of information.  One is a command that can be executed to test whether the toolbox is on the path (testcmd).  The second is a structure that contains enough information to download a git repository.
```
disp(tbx)
  toolboxes with properties:

    testcmd: 'dtiError'
    gitrepo: [1×1 struct]
```
The gitrepo structure contains this information
```
>> disp(tbx.gitrepo)
       user: 'scitran-apps'
    project: 'dti-error'
     commit: 'master'
```
scitran data directory includes several examples and a script s_tbxSave, that writes out toolbox files.
They are written out as JSON files with the git repo projection and a .json extension.

```
tbx = toolboxes('');
tbx.testcmd     = 'dtiError';
tbx.gitrepo.user    = 'scitran-apps'; 
tbx.gitrepo.project = 'dti-error'; 
tbx.saveinfo;
```
Toolboxes can be combined into a single file and uploaded to a Flywheel project page.  In this example, the stToolbox() function reads a JSON file for two repositories.  These are placed in an array, and written out to a new JSON file. 
```
tbx(1) = stToolbox('dtiError.json');
tbx(2) = stToolbox('vistasoft.json');
tbxWrite('aldit-toolboxes.json',tbx);
% Subsequently, your could read the combined file
% tbx = stToolbox('aldit-toolboxes.json');

% upload to the project page
project = st.search('project','project label exact','ALDIT');
st.upload('aldit-toolboxes.json','project',project{1}.project.x_id);
```
