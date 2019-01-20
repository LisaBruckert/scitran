Flywheel supports three types of programming interactions. **Gears** support stable software tools that many people might use, such as the FSL, FreeSurfer, BIDS, or HCP programs.  The **Software Development Kit** supports people who are developing specialized analyses; these analyses may be developed for a particular project and experimental design.  As the development stabilizes, it might become a **Gear**. The **Command Line Interface** is available from the Flywheel instance. This is software that performs various tasks such as uploading and downloading projects and sessions.

## Gears
**Flywheel Gears** are a way to share stable and used software. Flywheel has converted many programs into Gears, including some of the FSL, Freesurfer, ANTS and HCP programs. We use Chris Rorden's dcm2niix utility frequently.  Nearly any program that runs without user-intervention can be transformed into a Flywheel Gear.  

To see the Gears installed at your site click on 'Gears installed' on the left panel of the Flywheel web page. Most sites have added Gears based on their specific interests. These Gears can be based on a compiled program, or they can be based on Python, Matlab or R programs. [Read about Gears on this page](Gears).

The Flywheel system lets users automatically run a particular Gear when data of a certain type are entered into the database. The system also makes a distinction between Utility Gears and Analysis Gears.  The first group includes methods such as conversion between file formats, quality assurance, and data classification.  The second group includes more advanced analysis methods, such as atlas alignment, tissue segmentation, and tractography.

### Jobs
To run a Gear the Flywheel system schedules a Job.  Flywheel can schedule many Jobs, and depending on the system resources these may run in parallel. For example, you may instruct the Flywheel system to start 100 Jobs with the FreeSurfer Gear. These will be scheduled, and each Gear can be run on a different data set. The Flywheel system will start, monitor, and finish the Jobs based on the available system resources.  A FreeSurfer job might take 5 few hours. If you are running on a Cloud platform where many resources can be summoned, running 100 Jobs only takes a little longer than running 1 Job.

### Provenance
The inputs, program parameters, and results of a Job will be stored in the Analysis tab.  There is an Analysis tab for each Session, and there is an Analysis tab for each Project. A record of when the Jobs were run and their status (e.g., running or completed) is available in the Provenance Tab.

## Software Development Kit (SDK)
Many people write their own analysis programs; during this process it may be essential to access Flywheel data and methods. The Flywheel-SDK is a collection of utilities that developers use to interact with Flywheel from their programming environment, either Python, Matlab or R. The **scitran** methods described here are a wrapper on the Matlab version of the Flywheel-SDK.

### Methods
[**Scitran** methods](https://github.com/vistalab/scitran/wiki/scitran-methods) use the Flywheel-SDK to interact with data containers, data files, info (metadata), analyses, Gears, and Jobs. The methods are named using a convention of **objectAction**.  For example, suppose you create a **scitran** object, 

    st = scitran('stanfordlabs');

Here are examples of methods.

```
st.containerDownload - downloading one of the several container types
st.containerCreate   - create a container on the remote site
st.fileDownload      - downloads a data file
st.fileDelete        - delete a file
st.analysisUpload    - create and upload an analysis structure
```
If you would like to perform a task involving a data file, and you are wondering what methods are available, use tab-completion (e.g., st.file**TAB**) to see the list of File methods. Documentation about a method is available through

     doc scitran
     doc scitran.containerDownload
     doc scitran.<METHOD_NAME>

Examples of the methods are often available you can find them using the stExamplesShow function.

    stExamplesShow('scitran.containerDownload');
    stExamplesShow('scitran.fileRead');
    stExamplesShow('scitran.analysisDownload');

The Flywheel-SDK also includes methods for securely connecting to the site, reading and writing data and metadata, storing analysis results, creating projects, controlling Gears and Jobs, and more.

## CLI - Command line interface

The command line interface software can be obtained from your user profile page on the Flywheel instance.

![](https://github.com/scitran/client/wiki/images/cliDownload.png)

The program installs as 'fw'.  Type`fw help` to see the options and see the [CLI Documentation here](https://docs.flywheel.io/display/EM/CLI+-+Commands).






