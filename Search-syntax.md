This page contains more detailed descriptions of the search parameters. To perform a search, first create a scitran Matlab object that is authorized to interact with your database (see [Authorization](Authorization)).  Then run

    st = scitran('vistalab');

You can search for a variety of different database objects.  The search returns a cell array of the database objects that match your query. Here is a list of objects you can search for.

    objects = {'files','acquisitions','sessions','projects','collections',...
               'analyses','subjects','notes','analyses in collection','files in collection'};

The general search syntax is

    objects = st.search('<objectTypeToReturn>','Parameter',value, ...);

## What is returned

The **objects** structure contains many different fields.  Most of the important information is in the 'source' field, say objects{1}.source.

## Running a search



You can do many different types of searches, such as the ones illustrated in [s_stSearches.m](https://github.com/scitran/client/blob/master/scripts/s_stSearches.m)
```
projects = st.search('projects');
VWFAsessions = st.search('sessions','project label','VWFA');
    
files = st.search('files',...
    'collection label','Anatomy Male 45-55',...
    'acquisition label','Localizer',...
    'file type','nifti');
```





