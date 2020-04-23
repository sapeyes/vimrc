
This .vimrc is designed for VIM IDE for Python3 both in Windows, Ubuntu (other linux has not been tested yet).

This requires higher version of VIM 7.0.

This has been tested in:
  windows 10
  ubuntu

To apply and install vim pluggins using VimPlug, just try:

 - Ubuntu
   $ wget https://raw.githubusercontent.com/sapeyes/vimrc/master/.vimrc 
   $ vim   -- this will install all vim plugins and type :q
   $ cd .vim/plugged/YouCompleteMe
   $ python install.py

 - Windows
   C:\Users\YourName> wget https://raw.githubusercontent.com/sapeyes/vimrc/master/.vimrc 
   C:\Users\YourName> gvim or vim -- this will install all vim plugins and type :q
   C:\Users\YourName> cd .vim/plugged/YouCompleteMe
   C:\Users\YourName> python install.py


You should check that your Vim supports Python3 by vim --versions
 
