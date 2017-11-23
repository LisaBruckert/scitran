
To perform a search, you must first obtain [authorization](https://github.com/scitran/client/wiki/Authorization).  

    st = scitran('<your site name.');  % For example, st = scitran('vistalab');

The st.search() command specifies your search through a series of parameters.  The first parameter is a required string that indicates what type of object you would like to have returned.  For example, suppose you are searching for a project.  Then you would specify

    projectList = st.search('projects');

The first argument is always plural (projects, sessions, acquisitions, files).

The next set of parameters are in parameter/val format and optional.  Suppose you would like to return the files in a collection name 'GearTest'.

    % These files match the following properties
    files = st.search('files','collection label','VWFA',...
            'file type','nifti',...
            'file measurement','Anatomy_t1w');

The variable 'files' is a cell array of Matlab structures;  each contains the database information of a file that matches the search criteria.  You can retrieve one of these files with the stGet() command

    st.get(files{1})

You can direct the output to a particular destination using

    st.get(files{1},'destination',localFileName)

There are many types of searches, and you can see [search examples on this page](search-examples) and an [m-file with many examples](https://github.com/scitran/client/blob/master/scripts/s_stSearches.m)


