## Installing

### Github repositories
You can install this scitranClient and another essential toolbox, Guillaume Flandin's code to read and write JSON files (JSONio) by 

    git clone https://github.com/vistasoft/scitran
    git clone https://github.com/gllmflndn/JSONio
    
This will create two directories, scitran and JSONio.  Please add both directories to your path, say by using

    chdir(<scitran directory>); addpath(genpath(pwd));
    chdir(<JSONio directory>); addpath(genpath(pwd));

### Flywheel Add-Ons

You will also need to have the Flywheel Add-On installed.  This is done once using

    stFlywheelSDK('install');

You can verify or uninstall using

    status = stFlywheelSDK('verify')
    status = stFlywheelSDK('uninstall')

It seems that if you are upgrading it may be necessary to restart matlab.  We have done this sequence several times with success.  We are not sure why the restart may be necessary

    stFlywheelSDK('uninstall');
    RESTART MATLAB
    stFlywheelSDK('install');

## Flywheel command line interface (CLI)

We will write a stFlywheelCLI to install and invoke.  Hasn't happened yet.


