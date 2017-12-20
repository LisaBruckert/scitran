All Flywheel containers (projects, sessions, acquisitions, files and collections) can have metadata. The metadata are stored in Information fields attached to the container; you can see the information fields in the user interface by clicking on the drawer on the right and selecting 'Information.' If there is no metadata, the field is gray'd out.

### Dicom file info
Dicom file headers contain a great deal of information about the MRI scan. When read from a scanner, Flywheel automatically extracts this information and incorporates in to the Information file for the dicom data. To read this metadata use the **getdicominfo** method.
```
st = scitran('cni');
files = st.search('file',...
          'filename exact','16504_4_1_BOLD_EPI_Ax_AP.dicom.zip',...
          'filetype','dicom',...
          'project label exact','qa');

% This returns info as a slot within the files{} struct
files = st.getdicominfo(files);
fprintf('Echo Time %s\n',files{1}.info.('EchoTime'))
Echo Time 30
```
### setFileInfo
The **setFileInfo** method places metadata in a file's Information.  The metadata is represented as slots in a Matlab struct.  This code snippet, which was run on the CNI site, illustrates the **setFileInfo** method.
```
% This is a json file that has metadata we will use for the information field
files = st.search('file',...
    'project label exact','qa',...
    'session label exact','16542',...
    'acquisition label exact','16542_4_1_BOLD_EPI_Ax_AP',...
    'filename contains','json',...
    'filetype','qa',...
    'summary',true);

%% Download the json file
qaInfo = st.read(files{1})

%% Extract the fields from the json data and put them in a struct
jsonInfoFields = {'temporalSNR_median_','medianMd','spikes',...
    'maxMd','tr','version','spikeThresh'};
for ii=1:length(jsonInfoFields)
    jsonInfo.(jsonInfoFields{ii}) = qaInfo.(jsonInfoFields{ii});
end
jsonInfo.numSpikes = numel(qaInfo.spikes);

%% Call setFileInfo to attach the information to the file.
st.setFileInfo(files{1},jsonInfo);
```
### getFileInfo
We still have not implemented a **getFileInfo** method.  Will do before long.  It will look like

     info = st.getFileInfo(files{1});

### getContainerInfo and setContainerInfo
The search and list operations typically return the metadata (info) about a container.  The getContainerInfo and setContainerInfo methods return structs with the metadata (info). They are not used a lot because the information is also present from a list or search.  (MORE INSTRUCTIONS NEEDED HERE).

