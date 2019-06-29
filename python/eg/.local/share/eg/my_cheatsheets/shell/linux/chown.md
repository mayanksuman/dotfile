# chown

  Change user and/or group ownership of files and folder.

## Syntax

    sudo chown user:group path/to/file			# for single file
    sudo chown -R user:group path/to/directory		# recursively for directory

## Example

- Change owning user

    sudo chown user path/to/file


- Change user and group

    sudo chown username:groupname path/to/file


- Change only group

    sudo chown :groupname path/to/file


- Change the owner of a symbolic link

    sudo chown -h user path/to/symlink


- Change the owner of a file/folder to match a reference file

    sudo chown --reference=path/to/reference_file path/to/file


- Change the owner of a file/folder only if it has user1:group1 as owner

    sudo chown --from=user1:group1 user2:group2 path/to/file
