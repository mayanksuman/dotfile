- For profiling vim loadup 
A python code `vim-profiler.py` is included in this dotfile. 
The python is installed in `~/.local/bin/` by default.


- For finding the usage of command quickly
A python program `eg` is included in the dotfile.
```
eg command
```
`eg eg` give more details about `eg` command.


- For generating randomized password use `gpw` command
	The random salt is at /.local/share/gpw/salt.secret. 
	The salt.secret is randomly generated data. ('head -c 4kB /dev/urandom > salt.secret;sync')
	Salt file if lost, you will lose all of your passwords.

	Other global randomization is done at ~/.config/gpw/gpw.conf.secret.
	Randomization for specific site can be done at ~/.config/gpw/gpw.custom.conf.secret.
	Check ~/.config/gpw/gpw.conf.secret.example for reference.


- For profiling python script
```
python -m cProfile -o myscript.cprof myscript.py
pyprof2calltree -k -i myscript.cprof
```

