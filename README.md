# .vimrc for Python3 IDE (Windows, Ubuntu)

This .vimrc is designed for VIM IDE for Python3 both in Windows, Ubuntu (other linux has not been tested yet).

This requires higher version of VIM 7.0.

This has been tested in windows 10 and ubuntu.

To apply and install vim pluggins using VimPlug, just try:

 - Ubuntu
 <pre>
   $ wget https://raw.githubusercontent.com/sapeyes/vimrc/master/.vimrc 
   $ vim   -- this will install all vim plugins and type :q
   $ cd .vim/plugged/YouCompleteMe
   $ python install.py
</pre>

 - Windows
<pre>
   C:\Users\YourName> wget https://raw.githubusercontent.com/sapeyes/vimrc/master/.vimrc 
   C:\Users\YourName> gvim or vim -- this will install all vim plugins and type :q
   C:\Users\YourName> cd vimfiles/plugged/YouCompleteMe
   C:\Users\YourName> python install.py
</pre>

You should check that your Vim supports Python3 by 
<pre>
  vim --versions
</pre>
 
