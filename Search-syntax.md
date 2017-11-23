
The scitran search method syntax is

```
cellArray = st.search('objectTypeToReturn',...
               'Parameter',value, ...
                ...);
```
The 'objectTypeToReturn' can be one of these Flywheel data objects
```
objects = ...
{'file','acquisition','session','project','collection', 'analysis','subject','note'};
```

**cellArray** is a cell array of structures containing fields that are relevant to describe the database object.  For example, the cell array returned for a project is
```
>> projects{1}

ans = 

  struct with fields:

        project: [1×1 struct]
          group: [1×1 struct]
    permissions: [15×1 struct]
```
While the cell array for returned for a session is

```
>> sessions{1}

ans = 

  struct with fields:

        project: [1×1 struct]
          group: [1×1 struct]
        session: [1×1 struct]
        subject: [1×1 struct]
    permissions: [11×1 struct]
```

## Search parameters

The search method lets you specify many different parameters.  The list is far too long to (usefully) include here.  We think the best way for you to understand search is through [examples](Search-examples) and leafing through the [search method source code](https://github.com/scitran/client/blob/master/%40scitran/search.m).

The comments here provide information that might not be obvious and some general guidance.

### Utility parameters

We have some utility parameters that do not guide the search, but that we have found helpful.

* **'summary'**  - A logical that indicates whether to print the number of found objects
* **'all_data'** - Run the search across the entire database; you cannot query or download objects without permission
* **'limit'**    - Limit number of returned cells, st.search('file','limit',17,'file name','foo); (default 10,000)

### Groups

It is possible to search for information about the groups using the database.  This information includes their project names and users. For example, to list all of groups use

    st.search('group','all')

Other 'group' search parameters are 
```
st.search('group','all names');       % All group names
st.search('group','name',groupName);  % Details about a particular group
st.search('group','users',groupName); % Users from a group
st.search('group','all labels');      % Groups appear to have both labels and names
```
### Partial and exact matches

When searching for an object based on its label (or name), you can specify an exact match or a partial match. For example, on the vistalab site we have a project with the label 'VWFA' and several other projects that include 'VWFA' in the label.  

When we search for a project label exact 'VWFA'
```
>> projects = st.search('project',...
    'summary',true,...
    'project label exact','VWFA');
Found 1 (project)
```

It is possible to find all the projects that contain the string 'VWFA' as well.

```
>> projects = st.search('project',...
    'summary',true,...
    'project label contains','vwfa');
Found 3 (project)

>> for ii=1:length(projects), disp(projects{ii}.project.label); end
VWFA FOV
VWFA
VWFA FOV Hebrew
>> 
```
The exact vs. contains options are also used for labels describing session, analysis, acquisition, collection, and file **name**.

**N.B.**  'contains' is case insensitive; 'exact' is case-sensitive.

### Labels and names

Most objects are described by a **label**.  There is one exception, however.  When we search for files we search on the **name**, not the **label**.

## Search examples

See the searches illustrated in [s_stSearches.m](https://github.com/scitran/client/blob/master/scripts/s_stSearches.m). 





