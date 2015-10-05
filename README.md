Lines and Circles (Love2D)
==========================

![Screenshot](screenshot.png)

Nab the blue circles and don't get hit by the lines. Have fun!


Running Lines and Circles
-------------------------

You must have [Love2D](love2d.org) installed to run this. On
Debian-based Linux distros you can install it with this command:

~~~
$ sudo apt-get install love
~~~

You can install it on Windows by downloading and running the installer.

 * [32-bit installer](https://bitbucket.org/rude/love/downloads/love-0.9.1-win32.exe)
 * [64-bit installer](https://bitbucket.org/rude/love/downloads/love-0.9.1-win64.exe)

To run Lines and Circles, just double-click on `lines-and-circles.love`


Hacking Lines and Circles
-------------------------

If you want to work on the lines and circles source code, here are some tips to get you started.

### Running the source code without packaging

To run `main.lua` without packaging it into a `.love` file, run this command in the directory `main.lua` is in:

~~~
$ love .
~~~


### Packaging the source code

After you are finished updating the game, you may want to package it for distribution. To do this, compress the directory (not including the current `.love` package) as a ZIP file and change the extension from `.zip` to `.love`.


