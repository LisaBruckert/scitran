The remainder of this wiki describes how to perform tasks using the **scitran** client methods. Tasks include

* search for data and metadata
* read, download or upload data and metadata
* launch jobs (Gears) and check their status
* download or upload the outputs of jobs (analyses)

This example illustrates the 'look-and-feel' of the **scitran** code.  The first example identifies a group, and then all the projects that are part of the group
```
>> st = scitran('stanfordlabs');      % Make an object connected to 'stanfordlabs'
>> group = st.lookup('wandell');      
>> projects = group.projects();       % Find all the projects for this group
>> stPrint(projects,'label');         % Print out a list of all the project names ...
>> stPrint(projects,'label')

Entry: label.
-----------------------------
	1 - BCBL_ILLITERATES 
	2 - Brain Beats 
	3 - CoRR 
	4 - EJ Apricot 
	5 - Graphics assets 
	6 - HCP 
	7 - HCP_preproc 
        ....
```

Or, you might start by looking up on one named project in your grupo

```
>> thisProject = st.lookup('wandell/HCP')

thisProject = 

  ResolverProjectNode with properties:

         public: []
          label: 'HCP'
           info: [1×1 flywheel.model.CommonInfo]
    description: ' ... .... '
          group: 'wandell'
             id: '57745645ce3b5900238d466c'
        parents: [1×1 flywheel.model.ContainerParents]
     infoExists: []
        created: 29-Jun-2016 23:14:13
       modified: 09-Nov-2018 05:30:55
      templates: []
    permissions: {16×1 cell}
          files: {3×1 cell}
          notes: []
           tags: []
       analyses: []

```
Understanding the principles of the [Data organization](Data-organization) and [Computational organization](Computational-organization) can be important to use **scitran** effectively.  The comments below describe these principles.

### Data

#### Databases
A database is part of most modern computer architectures. For example, when you ask for the 'Info' about a file on a Mac, you are provided with file metadata (e.g., file size, date of access). The file itself is the **data**, and the information about the file is the **metadata**. Like the Mac, Flywheel calls the metadata in its system 'Info' or 'Information'.

#### Metadata
MRI Info includes critical scientific information (TR, TE, voxel size, diffusion directions, ...). This information can be included within a data file, for example the DICOM format includes this information in its header. The widely used NIfTI format does not include as much information in its default header. When Flywheel converts a DICOM file to a NIfTI file, it stores the MRI Info into Flywheel metadata attached to the NIfTI file. 

In typical computer usage, we focus on directories and files. When using database systems, the Info (metadata) has a very prominent role. You can find the INFO in the web-browser interface, and you can download it with the SDK.

#### Data hierarchy
The speed of a database search relies on having a disciplined data organization.  The Flywheel hierarchy comprises the user's Group, Project, Session, Acquisition and Files. The benefit of enforcing the hierarchy is that you can rapidly search, categorize and compute using the data and Info.

#### Data reuse
To reuse data, users often copy files into a new directory tree. Using the Flywheel database there is no need to copy. We can reuse the data by copying fields from the database. Flywheel creates a *virtual project* by creating a database entry that contains pointers to existing files. To the user, this appears to be a new project.  Flywheel calls these 'Collections'.  Maybe they should be called 'Virtual Projects.'

### Computations

#### Sharing software
Modern software is very complex to create and maintain. Compiling software - yes, even from freely available code on github! - can be daunting. A computational management system helps all users by providing the programs in a format that everyone can use.  Given that data are stored in the system, the shared computational methods can be applied to everyone's data.

#### Platform-independent computing
But what format should the computations be stored in? Users use many different operating systems (PC, Mac, Linux, each with different variants) and code is compiled for a particular system. Small virtual machines, also called Containers, are a solution.  If we compile the code once within the virtual machine, we can install the virtual machine and then run the code on many different platforms.  Docker Containers are small virtual machine that can be installed and run on nearly all platforms. Hence, your software can be run on Cloud or Local systems.

#### Cloud-scale elastic computing
When running on the cloud, it is possible to expand and shrink the compute resources available for your project on demand. Flywheel has a computational management system that runs on the Google Cloud Platform.  More resources are added when users run more Jobs.  These resources are released when demand is low.  Cloud-scaling is a cost-effective approach if your computing happens in cyclical bursts.

#### Reproducible computing
To be reproducible, we must know exactly what computations were run.  Hence, a reproducible system must track which Containers were run, what the inputs were, and where the outputs were stored.  If this information is stored in the system,  you or a colleague can re-run precisely the same computation using either the same or different data.

#### Software development
To develop new software based on new ideas, we need to writing new programs. A software development kit (SDK) is an important resource that lets people test their ideas using the programming environment.  Such a kit should enable people to perform all of the functions that are embedded in the web-interface, and then build from there.

