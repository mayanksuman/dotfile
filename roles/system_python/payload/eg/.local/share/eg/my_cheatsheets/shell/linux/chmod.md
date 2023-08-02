# chmod

  Change the access permissions of a file or directory recursively[-R].
  Permissions is given to the owning user [u], the group [g], and other user [o].
  All of these at once can be referred to as [a]. [ugo] is equivalent to [a].

- Grant[+] read[r], write[w], and execute[x] permissions to all[a]

```
	chmod a+rwx {{file}}
	chmod rwx {{file}}
	chmod 777 {{file}}
```


- Remove[-] group[g] write and execute permissions

	chmod g-wx file


- Grant execute permission to the owning user[u]

	chmod u+x {{file}}


- Remove all permissions from non-owning user and non-group members[o]

	chmod o-rwx {{file}}


- Give others (not in the file owner's group) the same rights[=] as the group

	chmod o=g {{file}}

- Change the permission of a file to match a reference file[--reference=]

	chmod --reference={{path/to/reference_file}} {{path/to/file}}


- Grant write permissions recursively[-R] for group and others

	chmod -R g+w,o+w {{path/to/directory}}


## Bit Representation

Permissions can also be specified with numbers acting as bit masks. `7` is
`111`, which turns on `rwx`. Similary, `rw-`, `r-x` and `r--` are 6, 5 and 4.
`chmod 777` is thus equivalent to `chmod a+rwx`. Similarly, `chmod 754` will
grant `rwx` permission to owning user, `r-x` permission to owing group and
`r--` to others.
