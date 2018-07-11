The database is organized into a set of basic categories that they call the [data model](https://flywheel-io.github.io/core/branches/master/matlab/data_model.html)  The search queries are structured around these categories.

* **Projects** - data from multiple sessions; a project belongs to a research *group* 
* **Sessions** - complete set of files acquired in a visit to the scanner.  A session usually contains many data and auxiliary files
* **Acquisitions** - groups of related files acquired during a session.  The files in acquisition can be related because they are derived from a common source (e.g., a raw (spectra) file, the dicom files produced from it, and the nifti file assembled from the dicoms).  Or, an acquisition can contain files that provide different types of information (e.g., diffusion data set in a nifti file along with the bvecs and bvals files).  Or the acquisition can contain files related for both reasons (.e.g, fMRI data in dicom files, the derived nifti file, associated physiological data). The files in an acquisition typically result from the single push of a 'Scan' button.
* **Files** - single files, such as a dicom, nifti or zip file (which might contain many dicom files)

* **Collections** - The notion of a collection or 'virtual experiment' is fundamental to the scitran approach.  Collections are 'virtual experiments' in which data from multiple sessions are combined for further analysis.  Typically, we use search to identify the acquisitions we wish to combine into a collection for further analysis.  (Scitran builds collections without duplicating the data.) Collections appear as if they are projects (groups of sessions).  But the data represented within each session of a collection is usually only a subset of the data from the original experimental session.

* **Analyses** - We perform analyses on collections.  Reproducible analyses must have defined inputs, a complete specification of the method for processing the data (usually a container), and defined outputs.  The analyses may operate on files within an acquisition, session, or spread across a collection. The analysis information itself is stored in the database so you and others can reproduce the analysis.  Before long, you will be able to search for analyses just as you can search for data.

* **Notes**  - Search for notes that people have added.  These can be searched just like files.

See the [scitran core data model page](https://github.com/scitran/core/wiki/Data-Model) for an introduction to the Flywheel data model.
