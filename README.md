# Scitran client software

This repository includes Matlab and Python utilities to interact with the SciTran API from the client side for search, get, and put.  See the [project wiki page](https://github.com/scitran/client/wiki) for a general introduction and links to specific manual pages.

## Matlab Client Setup

* Even when using the Matlab version, you must have python on your path to enable authorization. The key Python module is oauth2client.  If you use, say, anaconda to manage your python method than pip is included and you can do the install this way from your terminal
   ```
   pip install oauth2client
   ```
There are many ways to do the install for other systems, and we will add other examples here later.

* The python executable must be in the path environment variable in Matlab.  You can find your path by typing
   ```
   getenv('PATH')
   ```
If the path to python is not in this list, then you set add it, say be
   ```
   setenv('PATH',['/Users/wandell/anaconda/bin/:',getenv('PATH')]);
   ```
You might verify that you succeeded by trying
   ```
   system('which python')
   ```
* If your terminal environment is set up properly, the best way to initiate scitran client is to start matlab from a terminal.  In that case, the Matlab program inherits your shell ENV. Many people start Matlab from an icon, however. This sets up Matlab's own idiosyncratic environment. In that case, you may have to set your ENV (PATH) to include paths to python & required libs manually from within Matlab.  See XXX for instructions on how to do this.

## Scitran client dependencies

* The purpose of the software is to access a Flywheel instance.  You will need an authorization token.  On first access, you will be prompted for the client ID and secret. This secret can only be given by an administrator of the instance you wish to connect to.  So, speak to your administrator about the client ID and secret.

* JSONlab
The MATLAB SciTran client uses JSONlab to load, save, and parse json objects. Hence, [JSONlab](https://github.com/fangq/jsonlab) must  be on your MATLAB path. Version XXX is included in this distribution.

* (Deprecated). You must have access to port 9000 to open a browser window/tab. By default this should work just fine. This is almost never a problem, apart from some VM installs.


## Python Client
Coming soon...
