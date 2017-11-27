There are two principal classes in the client toolbox.  The **scitran** class and the **toolboxes** class.  The scitran class, described here, is designed to interact with the contents of the Flywheel database.  The toolboxes class, designed to support reproducible computation with Flywheel data, is described [in a separate page](Toolboxes).

This page describes scitran methods, and we plan to update this information regularly.

A scitran object is instantiated by a call that identifies which Flywheel database you wish to address. 
```
>> st = scitran('vistalab')

st = 

  scitran with properties:

         url: 'https://vistalab.flywheel.io'
    instance: 'vistalab'
          fw: [1×1 Flywheel]
```
The [authorization page](Authorization) describes how to create the information that permits you to interact with a Flywheel database (in this case 'vistalab').

The scitran methods enable you to find database contents, get information about these objects, download and upload files, and modify metadata. See the [Flywheel terms](Flywheel-terms) page to learn about the conceptual organization of information in Flywheel.

## Methods

To create a scitran instance, we use 

    st = scitran('vistalab');

where 'vistalab' is a Flywheel site.  Below, we assume that file is a struct, as returned by a search.


```
(IN PROGRESS; INCOMPLETE)

st.search(objType,...)  -  Search for objects constrained by many possible limits (file type, label, date...).
st.listObjects(objType, parentID, ...) - List objects within a parent; might change to getObjects
[p,s,a] = st.projectHierarchy - List the sessions and acquisitions in a project hierarchy 
st.getdicominfo - Information about files or database objects

st.downloadFile(file,...) -
data = st.read(file,...)  - Certain file types can be downloaded and read into a Matlab variable  
st.dwiLoad - Read a nifti file and its associated bvec/bval data
st.downloadObject(file,...)  - Download a directory tree containing a database object as a tar file

st.upload - File upload

st.create - Create a project or a session or an acquistion
st.createCollection
st.modify - Modify database values (e.g., subject code, sex ...)

st.deleteFile - Delete objects
st.deleteObject - Delete objects

st.create - Create an object (project, session, acquisition)
st.createCollection

% Computational
st.docker
st.runFunction - Download toolboxes and run a function from a remote site
st.runScript
st.toolbox

% Miscellaneous
st.exist - See if a particular object exists
st.verify
st.browser - Bring a browser to a location

% Not yet decided
st.putAnalysis
st.bidsUpload
st.bidsDownload
```





