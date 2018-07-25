All Flywheel containers (projects, sessions, acquisitions, files and collections) can have metadata. The metadata are stored in Information fields attached to the container; you can see the information fields in the user interface by clicking on the drawer on the right and selecting 'Information.' If there is no metadata, the field is gray'd out.

### File info get
Files have metadata associated with them. For example, when we read a DICOM file from a scanner, Flywheel automatically extracts the header information and incorporates much of it into Information file for the dicom file. This makes the header information searchable in the database. 

To read this metadata use the **fileInfoGet** method.
```
st = scitran('cni');
files = st.search('file',...
          'filename exact','16504_4_1_BOLD_EPI_Ax_AP.dicom.zip',...
          'filetype','dicom',...
          'project label exact','qa');

% This returns info as a slot within the files{} struct
info = st.fileInfoGet(files{1});

% The info structure has a lot of fields with useful metadata
info.classification
  CommonClassification with properties:

         Intent: {'Functional'}
    Measurement: {'T2*'}

info.info
  AcquisitionDate: 20171113
  AcquisitionMatrix: [4×1 double]
  AcquisitionNumber: 1
  AcquisitionTime: 84103
  AngioFlag: 'N' 
...
fprintf('%d\n',info.info.EchoTime)
30
```
### fileInfoSet
The **fileInfoSet** method lets you edit metadata in a file's Information field. This code snippet, which was run on the CNI site, illustrates the **fileInfoSet** method.
```
% This json file has metadata we use in our quality assurance testing
  files = st.search('file',...
    'project label exact','qa',...
    'session label exact','16542',...
    'acquisition label exact','4_1_BOLD_EPI_Ax_AP',...
    'filename contains','json',...
    'filetype','qa',...
    'summary',true);

%% Download the json file into this qaInfo struct
qaInfo = st.fileRead(files{1})


%% Add a field to the struct
qaInfo.numSpikes = numel(qaInfo.spikes);

%% Call setFileInfo to attach the information to the file.
st.fileInfoSet(files{1},qaInfo);
```

### getContainerInfo and setContainerInfo
The search and list operations typically return the metadata (info) about a container.  The getContainerInfo and setContainerInfo methods return structs with the metadata (info). They are not used a lot because the information is also present from a list or search.  (MORE INSTRUCTIONS NEEDED HERE).

