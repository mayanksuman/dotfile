# cp

  Copy file and folders.

## Syntax

    cp options source target

## Notable Options

		-f : Force mode.
		-s : Make symbolic link instead of copying
		-u : Update mode. Copy only if file is updated or it does not exist.
		-v : Verbose mode.

- Copy a file

    cp path/to/original.txt path/to/copy.txt


- Copy in interactive mode[-i] : Prompt if will overwrite existing file

    cp -i *.txt path/to/directory/


- Copy a directory recursively[-R]

    cp -R /path/to/directory path/to/directory_copy


Behavior differs if the argument that is the directory being copied ends with a
`/`. If it does end with a `/` the contents are copied as opposed to the
directory itself. For example, `cp -R foo/ bar` will take the contents of the
`foo` directory and copy them into `bar`, while `cp -R foo bar` will copy `foo`
itself and put it into `bar`.


