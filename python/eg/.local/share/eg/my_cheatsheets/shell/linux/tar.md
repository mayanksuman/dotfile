# tar

  Archiving utility. Often used with a compression method, like gzip or bzip.

## Notable Flags

	- `z` : Working with gzipped archive (.tar.gz or .tgz)
	- `j` : Working with bzipped archive (.tar.bz2)
	- `J` : Working with xzzipped archive (.tar.xz)
	- `v` : Verbose output

## Examples

- Extract[x] source.tar file[f]

    tar fx source.tar


- For extracting in directory[-C]

    tar fxz source.tar.gz -C target_directory


- Create[c] a tar file from a directory or list of files

    tar fc output.tar target_directory
    tar fc output.tar file1 file2 file3


- Extract only part of the contents (`foo.txt`) from archive file:

    tar fx source.tar foo.txt

- Extract files matching a pattern:

    tar xf source.tar --wildcards "*.html"

- List[t] the contents of a tar file without untarring it:

    tar vft tarred_directory.tar
