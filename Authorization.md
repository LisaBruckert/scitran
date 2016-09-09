To access a scitran database, we create a scitran object

    st = scitran(varargin)

Normally, when the object is created authorization is obtained. 

    st = scitran('action', 'create', 'instance', 'scitran');

There are several configuration steps needed the very first time you use scitran client in a session on your computer.  These initializations for the PATH configuration are managed here by the 'init' flag. 

    st = scitran('action', 'create', 'instance', 'scitran', 'init',true);

To see other options and the methods, type

    doc scitran

To configure your computer with the necessary Python libraries, follow the instructions on the scitran/client [Readme](https://github.com/scitran/client).

### Plans

In the next release, it will be possible to ask for your own secure code (API key) from the flywheel web-page.  We will then enable you to store it through this command line code.
